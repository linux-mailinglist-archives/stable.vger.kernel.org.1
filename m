Return-Path: <stable+bounces-4604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C56480482D
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4511C20ED3
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E2479E3;
	Tue,  5 Dec 2023 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2szcuUV6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026F6FB0;
	Tue,  5 Dec 2023 03:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F7AC433C8;
	Tue,  5 Dec 2023 03:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701748004;
	bh=lekGiE/gapQG01GMk0Yyl8Q8hRzQcbgjEfWRet+M2qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2szcuUV6lFrmEsAoPWw+76t05UoFejGcZvMbvBLOHqlLpnoDyU18AqNvFfmSH6u7S
	 MARB92ivuwnbXcobwHKicC7w16fRZ+uBsf2wwAIsi97zu9AV+eGFzh+k3KFnfohQRd
	 Rp17cCjjB97NJK6oZAcQSz8iyjhqdMoYLgEM2MKs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 78/94] mtd: cfi_cmdset_0001: Support the absence of protection registers
Date: Tue,  5 Dec 2023 12:17:46 +0900
Message-ID: <20231205031527.169129248@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031522.815119918@linuxfoundation.org>
References: <20231205031522.815119918@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

[ Upstream commit b359ed5184aebf9d987e54abc5dae7ac03ed29ae ]

The flash controller implemented by the Arm Base platform behaves like
the Intel StrataFlash J3 device, but omits several features. In
particular it doesn't implement a protection register, so "Number of
Protection register fields" in the Primary Vendor-Specific Extended
Query, is 0.

The Intel StrataFlash J3 datasheet only lists 1 as a valid value for
NumProtectionFields. It describes the field as:

	"Number of Protection register fields in JEDEC ID space.
	“00h,” indicates that 256 protection bytes are available"

While a value of 0 may arguably not be architecturally valid, the
driver's current behavior is certainly wrong: if NumProtectionFields is
0, read_pri_intelext() adds a negative value to the unsigned extra_size,
and ends up in an infinite loop.

Fix it by ignoring a NumProtectionFields of 0.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Stable-dep-of: 565fe150624e ("mtd: cfi_cmdset_0001: Byte swap OTP info")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/chips/cfi_cmdset_0001.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 79a53cb8507b6..1d77687b67169 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -420,8 +420,9 @@ read_pri_intelext(struct map_info *map, __u16 adr)
 		extra_size = 0;
 
 		/* Protection Register info */
-		extra_size += (extp->NumProtectionFields - 1) *
-			      sizeof(struct cfi_intelext_otpinfo);
+		if (extp->NumProtectionFields)
+			extra_size += (extp->NumProtectionFields - 1) *
+				      sizeof(struct cfi_intelext_otpinfo);
 	}
 
 	if (extp->MinorVersion >= '1') {
@@ -695,14 +696,16 @@ static int cfi_intelext_partition_fixup(struct mtd_info *mtd,
 	 */
 	if (extp && extp->MajorVersion == '1' && extp->MinorVersion >= '3'
 	    && extp->FeatureSupport & (1 << 9)) {
+		int offs = 0;
 		struct cfi_private *newcfi;
 		struct flchip *chip;
 		struct flchip_shared *shared;
-		int offs, numregions, numparts, partshift, numvirtchips, i, j;
+		int numregions, numparts, partshift, numvirtchips, i, j;
 
 		/* Protection Register info */
-		offs = (extp->NumProtectionFields - 1) *
-		       sizeof(struct cfi_intelext_otpinfo);
+		if (extp->NumProtectionFields)
+			offs = (extp->NumProtectionFields - 1) *
+			       sizeof(struct cfi_intelext_otpinfo);
 
 		/* Burst Read info */
 		offs += extp->extra[offs+1]+2;
-- 
2.42.0




