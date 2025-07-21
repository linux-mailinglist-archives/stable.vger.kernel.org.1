Return-Path: <stable+bounces-163583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93263B0C54F
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5ECD5405C3
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2021607A4;
	Mon, 21 Jul 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeknNCwr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B0290BBD
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104959; cv=none; b=d5qCGQvmGP9+3jVqjrgp8ij4YrelOWceLJgq8ic7bIOQj0SFfqH8KrTxAOXwqcfppWJn6miK2HRWKmlXg6F8mWY88+mBOseG5Ix9Y6wGwt0wA5Egj1Fbw5NKj3ajHm9Mqw2dFSd4M9Bxo8OfDiMgx2iVjLu1PjKEbmqZsRV2jvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104959; c=relaxed/simple;
	bh=jrJv+I3xcgovuG4Xtu8GJwpcOn0rfG0y3tfathksUY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ddIX1l2ZmrAOfXpwuUvrRz76BoOlRNLy9+bjinuuMtr/iXz8m9QdQtIt8yI9VENfKCRdNBWQi6UbH75wv6mj2ST78/262PlwFPYVR3SetXPCpJU9kZiG55f0SBBLBjR0TuzsLF7+COKJlg06xKzZs6SgxFwosxZkgRh24OoyDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeknNCwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F70C4CEF4;
	Mon, 21 Jul 2025 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753104958;
	bh=jrJv+I3xcgovuG4Xtu8GJwpcOn0rfG0y3tfathksUY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeknNCwrT0HpKFmWH6A9PpTHXSmEl/fuEHBPIza8ZqFi40IcAtpm4aacU+Xqtv5aK
	 dU4w0WI6/KwvIsY8El70DaqxnX7a2SyTqvuNURj1DJxYnbdwTIZEx5WeAOqAV4DgjP
	 z11yNuSkdnveF5ORnTsYnChyEfEWzFqm4ns/nSt2yDAVvv1vps6gNp16Z+kzTNFiM3
	 lJgVk6Uz5tEPjvfoKxEcu8dKnOvAlFacPh9oK0B4LV+ftKOAvdjnvWTRfuaOtGA9D2
	 gwbtL0+Iz16DM3epRabzbmjRxx6eybDhdAEXL7b62UV70fztZekb3mvLRzUhdMR/+i
	 0DCD2v/Y0mYTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Drew Hamilton <drew.hamilton@zetier.com>,
	Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] usb: musb: fix gadget state on disconnect
Date: Mon, 21 Jul 2025 09:35:52 -0400
Message-Id: <20250721133552.838476-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721133552.838476-1-sashal@kernel.org>
References: <2025072132-fiscally-rearrange-1853@gregkh>
 <20250721133552.838476-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/musb_gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index c1076b6cc844f..421fe1645e320 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1909,6 +1909,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 * gadget driver here and have everything work;
 	 * that currently misbehaves.
 	 */
+	usb_gadget_set_state(g, USB_STATE_NOTATTACHED);
 
 	/* Force check of devctl register for PM runtime */
 	schedule_delayed_work(&musb->irq_work, 0);
@@ -2017,6 +2018,7 @@ void musb_g_disconnect(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
 		musb_set_state(musb, OTG_STATE_B_IDLE);
+		usb_gadget_set_state(&musb->g, USB_STATE_NOTATTACHED);
 		break;
 	case OTG_STATE_B_SRP_INIT:
 		break;
-- 
2.39.5


