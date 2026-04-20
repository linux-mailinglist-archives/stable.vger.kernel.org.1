Return-Path: <stable+bounces-239446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELAbECZe5mm3vQEAu9opvQ
	(envelope-from <stable+bounces-239446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:11:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD35E430A98
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42E123938D6E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EBE33AD99;
	Mon, 20 Apr 2026 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fhexiCQ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930C3382DE;
	Mon, 20 Apr 2026 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700274; cv=none; b=teXaAJZ0pHb0rs848NmZ6izYkgvBY+KXHPY0j2+MmwCWvi+m+A7WVw6ZyG4NWn7Ai3RYS8H6L5KGPMfz3Bi5G/kdBAunuGqtyofvTUb7XVQypbfgyBafSBOK0zPnVyVcwlWG5/Sbipf+kib8HLGnv+e+8w401WLER/i0T2TBJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700274; c=relaxed/simple;
	bh=Z1oHvWK4r+zzSfkprcw8wVE7P7ge9UFx82SYRTKj4UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKty604MYE3yE79UiIP0VI7X6hiWAhWqy/ASv+vs+SFT5KFeLXELZxZLZ8zELKGCZmKqtH8hFU719ocfK8VBAJkULOk6+biFOY8vLXTBB+PGZd5zkkldbSfB93NYqAK2QfpStxZoPmMZpVn91J8Qz0dXR48Jpdl4voMJk9wlAgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fhexiCQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE67C19425;
	Mon, 20 Apr 2026 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700274;
	bh=Z1oHvWK4r+zzSfkprcw8wVE7P7ge9UFx82SYRTKj4UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhexiCQ8EmtpjOIHoklc2KkNZAltqTV9rvd7EzxW+XZLJ8JZkbfLnGMEfsKbpBm7Q
	 Kdq/buuzBDUL2+q/rkUum2XaX9Ndwclx0LbzC8964nyukKMivQwWXxDn9cHcC0PWem
	 QtGS2o0ihkctc3JtGuOWa9YJiOf94b3ANYLvRY1k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicholas Carlini <nicholas@carlini.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 076/220] eventpoll: defer struct eventpoll free to RCU grace period
Date: Mon, 20 Apr 2026 17:40:17 +0200
Message-ID: <20260420153936.774715282@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239446-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[carlini.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD35E430A98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Carlini <nicholas@carlini.com>

[ Upstream commit 07712db80857d5d09ae08f3df85a708ecfc3b61f ]

In certain situations, ep_free() in eventpoll.c will kfree the epi->ep
eventpoll struct while it still being used by another concurrent thread.
Defer the kfree() to an RCU callback to prevent UAF.

Fixes: f2e467a48287 ("eventpoll: Fix semi-unbounded recursion")
Signed-off-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d20917b03161b..3bdbaf202d4db 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -226,6 +226,9 @@ struct eventpoll {
 	 */
 	refcount_t refcount;
 
+	/* used to defer freeing past ep_get_upwards_depth_proc() RCU walk */
+	struct rcu_head rcu;
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* used to track busy poll napi_id */
 	unsigned int napi_id;
@@ -819,7 +822,8 @@ static void ep_free(struct eventpoll *ep)
 	mutex_destroy(&ep->mtx);
 	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
-	kfree(ep);
+	/* ep_get_upwards_depth_proc() may still hold epi->ep under RCU */
+	kfree_rcu(ep, rcu);
 }
 
 /*
-- 
2.53.0




