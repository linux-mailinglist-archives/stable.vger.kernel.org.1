Return-Path: <stable+bounces-141213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D4AAB1A2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8713A16D0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2041E2D8E6F;
	Tue,  6 May 2025 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC5tqzDI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381782D900E;
	Mon,  5 May 2025 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485498; cv=none; b=JMngEfTSK9lefHXkodtQAAnJmw/sHR6xih2BEnXgf0ix2W9h5FmXbCympeOPf/pJeKMajF0pABJJRy2sxedTyB0PQ4q38FoBo6SPPg7FQZUUTsLSViSWDpGmbJ5sUZFPGLugbWFRlS6hV7xOvlVvCfn2nYno0sqYA3jlMpauyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485498; c=relaxed/simple;
	bh=coLhG9Pp1bgSTr9mtBnDZVokSNSSpLEUVDDReXuEQes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mm2/Rotyzc1KJTIzdkkF6HtSf/XGGRRuuEoRqdfhGjzO3ezNsN8THMEczz23tpfy+Kr27GUmJio4K9+xn72I+gdZYoS6BeA2CzjhVELQeUnFVyp/2tDmKlkGie6MXAhSgfivY6+LEOtnnIMlOBI2w3/+/wShCAkMbVzCgEYw93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC5tqzDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07A0C4CEE4;
	Mon,  5 May 2025 22:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485498;
	bh=coLhG9Pp1bgSTr9mtBnDZVokSNSSpLEUVDDReXuEQes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JC5tqzDI+zVUhZ3Xl3flGvNNH3EN0VAMeimdQ346xS2QvhbRddC7VGBRYGU30otdN
	 jfKF6TK6b4fcmMK13j67jM4duzTSRK58wpIo5KQXu3hOeNevKnScejcdCg8cH0c5fd
	 PzrSHCraV2VmBqMzlzV37TlFc2wacz7i/40yJP/hv4aY1m5A2YWbgiUuaIs8hjOeij
	 Crg4MF6vSj0AcqiqY1yclvR0h7oQ1yWNerZmUOK9TU1DDCyOuSlgrTiPaiNpo+JmYK
	 3O0nGYRD9LQQgc1U5xAwCvEWx0+tm5MGZjl9v4y/CRpDGQ57zIZLuKxmsrhGEBFDVr
	 MMKnzqs6buteQ==
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
Subject: [PATCH AUTOSEL 6.12 348/486] drm/xe/debugfs: Add missing xe_pm_runtime_put in wedge_mode_set
Date: Mon,  5 May 2025 18:37:04 -0400
Message-Id: <20250505223922.2682012-348-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 051a37e477f4c..278ce1c37b395 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -156,6 +156,7 @@ static ssize_t wedged_mode_set(struct file *f, const char __user *ubuf,
 		ret = xe_guc_ads_scheduler_policy_toggle_reset(&gt->uc.guc.ads);
 		if (ret) {
 			xe_gt_err(gt, "Failed to update GuC ADS scheduler policy. GuC may still cause engine reset even with wedged_mode=2\n");
+			xe_pm_runtime_put(xe);
 			return -EIO;
 		}
 	}
-- 
2.39.5


