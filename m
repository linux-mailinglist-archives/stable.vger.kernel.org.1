Return-Path: <stable+bounces-84206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5560899CEE1
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31831F24200
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D831B4F23;
	Mon, 14 Oct 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z8racGtN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600271B4F25;
	Mon, 14 Oct 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917202; cv=none; b=Rn448NyCUGhCkc9lji/sVJBVzsa4Z76evfLq8tLjwZo4n4GRCZ29Z9ddBX3zA4wS+dFo/584K3Pfm+ZVVU5kPwvDGw1FtOWiLi8Ji9GY3vVAnEKg2FAnfF/2upGg6CWUDQ9d6/LQyNwFWCHNaAZ2t6n8JvJYU4bgyimQ5D7LYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917202; c=relaxed/simple;
	bh=41s/XLmh8T6etMV3wMpEU5Z9Sy/CyV+m06ZmaITgB4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTqRhQdCoqJjfy+2z+7CoFoUcbp8736wdXLjs+8/VkiWctzc5sVMZ74XdgBF2511vjbKvRCjCylL/NU1Peh7sjMEHg57mHCFd1JOd6mxhrYrWTkPesr0auy2EJNogOCMWsKyO/EFeh0bPcdQvjgB7JOLQaadVeXt1djFHnULiOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z8racGtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D764DC4CECF;
	Mon, 14 Oct 2024 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917202;
	bh=41s/XLmh8T6etMV3wMpEU5Z9Sy/CyV+m06ZmaITgB4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8racGtNHVLdvmENgjiRRRthva4QR/IGJllZHkYp/mtJHQw1a629PokfilLZssegM
	 IyO1UJfMho4B7VPBAQq1PdZpR7tGcQQqodcLEwLSgLMxUHq4nnsVoI90ZpZCdIBDiD
	 UvnDgKPXqNkvFNEPNKwPmEF8Wj3Vp1ewjBe7mHN0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Colberg <peter.colberg@intel.com>,
	Michael Adler <michael.adler@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 174/213] hwmon: intel-m10-bmc-hwmon: relabel Columbiaville to CVL Die Temperature
Date: Mon, 14 Oct 2024 16:21:20 +0200
Message-ID: <20241014141049.758157545@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
References: <20241014141042.954319779@linuxfoundation.org>
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

From: Peter Colberg <peter.colberg@intel.com>

[ Upstream commit a017616fafc6b2a6b3043bf46f6381ef2611c188 ]

Consistently use CVL instead of Columbiaville, since CVL is already
being used in all other sensor labels for the Intel N6000 card.

Fixes: e1983220ae14 ("hwmon: intel-m10-bmc-hwmon: Add N6000 sensors")
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Michael Adler <michael.adler@intel.com>
Message-ID: <20240919173417.867640-1-peter.colberg@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/intel-m10-bmc-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
index ca2dff1589251..96397ae6ff18f 100644
--- a/drivers/hwmon/intel-m10-bmc-hwmon.c
+++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
@@ -358,7 +358,7 @@ static const struct m10bmc_sdata n6000bmc_temp_tbl[] = {
 	{ 0x4f0, 0x4f4, 0x4f8, 0x52c, 0x0, 500, "Board Top Near FPGA Temperature" },
 	{ 0x4fc, 0x500, 0x504, 0x52c, 0x0, 500, "Board Bottom Near CVL Temperature" },
 	{ 0x508, 0x50c, 0x510, 0x52c, 0x0, 500, "Board Top East Near VRs Temperature" },
-	{ 0x514, 0x518, 0x51c, 0x52c, 0x0, 500, "Columbiaville Die Temperature" },
+	{ 0x514, 0x518, 0x51c, 0x52c, 0x0, 500, "CVL Die Temperature" },
 	{ 0x520, 0x524, 0x528, 0x52c, 0x0, 500, "Board Rear Side Temperature" },
 	{ 0x530, 0x534, 0x538, 0x52c, 0x0, 500, "Board Front Side Temperature" },
 	{ 0x53c, 0x540, 0x544, 0x0, 0x0, 500, "QSFP1 Case Temperature" },
-- 
2.43.0




