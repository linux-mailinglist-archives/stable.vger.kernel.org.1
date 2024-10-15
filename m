Return-Path: <stable+bounces-85615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3783D99E817
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D461C217B9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE0C1D1512;
	Tue, 15 Oct 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JOrApUMJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66D1C57B1;
	Tue, 15 Oct 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993711; cv=none; b=WdzRrood+a+vg/EXKY0gPRvtVZ8XQr+n4ZrNo9MjuLEcHWGByst8a8RLcbtQHyMrLhhoh4oTRj3lJe60Xy+ut87tnTrxaue8o+HGTjlJp6nLee2EaSxRSWxZEqaDSUxOLkjYo9WkNwlVjciUlQE8U2XoK5Li1zpWcdsrPnQXPfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993711; c=relaxed/simple;
	bh=i4b484gNj7usPWq1AxVpFaSNRrdz4PdnScPpXw+qzRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/6RgRpUmsRcYG1CGQGoyNn6F4hggX1V8gg+XjarNuDspfrTvV+E4RKbVK5PBsSfHHX/46zyoUlHa/UtkkPAk5YID4lBZf+fx4deBRFhiY+IURttXGqShK2ldVAJeIDbI2E42nSlnweWCi7/wNB8G0IdeVmZtq0OqzK813JckWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JOrApUMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1274CC4CEC6;
	Tue, 15 Oct 2024 12:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993711;
	bh=i4b484gNj7usPWq1AxVpFaSNRrdz4PdnScPpXw+qzRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOrApUMJLVPa53h+m1NVZwGEYq3twJ70vFWA0orulSPcWLuBp247U+zhL2bH3MZUQ
	 3I1D4HnblKuxYJ2zY9cGQ6+k4uXkNbZ1uWdlqL71C47sGOieROpEx5Z9dwWtI/s+9c
	 nAwq4YR4jnBMN7GZcX/m4YrtsuoBrmPc37LLQ3yY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 493/691] spi: bcm63xx: Fix module autoloading
Date: Tue, 15 Oct 2024 13:27:21 +0200
Message-ID: <20241015112459.910651560@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 909f34f2462a99bf876f64c5c61c653213e32fce upstream.

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from platform_device_id table.

Fixes: 44d8fb30941d ("spi/bcm63xx: move register definitions into the driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Link: https://patch.msgid.link/20240819123349.4020472-2-ruanjinjie@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-bcm63xx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -476,6 +476,7 @@ static const struct platform_device_id b
 	{
 	},
 };
+MODULE_DEVICE_TABLE(platform, bcm63xx_spi_dev_match);
 
 static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6348-spi", .data = &bcm6348_spi_reg_offsets },



