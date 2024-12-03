Return-Path: <stable+bounces-96591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDE89E20B0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FD4B84CDF
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4962D1F6698;
	Tue,  3 Dec 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CugzjO6t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1F1DA4E;
	Tue,  3 Dec 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238018; cv=none; b=qstMrWIwTTtsKGfQOUlr/IlTLz/jXFK5NLgHFtkrvqkboe6lruic8iKQcwzAw9V+yF6QT8bowKFeDJG40PCAe+6H2U2fsagC0/OhmithcvI8hp3j4tyrvpHBGo5vdhu2Y7zUB/nsqX1UtZKEKB3y4i+y+5tp+SdcxpyzVFUFW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238018; c=relaxed/simple;
	bh=6mWMaXo83ANg7XNK7cjO19cKZ1xfrfdACqrHv/oL0os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocItknDEUX5GaJRNIEfcF+qAo+vztz1jy8SiI/gRAa1rGryYQClXh1Ru8CDFcehl3VSDWFBiYIJFMOX4sRJroLJo6+DgNMWDT/FyFQkmtlPr8m1hA2R9kE++nmmLeaUNz2c5vk702z078nmrh89iEYm7ifKlkINImjz2slNKtS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CugzjO6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7E6C4CECF;
	Tue,  3 Dec 2024 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238017;
	bh=6mWMaXo83ANg7XNK7cjO19cKZ1xfrfdACqrHv/oL0os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CugzjO6tqNVduTA43l4veDsZvY8coD4LVoJRS52lpbF5j4o+s4FJzoM3favy8jOzj
	 4nwXVfRa8eF6U/Rtx+a6hyXQnsS23u+bQl3mCq/B96VSYFst6NMuuR0tlpO3hzTOvW
	 oYfg4z4suOWAoUoYQPLt0JA+0DZcJhcWQWK3CiFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Priyanka Singh <priyanka.singh@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 104/817] EDAC/fsl_ddr: Fix bad bit shift operations
Date: Tue,  3 Dec 2024 15:34:36 +0100
Message-ID: <20241203143959.767964107@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Priyanka Singh <priyanka.singh@nxp.com>

[ Upstream commit 9ec22ac4fe766c6abba845290d5139a3fbe0153b ]

Fix undefined behavior caused by left-shifting a negative value in the
expression:

    cap_high ^ (1 << (bad_data_bit - 32))

The variable bad_data_bit ranges from 0 to 63. When it is less than 32,
bad_data_bit - 32 becomes negative, and left-shifting by a negative
value in C is undefined behavior.

Fix this by combining cap_high and cap_low into a 64-bit variable.

  [ bp: Massage commit message, simplify error bits handling. ]

Fixes: ea2eb9a8b620 ("EDAC, fsl-ddr: Separate FSL DDR driver from MPC85xx")
Signed-off-by: Priyanka Singh <priyanka.singh@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241016-imx95_edac-v3-3-86ae6fc2756a@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/fsl_ddr_edac.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index d148d262d0d4d..339d94b3d04c7 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -328,21 +328,25 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 	 * TODO: Add support for 32-bit wide buses
 	 */
 	if ((err_detect & DDR_EDE_SBE) && (bus_width == 64)) {
+		u64 cap = (u64)cap_high << 32 | cap_low;
+		u32 s = syndrome;
+
 		sbe_ecc_decode(cap_high, cap_low, syndrome,
 				&bad_data_bit, &bad_ecc_bit);
 
-		if (bad_data_bit != -1)
-			fsl_mc_printk(mci, KERN_ERR,
-				"Faulty Data bit: %d\n", bad_data_bit);
-		if (bad_ecc_bit != -1)
-			fsl_mc_printk(mci, KERN_ERR,
-				"Faulty ECC bit: %d\n", bad_ecc_bit);
+		if (bad_data_bit >= 0) {
+			fsl_mc_printk(mci, KERN_ERR, "Faulty Data bit: %d\n", bad_data_bit);
+			cap ^= 1ULL << bad_data_bit;
+		}
+
+		if (bad_ecc_bit >= 0) {
+			fsl_mc_printk(mci, KERN_ERR, "Faulty ECC bit: %d\n", bad_ecc_bit);
+			s ^= 1 << bad_ecc_bit;
+		}
 
 		fsl_mc_printk(mci, KERN_ERR,
 			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
-			cap_high ^ (1 << (bad_data_bit - 32)),
-			cap_low ^ (1 << bad_data_bit),
-			syndrome ^ (1 << bad_ecc_bit));
+			upper_32_bits(cap), lower_32_bits(cap), s);
 	}
 
 	fsl_mc_printk(mci, KERN_ERR,
-- 
2.43.0




