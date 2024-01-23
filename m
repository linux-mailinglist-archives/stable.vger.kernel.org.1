Return-Path: <stable+bounces-12885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821CF8378E5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B2C1F26093
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F4144638;
	Tue, 23 Jan 2024 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0OeFr7uL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44E14462C;
	Tue, 23 Jan 2024 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968280; cv=none; b=jmV7mMe6EpOrfIg808VKEwaksK9y/UiA33WlXmizQGfvKHYO9kC+zFQxb0dFCaS93GUBk8ePNZyszZJOCgj1hfx+JgDJFDq5ct/ZeTKSOXITJJlixbmxb4LBrkKzQjmBjExnNkjKR3hr3F7eGbKdIsBrk4FMd7J6thqkJ+RP2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968280; c=relaxed/simple;
	bh=65HMRHkrkXogRO2m6v8/smcCbV60q4wNhtkdzLakg0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3VEiFTuOehg3vrx6zXtE269GQWlf1ju35Q0uRZNbDMZQLryP60P1C8zInm43JfERhmEOEHILQF5gxn8EvpW6gTe4pPrO8dm6tOzd78p/Z9Vp4pD80RI0ShGVlXmXarcape/NuhDvnno12vgJjjuSVE9uqwXfv0GdA5G23a3Lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0OeFr7uL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3DDC433F1;
	Tue, 23 Jan 2024 00:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968280;
	bh=65HMRHkrkXogRO2m6v8/smcCbV60q4wNhtkdzLakg0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0OeFr7uLVYqySgYmXwoqxD1A3n4BJ9hTCB6JvWm6VhmLFDJbTIfkuSLdAsb5zshSb
	 qiciNzByhI9l3MMoUVFFeLAnOc/yG1YxtpdE4gU+GKeYEBnS8xsrzTmYYqdNdi/BX9
	 HLvV5HK3Q7sWI8Lj3yJK3GJh7CgKRjNtWOrUGxlw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/148] firmware: ti_sci: Fix an off-by-one in ti_sci_debugfs_create()
Date: Mon, 22 Jan 2024 15:57:05 -0800
Message-ID: <20240122235715.188554118@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
References: <20240122235712.442097787@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 964946b88887089f447a9b6a28c39ee97dc76360 ]

The ending NULL is not taken into account by strncat(), so switch to
snprintf() to correctly build 'debug_name'.

Using snprintf() also makes the code more readable.

Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/7158db0a4d7b19855ddd542ec61b666973aad8dc.1698660720.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/ti_sci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 46acc6440b9a..639e0481f952 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -176,7 +176,7 @@ static int ti_sci_debugfs_create(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	char debug_name[50] = "ti_sci_debug@";
+	char debug_name[50];
 
 	/* Debug region is optional */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -193,10 +193,10 @@ static int ti_sci_debugfs_create(struct platform_device *pdev,
 	/* Setup NULL termination */
 	info->debug_buffer[info->debug_region_size] = 0;
 
-	info->d = debugfs_create_file(strncat(debug_name, dev_name(dev),
-					      sizeof(debug_name) -
-					      sizeof("ti_sci_debug@")),
-				      0444, NULL, info, &ti_sci_debug_fops);
+	snprintf(debug_name, sizeof(debug_name), "ti_sci_debug@%s",
+		 dev_name(dev));
+	info->d = debugfs_create_file(debug_name, 0444, NULL, info,
+				      &ti_sci_debug_fops);
 	if (IS_ERR(info->d))
 		return PTR_ERR(info->d);
 
-- 
2.43.0




