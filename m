Return-Path: <stable+bounces-7940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52DC818FFA
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 19:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF76DB22FB7
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 18:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9005839AE1;
	Tue, 19 Dec 2023 18:48:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cam-smtp0.cambridge.arm.com (fw-tnat-cam2.arm.com [217.140.106.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DD39AD6
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from e132893.cambridge.arm.com (e132893.arm.com [10.1.201.36])
	by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id 3BJFq1PZ022191;
	Tue, 19 Dec 2023 15:52:01 GMT
From: Lingkai Dong <lingkai.dong@arm.com>
To: stable@vger.kernel.org
Cc: nd@arm.com, Lingkai Dong <Lingkai.Dong@arm.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 6.6.y] drm: Fix FD ownership check in drm_master_check_perm()
Date: Tue, 19 Dec 2023 15:51:34 +0000
Message-Id: <20231219155134.745211-1-lingkai.dong@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023121851-roamer-gravel-ddbe@gregkh>
References: <2023121851-roamer-gravel-ddbe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lingkai Dong <Lingkai.Dong@arm.com>

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
(cherry picked from commit 5a6c9a05e55cb2972396cc991af9d74c8c15029a)
---
 drivers/gpu/drm/drm_auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index cf92a9ae8034c..7ef8a2762e818 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -235,7 +235,7 @@ static int drm_new_set_master(struct drm_device *dev, struct drm_file *fpriv)
 static int
 drm_master_check_perm(struct drm_device *dev, struct drm_file *file_priv)
 {
-	if (file_priv->pid == task_pid(current) && file_priv->was_master)
+	if (file_priv->pid == task_tgid(current) && file_priv->was_master)
 		return 0;
 
 	if (!capable(CAP_SYS_ADMIN))
-- 
2.34.1


