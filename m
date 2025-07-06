Return-Path: <stable+bounces-160298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27ECAFA4EA
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 13:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457A63A83C8
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11731ACEAC;
	Sun,  6 Jul 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KOeOuhH4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217A14A0A8
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802563; cv=none; b=q/QjI/1/BCQHnwOVUv27DEIx+AQCfuga+ifjH7voMCbgQTdy22tOowOYnpWVMCJXe2kO+eBDQaSjc4bU3p8S9qWntQsGR6pwzQ7T9IC0O5zUgQ94EEvUwbWL14/Q7FDAR4TLInJLt1LxcWJWqIG8VRBb8s6krfujs49BEBxYu1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802563; c=relaxed/simple;
	bh=UPMiM//0E0FVwzhVlKpwOtzS6oe/UlSW/bjyZ3nylJ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AcCEpio8EB+sVaG5sdUv5agFe+g5oi5nMKScBhCQhRE7klA0Jp6jDOGw84T8MmaKWZ/NqLeX2ZXS14GZlig9O77W+Rcg4ckl8cY8rrt0zE/zTjZWyRmVw7vIAlLCI500QPB3fg82WHOd0dEX09w0EF5puWHgC9p+TXlMacG8jgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KOeOuhH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6ACC4CEED;
	Sun,  6 Jul 2025 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802563;
	bh=UPMiM//0E0FVwzhVlKpwOtzS6oe/UlSW/bjyZ3nylJ4=;
	h=Subject:To:Cc:From:Date:From;
	b=KOeOuhH4SXGQXV0j10M3//FAGGDR6iSnIlODi4o3zEMt73BW1RN7OfKyjHUpm3AWE
	 TTOcv08cuNbdHRyeS/pC62DaXOQemL9NtRVhSIPLM/Wcd5Uck+z2v596/g8NO9xu9W
	 6CSjivISg1lwnXEJldQQvso6r5uDDkNXSxw/yc6U=
Subject: FAILED: patch "[PATCH] mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier" failed to apply to 5.15-stable tree
To: avri.altman@sandisk.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:49:20 +0200
Message-ID: <2025070620-seclusion-jarring-cacd@gregkh>
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
git cherry-pick -x 009c3a4bc41e855fd76f92727f9fbae4e5917d7f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070620-seclusion-jarring-cacd@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 009c3a4bc41e855fd76f92727f9fbae4e5917d7f Mon Sep 17 00:00:00 2001
From: Avri Altman <avri.altman@sandisk.com>
Date: Mon, 26 May 2025 14:44:45 +0300
Subject: [PATCH] mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier

Move the BROKEN_SD_DISCARD quirk for certain SanDisk SD cards from the
`mmc_blk_fixups[]` to `mmc_sd_fixups[]`. This ensures the quirk is
applied earlier in the device initialization process, aligning with the
reasoning in [1]. Applying the quirk sooner prevents the kernel from
incorrectly enabling discard support on affected cards during initial
setup.

[1] https://lore.kernel.org/all/20240820230631.GA436523@sony.com

Fixes: 07d2872bf4c8 ("mmc: core: Add SD card quirk for broken discard")
Signed-off-by: Avri Altman <avri.altman@sandisk.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250526114445.675548-1-avri.altman@sandisk.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 7f893bafaa60..c417ed34c057 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -44,6 +44,12 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
 		   MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
 
+	/*
+	 * Some SD cards reports discard support while they don't
+	 */
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
+		  MMC_QUIRK_BROKEN_SD_DISCARD),
+
 	END_FIXUP
 };
 
@@ -147,12 +153,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
-	/*
-	 * Some SD cards reports discard support while they don't
-	 */
-	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
-		  MMC_QUIRK_BROKEN_SD_DISCARD),
-
 	END_FIXUP
 };
 


