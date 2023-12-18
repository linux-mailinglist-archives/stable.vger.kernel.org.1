Return-Path: <stable+bounces-6956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB391816747
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5721C2225F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 07:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA1B79E6;
	Mon, 18 Dec 2023 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TN09O+Wu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DDB79D9
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5100C433C7;
	Mon, 18 Dec 2023 07:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702884002;
	bh=ah99foPDIpL5X0j2BDGyNqk6g4c8M+T3b7s47GhgnRM=;
	h=Subject:To:Cc:From:Date:From;
	b=TN09O+WuWGlrYVsRMbKae4na68n+D1xzQt6HjwOHjdwKwvEOg6cvpsnsZXV+bB3Uf
	 rt5KUeCAyQSxrkQ7mO72jMy+sw6X/hM3/zunf+66Aus3dzs5Kdgh7k8k2XQygrth1y
	 qWbl6p2JRQyovKbAv8AAbza2Zi4XA/NFrlJanmCw=
Subject: FAILED: patch "[PATCH] drm: Fix FD ownership check in drm_master_check_perm()" failed to apply to 6.6-stable tree
To: Lingkai.Dong@arm.com,christian.koenig@amd.com,lingkai.dong@arm.com,stable@vger.kernel.org,tvrtko.ursulin@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Dec 2023 08:19:51 +0100
Message-ID: <2023121851-roamer-gravel-ddbe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5a6c9a05e55cb2972396cc991af9d74c8c15029a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121851-roamer-gravel-ddbe@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

5a6c9a05e55c ("drm: Fix FD ownership check in drm_master_check_perm()")
1c7a387ffef8 ("drm: Update file owner during use")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a6c9a05e55cb2972396cc991af9d74c8c15029a Mon Sep 17 00:00:00 2001
From: Lingkai Dong <Lingkai.Dong@arm.com>
Date: Wed, 6 Dec 2023 13:51:58 +0000
Subject: [PATCH] drm: Fix FD ownership check in drm_master_check_perm()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The DRM subsystem keeps a record of the owner of a DRM device file
descriptor using thread group ID (TGID) instead of process ID (PID), to
ensures all threads within the same userspace process are considered the
owner. However, the DRM master ownership check compares the current
thread's PID against the record, so the thread is incorrectly considered to
be not the FD owner if the PID is not equal to the TGID. This causes DRM
ioctls to be denied master privileges, even if the same thread that opened
the FD performs an ioctl. Fix this by checking TGID.

Fixes: 4230cea89cafb ("drm: Track clients by tgid and not tid")
Signed-off-by: Lingkai Dong <lingkai.dong@arm.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: <stable@vger.kernel.org> # v6.4+
Link: https://patchwork.freedesktop.org/patch/msgid/PA6PR08MB107665920BE9A96658CDA04CE8884A@PA6PR08MB10766.eurprd08.prod.outlook.com
Signed-off-by: Christian König <christian.koenig@amd.com>

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index 2ed2585ded37..6899b3dc1f12 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -236,7 +236,7 @@ static int
 drm_master_check_perm(struct drm_device *dev, struct drm_file *file_priv)
 {
 	if (file_priv->was_master &&
-	    rcu_access_pointer(file_priv->pid) == task_pid(current))
+	    rcu_access_pointer(file_priv->pid) == task_tgid(current))
 		return 0;
 
 	if (!capable(CAP_SYS_ADMIN))


