Return-Path: <stable+bounces-159586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05849AF7960
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7FE3B765B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF2C2EE29D;
	Thu,  3 Jul 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HGQmmgkU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD982ECEBA;
	Thu,  3 Jul 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554698; cv=none; b=OY5Ea+dcnINCF2+TxhCkdfEwwmoZ2nGeGmDnG8ggRtcMnHR+VNc8dq6p7E7QpGsTxf60pEeHLdaKLARMXLLGdC/HwlYSU/U0Lk5bJeik17Zp9jZ+o0lc4bNUE4jtDIiMDAjKsYHoGT0e4IQM8MSZ/4ZVupk8XZi50nGx/Hd1qCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554698; c=relaxed/simple;
	bh=16A6WxFZmxKySp9SEXStGIfGREpq+s3O3HgrYIfDdpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9TsxnTiu8egl21SXpH+D/1TaMtKd86MJM5Tt7EKCo/DsTwltKaJTpIzZCtZNGAodgC4w5QuXLi19m8WyCY/eQREFBYiXjYSUXY/8oFuQhRfDJizlIOO4zL4CPUAjxTr2dSYrcy4ONNs0H3ct/lzViRCveCewUBaCGOuZT5hVOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HGQmmgkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E138AC4CEED;
	Thu,  3 Jul 2025 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554698;
	bh=16A6WxFZmxKySp9SEXStGIfGREpq+s3O3HgrYIfDdpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGQmmgkUiqq15RkCDUsgQYlJ7F5uvGstJi2BgeaaOnJ+g8cLt/rxwexJRj0uU9mnj
	 6PplrS27rrhPUf4tpi6aL+PxZR9h/74NrQHIgHNDJ5cvQxIz+19IecMWfQLC8JH3AJ
	 /1402jiclP2nwpHHrsm0ATD2MWB1hizYyZoCyWBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 050/263] usb: dwc2: also exit clock_gating when stopping udc while suspended
Date: Thu,  3 Jul 2025 16:39:30 +0200
Message-ID: <20250703144006.309059875@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

[ Upstream commit af076a41f8a28faf9ceb9dd2d88aef2c202ef39a ]

It is possible that the gadget will be disabled, while the udc is
suspended. When enabling the udc in that case, the clock gating
will not be enabled again. Leaving the phy unclocked. Even when the
udc is not enabled, connecting this powered but not clocked phy leads
to enumeration errors on the host side.

To ensure that the clock gating will be in an valid state, we ensure
that the clock gating will be enabled before stopping the udc.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Link: https://lore.kernel.org/r/20250417-dwc2_clock_gating-v1-1-8ea7c4d53d73@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 300ea4969f0cf..f323fb5597b32 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4604,6 +4604,12 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
 	if (!hsotg)
 		return -ENODEV;
 
+	/* Exit clock gating when driver is stopped. */
+	if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
+	    hsotg->bus_suspended && !hsotg->params.no_clock_gating) {
+		dwc2_gadget_exit_clock_gating(hsotg, 0);
+	}
+
 	/* all endpoints should be shutdown */
 	for (ep = 1; ep < hsotg->num_of_eps; ep++) {
 		if (hsotg->eps_in[ep])
-- 
2.39.5




