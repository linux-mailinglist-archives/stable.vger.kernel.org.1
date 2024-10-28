Return-Path: <stable+bounces-89010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D02E59B2DAD
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525F51F21F3C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32081DEFC5;
	Mon, 28 Oct 2024 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsLjCbA2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948D1DEFE8;
	Mon, 28 Oct 2024 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112720; cv=none; b=MO8lOj0QRNxe4Wyr4h/ZoNMIyW5NX8yaMObMcGtZDQNLsUNll9q/pvlI28+KkGIEzSvJklogAUB3Qqktt4leLsW/jEjHtV3P+d66OiX+kQixEhjkANc83ZjiK/G6wWoGl0BgRcXMNsxPQtzohVQ+wNH/xY7V5dGvcVj8oAoBO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112720; c=relaxed/simple;
	bh=bIsuXLW/KCKvhvK3+EhfVO5O9oazimM8bvpOYqcxDuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvkJrHoG6GeEtvjuRW1IvFJTvpZkX97VlLbPPgLCdij1TfCgkso8/9LgiNrbXoo9R6dlr0/sdy50EHWsFbbADtVzVO2RlKnqS6UNpOMCa/ZxAfIgAPiHr+/WOwV3kr4YbbT/LJSlcb/mkFIvWaoW/SMaPPI0Dt76dbCqQZ01YaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsLjCbA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F92C4CEE4;
	Mon, 28 Oct 2024 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112720;
	bh=bIsuXLW/KCKvhvK3+EhfVO5O9oazimM8bvpOYqcxDuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsLjCbA2y0XkIvixKQneQVehDf2pwAisqy20KYXsbHF506htYdC1yUFQCeuy57VDX
	 QkYvmxMSCx2AvpEJs65aNQX7sDLqEarMzaZFkXOjFH/QEXsRc4+lqFmCFXNbQ1DXty
	 v2+6f/5aIgcP5V2mr7bYKDDipwVf1vyyft2aWCFTsjmhMRva0w7G28dswFL7U74ndD
	 JO/eDLzLRrwpdfkFaSA66ysjUSvV1JB9+jkWYRhCA3YwXix2z80fPIcW+2dmWITtZp
	 LtNYZv7XB615lvjZic5+5+amMc0YZul8qOLfn3AJO441XpOFH2Pp4xeJcCt7fqqZyK
	 sK7wDsV4xWsBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Jia Yao <jia.yao@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Zongyao Bai <zongyao.bai@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 28/32] drm/xe: Enlarge the invalidation timeout from 150 to 500
Date: Mon, 28 Oct 2024 06:50:10 -0400
Message-ID: <20241028105050.3559169-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit c8fb95e7a54315460b45090f0968167a332e1657 ]

There are error messages like below that are occurring during stress
testing: "[   31.004009] xe 0000:03:00.0: [drm] ERROR GT0: Global
invalidation timeout". Previously it was hitting this 3 out of 1000
executions of warm reboot.  After raising it to 500, 1000 warm reboot
executions passed and it didn't fail.

Due to the way xe_mmio_wait32() is implemented, the timeout is able to
expire early when the register matches the expected value due to the
wait increments starting small. So, the larger timeout value should have
no effect during normal use cases.

v2 (Jonathan):
  - rework the commit message
v3 (Lucas):
  - add conclusive message for the fail rate and test case
v4:
  - add suggested-by

Suggested-by: Jia Yao <jia.yao@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Tested-by: Zongyao Bai <zongyao.bai@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241015161207.1373401-1-shuicheng.lin@intel.com
(cherry picked from commit 2eb460ab9f4bc5b575f52568d17936da0af681d8)
[ Fix conflict with gt->mmio ]
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 8a44a2b6dcbb6..5226333cfdd6d 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -870,7 +870,7 @@ void xe_device_l2_flush(struct xe_device *xe)
 	spin_lock(&gt->global_invl_lock);
 	xe_mmio_write32(gt, XE2_GLOBAL_INVAL, 0x1);
 
-	if (xe_mmio_wait32(gt, XE2_GLOBAL_INVAL, 0x1, 0x0, 150, NULL, true))
+	if (xe_mmio_wait32(gt, XE2_GLOBAL_INVAL, 0x1, 0x0, 500, NULL, true))
 		xe_gt_err_once(gt, "Global invalidation timeout\n");
 	spin_unlock(&gt->global_invl_lock);
 
-- 
2.43.0


