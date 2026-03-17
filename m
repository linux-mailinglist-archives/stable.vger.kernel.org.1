Return-Path: <stable+bounces-225852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJsAOXw/uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:48:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88182A92F3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B8633025674
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35505372666;
	Tue, 17 Mar 2026 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a4ODTlz0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60BEACE
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748057; cv=none; b=t4NFJxhxxqI4JC4DXl1I4JLg7cgQGvcsEdIThM3ciRH6ReHszzYKnomyVfxtEJ4+BjXAJI7JUMKeDfb3i+jPBsq/iRX+JapaoUxiT/ybw5N9uAg5q3t9L2Os6ANnkrhWfAX3+VsAEFdDW/2tQ3SICsQa2lnlqDLmpZ70SpskdoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748057; c=relaxed/simple;
	bh=GNQHAKP/xdwcHdPpzFINDuSV+NYGWp+i5WYxuZoE0cI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BrxrokVoFOv01HET7nNBXK4H4+PylISkjruunZ9kANDJHa0lo5dbLTaD2A9YtgqsnkKhJoXjEjKUQJkaIfoqbNGagngz6Z+4sn7J+p60kkEGMVPYfxLpQ81fRE12l3p/mt1VJcIKhGwp8O6KSs6fX7Q2ns7Ed3CpN38ywVoXv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a4ODTlz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14990C4CEF7;
	Tue, 17 Mar 2026 11:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773748056;
	bh=GNQHAKP/xdwcHdPpzFINDuSV+NYGWp+i5WYxuZoE0cI=;
	h=Subject:To:Cc:From:Date:From;
	b=a4ODTlz0FA8MtHT1kkb+n8QYrSGNMHyU3LLrSz5OpFJQg0ubec6owVaVxSV3bY/3y
	 bAA9C+mP2iRbCbRJiOU1WXThU/Y83B7a6Q0wHcJYik5ZUZlWwbdw2HlGVsBTboHYLJ
	 s5910WrAsdVT4BXBumBzOGM/dlurawAhIRxUzo3I=
Subject: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially initialized sync on parse" failed to apply to 6.12-stable tree
To: shuicheng.lin@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:47:32 +0100
Message-ID: <2026031732-size-unfasten-2bf3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225852-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,intel.com:email]
X-Rspamd-Queue-Id: E88182A92F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1bfd7575092420ba5a0b944953c95b74a5646ff8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031732-size-unfasten-2bf3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1bfd7575092420ba5a0b944953c95b74a5646ff8 Mon Sep 17 00:00:00 2001
From: Shuicheng Lin <shuicheng.lin@intel.com>
Date: Thu, 19 Feb 2026 23:35:18 +0000
Subject: [PATCH] drm/xe/sync: Cleanup partially initialized sync on parse
 failure

xe_sync_entry_parse() can allocate references (syncobj, fence, chain fence,
or user fence) before hitting a later failure path. Several of those paths
returned directly, leaving partially initialized state and leaking refs.

Route these error paths through a common free_sync label and call
xe_sync_entry_cleanup(sync) before returning the error.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260219233516.2938172-5-shuicheng.lin@intel.com
(cherry picked from commit f939bdd9207a5d1fc55cced5459858480686ce22)
Cc: stable@vger.kernel.org
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index eb136390dafd..ebf6c96d7a41 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -146,8 +146,10 @@ int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
 
 		if (!signal) {
 			sync->fence = drm_syncobj_fence_get(sync->syncobj);
-			if (XE_IOCTL_DBG(xe, !sync->fence))
-				return -EINVAL;
+			if (XE_IOCTL_DBG(xe, !sync->fence)) {
+				err = -EINVAL;
+				goto free_sync;
+			}
 		}
 		break;
 
@@ -167,17 +169,21 @@ int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
 
 		if (signal) {
 			sync->chain_fence = dma_fence_chain_alloc();
-			if (!sync->chain_fence)
-				return -ENOMEM;
+			if (!sync->chain_fence) {
+				err = -ENOMEM;
+				goto free_sync;
+			}
 		} else {
 			sync->fence = drm_syncobj_fence_get(sync->syncobj);
-			if (XE_IOCTL_DBG(xe, !sync->fence))
-				return -EINVAL;
+			if (XE_IOCTL_DBG(xe, !sync->fence)) {
+				err = -EINVAL;
+				goto free_sync;
+			}
 
 			err = dma_fence_chain_find_seqno(&sync->fence,
 							 sync_in.timeline_value);
 			if (err)
-				return err;
+				goto free_sync;
 		}
 		break;
 
@@ -216,6 +222,10 @@ int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
 	sync->timeline_value = sync_in.timeline_value;
 
 	return 0;
+
+free_sync:
+	xe_sync_entry_cleanup(sync);
+	return err;
 }
 ALLOW_ERROR_INJECTION(xe_sync_entry_parse, ERRNO);
 


