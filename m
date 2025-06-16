Return-Path: <stable+bounces-152707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602CBADB167
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 15:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11143B64DC
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BFC2DF3C7;
	Mon, 16 Jun 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MTxP81ve"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8002DBF4B;
	Mon, 16 Jun 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079647; cv=none; b=tzDzxl3Q5pNc4fQnV2/9wJShvp8F73XKyZcuCcQOKnEIEXd2aXzwrOnkDd4q69PJ6FuLwmVhXvKvzGurXwdbqtz5ZJdXuwQbx1GEM9eMrDgTmaS50vGP6jw4etnR2ilUH9xi3ph47072vkKiUALeEMQxGYs/zj4tIdZzD6lp+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079647; c=relaxed/simple;
	bh=6smqU54BEO2XnBviN3eGQUkauExI8DxZeH+aP8oRbvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tu7+RfeTnrvWcCkNvXPtCTGvNdl8+XEc64CaGfG8yooUuWEOaGFqy6xLem/FvoSmr6MoJy6rbCVsxX+yi5W/Fbp1tnIA93mzxufBMOBfvkAaGrnvcmCsDLIv9eqd4smdUWdDxi6EiWgV2ApH/rodWJM8EKq57VGcDDoSOj/qWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MTxP81ve; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750079638;
	bh=YNOjnLRACDOPWRZKVVKbg9U7d4b+QVB/orVEDglJFaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MTxP81veaxRXticdcirQZoVeYQf/6K29Oc8GVg15i0BLTrSDSCYMPnnBUkfjOUgNU
	 CsLtsKhqBFpBR6Szbov6sVSjZFzCvrU4AC8UwmvBXMF804+500fjOwzqlHQPau3pPh
	 0+AXXvj4F1/BNPMJo3I+eD6pMT5syY/Amujjm3goVLaxbIVCypU3ehCNQTDbGft0Xj
	 PdnL957OzqylE/UwX9P5AbnYdbXkNbRr6BC3pqG8tWkKGd0fbAmmuJVNmpVit2gkQC
	 3cbLtHQXuRZf46nXMVaHtQPc5LaEDZ3Gkh46GZXZveQ4g9BTdOKGYgIvYVPR2bprHB
	 RFw4Jbf/9Kbhg==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 837D668818;
	Mon, 16 Jun 2025 21:13:57 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Jun 2025 22:43:38 +0930
Subject: [PATCH v2 01/10] soc: aspeed: lpc-snoop: Cleanup resources in
 stack-order
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-aspeed-lpc-snoop-fixes-v2-1-3cdd59c934d3@codeconstruct.com.au>
References: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
In-Reply-To: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Free the kfifo after unregistering the miscdev in
aspeed_lpc_disable_snoop() as the kfifo is initialised before the
miscdev in aspeed_lpc_enable_snoop().

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Cc: stable@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>
Acked-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index ef8f355589a584d76bfac2b130ba9965c9b06ba5..59c18afa649cd672f54f947066f468f2a78c0d5d 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -263,8 +263,8 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		return;
 	}
 
-	kfifo_free(&lpc_snoop->chan[channel].fifo);
 	misc_deregister(&lpc_snoop->chan[channel].miscdev);
+	kfifo_free(&lpc_snoop->chan[channel].fifo);
 }
 
 static int aspeed_lpc_snoop_probe(struct platform_device *pdev)

-- 
2.39.5


