Return-Path: <stable+bounces-140196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9805AAA609
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034F41885A1F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C0C31DA41;
	Mon,  5 May 2025 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgftdVMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE428E616;
	Mon,  5 May 2025 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484315; cv=none; b=k/EyyvDQb1OyjfG1OtNxHPuq2oKv8f1gyxkUw4AD8CQuyyipBWT0gBJsZuCu0GqXwx6GyjQPpj6sN9jagFX2V7h9rR/D0iygnyGG4FPHC53cteWrkVZbXA+mpHxZ5nF97V6Uuitgf50NYH0Tb8jpKFujlp9OAB0i2ufC4dpiUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484315; c=relaxed/simple;
	bh=0+x/1ba+TCL1sFEC6TM5FPJpMZfBZBascbItQHc6Fe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KvBtBKHs7wxeQnsSnKVBJWpRovzY9iHsvEQTDUJwrah4Z1O/EEmE2YqCzI2NB3vuDF6hJHUNdrc4P/24jY6ax1P1BPcxaY/6yAjMbRI6H8aYeNAUR83Jg/pwkUSZoPLv2d7HXRRjc+f9ZQvrFtilWBHX2Qs6rO/WXx1BTYR65Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgftdVMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5E6C4CEED;
	Mon,  5 May 2025 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484315;
	bh=0+x/1ba+TCL1sFEC6TM5FPJpMZfBZBascbItQHc6Fe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgftdVMnM5Lz40NihVmPIJ9hkH3xpIQHWB0+2H4ivyTILFQCiRBwpuVydaPJHL1wk
	 XxNQvCmXMrd0H1irgtF1ubhQhNkq3rR0U/XyXhItyt02Ihqc+THG+tG2fJQxWdwrab
	 yx0f8pNVqgHykiFUWBCtVkWahauBg+p91XZe831fwJ7Zb0nnUAhdW5qwZKZMPVmYw+
	 kNXc2iIQZ/e5AnpWDRD3mid5o5udE7HSeXUMsGIpN9jbIMb6zeQgJH9itODs6De1sx
	 iIv88fUft87syUHwp064yUogo23F8czYExy1UfXVkpxWLgolo4/IQIZ0QgFU+a1wph
	 LCGG1BMSZiT8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jani.nikula@linux.intel.com,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 449/642] drm/xe/display: Remove hpd cancel work sync from runtime pm path
Date: Mon,  5 May 2025 18:11:05 -0400
Message-Id: <20250505221419.2672473-449-sashal@kernel.org>
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

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

[ Upstream commit 1ed591582b7b894d2f7e7ab5cef2e9b0b6fef12b ]

This function will synchronously cancel and wait for many display
work queue items, which might try to take the runtime pm reference
causing a bad deadlock. So, remove it from the runtime_pm suspend patch.

Reported-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250212192447.402715-1-rodrigo.vivi@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/display/xe_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index b3921dbc52ff6..b735e30953cee 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -346,7 +346,8 @@ static void __xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 
 	xe_display_flush_cleanup_work(xe);
 
-	intel_hpd_cancel_work(xe);
+	if (!runtime)
+		intel_hpd_cancel_work(xe);
 
 	if (!runtime && has_display(xe)) {
 		intel_display_driver_suspend_access(display);
-- 
2.39.5


