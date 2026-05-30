Return-Path: <stable+bounces-258323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DnbMj4oG2qS/ggAu9opvQ
	(envelope-from <stable+bounces-258323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:11:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DD6611314
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F79930A5E08
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB256332EA7;
	Sat, 30 May 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cv3R2UaG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A533032B;
	Sat, 30 May 2026 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163964; cv=none; b=jpNS9leLcpTczX+9k3Ml4tBnG7BYfYMatCwy+qPkXbVKj9gce4VfPU1NjULwEOG1uqf8mqdwb/od6nIBemDtHzJjBZVNN/zI7PAM2h2iCHmoYPgp/dHo3VBGGqAWWMgqDcf0cUR8i6qM6OFKRZ5BX3OO6PQq51NmExB3lzVeH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163964; c=relaxed/simple;
	bh=GHCxbSHtyQdXyXW1zPX24+HhCf7F1ZkeY8Rr2aZ4L9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9JkZX+AVQ3zKuK01aGBZ1mH8sW3kSf7Vjzjh4yUyq678OoooCVYom3vuqvuguAQdbyj2SnC0Mcc5zbmwUa1KshPOxHKuAJtCqXFbfXzTTTeHsxakezHNVHDjoqMd33h3a4HE7Vvuprm2n2CbWckg0OH0rcodOuu5yF2VlXshmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cv3R2UaG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F56B1F00893;
	Sat, 30 May 2026 17:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163963;
	bh=QdylUWDgxq8V0Pd1524662bNv2E6V8itrdYRKq6k/FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cv3R2UaGAaUcGSX4svPlzjZhmgCQdp5oWoVapY8t5ANUfRvWmnb0HRxIHSTnIqm/3
	 7dAn/EgjIc/MHWiv8fYe91FeGOl43Zeq3RLsXmhPT+r6JKo9pRClksI4NCb/YuxRKG
	 PjeD6iHHjQdaNjLXHPbVuNx/5y+GCFBA86uHV8jI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 414/776] netfilter: xt_socket: enable defrag after all other checks
Date: Sat, 30 May 2026 18:02:08 +0200
Message-ID: <20260530160251.178889654@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258323-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 79DD6611314
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 542be3fa5aff54210a02954c38f07e53ea9bdafd ]

Originally this did not matter because defrag was enabled once per netns
and only disabled again on netns dismantle.  When this got changed I should
have adjusted checkentry to not leave defrag enabled on error.

Fixes: de8c12110a13 ("netfilter: disable defrag once its no longer needed")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_socket.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/net/netfilter/xt_socket.c b/net/netfilter/xt_socket.c
index 7013f55f05d1e..5ff7d00786eee 100644
--- a/net/netfilter/xt_socket.c
+++ b/net/netfilter/xt_socket.c
@@ -168,52 +168,41 @@ static int socket_mt_enable_defrag(struct net *net, int family)
 static int socket_mt_v1_check(const struct xt_mtchk_param *par)
 {
 	const struct xt_socket_mtinfo1 *info = (struct xt_socket_mtinfo1 *) par->matchinfo;
-	int err;
-
-	err = socket_mt_enable_defrag(par->net, par->family);
-	if (err)
-		return err;
 
 	if (info->flags & ~XT_SOCKET_FLAGS_V1) {
 		pr_info_ratelimited("unknown flags 0x%x\n",
 				    info->flags & ~XT_SOCKET_FLAGS_V1);
 		return -EINVAL;
 	}
-	return 0;
+
+	return socket_mt_enable_defrag(par->net, par->family);
 }
 
 static int socket_mt_v2_check(const struct xt_mtchk_param *par)
 {
 	const struct xt_socket_mtinfo2 *info = (struct xt_socket_mtinfo2 *) par->matchinfo;
-	int err;
-
-	err = socket_mt_enable_defrag(par->net, par->family);
-	if (err)
-		return err;
 
 	if (info->flags & ~XT_SOCKET_FLAGS_V2) {
 		pr_info_ratelimited("unknown flags 0x%x\n",
 				    info->flags & ~XT_SOCKET_FLAGS_V2);
 		return -EINVAL;
 	}
-	return 0;
+
+	return socket_mt_enable_defrag(par->net, par->family);
 }
 
 static int socket_mt_v3_check(const struct xt_mtchk_param *par)
 {
 	const struct xt_socket_mtinfo3 *info =
 				    (struct xt_socket_mtinfo3 *)par->matchinfo;
-	int err;
 
-	err = socket_mt_enable_defrag(par->net, par->family);
-	if (err)
-		return err;
 	if (info->flags & ~XT_SOCKET_FLAGS_V3) {
 		pr_info_ratelimited("unknown flags 0x%x\n",
 				    info->flags & ~XT_SOCKET_FLAGS_V3);
 		return -EINVAL;
 	}
-	return 0;
+
+	return socket_mt_enable_defrag(par->net, par->family);
 }
 
 static void socket_mt_destroy(const struct xt_mtdtor_param *par)
-- 
2.53.0




