Return-Path: <stable+bounces-140189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E19AAA61B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CF5981452
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B77C72623;
	Mon,  5 May 2025 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrQ2to7P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAE7261B;
	Mon,  5 May 2025 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484297; cv=none; b=WFUkHoDvIjvLD67y3JDTrInRNhNLIqNXWHbc44bfA99FCrJYpftyhT/eBWh4EDY+x3IWX8Fv3YyiEns+3Wxhi2oKsa/DnLqFulFvrzHvG48ygWkUX7dtptkHY7DakN7Bzq2PeBknJr2Sf+U2oa1ME6c5pkJH0n+ESvShWGkTsY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484297; c=relaxed/simple;
	bh=t6TI3iTTL62UNxvk9YqXnix3T6orGKEhqzk2cWclT6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHe7IZwkDYyIq2LKG5Rk9yPPFbltEtttBXQsGWuMd8aihLyAoP7oV2fVvP3vt8M/FgCov8fU6GFxmj3deVCZ1tasJzuc8gUl1/nUvrQuXOSuCD+Wa2bGfRl9+A+/PYUqVICyQon7qnPd0jMOYNymoWcr+x42H6AGKJq/zmxkEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrQ2to7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0309EC4CEEF;
	Mon,  5 May 2025 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484297;
	bh=t6TI3iTTL62UNxvk9YqXnix3T6orGKEhqzk2cWclT6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PrQ2to7PMohRHB3p1L4lzgzZcIjc10GZDjD3cDz6Oqox7hcsFUE1ecFjw/mTWRlTd
	 jPEVthJMi/ARMoLXVJq931UtKE5+40DjXZiNjGwPplw7XgDxtdAhd7cTzRgp2ZhUwS
	 x3IJ7syeHE33o9T3Z3QSgnbyBP5+FbrTSiI6ngzls8Ad0tVnuLwXtq3bqI/1TH5IA2
	 yMXXCOEwzElIlGngbg0m1SfbchZlbohyoHDkW1klTKBqcxIDRZw/wU4fHKOylw2Jwr
	 A1X0RgDUHePoY+eGEsmHwmEVOUel1+gqtgJ/X2P5rNuonSVmIESdvHhIQ8/zpxwXSV
	 I1RIAGkP2zOOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 442/642] drm/xe/debugfs: Add missing xe_pm_runtime_put in wedge_mode_set
Date: Mon,  5 May 2025 18:10:58 -0400
Message-Id: <20250505221419.2672473-442-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit b31e668d3111b100d16fd7db8db335328ce8c6d5 ]

xe_pm_runtime_put is missed in the failure path.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213230322.1180621-1-shuicheng.lin@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 6bfdd3a9913fd..92e6fa8fe3a17 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -175,6 +175,7 @@ static ssize_t wedged_mode_set(struct file *f, const char __user *ubuf,
 		ret = xe_guc_ads_scheduler_policy_toggle_reset(&gt->uc.guc.ads);
 		if (ret) {
 			xe_gt_err(gt, "Failed to update GuC ADS scheduler policy. GuC may still cause engine reset even with wedged_mode=2\n");
+			xe_pm_runtime_put(xe);
 			return -EIO;
 		}
 	}
-- 
2.39.5


