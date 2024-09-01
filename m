Return-Path: <stable+bounces-72352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD432967A4A
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073E0B20E21
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B615181CE1;
	Sun,  1 Sep 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cBv2jmKf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18626208A7;
	Sun,  1 Sep 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209644; cv=none; b=OMwZeTJEdegAWbNIbKejTBkhZrBPOmU5xA4TokkLYHBGA65QRStEPw4lWV3V9R4LX8stkgSCWp+kBlavgeiEXaXQ2CsJFKnL8cM+x+UpFOUbERkI5/ONPAJiWudhGf/CLbe8H1aW7OGsOrvwBRtiRYINBOtlw5JWiP4RHcDDd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209644; c=relaxed/simple;
	bh=047U0VXOp6nEn/TtAwLGgTfuVuqwI7SmH4Tb9AtxKZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwPz1T84aCTyFom7q9EdpGsYR+PMXRIDYZ4HD8QI/WaFERB0ltznP5E9gYy4aefz2Vo3Y+c3MnRMl+hXOVAguEMArlwQq08x2bffKJyHisLceOxCWcbiFzV5YKRxaRT5MohdVXNTBXxhA4oCnU0kL9M2lWFlhOgw3Y7GCqYcVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cBv2jmKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C27C4CEC3;
	Sun,  1 Sep 2024 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209644;
	bh=047U0VXOp6nEn/TtAwLGgTfuVuqwI7SmH4Tb9AtxKZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBv2jmKfRsxxhNerfTK0CIjp7TWT0/3zPsauHOhMZ458XS6gZcoFQbTsln9dU9ViO
	 W26vwLqCSBWs0+jYQo+keee6sjnfkOEJ2vLcP4Tff9iUG68qVU3wV9uRnnpqmAnfrB
	 f6gTafOz0rNeUSIuFT0C2ZFEr7K8WguSV5wgmRjo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 069/151] usb: gadget: fsl: Increase size of name buffer for endpoints
Date: Sun,  1 Sep 2024 18:17:09 +0200
Message-ID: <20240901160816.713841344@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
References: <20240901160814.090297276@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 87850f6cc20911e35eafcbc1d56b0d649ae9162d ]

This fixes a W=1 warning about sprintf writing up to 16 bytes into a
buffer of size 14. There is no practical relevance because there are not
more than 32 endpoints.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/6754df25c56aae04f8110594fad2cd2452b1862a.1708709120.git.u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index ad6ff9c4188ef..3986e0639f05a 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2501,7 +2501,7 @@ static int fsl_udc_probe(struct platform_device *pdev)
 	/* setup the udc->eps[] for non-control endpoints and link
 	 * to gadget.ep_list */
 	for (i = 1; i < (int)(udc_controller->max_ep / 2); i++) {
-		char name[14];
+		char name[16];
 
 		sprintf(name, "ep%dout", i);
 		struct_ep_setup(udc_controller, i * 2, name, 1);
-- 
2.43.0




