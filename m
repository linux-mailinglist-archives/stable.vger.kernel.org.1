Return-Path: <stable+bounces-85659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1535A99E84D
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDFD1F227C3
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689231E1A35;
	Tue, 15 Oct 2024 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yNGN96Dp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A51CFEA9;
	Tue, 15 Oct 2024 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993856; cv=none; b=Ezr0hYx0nhJ755TM+jI/n8asWou8JB1bVaDFt22dIm5J8ty2K2LLj1smrdnRhVRKVAzMJQZ41a4uEzTiEDMwrpKjYAzTFDY+MtyMaruUodpb5KdcPmyEUmE0NdkVlrg3FkG4H9KrRWw4AXTnTdHBjJNLN6N4K7OjASgx6NU8jVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993856; c=relaxed/simple;
	bh=8MxGYmKcWXroxibclMBQM0VbINFtZcrbPggpNkNrmQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZ3ZmISSuWaR7BPBHmB7CkPoMfYQIUkTGQOPVCIpGUjAPF25fm/hrvo54O5GsTN8vHuj80KNKSrOiXrXyOL5moiUsKGt0pHRmqcyb2RUbtvfFtTch59gbLCY4XjDG4022fdvAu8xvXQXIDXgPW3e7Moo/hPyxsmg/bx0mfgBWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yNGN96Dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0A9C4CECE;
	Tue, 15 Oct 2024 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993856;
	bh=8MxGYmKcWXroxibclMBQM0VbINFtZcrbPggpNkNrmQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yNGN96DpS1nr7DgiGdWxR7t0CZJYfNno6f1Qat4hkFcTOSLRXZlDtE+gNzJUhpIND
	 F6AXkwSX1iDTdMoKtSjGxFuBgRr8ktoKs2Kt9jvNhAyF8bvRGqesolbo66zNZlmdWS
	 qGAuKpWzDx5VRFIkYEXQtbg04zU+DFpxwJJM2cuk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5.15 536/691] rtc: at91sam9: fix OF node leak in probe() error path
Date: Tue, 15 Oct 2024 13:28:04 +0200
Message-ID: <20241015112501.614539272@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 73580e2ee6adfb40276bd420da3bb1abae204e10 upstream.

Driver is leaking an OF node reference obtained from
of_parse_phandle_with_fixed_args().

Fixes: 43e112bb3dea ("rtc: at91sam9: make use of syscon/regmap to access GPBR registers")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240825183103.102904-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-at91sam9.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -368,6 +368,7 @@ static int at91_rtc_probe(struct platfor
 		return ret;
 
 	rtc->gpbr = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
 	rtc->gpbr_offset = args.args[0];
 	if (IS_ERR(rtc->gpbr)) {
 		dev_err(&pdev->dev, "failed to retrieve gpbr regmap, aborting.\n");



