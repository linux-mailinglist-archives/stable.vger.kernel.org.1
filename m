Return-Path: <stable+bounces-191103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E7C11147
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 261C7507B62
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC4E2D836A;
	Mon, 27 Oct 2025 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vzmNNwUC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70923EA92;
	Mon, 27 Oct 2025 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593015; cv=none; b=uXB+H+mjQX7fWoLW994BFb2Bqir1W+P7Bpv5JocPIY3C1psx/orlLSajZuoIoThF0F2vN4AXB9l0a44sX8/4bkArPb8J5XCiip0DpmUbsy7qBFGt0GmKdeLaJLempVB/+JCKtu+65a9XipFi4UdzprQpk/LHT8cpBv2gEjXxdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593015; c=relaxed/simple;
	bh=keUInPnTrEsb+7VJJZggau9jqJvG13MyMjRmcvZ+JHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tg3iBrasGBBAUJgsyOwn56+2jG+zwcNSmjOkI4znAvxCxSOqzyZfaBpFcaUbQzSmTRTNzY497Kdgf7f5HmYjGIoYFOPYS5weiWYtcCCyLsTNLF4Z/K3e3vZBAAjkqRZDiIafU0OhDx8eWgQyoj5YQrTdrD7bAnRKZ4Fva8+LsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vzmNNwUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CC6C4CEF1;
	Mon, 27 Oct 2025 19:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761593014;
	bh=keUInPnTrEsb+7VJJZggau9jqJvG13MyMjRmcvZ+JHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vzmNNwUCsknf+Ytp1DZeQZbBjVPDpri9hktCpRrI4jPgQPhNuTTnp7MJl5iq99ZDg
	 hhcAYxxmB55vmruvrwihfqlIS+V/bUnhMN1xg30AJCcHcv+FOABMaSd0m1+lPY2dt3
	 OdrOB0mEDJUJcs9jzS3X0G5MKQxZ31XhcFC9qyHA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Tim Guttzeit <t.guttzeit@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH 6.12 097/117] usb/core/quirks: Add Huawei ME906S to wakeup quirk
Date: Mon, 27 Oct 2025 19:37:03 +0100
Message-ID: <20251027183456.641633670@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
References: <20251027183453.919157109@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>

commit dfc2cf4dcaa03601cd4ca0f7def88b2630fca6ab upstream.

The list of Huawei LTE modules needing the quirk fixing spurious wakeups
was missing the IDs of the Huawei ME906S module, therefore suspend did not
work.

Cc: stable <stable@kernel.org>
Signed-off-by: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Link: https://patch.msgid.link/20251020134304.35079-1-wse@tuxedocomputers.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -464,6 +464,8 @@ static const struct usb_device_id usb_qu
 	/* Huawei 4G LTE module */
 	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
+	{ USB_DEVICE(0x12d1, 0x15c1), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
 	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
 



