Return-Path: <stable+bounces-163599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E25EB0C62E
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376CA162729
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C4B2DCBFA;
	Mon, 21 Jul 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2L1IDnr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35F2DCBF5
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107772; cv=none; b=aRlJGw3nqtJdkYuod+mUtF66/opx2snJD5X3K7Qkag+rPydySnSKzJsiGpfA0FE+vRZY/nPQzyKu70H8CZU38r6sEqBiw9VAmuHB485VaLMgXEHBva9JGOQP/MX3AJHTIcyQJhuuxjBek3M1Ruv4TaeEpC1qOboHkN+V8BGufuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107772; c=relaxed/simple;
	bh=CSoFAw/Z3VS45VvUDrFbvgpVjPq7KgSDj7IUHZdULq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KogeBK5jx8KCZDQa8Yb72dpb35lqY+7o8q1Xgo3Vtcy5OXNr9PItchRYNBwq66Ag16/kOWQRTKrP24VQ39XVOiks5F6/MRvP6z/OaZXVMhi/RGZxLhK8Re6aEB13NsRXtwF59QQ/HFHQoM8gSpd1rmUgPXwLORJkEP8RjFeQAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2L1IDnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F6DC4CEF4;
	Mon, 21 Jul 2025 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753107772;
	bh=CSoFAw/Z3VS45VvUDrFbvgpVjPq7KgSDj7IUHZdULq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2L1IDnrsge6kfa1UNAKIEGDk15hbrn2laJ799bltNqHCnduQ5lCRXP3Kz/d9Xfvt
	 3F0XWXJMK3vpiotCMhj2JpxgoFlO5JHCYNd3kVvS0r+I+xzv6SXKEafslDLpsU0CaC
	 VSf1+NZdnU5rhn5zxqeqWhTIXRKjOirAZdCdnnTFHVJYSL3gTDZyecE3s4Ot46WzWg
	 bk4X0t11LF5Xv69qmPwNRHPJmx+jDK9scDFbce6KlLX/k+M1OAm2FGNSBdIEDMlOJ/
	 2fREuT038JdQl95LWgb0Z718DRd8EifLPsnCcau6qnH9MzMyLXyQ61aDjPZwQTROwV
	 OHxIOKrYXjhAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Drew Hamilton <drew.hamilton@zetier.com>,
	Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] usb: musb: fix gadget state on disconnect
Date: Mon, 21 Jul 2025 10:22:47 -0400
Message-Id: <20250721142247.843633-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072133-unwatched-pushy-6a36@gregkh>
References: <2025072133-unwatched-pushy-6a36@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Drew Hamilton <drew.hamilton@zetier.com>

[ Upstream commit 67a59f82196c8c4f50c83329f0577acfb1349b50 ]

When unplugging the USB cable or disconnecting a gadget in usb peripheral mode with
echo "" > /sys/kernel/config/usb_gadget/<your_gadget>/UDC,
/sys/class/udc/musb-hdrc.0/state does not change from USB_STATE_CONFIGURED.

Testing on dwc2/3 shows they both update the state to USB_STATE_NOTATTACHED.

Add calls to usb_gadget_set_state in musb_g_disconnect and musb_gadget_stop
to fix both cases.

Fixes: 49401f4169c0 ("usb: gadget: introduce gadget state tracking")
Cc: stable@vger.kernel.org
Co-authored-by: Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>
Signed-off-by: Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>
Signed-off-by: Drew Hamilton <drew.hamilton@zetier.com>
Link: https://lore.kernel.org/r/20250701154126.8543-1-drew.hamilton@zetier.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ replaced musb_set_state() call with direct otg state assignment ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/musb_gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index b8fc818c154ae..efb70b5c9e8ee 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1910,6 +1910,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 * gadget driver here and have everything work;
 	 * that currently misbehaves.
 	 */
+	usb_gadget_set_state(g, USB_STATE_NOTATTACHED);
 
 	/* Force check of devctl register for PM runtime */
 	schedule_delayed_work(&musb->irq_work, 0);
@@ -2018,6 +2019,7 @@ void musb_g_disconnect(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
 		musb->xceiv->otg->state = OTG_STATE_B_IDLE;
+		usb_gadget_set_state(&musb->g, USB_STATE_NOTATTACHED);
 		break;
 	case OTG_STATE_B_SRP_INIT:
 		break;
-- 
2.39.5


