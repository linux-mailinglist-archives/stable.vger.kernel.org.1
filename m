Return-Path: <stable+bounces-97467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CA59E2985
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3965BBA68FB
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05014204F98;
	Tue,  3 Dec 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nI9iwQrq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A811F8AFF;
	Tue,  3 Dec 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240605; cv=none; b=NI/UlOZVuQUIralMTXBEsR5cg/p5mNOlwEgUeeQJxR6DhpKRTqBXjJcCgvSUgmDL05OLzgnr22Sp/s/C9ZyW9JBTkpuaX4EBzdW2cd43sNhLM/O6Gu0FmUIQa5reJoXsfWyFhRMOndelrM7mFfDSDRcukeS2Us90zMYSNVImkmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240605; c=relaxed/simple;
	bh=f6L8O/TV5QctOPGfgBGkZfPxYlj6hHUi+NrM3BpLp9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARJDBBqRCOZtmU/ESDNAfLq29E4NuhWsSd9J2U1Mlgd7jF0U6P5LRUla0hSB7C0XyhZ42dCTuNSXAM9ME+G3kUt8MHd1evMdPTYuNSr7AsJTFRmdYBo7VPoBglEnIRdiDHpCOAg8f7YFViXDXyhk2F4WUP8BI0QeCOxU/oU7h5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nI9iwQrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23177C4CECF;
	Tue,  3 Dec 2024 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240605;
	bh=f6L8O/TV5QctOPGfgBGkZfPxYlj6hHUi+NrM3BpLp9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nI9iwQrqH1EdnwX3DJHMFXeSe7CHFE7KgYKtSfiP5td6hHgFLY76jQJUVwdIUeep8
	 ygqpHuMc0OPOPlS5klZUznKhRpK9n++UFygnxjh9NNCQnxQAYoOilAp1CVk5geelXY
	 K7mUQKb2JRDryuO/hLQlMT40HNREBybhDJcfbKXo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dom Cobley <popcornmix@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 185/826] drm/vc4: hdmi: Avoid hang with debug registers when suspended
Date: Tue,  3 Dec 2024 15:38:32 +0100
Message-ID: <20241203144750.958642690@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dom Cobley <popcornmix@gmail.com>

[ Upstream commit 223ee2567a55e4f80315c768d2969e6a3b9fb23d ]

Trying to read /sys/kernel/debug/dri/1/hdmi1_regs
when the hdmi is disconnected results in a fatal system hang.

This is due to the pm suspend code disabling the dvp clock.
That is just a gate of the 108MHz clock in DVP_HT_RPI_MISC_CONFIG,
which results in accesses hanging AXI bus.

Protect against this.

Fixes: 25eb441d55d4 ("drm/vc4: hdmi: Add all the vc5 HDMI registers into the debugfs dumps")
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240621152055.4180873-17-dave.stevenson@raspberrypi.com
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 6611ab7c26a63..6c2215068c537 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -147,6 +147,8 @@ static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 	if (!drm_dev_enter(drm, &idx))
 		return -ENODEV;
 
+	WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
+
 	drm_print_regset32(&p, &vc4_hdmi->hdmi_regset);
 	drm_print_regset32(&p, &vc4_hdmi->hd_regset);
 	drm_print_regset32(&p, &vc4_hdmi->cec_regset);
@@ -156,6 +158,8 @@ static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 	drm_print_regset32(&p, &vc4_hdmi->ram_regset);
 	drm_print_regset32(&p, &vc4_hdmi->rm_regset);
 
+	pm_runtime_put(&vc4_hdmi->pdev->dev);
+
 	drm_dev_exit(idx);
 
 	return 0;
-- 
2.43.0




