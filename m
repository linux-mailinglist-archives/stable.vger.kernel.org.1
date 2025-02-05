Return-Path: <stable+bounces-112771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9140A28E55
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E88168A81
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF3815573F;
	Wed,  5 Feb 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MGYQUEde"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB648155333;
	Wed,  5 Feb 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764696; cv=none; b=U/891Lj7CbDaaYL2G/FX2cOJuIt/VVAytWmNTo/rgHJDid3KssaSA+9Hmlvff5197xnLYzv7/tjsARCYsbNGqRyeeFtQfON7vMdcWYOqYX86gSzIWxJcyQSFnlA1URMXjLUV5L/YLm5ww7MQTr+cyMGLMQFfdmR7Etwd90ttBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764696; c=relaxed/simple;
	bh=aaIqaNVVovZwggk0UFd4GPmy7fndRJfszo/k/+xaVxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnVRxg/hqkkcGZkV8GYhPhtduz7Yvx2piKO3gDfPk1J/lD9PBRdp94s3vo9J79yHCGPOJWawhb82Ps/BXqM2Z2bWjdzvZQebeGVA3qzbjXu6ORHtXPmPEDtK+3FFf+c4DWjaFprlSApAgWc55IHOSLBeRDHB1ISxiSh18djqxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MGYQUEde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44563C4CED1;
	Wed,  5 Feb 2025 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764696;
	bh=aaIqaNVVovZwggk0UFd4GPmy7fndRJfszo/k/+xaVxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGYQUEdeA4Gluhb2Cfd10KoylewFi0P4lXBSWR83zWFP4nVYSUIWSaMSHxx2b+DmM
	 2MVoZJkU05T+LCwYnyDcUxUojnMH12rCm/fTY3HvETHUPeMP77YoHdLPlTGIecEXpI
	 ZJeHu3p8XphRdgGv528+iJ0Tr4wGgNvZlN2OSaM8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Han <hanchunchao@inspur.com>,
	Corey Minyard <corey@minyard.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 083/623] ipmi: ipmb: Add check devm_kasprintf() returned value
Date: Wed,  5 Feb 2025 14:37:05 +0100
Message-ID: <20250205134459.399499541@linuxfoundation.org>
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

From: Charles Han <hanchunchao@inspur.com>

[ Upstream commit 2378bd0b264ad3a1f76bd957caf33ee0c7945351 ]

devm_kasprintf() can return a NULL pointer on failure but this
returned value is not checked.

Fixes: 51bd6f291583 ("Add support for IPMB driver")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
Message-ID: <20240926094419.25900-1-hanchunchao@inspur.com>
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmb_dev_int.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 7296127181eca..8a14fd0291d89 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -321,6 +321,9 @@ static int ipmb_probe(struct i2c_client *client)
 	ipmb_dev->miscdev.name = devm_kasprintf(&client->dev, GFP_KERNEL,
 						"%s%d", "ipmb-",
 						client->adapter->nr);
+	if (!ipmb_dev->miscdev.name)
+		return -ENOMEM;
+
 	ipmb_dev->miscdev.fops = &ipmb_fops;
 	ipmb_dev->miscdev.parent = &client->dev;
 	ret = misc_register(&ipmb_dev->miscdev);
-- 
2.39.5




