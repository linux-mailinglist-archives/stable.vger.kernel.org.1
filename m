Return-Path: <stable+bounces-63184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8D69417D4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62A71F2464C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192F4184556;
	Tue, 30 Jul 2024 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vfSSUDPK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0918455D;
	Tue, 30 Jul 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355992; cv=none; b=hxUwtvoO+Pi7xsjWZgpvqAMJJQi3KP1BRD5SwLt+MYV0b1WcMVhhJL5M+z5wj1LJlsrutnRjky0BWa+xzjCnG759DSTuV4T9vIJyOYnwerL2TBo9VyE7ayFJSSXs5h8rRSr8pKww7QiY6EOWvlWl4fryUx976myOKzwlqI5eKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355992; c=relaxed/simple;
	bh=bRVgDxQU1hWdEIpwvSdKQV/hL8/Dlo1i9a3cyotH/U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzGNMT4wUimkyLfmollJDl9FmD6CUWGh7Hf55oySYgcw4VEdaqROrPR94iSP3bq6H+nSxForVRLNF7qcvIMbKS5p5Ca2OwVbdU7ko5SNnUjozBJB/XtQQD4o/YL2GCtgxcAllyNGhPKBjgFSn1zl0XJGdZ6F26WLg4uXLVSeymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vfSSUDPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FADC4AF0A;
	Tue, 30 Jul 2024 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355992;
	bh=bRVgDxQU1hWdEIpwvSdKQV/hL8/Dlo1i9a3cyotH/U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vfSSUDPKJBypdi/pR+6fQPB6Ep3skIol8T1j+VozdxqbQuHX2djSrnE+PJEt/8gxZ
	 +fePz/Moljz+klZLF/DUMLeCZBlLX2GNl66/eW5wW8hSGCabw6wljlzZYQAp1JR1/K
	 v9yFNpB1CbBtAONADcJZQZ9Wx4edIeZ1ina7mToc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 146/440] media: rcar-vin: Fix YUYV8_1X16 handling for CSI-2
Date: Tue, 30 Jul 2024 17:46:19 +0200
Message-ID: <20240730151621.583628752@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

[ Upstream commit 9caf253e8ad6f4c66f5591bac900f9f68b6b6620 ]

The YUYV8_1X16 and UYVY8_1X16 formats are treated as 'ITU-R
BT.601/BT.1358 16-bit YCbCr-422 input' (YUV16 - 0x5) in the R-Car VIN
driver and are thus disallowed when capturing frames from the R-Car
CSI-2 interface according to the hardware manual.

As the 1X16 format variants are meant to be used with serial busses they
have to be treated as 'YCbCr-422 8-bit data input' (0x1) when capturing
from CSI-2, which is a valid setting for CSI-2.

Commit 78b3f9d75a62 ("media: rcar-vin: Add check that input interface
and format are valid") disallowed capturing YUV16 when using the CSI-2
interface. Fix this by using YUV8_BT601 for YCbCr422 when CSI-2 is in
use.

Fixes: 78b3f9d75a62 ("media: rcar-vin: Add check that input interface and format are valid")
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20240617161135.130719-2-jacopo.mondi@ideasonboard.com
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/renesas/rcar-vin/rcar-dma.c   | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
index ef5adffae1972..8bfb020b2f260 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
@@ -665,12 +665,22 @@ static int rvin_setup(struct rvin_dev *vin)
 	 */
 	switch (vin->mbus_code) {
 	case MEDIA_BUS_FMT_YUYV8_1X16:
-		/* BT.601/BT.1358 16bit YCbCr422 */
-		vnmc |= VNMC_INF_YUV16;
+		if (vin->is_csi)
+			/* YCbCr422 8-bit */
+			vnmc |= VNMC_INF_YUV8_BT601;
+		else
+			/* BT.601/BT.1358 16bit YCbCr422 */
+			vnmc |= VNMC_INF_YUV16;
 		input_is_yuv = true;
 		break;
 	case MEDIA_BUS_FMT_UYVY8_1X16:
-		vnmc |= VNMC_INF_YUV16 | VNMC_YCAL;
+		if (vin->is_csi)
+			/* YCbCr422 8-bit */
+			vnmc |= VNMC_INF_YUV8_BT601;
+		else
+			/* BT.601/BT.1358 16bit YCbCr422 */
+			vnmc |= VNMC_INF_YUV16;
+		vnmc |= VNMC_YCAL;
 		input_is_yuv = true;
 		break;
 	case MEDIA_BUS_FMT_UYVY8_2X8:
-- 
2.43.0




