Return-Path: <stable+bounces-99394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E799E7182
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C838A164458
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266915667D;
	Fri,  6 Dec 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hbi6ppyn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8891442E8;
	Fri,  6 Dec 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497006; cv=none; b=QplGAQqMSyweJn5oA+dNXk+BLAEgXT1Q0PSiJQt41NovbswPwAcN4JEeeZSyuPwYsM+3p2FYv4d3v0neM4Z+sWpjdKFNTOwv322baY0zTH0rYWBZcByRM43vQrz89oU7/6njEEPyt7L85wcnPYe34b58jU0/Ompp4Frt7ceSp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497006; c=relaxed/simple;
	bh=/oGm5zBvUP/e0sb9l1+oQM03MhD5RswDihJ+aD4Z7C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvCCjOildOBlxdwbXCuqSyOxGQYYoXWAJLo8kWv3WWrpoL3/dQxY8dluvzWpwtHL/kSgDtsZp0Sbwcf3O0x59lwjzAhHx3EQPO0FLzsC+F3fJ3MPx8XL4H7LZ7+SW84ZLk7gf0UvKrV+fgIL9fjL0laHngJ7sBV0ti8CMwey3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hbi6ppyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB76C4CED1;
	Fri,  6 Dec 2024 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497006;
	bh=/oGm5zBvUP/e0sb9l1+oQM03MhD5RswDihJ+aD4Z7C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hbi6ppynvoRa2iYKNqmA4G+0KFNhEia/Ks/HaIsuSjES9Wggn9UZ8pll1XFtxSqrK
	 2Y+Nuu9ZO6Az8+ABorIXKSqp+7ud9OmEAQDFoaGW4kPESaDjwoKGN/Ui/wXoKzWZTT
	 w/KPrVogzg2qxtfG6nb3VzxESLL2xAdDsONkA9tw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 168/676] drm/vc4: hvs: Remove incorrect limit from hvs_dlist debugfs function
Date: Fri,  6 Dec 2024 15:29:47 +0100
Message-ID: <20241206143659.913628398@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

[ Upstream commit d285bb622ebdfaa84f51df3a1abccb87036157ea ]

The debugfs function to dump dlists aborted at 256 bytes,
when actually the dlist memory is generally significantly
larger but varies based on SoC.

We already have the correct limit in __vc4_hvs_alloc, so
store it for use in the debugfs dlist function.

Fixes: c6dac00340fc ("drm/vc4: hvs: Add debugfs node that dumps the current display lists")
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240621152055.4180873-19-dave.stevenson@raspberrypi.com
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 1 +
 drivers/gpu/drm/vc4/vc4_hvs.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index bf66499765fbb..ac4ad95b36438 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -314,6 +314,7 @@ struct vc4_hvs {
 	struct platform_device *pdev;
 	void __iomem *regs;
 	u32 __iomem *dlist;
+	unsigned int dlist_mem_size;
 
 	struct clk *core_clk;
 
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 7137a90e6efa7..3e72219a6a75f 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -110,6 +110,7 @@ static int vc4_hvs_debugfs_dlist(struct seq_file *m, void *data)
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_hvs *hvs = vc4->hvs;
 	struct drm_printer p = drm_seq_file_printer(m);
+	unsigned int dlist_mem_size = hvs->dlist_mem_size;
 	unsigned int next_entry_start;
 	unsigned int i, j;
 	u32 dlist_word, dispstat;
@@ -126,7 +127,7 @@ static int vc4_hvs_debugfs_dlist(struct seq_file *m, void *data)
 		drm_printf(&p, "HVS chan %u:\n", i);
 		next_entry_start = 0;
 
-		for (j = HVS_READ(SCALER_DISPLISTX(i)); j < 256; j++) {
+		for (j = HVS_READ(SCALER_DISPLISTX(i)); j < dlist_mem_size; j++) {
 			dlist_word = readl((u32 __iomem *)vc4->hvs->dlist + j);
 			drm_printf(&p, "dlist: %02d: 0x%08x\n", j,
 				   dlist_word);
@@ -804,9 +805,10 @@ struct vc4_hvs *__vc4_hvs_alloc(struct vc4_dev *vc4, struct platform_device *pde
 	 * our 16K), since we don't want to scramble the screen when
 	 * transitioning from the firmware's boot setup to runtime.
 	 */
+	hvs->dlist_mem_size = (SCALER_DLIST_SIZE >> 2) - HVS_BOOTLOADER_DLIST_END;
 	drm_mm_init(&hvs->dlist_mm,
 		    HVS_BOOTLOADER_DLIST_END,
-		    (SCALER_DLIST_SIZE >> 2) - HVS_BOOTLOADER_DLIST_END);
+		    hvs->dlist_mem_size);
 
 	/* Set up the HVS LBM memory manager.  We could have some more
 	 * complicated data structure that allowed reuse of LBM areas
-- 
2.43.0




