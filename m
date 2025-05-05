Return-Path: <stable+bounces-141411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D2BAAB6FB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272213B0306
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA13226CF0;
	Tue,  6 May 2025 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxtgr4NV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE463710E9;
	Mon,  5 May 2025 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486200; cv=none; b=qcP9106rPvM05AtFntAaEqJbW8ybdZAAb70VI6/zFC4IZ4/QilI7xTKZFQW4vHZA5aNGlg8xi0Y8K+L6Njo2gorv1MqQ309ZCVNf4b/rKHoQyz1GD/duCvThHWy7WA24/DrlI/nqJFUovkcWqmUXsOe5tYo/cHf2qtgf9BAXuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486200; c=relaxed/simple;
	bh=acOIZdiqoPGUWIxc3VAPqMGZ8tAuc7e89W3t7MWMbns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUVNdpLlk8GRHT69HX9VWZlrlSRqFcnqTnbByYWOVrCLVbz+V/+kyx/HzMEMnLk3WMWs9ZNK8WXnOF6dHkLro4WX/KtsHpvUZOUF5m2pEtvTJvBG+ItrluNJdA3Ac12Fwm6kFZlKolocVbFl1tk5eoIYMJPScfauwavAvnTagBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxtgr4NV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C43BC4CEE4;
	Mon,  5 May 2025 23:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486200;
	bh=acOIZdiqoPGUWIxc3VAPqMGZ8tAuc7e89W3t7MWMbns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxtgr4NVsh1Dqd1m4dOBAefCbbNFvvwwI7mPYtdsyvMGa/oL8jWroD6jeOwDRhr4p
	 KVjsO2MG3Mc1UyfbbN1ZCva1hGUHStqNyaWz7Ap6kXOMJ00/3Iyz/QMImZR5O1T0hV
	 UxZBQelMk+MoM59qVOv7cYLTsxEwqq0oXw/guU+EmGsG9M4Wn8Ju6MMlEkzE8iul9j
	 LGtOvhY8KbjA5pNYp9aroT0F49o+NjQAz5ByyEgs92DPNnnsnXyHvt/OoN3TAHpE3l
	 /FH3MCMju1pHmnaoK+F8jASbi/kOQsVfCi5f6vGqBrM3SleBIMmu8ktoxK1HYzIl4+
	 B/a4ZKduYQ1dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 201/294] ASoC: tas2764: Mark SW_RESET as volatile
Date: Mon,  5 May 2025 18:55:01 -0400
Message-Id: <20250505225634.2688578-201-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit f37f1748564ac51d32f7588bd7bfc99913ccab8e ]

Since the bit is self-clearing.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2764-v1-3-dbab892a69b5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 4e5381c07f504..3f622d629f77a 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -654,6 +654,7 @@ static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
 static bool tas2764_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case TAS2764_SW_RST:
 	case TAS2764_INT_LTCH0 ... TAS2764_INT_LTCH4:
 	case TAS2764_INT_CLK_CFG:
 		return true;
-- 
2.39.5


