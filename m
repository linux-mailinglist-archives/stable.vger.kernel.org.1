Return-Path: <stable+bounces-79164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0874098D6E8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732041F243EC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53DB1D0BB5;
	Wed,  2 Oct 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eezcsCCA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECA1D0945;
	Wed,  2 Oct 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876627; cv=none; b=pmyu2/ozcf2eeaJ7+dRPWewaXi8ERJ8E+5VE8cKE79A5uNpwqxr5QBXfNy4s4jZi+uKBhSaIC5ihll06OBoOOkGvCsRUjaKbnmrxqJGAT2C9KBKNBvV+76GGsaGgqopRKAbhxLRChqF3gUqfliY6jdiZnoGh/BcNSD0XLnCUeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876627; c=relaxed/simple;
	bh=KQRItBo8Ure3IdP21eIR2hxL0bsgkYcot+Y8Kk/XgTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfXzQvP6m8jB9/vwh9V9gY+7VZ2SLqgKAtzpXvxueoKMwuLbnZHSVmgl70raex4pXKoT/OAP5KlhU7X4w8qr4wH3ZHYwdZzzKXumiD1LDv63LMU//3R2FZAZTOzAFhK3mwXQ85pxNBguKN1bsItNaMh+WxIzbRP3xH1iZrBTJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eezcsCCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AA6C4CEC5;
	Wed,  2 Oct 2024 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876627;
	bh=KQRItBo8Ure3IdP21eIR2hxL0bsgkYcot+Y8Kk/XgTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eezcsCCADIq426zuwvHRPmG7RUdZZR37ihmt/JaUsTX61I33yIyy0JfxriRzcm2b0
	 Hb+DQyerm/5csaSuN7IdfCeumeXmOBSBRrsPrtETzSvMvA+FMhqv8mQcQaGS4lCr1x
	 89AFHbYkmMa+PWUm6JEn4WiB76r6+jjaDI3tlTaQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 491/695] netfilter: ctnetlink: compile ctnetlink_label_size with CONFIG_NF_CONNTRACK_EVENTS
Date: Wed,  2 Oct 2024 14:58:09 +0200
Message-ID: <20241002125842.068292887@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Horman <horms@kernel.org>

[ Upstream commit e1f1ee0e9ad8cbe660f5c104e791c5f1a7cf4c31 ]

Only provide ctnetlink_label_size when it is used,
which is when CONFIG_NF_CONNTRACK_EVENTS is configured.

Flagged by clang-18 W=1 builds as:

.../nf_conntrack_netlink.c:385:19: warning: unused function 'ctnetlink_label_size' [-Wunused-function]
  385 | static inline int ctnetlink_label_size(const struct nf_conn *ct)
      |                   ^~~~~~~~~~~~~~~~~~~~

The condition on CONFIG_NF_CONNTRACK_LABELS being removed by
this patch guards compilation of non-trivial implementations
of ctnetlink_dump_labels() and ctnetlink_label_size().

However, this is not necessary as each of these functions
will always return 0 if CONFIG_NF_CONNTRACK_LABELS is not defined
as each function starts with the equivalent of:

	struct nf_conn_labels *labels = nf_ct_labels_find(ct);

	if (!labels)
		return 0;

And nf_ct_labels_find always returns NULL if CONFIG_NF_CONNTRACK_LABELS
is not enabled.  So I believe that the compiler optimises the code away
in such cases anyway.

Found by inspection.
Compile tested only.

Originally splitted in two patches, Pablo Neira Ayuso collapsed them and
added Fixes: tag.

Fixes: 0ceabd83875b ("netfilter: ctnetlink: deliver labels to userspace")
Link: https://lore.kernel.org/netfilter-devel/20240909151712.GZ2097826@kernel.org/
Signed-off-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_netlink.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 4cbf71d0786b0..c55cf5bc36b2f 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -382,7 +382,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 #define ctnetlink_dump_secctx(a, b) (0)
 #endif
 
-#ifdef CONFIG_NF_CONNTRACK_LABELS
+#ifdef CONFIG_NF_CONNTRACK_EVENTS
 static inline int ctnetlink_label_size(const struct nf_conn *ct)
 {
 	struct nf_conn_labels *labels = nf_ct_labels_find(ct);
@@ -391,6 +391,7 @@ static inline int ctnetlink_label_size(const struct nf_conn *ct)
 		return 0;
 	return nla_total_size(sizeof(labels->bits));
 }
+#endif
 
 static int
 ctnetlink_dump_labels(struct sk_buff *skb, const struct nf_conn *ct)
@@ -411,10 +412,6 @@ ctnetlink_dump_labels(struct sk_buff *skb, const struct nf_conn *ct)
 
 	return 0;
 }
-#else
-#define ctnetlink_dump_labels(a, b) (0)
-#define ctnetlink_label_size(a)	(0)
-#endif
 
 #define master_tuple(ct) &(ct->master->tuplehash[IP_CT_DIR_ORIGINAL].tuple)
 
-- 
2.43.0




