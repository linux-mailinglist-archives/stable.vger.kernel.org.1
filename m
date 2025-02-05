Return-Path: <stable+bounces-113665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E184A293EB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE95188ACF9
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66771186E26;
	Wed,  5 Feb 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PELPw54b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223451519BF;
	Wed,  5 Feb 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767740; cv=none; b=di2MdlJiVDpBIl9xWm3kwcobs4SHoNVYDeYKcMj1zNwUuQamoSgbRD8civPKgWyLVbupE2SPslWyUZP1ex+ha0wUQz5kChC3k95sGc4p+KOYRyhuxFQG2m9NtIasCXwGTAXRbgEe49d2mwHFOuN+VgDs8naFnxtJnSHmJwEOddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767740; c=relaxed/simple;
	bh=WwgYzrmU8deHSa6BDXthzKtpYX32wvkPFFk7ZxaDg8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImryS0oGsAoVs+EsiOL+Tqn+EGy9RFfLr/+aLmfoYAIQKYjdJU21lCuFSFQTVwCNYxGtfdibJfvT14SGhVPqeN1fLIwG8HKqTiDNr6oM4ZaZgbiNaIzdr5/RpbdzgQlGphqW/nPNBsrOv3a/LYIap2tU6ZiNhzPf/HDLnmFwzws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PELPw54b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828F4C4CED1;
	Wed,  5 Feb 2025 15:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767740;
	bh=WwgYzrmU8deHSa6BDXthzKtpYX32wvkPFFk7ZxaDg8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PELPw54bFY0Bx72qOJ/duMW1SxnEbvDiFj+s0lHwCcF3R7Y3uPyJqJ8DNAJtbCYdj
	 O9Pgfvq9/4tCiElPi4FVoprsAECRYnGwRl5SXCM2vsfn2SCglTv7DPo64qRkJFIFWt
	 fKZ9hcUoqFDAY+LwZkKJDl0DQ2pCMdnuuwxSVOj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 447/623] media: marvell: Add check for clk_enable()
Date: Wed,  5 Feb 2025 14:43:09 +0100
Message-ID: <20250205134513.319179295@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit 11f68d2ba2e1521a608af773bf788e8cfa260f68 ]

Add check for the return value of clk_enable() to guarantee the success.

Fixes: 81a409bfd551 ("media: marvell-ccic: provide a clock for the sensor")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
[Sakari Ailus: Fix spelling in commit message.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/marvell/mcam-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/marvell/mcam-core.c b/drivers/media/platform/marvell/mcam-core.c
index 9ec01228f9073..b8360d37000a7 100644
--- a/drivers/media/platform/marvell/mcam-core.c
+++ b/drivers/media/platform/marvell/mcam-core.c
@@ -935,7 +935,12 @@ static int mclk_enable(struct clk_hw *hw)
 	ret = pm_runtime_resume_and_get(cam->dev);
 	if (ret < 0)
 		return ret;
-	clk_enable(cam->clk[0]);
+	ret = clk_enable(cam->clk[0]);
+	if (ret) {
+		pm_runtime_put(cam->dev);
+		return ret;
+	}
+
 	mcam_reg_write(cam, REG_CLKCTRL, (mclk_src << 29) | mclk_div);
 	mcam_ctlr_power_up(cam);
 
-- 
2.39.5




