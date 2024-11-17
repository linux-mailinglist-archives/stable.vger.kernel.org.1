Return-Path: <stable+bounces-93729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A98A9D05E1
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9C6282119
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E48D1DB924;
	Sun, 17 Nov 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mwjWvHzB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01B17BB6
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731876419; cv=none; b=QJ21iGXXNFG9/cs0cdbbVYCoIrjWgvzjxfxUNVEFxULdnAmfwnzUcsdEOgJ8hAp4RIKp4m3GaF+17B2PUR+dVP7UHw0+XlmaSQd0XsEccMqAv1i02bZ1nRdy3glolBgwtXug7UguV2H1OXrB2LF1dCgxRwDuknKZs1XheaTLqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731876419; c=relaxed/simple;
	bh=QhTxonAInE+XzSOXSovYZwZz06FGFPspv4zQeCAxLlY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FPBwtgDY2li97XxoIPJD7YJ6BgmFTaRFD7ZF6YOO5A0sEtO6z8Gq6O6rD7ypv9sIRnKwvUDs5tKd+zD5NtjUAImLmdYNSjNHebeyHRNwo/zKNUccGYpD4yZHJ0NxTW0zPFR5tBIbgspiNVx/tzVgn5dN2BEb2LSX+qer8RCvsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mwjWvHzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6499C4CECD;
	Sun, 17 Nov 2024 20:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731876419;
	bh=QhTxonAInE+XzSOXSovYZwZz06FGFPspv4zQeCAxLlY=;
	h=Subject:To:Cc:From:Date:From;
	b=mwjWvHzB8+LaWFyUUTEXcnPefhcBjeqeAoXYxWridHDhbMDJ047NhWpMbRtlM5wVw
	 8OMa7hNrAqiiM/OIAKYFCaIgBZxiWQPAYf9jkFzvzElz2YVSjx87X1YmaB4i8Exjxq
	 8+qO7xMgnbv4Fhwb5uORCi0ls9frM5jnA21vf+Wc=
Subject: FAILED: patch "[PATCH] mmc: sunxi-mmc: Fix A100 compatible description" failed to apply to 5.15-stable tree
To: andre.przywara@arm.com,parthiban@linumiz.com,ulf.hansson@linaro.org,wens@csie.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 21:46:34 +0100
Message-ID: <2024111734-aneurism-aroma-9f52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 85b580afc2c215394e08974bf033de9face94955
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111734-aneurism-aroma-9f52@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85b580afc2c215394e08974bf033de9face94955 Mon Sep 17 00:00:00 2001
From: Andre Przywara <andre.przywara@arm.com>
Date: Thu, 7 Nov 2024 01:42:40 +0000
Subject: [PATCH] mmc: sunxi-mmc: Fix A100 compatible description

It turns out that the Allwinner A100/A133 SoC only supports 8K DMA
blocks (13 bits wide), for both the SD/SDIO and eMMC instances.
And while this alone would make a trivial fix, the H616 falls back to
the A100 compatible string, so we have to now match the H616 compatible
string explicitly against the description advertising 64K DMA blocks.

As the A100 is now compatible with the D1 description, let the A100
compatible string point to that block instead, and introduce an explicit
match against the H616 string, pointing to the old description.
Also remove the redundant setting of clk_delays to NULL on the way.

Fixes: 3536b82e5853 ("mmc: sunxi: add support for A100 mmc controller")
Cc: stable@vger.kernel.org
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Parthiban Nallathambi <parthiban@linumiz.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Message-ID: <20241107014240.24669-1-andre.przywara@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index d3bd0ac99ec4..e0ab5fd635e6 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1191,10 +1191,9 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
 	.needs_new_timings = true,
 };
 
-static const struct sunxi_mmc_cfg sun50i_a100_cfg = {
+static const struct sunxi_mmc_cfg sun50i_h616_cfg = {
 	.idma_des_size_bits = 16,
 	.idma_des_shift = 2,
-	.clk_delays = NULL,
 	.can_calibrate = true,
 	.mask_data0 = true,
 	.needs_new_timings = true,
@@ -1217,8 +1216,9 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun20i-d1-mmc", .data = &sun20i_d1_cfg },
 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
-	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
+	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun20i_d1_cfg },
 	{ .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
+	{ .compatible = "allwinner,sun50i-h616-mmc", .data = &sun50i_h616_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);


