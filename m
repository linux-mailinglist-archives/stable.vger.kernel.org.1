Return-Path: <stable+bounces-51689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D1E907122
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C131C2308F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B2CEC4;
	Thu, 13 Jun 2024 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T97jMWZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156FB384;
	Thu, 13 Jun 2024 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282027; cv=none; b=K/Ez2ODX50Cyu7WCtC2B8O70mCytYuBvzYta5cIX5l+ldJY/PNHzlDvLdCeyc6mmBbk4fNaDEpPWfQjbQk7/vIg4Hv9j7vIL36JqyLxNeLRTfzcqpdsTuk3gDsihSe2BEJTGP8s59MhXxrP/Xy+lDSQIzVGo2RgWnuYNHv57sOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282027; c=relaxed/simple;
	bh=EvHPonryX9B5vKl2fC/Xj9uPuBQoHSoFOiFujO53JFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6abKz0/H+SagEP6rboOd1zCWWM407ADL/Erz0aTXPIsEZRGhUcNFQRdGoeKExFltfKPYnR2+xMztQKWV1NN83w2by5ymhJOGdgVF77cLkCmye0+Y6KbCPdQfSnHAHoJrdmqhNOJ1Yvx44+4cGiCOC7Z8B5S+oPQl9KBGfEozow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T97jMWZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7F8C2BBFC;
	Thu, 13 Jun 2024 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282027;
	bh=EvHPonryX9B5vKl2fC/Xj9uPuBQoHSoFOiFujO53JFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T97jMWZ9/QXA+yVDY6VJ9iZYSsJCh7TbRqo7+iGpWL4QB9UWqCSu5zfPj/cMazzJa
	 acPd8K1dnGHjfJQv8JPVvx1tRl6/dgkokPVWu6UhPD/zga1gkVOzJ10TkADxO07zeI
	 g/F4IN3DNlUs+IZQdy5/fK6iWbkAnkkhiDnowG4M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 137/402] media: ipu3-cio2: Request IRQ earlier
Date: Thu, 13 Jun 2024 13:31:34 +0200
Message-ID: <20240613113307.480715330@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit a069f79bfa6ec1ea0744981ea8425c8a25322579 ]

Call devm_request_irq() before registering the async notifier, as otherwise
it would be possible to use the device before the interrupts could be
delivered to the driver.

Fixes: c2a6a07afe4a ("media: intel-ipu3: cio2: add new MIPI-CSI2 driver")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index 29c660fe1425b..dfb2be0b9625a 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -1803,11 +1803,6 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	v4l2_async_notifier_init(&cio2->notifier);
 
-	/* Register notifier for subdevices we care */
-	r = cio2_parse_firmware(cio2);
-	if (r)
-		goto fail_clean_notifier;
-
 	r = devm_request_irq(dev, pci_dev->irq, cio2_irq, IRQF_SHARED,
 			     CIO2_NAME, cio2);
 	if (r) {
@@ -1815,6 +1810,11 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 		goto fail_clean_notifier;
 	}
 
+	/* Register notifier for subdevices we care */
+	r = cio2_parse_firmware(cio2);
+	if (r)
+		goto fail_clean_notifier;
+
 	pm_runtime_put_noidle(dev);
 	pm_runtime_allow(dev);
 
-- 
2.43.0




