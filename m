Return-Path: <stable+bounces-225853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Eg7CD5AuWmB9QEAu9opvQ
	(envelope-from <stable+bounces-225853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:51:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD112A9403
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94A3B30989C9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC06B3AE702;
	Tue, 17 Mar 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GfD7EhJQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA73AE6EF
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748106; cv=none; b=O+agtb5MjG7hJDBUoerqnGZsfRMpamrcexMy8iN4L4PRK99txpjDQ71yGQsp6Rqpo+bU5I0msrnnp7vfE8ZkyCptoHe8J1p5x+c3nHsRoXwIfJ8ABtgp5RCRWTKEHsl4lVB4y2+q6Yox8pK9E9BGT2a262TAZGA+7xhn/fplvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748106; c=relaxed/simple;
	bh=FMTCPo4nosAqGRJMGBuIYL/hWIuCDyzHs+e5wSBmVC8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Utn/kAUE+FxyZV3FEndSFtBRJwHtVVWBXASz/ehw7EgGl3IE8+rPUz7J+aYFuwAKqVeKwKMRmgs0IEr0RHxYD3GqDx1CNGY2VLOh423ji1i3+NOuh6l5/dvWKvsWEuojo6nw8BcADG+FOt0pVh+96Nf3RtPl7sdfS/ZXVXrw7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GfD7EhJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE093C19425;
	Tue, 17 Mar 2026 11:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773748106;
	bh=FMTCPo4nosAqGRJMGBuIYL/hWIuCDyzHs+e5wSBmVC8=;
	h=Subject:To:Cc:From:Date:From;
	b=GfD7EhJQ03/Itqo/Ah9kSuXw3Y4PMjammXdwb5iO92h2Y2oCiK7EixIczcPbBqpV1
	 ITt1oc8p8fI3HS8Mwn37tB7okWolTi7X6Q6ZatrbBvynZitj7VgeCKoJf76AN+Mp+j
	 IWrZmMYo0BgQ8f8hgoUeXEzDga/kfEAg+dwCtcPI=
Subject: FAILED: patch "[PATCH] drm/xe/sync: Fix user fence leak on alloc failure" failed to apply to 6.18-stable tree
To: shuicheng.lin@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:48:22 +0100
Message-ID: <2026031722-spectrum-cocoa-0d75@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225853-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,msgid.link:url,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: AAD112A9403
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0879c3f04f67e2a1677c25dcc24669ce21eb6a6c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031722-spectrum-cocoa-0d75@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0879c3f04f67e2a1677c25dcc24669ce21eb6a6c Mon Sep 17 00:00:00 2001
From: Shuicheng Lin <shuicheng.lin@intel.com>
Date: Thu, 19 Feb 2026 23:35:19 +0000
Subject: [PATCH] drm/xe/sync: Fix user fence leak on alloc failure

When dma_fence_chain_alloc() fails, properly release the user fence
reference to prevent a memory leak.

Fixes: 0995c2fc39b0 ("drm/xe: Enforce correct user fence signaling order using")
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260219233516.2938172-6-shuicheng.lin@intel.com
(cherry picked from commit a5d5634cde48a9fcd68c8504aa07f89f175074a0)
Cc: stable@vger.kernel.org
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index ebf6c96d7a41..24d6d9af20d6 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -206,8 +206,10 @@ int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
 			if (XE_IOCTL_DBG(xe, IS_ERR(sync->ufence)))
 				return PTR_ERR(sync->ufence);
 			sync->ufence_chain_fence = dma_fence_chain_alloc();
-			if (!sync->ufence_chain_fence)
-				return -ENOMEM;
+			if (!sync->ufence_chain_fence) {
+				err = -ENOMEM;
+				goto free_sync;
+			}
 			sync->ufence_syncobj = ufence_syncobj;
 		}
 


