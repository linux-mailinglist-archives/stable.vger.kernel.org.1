Return-Path: <stable+bounces-127972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629A1A7ADC6
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EC717F102
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3E929214B;
	Thu,  3 Apr 2025 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRR23CEj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5A292145;
	Thu,  3 Apr 2025 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707647; cv=none; b=MYLZfp8kODQA3iorucwS/f/YVHEcXSx0bl+KZ7qyx0zzrARTRLapCySQoGIunTkcaS83W/tcSwH0JTwmRRuDdvW3VJE+GjKxfRtAR/WFKfeInDeoor39xMf6NUuVLdNiEhfBMCp83w0dhQoLMO7kBxWCdcmmUxLJ7uGAh/Pjgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707647; c=relaxed/simple;
	bh=RsSQvyW3QrtSAJP9FCcNN6N/x+TyIyFZQExTiaNbHWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gs/GCK3+vOMwqch2xe/z+Aq01qmlwSB0RHLq4ZPCJOMqfwrbtyWR2v3V3e94uMVUfRON+9iphrz3AKkITy0XIT/n9KcGogN1U/ITEN+zJ5FJAluA3kq8H8nRmyEBLQoy63JLrVKs6wMd1vvO9ftqzZeu0osMXg4JilCCOMspM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRR23CEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF334C4CEE9;
	Thu,  3 Apr 2025 19:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707647;
	bh=RsSQvyW3QrtSAJP9FCcNN6N/x+TyIyFZQExTiaNbHWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRR23CEjxwF9tOAD7D76WQuCkO2Sju/+Wa4KheyaFlq/3jriDOd0Eqvp+6/8zIsKy
	 VbsilYjHicM3saA+UVItPh6tlCQICNd1Df/AQUQcichv3JtVlLMNOD8A+8O7CJ09bX
	 Jp3AO7bTz5wbwo56EKbYPqmFtaMA2jQZ2nmIXyKIPG6gOoPCt4T4pqWueF426ELU9J
	 oHnW+tOwQ+5cLmJTsH6iYAUm5A861NjeIQ6LJYTHdq+yeRqlI0X7Z/yckC1/H/lkll
	 QzJUNfkH7tHlFF3Ig9kLyzBhdsRvXzlmVXZEAEFZIn/j2SvJUj+N7HFHAqK/usZTT7
	 jSx4e4snsfFCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 17/44] drm/debugfs: fix printk format for bridge index
Date: Thu,  3 Apr 2025 15:12:46 -0400
Message-Id: <20250403191313.2679091-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit 72443c730b7a7b5670a921ea928e17b9b99bd934 ]

idx is an unsigned int, use %u for printk-style strings.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250214-drm-assorted-cleanups-v7-1-88ca5827d7af@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 536409a35df40..6b2178864c7ee 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -748,7 +748,7 @@ static int bridges_show(struct seq_file *m, void *data)
 	unsigned int idx = 0;
 
 	drm_for_each_bridge_in_chain(encoder, bridge) {
-		drm_printf(&p, "bridge[%d]: %ps\n", idx++, bridge->funcs);
+		drm_printf(&p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
 		drm_printf(&p, "\ttype: [%d] %s\n",
 			   bridge->type,
 			   drm_get_connector_type_name(bridge->type));
-- 
2.39.5


