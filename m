Return-Path: <stable+bounces-34064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19354893DBA
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0207E1C20E4E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B84CB35;
	Mon,  1 Apr 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0zriyS/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8873FE2D;
	Mon,  1 Apr 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986887; cv=none; b=rALx7wYWPNpQvU5rXSVFAoqOtEFYjeVmo8wDZOIbVrsg0oCtZaMhSazKOy4Lf1SFcDY6Zh56GVCifv0Sx63pftCC8oS3dYw181hiDMIVrEX5qvVhtJPuhCbJ5LcVssknUD5YWLPtxBfGc530KocHJnCeHE9hn+uYozFjr+cD8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986887; c=relaxed/simple;
	bh=2VMu6tDIfbYyEXc5vVp7PP1v8ltqWIZtnjNSaJP98uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPNtFEczgJ+YCz3gMYtMEHvVyRt0i4Z/vlMBCqaq3xL/MGpEMmcM7G2jP1Bj9b9YK10Ym0oyBBwKq1Oyg/rjXQwG2MLukBloA+ovjoDzNN8gNiYY/fDTr9H26UqDhOxiSV6EEvMtb9FJjRiSOI2EdmOfDG3Dyav8hohNtXtWfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y0zriyS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77401C433C7;
	Mon,  1 Apr 2024 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711986885;
	bh=2VMu6tDIfbYyEXc5vVp7PP1v8ltqWIZtnjNSaJP98uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0zriyS/50+CSlNOKYl3efDBz9Q/NQHOIGzcwIY8JieZMlpry7EYadfFMes6HnkQ7
	 jPvb7O1xStv+3797lPqU7++aZUImVII9H3z5PinoCyy427mLU/yiTpFc+HgDy0/SQ5
	 gyo5KBQdf/g0cMbOv0z21ofRiOcJj5o5hIHnx1gA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 117/399] mmc: core: Fix switch on gp3 partition
Date: Mon,  1 Apr 2024 17:41:23 +0200
Message-ID: <20240401152552.682298190@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

[ Upstream commit 4af59a8df5ea930038cd3355e822f5eedf4accc1 ]

Commit e7794c14fd73 ("mmc: rpmb: fixes pause retune on all RPMB
partitions.") added a mask check for 'part_type', but the mask used was
wrong leading to the code intended for rpmb also being executed for GP3.

On some MMCs (but not all) this would make gp3 partition inaccessible:
armadillo:~# head -c 1 < /dev/mmcblk2gp3
head: standard input: I/O error
armadillo:~# dmesg -c
[  422.976583] mmc2: running CQE recovery
[  423.058182] mmc2: running CQE recovery
[  423.137607] mmc2: running CQE recovery
[  423.137802] blk_update_request: I/O error, dev mmcblk2gp3, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 4 prio class 0
[  423.237125] mmc2: running CQE recovery
[  423.318206] mmc2: running CQE recovery
[  423.397680] mmc2: running CQE recovery
[  423.397837] blk_update_request: I/O error, dev mmcblk2gp3, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  423.408287] Buffer I/O error on dev mmcblk2gp3, logical block 0, async page read

the part_type values of interest here are defined as follow:
main  0
boot0 1
boot1 2
rpmb  3
gp0   4
gp1   5
gp2   6
gp3   7

so mask with EXT_CSD_PART_CONFIG_ACC_MASK (7) to correctly identify rpmb

Fixes: e7794c14fd73 ("mmc: rpmb: fixes pause retune on all RPMB partitions.")
Cc: stable@vger.kernel.org
Cc: Jorge Ramirez-Ortiz <jorge@foundries.io>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/block.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 32d49100dff51..86efa6084696e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -874,10 +874,11 @@ static const struct block_device_operations mmc_bdops = {
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
-	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_MASK;
+	const unsigned int rpmb = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if ((part_type & mask) == mask) {
+	if ((part_type & mask) == rpmb) {
 		if (card->ext_csd.cmdq_en) {
 			ret = mmc_cmdq_disable(card);
 			if (ret)
@@ -892,10 +893,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 static int mmc_blk_part_switch_post(struct mmc_card *card,
 				    unsigned int part_type)
 {
-	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_MASK;
+	const unsigned int rpmb = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if ((part_type & mask) == mask) {
+	if ((part_type & mask) == rpmb) {
 		mmc_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);
-- 
2.43.0




