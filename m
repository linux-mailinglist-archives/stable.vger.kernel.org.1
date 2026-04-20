Return-Path: <stable+bounces-239628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJQvO3dm5mmJvwEAu9opvQ
	(envelope-from <stable+bounces-239628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:46:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3CB432109
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90446330BA36
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6753F2E2665;
	Mon, 20 Apr 2026 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1FIKblMy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4E33B970;
	Mon, 20 Apr 2026 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700744; cv=none; b=EBdCfsgjRtnphCAbf98bRxGtFcLIzRL5EWr3/rEf3Kqo+H+P0r2wfwIbH8wtrd4wtTsA7IT5ikAHHOKhVecdT43P5pgUtcyJs6Smc7DcL5Clu6ME6OwWAkUDiirHWRBzeKYsu1LrE/+LcePKxItY7dveEOLZCftLXEFVWZLJRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700744; c=relaxed/simple;
	bh=A9CsL/iu3TsUHObuqKwqdlvjyMUgFjJuwhi8jcyMChs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJtBDeJvlRUc28p+PiSqhDlUvDam0q9pOcdtA65L1r6A8jStmFAB5CwdLk5Jd/H1BHf2gzLm+50XLu3nX3Cd2O+ErYwdYCgqLMBU6yUs+KoPN0/qI8WAfum4M0EmN590zRTAq7613f2wRGmB7092ZVNPaNP4bjlZNgo+eooDXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1FIKblMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3329C19425;
	Mon, 20 Apr 2026 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700744;
	bh=A9CsL/iu3TsUHObuqKwqdlvjyMUgFjJuwhi8jcyMChs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1FIKblMyPLjZxgpy8eTpI0o4SGi7D8nohZD33TdfohJSPGbUtlAqE9jhvmOXhM4X5
	 T2+l294SOIh/tJiK3xq4Wom7IeW8OIUbFVeHNt9hDxI9q9zky3oA/bbybzSHpINbjy
	 mKT/+6Bwj3Har1cfimgYWGDAEpgio6ljjQgggjck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicholas Carlini <nicholas@carlini.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 069/198] eventpoll: defer struct eventpoll free to RCU grace period
Date: Mon, 20 Apr 2026 17:40:48 +0200
Message-ID: <20260420153938.095774487@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-239628-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,carlini.com:email]
X-Rspamd-Queue-Id: 5B3CB432109
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index bcc7dcbefc419..a8e30414d996c 100644
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




