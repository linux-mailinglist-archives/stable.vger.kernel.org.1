Return-Path: <stable+bounces-138523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE33AA185C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44ABF188B7BA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D1B242D73;
	Tue, 29 Apr 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l20Ll5Fm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546721CA0E;
	Tue, 29 Apr 2025 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949522; cv=none; b=nbi57Hd/zuEKSH+QbNyV+38HZbOW3aEg8aLCuGJRheY72UA63+PyQh/071+Yrtiv1qYoq6WXlA704jMsSlq/WdER67aQMB7R9T0a+QqKBRm9aZIwgVCO/hlbfaYotTMxYihY3ASaqpCQ0LJy1ctsHQnHQXV65aklWkPLBSXas8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949522; c=relaxed/simple;
	bh=DN5pK3qhcRatTJEkdNecyUk1dP4Tj2XTvBetb6MTack=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ri8qu8V1wl++2iknwfbUFxwRqXKrrUBxE3wWSTBwPM8NYJeguJxVbJnxdmQYbo5uN/BVMdvp3BwX+37BmPSC/4cEMlkY0lC/ZoPdTvJ5wMTNgD0lPw322rCMe07FakU9Q4LqirHN1kgj+vRiT0vb0J8Oqwd8MaH5BZ1TXGxr2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l20Ll5Fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF30C4CEE3;
	Tue, 29 Apr 2025 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949522;
	bh=DN5pK3qhcRatTJEkdNecyUk1dP4Tj2XTvBetb6MTack=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l20Ll5FmwhTN+u+E+DB5Kop2W4g5bcQYW6IjyyEO2S3id5BCd/F8Q1GbZVA0OGqCx
	 4P5YBBD8RMtCMxZ4khEi0xAPPjexcBW8SUsySbc7CTe8RVSTPCtkk6GtCtV1Gv/qa0
	 22nRQDB4emh+5633jvcmJ15Du/pj3bWrTfxk3wWo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frode Isaksen <frode@meta.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.15 315/373] usb: dwc3: gadget: check that event count does not exceed event buffer length
Date: Tue, 29 Apr 2025 18:43:12 +0200
Message-ID: <20250429161136.064350240@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frode Isaksen <frode@meta.com>

commit 63ccd26cd1f6600421795f6ca3e625076be06c9f upstream.

The event count is read from register DWC3_GEVNTCOUNT.
There is a check for the count being zero, but not for exceeding the
event buffer length.
Check that event count does not exceed event buffer length,
avoiding an out-of-bounds access when memcpy'ing the event.
Crash log:
Unable to handle kernel paging request at virtual address ffffffc0129be000
pc : __memcpy+0x114/0x180
lr : dwc3_check_event_buf+0xec/0x348
x3 : 0000000000000030 x2 : 000000000000dfc4
x1 : ffffffc0129be000 x0 : ffffff87aad60080
Call trace:
__memcpy+0x114/0x180
dwc3_interrupt+0x24/0x34

Signed-off-by: Frode Isaksen <frode@meta.com>
Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20250403072907.448524-1-fisaksen@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/gadget.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4361,6 +4361,12 @@ static irqreturn_t dwc3_check_event_buf(
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length) {
+		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+			count, evt->length);
+		return IRQ_NONE;
+	}
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 



