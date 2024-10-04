Return-Path: <stable+bounces-81118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9E3990F65
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B2FB3243D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2FF230E05;
	Fri,  4 Oct 2024 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQf0aqBi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD7230DF8;
	Fri,  4 Oct 2024 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066731; cv=none; b=gN5y500Th1CpAdB5UX28t5w2ClWhnB9trEFpvn6Cur7RQ90o2c+AOae1g/qaJ+6W9uKnP/kHhiBmElaQePWCtoGaGerTQShi6yuIpRjlx0qpWBe3wE2hrgv1ryJUgabXLc7iHNjUq/E74bb2OoUPynB/WyOe+oc1TIkSjF5VPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066731; c=relaxed/simple;
	bh=hyDw1l3XAa2qhiMVPI224fKp6u0AkjplnujYGbkdQPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVp/yumoHKIiil10fhDom119cndDAMIA6/ytMu0t1kSpYiqvJGyKXUbeiZVe83V7LNWa1VGZ64CIIB7ZnF8ln8GOVpkoJY04dml45ZGRmAAS0XkCNIUP1dxOYd8KVdTkfImyzVmLeuFvET/Oj8J8L+yXnJty3wWuM3W2SQrTMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQf0aqBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95647C4CECE;
	Fri,  4 Oct 2024 18:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066731;
	bh=hyDw1l3XAa2qhiMVPI224fKp6u0AkjplnujYGbkdQPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQf0aqBio6oOXcxBFnzF2zskQVIo/+L9DvsB421GidtYWFpq0+vw0OeHQISltUnjt
	 bFRAmQmwnajJpX4M8jDQzhXOJfd120U2+fC+ELJmctcJ3Z2rWhdXynofYVJIiP3B/T
	 fVJ1vHW8yRlQRSnNr3iNWm1RGfajRjxMb8T5vBVOiThT+F5tx9lCWqk9TrWhCtppU3
	 lK4Uu/OTORjVryAkjKIZeuZziEtYOiihY/OH+lrZdvj4amTuQ+G+B36icwiam56AOx
	 Co0W9MhJPt8/XGFfnya/hlI6iJPKXQbeBaj7pCmYAa+iqA5HeuxEk8sfYJAzo1qxV1
	 4jUv1jiC5O99w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/16] usb: chipidea: udc: enable suspend interrupt after usb reset
Date: Fri,  4 Oct 2024 14:31:40 -0400
Message-ID: <20241004183150.3676355-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183150.3676355-1-sashal@kernel.org>
References: <20241004183150.3676355-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit e4fdcc10092fb244218013bfe8ff01c55d54e8e4 ]

Currently, suspend interrupt is enabled before pullup enable operation.
This will cause a suspend interrupt assert right after pullup DP. This
suspend interrupt is meaningless, so this will ignore such interrupt
by enable it after usb reset completed.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20240823073832.1702135-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/udc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 3bda856ff2cab..6a626f41cded1 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -81,7 +81,7 @@ static int hw_device_state(struct ci_hdrc *ci, u32 dma)
 		hw_write(ci, OP_ENDPTLISTADDR, ~0, dma);
 		/* interrupt, error, port change, reset, sleep/suspend */
 		hw_write(ci, OP_USBINTR, ~0,
-			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI|USBi_SLI);
+			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI);
 	} else {
 		hw_write(ci, OP_USBINTR, ~0, 0);
 	}
@@ -748,6 +748,7 @@ __releases(ci->lock)
 __acquires(ci->lock)
 {
 	int retval;
+	u32 intr;
 
 	spin_unlock(&ci->lock);
 	if (ci->gadget.speed != USB_SPEED_UNKNOWN)
@@ -761,6 +762,11 @@ __acquires(ci->lock)
 	if (retval)
 		goto done;
 
+	/* clear SLI */
+	hw_write(ci, OP_USBSTS, USBi_SLI, USBi_SLI);
+	intr = hw_read(ci, OP_USBINTR, ~0);
+	hw_write(ci, OP_USBINTR, ~0, intr | USBi_SLI);
+
 	ci->status = usb_ep_alloc_request(&ci->ep0in->ep, GFP_ATOMIC);
 	if (ci->status == NULL)
 		retval = -ENOMEM;
-- 
2.43.0


