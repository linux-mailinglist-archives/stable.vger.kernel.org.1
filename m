Return-Path: <stable+bounces-225916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kET7IGROuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:51:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F310E2AA255
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE47E3051495
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA933C5DBF;
	Tue, 17 Mar 2026 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zcC44P8Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24533C5528
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751906; cv=none; b=WXuxAjnow3d+tfQ8hPQU/j3NnQWJSaug3C25oiIrbRJ8Gqf4/dUyN8yfz8wSe5iiIndcJroh3jI7O/UXy6cMBLjxNDTgFOrXlJED83+etceNFHc9RLEt/WJC6BrGelrD1yoTpSYDx1HF0LIQKMX2Oa/OA9qYGT9/GaLJvrh1duI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751906; c=relaxed/simple;
	bh=3bstBKzijOxlOq6yrZOGEEZGKa75O78CVnKfsdV3UQY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RNGFCk7zNFxvQGxBmE1SGlFgncBWGrCuBoUYfCt6dgxXZichHcA0iAJYShPmN1yKR5GcV9gPzQ/HFsN3jVAjHyT3GVJ7F5sok6055qm/637MBxVJ6LN2LZLYWHmy0umVWvJ8PJcCG0wbd1z/kdwkXwb9pmf92qH/XIiR3Re/2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zcC44P8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D73C4CEF7;
	Tue, 17 Mar 2026 12:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773751905;
	bh=3bstBKzijOxlOq6yrZOGEEZGKa75O78CVnKfsdV3UQY=;
	h=Subject:To:Cc:From:Date:From;
	b=zcC44P8Y1fJp/ic5tJwMcJUl2a8b5B5evuMAaCfC7cBRjKbAwCM2tHGSc9Egsf0Fw
	 bD/8PY68E9SDUjHNe9f/U7mHtOwemwa6sJnzVoz65WPJcQR7cFERsMLzP408yB3oQ6
	 +I6JXZTHsfFbtdoguPi7ap6W2LFyBbOclh6gURtY=
Subject: FAILED: patch "[PATCH] drm/xe: Fix memory leak in xe_vm_madvise_ioctl" failed to apply to 6.19-stable tree
To: varun.gupta@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com,shuicheng.lin@intel.com,tejas.upadhyay@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:51:42 +0100
Message-ID: <2026031742-pull-husband-3953@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225916-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,intel.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F310E2AA255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x 0cfe9c4838f1147713f6b5c02094cd4dc0c598fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031742-pull-husband-3953@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0cfe9c4838f1147713f6b5c02094cd4dc0c598fa Mon Sep 17 00:00:00 2001
From: Varun Gupta <varun.gupta@intel.com>
Date: Mon, 23 Feb 2026 23:21:45 +0530
Subject: [PATCH] drm/xe: Fix memory leak in xe_vm_madvise_ioctl

When check_bo_args_are_sane() validation fails, jump to the new
free_vmas cleanup label to properly free the allocated resources.
This ensures proper cleanup in this error path.

Fixes: 293032eec4ba ("drm/xe/bo: Update atomic_access attribute on madvise")
Cc: stable@vger.kernel.org # v6.18+
Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>
Signed-off-by: Varun Gupta <varun.gupta@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260223175145.1532801-1-varun.gupta@intel.com
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
(cherry picked from commit 29bd06faf727a4b76663e4be0f7d770e2d2a7965)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index 95bf53cc29e3..bc39a9a9790c 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -453,7 +453,7 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 						    madvise_range.num_vmas,
 						    args->atomic.val)) {
 				err = -EINVAL;
-				goto madv_fini;
+				goto free_vmas;
 			}
 		}
 
@@ -490,6 +490,7 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 err_fini:
 	if (madvise_range.has_bo_vmas)
 		drm_exec_fini(&exec);
+free_vmas:
 	kfree(madvise_range.vmas);
 	madvise_range.vmas = NULL;
 madv_fini:


