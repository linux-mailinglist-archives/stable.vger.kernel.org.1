Return-Path: <stable+bounces-5877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C32880D79E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10E5B20DF9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156B152F8C;
	Mon, 11 Dec 2023 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CSlSHp9I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994DFC06;
	Mon, 11 Dec 2023 18:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDEFC433C7;
	Mon, 11 Dec 2023 18:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319908;
	bh=m542uhexIP3MRbvphx0aciVxZ7y2zOIXB9NiceiOh78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSlSHp9IQZkPZeMnwwaIJE47OCotuwIrcrkz9HnmZR3k/zUehx7KGk7yJQ9oq5rnB
	 BRI1nvfYCcKzLq1tJxrUIchIxSywq13dn1EalIgNbFquRQoY1WWnpCEEpVSyMsNI6l
	 EDCBIoIWeYcvhoq5zwwSRcqDKfwV1XXOyZV1wN+s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 33/97] netfilter: xt_owner: Fix for unsafe access of sk->sk_socket
Date: Mon, 11 Dec 2023 19:21:36 +0100
Message-ID: <20231211182021.188696372@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
References: <20231211182019.802717483@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 7ae836a3d630e146b732fe8ef7d86b243748751f ]

A concurrently running sock_orphan() may NULL the sk_socket pointer in
between check and deref. Follow other users (like nft_meta.c for
instance) and acquire sk_callback_lock before dereferencing sk_socket.

Fixes: 0265ab44bacc ("[NETFILTER]: merge ipt_owner/ip6t_owner in xt_owner")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_owner.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
index e85ce69924aee..50332888c8d23 100644
--- a/net/netfilter/xt_owner.c
+++ b/net/netfilter/xt_owner.c
@@ -76,18 +76,23 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 		 */
 		return false;
 
-	filp = sk->sk_socket->file;
-	if (filp == NULL)
+	read_lock_bh(&sk->sk_callback_lock);
+	filp = sk->sk_socket ? sk->sk_socket->file : NULL;
+	if (filp == NULL) {
+		read_unlock_bh(&sk->sk_callback_lock);
 		return ((info->match ^ info->invert) &
 		       (XT_OWNER_UID | XT_OWNER_GID)) == 0;
+	}
 
 	if (info->match & XT_OWNER_UID) {
 		kuid_t uid_min = make_kuid(net->user_ns, info->uid_min);
 		kuid_t uid_max = make_kuid(net->user_ns, info->uid_max);
 		if ((uid_gte(filp->f_cred->fsuid, uid_min) &&
 		     uid_lte(filp->f_cred->fsuid, uid_max)) ^
-		    !(info->invert & XT_OWNER_UID))
+		    !(info->invert & XT_OWNER_UID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
 	if (info->match & XT_OWNER_GID) {
@@ -112,10 +117,13 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			}
 		}
 
-		if (match ^ !(info->invert & XT_OWNER_GID))
+		if (match ^ !(info->invert & XT_OWNER_GID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
+	read_unlock_bh(&sk->sk_callback_lock);
 	return true;
 }
 
-- 
2.42.0




