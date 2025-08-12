Return-Path: <stable+bounces-167745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A15B231B8
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6FF188EE64
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191422FE587;
	Tue, 12 Aug 2025 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2kR6Iyo+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5582FE584;
	Tue, 12 Aug 2025 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021849; cv=none; b=KoiXQ9sVCltLl5LWVUUrWiSV0es1RZoECbBBffnEExLI8a+GsXNJwTS3NeU3viqWxc/goO2nUzofNxkn2Aba1KcKz6olOavJmz0AtLBQCbL8VajqJ5dLZNjXkDt3+H0D4awpZcO6nXBH7Zz2x+7fkwkOYYFL2tjkNjQSYdYPoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021849; c=relaxed/simple;
	bh=tZzrLCQxg6C5yiYJ53siNu4nugw/9EsjXW3XrcSEeTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1HpTwEISoGWxYw5tNP/GLr3ITHNv4UiLjyWY1voNu/JrkqUpRz9b1OOj2zFphA3+bMtk5XTAJ0BkXZPIalEPtDPl+Tnpda2Zm/fEGmR+HuNhlHVjTUBE8TbUEWL1xp9Acgm7hie7eMjPTta4atk8qS6ffQR/g2X0y/pz+vpXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2kR6Iyo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBD7C4CEF0;
	Tue, 12 Aug 2025 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021849;
	bh=tZzrLCQxg6C5yiYJ53siNu4nugw/9EsjXW3XrcSEeTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2kR6Iyo+cKDY7nSYJL/HVT+giSOYWxO8ecvFhUFjIeIsZpgcZkZ0ptjjMt7a96xD7
	 gByCw5H721oTNV9+voIflU6+ufSZ1B+RFTqcKVtRCbkCT5kYhAeeVD/p+HKp8m/MtR
	 BwVGI8rt9Lu6VYklAlDVRi8XkJrejExfsbiZa30A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alain Volmat <alain.volmat@foss.st.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 244/262] i2c: stm32f7: use dev_err_probe upon calls of devm_request_irq
Date: Tue, 12 Aug 2025 19:30:32 +0200
Message-ID: <20250812173003.539651605@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alain Volmat <alain.volmat@foss.st.com>

[ Upstream commit a51e224c2f42417e95a3e1a672ade221bcd006ba ]

Convert error handling upon calls of devm_request_irq functions during
the probe of the driver.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 6aae87fe7f18 ("i2c: stm32f7: unmap DMA mapped buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-stm32f7.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -2198,19 +2198,13 @@ static int stm32f7_i2c_probe(struct plat
 					stm32f7_i2c_isr_event_thread,
 					IRQF_ONESHOT,
 					pdev->name, i2c_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq event %i\n",
-			irq_event);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to request irq event\n");
 
 	ret = devm_request_irq(&pdev->dev, irq_error, stm32f7_i2c_isr_error, 0,
 			       pdev->name, i2c_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq error %i\n",
-			irq_error);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to request irq error\n");
 
 	setup = of_device_get_match_data(&pdev->dev);
 	if (!setup) {



