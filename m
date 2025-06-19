Return-Path: <stable+bounces-154832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491FFAE0EFD
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 23:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2394174739
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 21:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD2125B2E8;
	Thu, 19 Jun 2025 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB7oRRku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2623183B;
	Thu, 19 Jun 2025 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750368125; cv=none; b=oVJUAULnBOWuBLRoyNwf5wihv5EbZyt40q3JcXQmEXOv2ijZhcn3ZeZ8R47qTvr/cZqBHg6RmPVnbDPIOsfu57+St6DDH0qyBKwiBxfBLIBiFK3LymiUVMwElIjGVTR7T/UwX4ROdSyZZDYgUOFv9bp66hFZWTVJ5em7ecYRoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750368125; c=relaxed/simple;
	bh=pRuGfH2o8r29IBa31hoMcUPybgxpzd9xd7p/eTD4ucE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ajfDyKAHuaRzUKQc6AcoaiEvCieKEPULNL/tcPGH7NzyzPKxJrwn8QN7F4jnocAEd7pOQ3wLf55bIst3bw/IMhWzWMVHC21UOOUQlCv9R47ItpneOzWBwYZSSu/uv0s0WNqmYNBSSG88s7X1SyjliLhVdmOZ6qodL5bMFGV9XMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB7oRRku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6067EC4CEEA;
	Thu, 19 Jun 2025 21:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750368125;
	bh=pRuGfH2o8r29IBa31hoMcUPybgxpzd9xd7p/eTD4ucE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=QB7oRRkujF64rco7v1qJSFRQ2UuX/i+bueaLWm8EloYX302qLwPpi60nZiCv2LpFh
	 b0DqWyUc3mEuw3RZ5fP0k0ZLuNKfRmR2LYyaXB8EPeBv+WVMwOFjx1XhLtP1o4bFPP
	 3FOfOmk1krrwGqGFisNi5MS7IcHV2SKrsZi3KhXugevEAnx3eXu/tKqswkB3gXv+FW
	 xWBRJVLKsq2YlDhKlDNPXktdimQm4ainjzAAQCooQvyiX9YpCm6mqHgUetK5UD+D2H
	 EVFoVU5Jq3bwimQqxyCSK3QW0bFN3hi1SSClf6B+5loLFs5KHPbYZNDgC/Ulh/SSkm
	 9VArDebKn7jQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5626BC7115A;
	Thu, 19 Jun 2025 21:22:05 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Fri, 20 Jun 2025 06:22:03 +0900
Subject: [PATCH v2] net/9p: Fix buffer overflow in USB transport layer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-9p-usb_overflow-v2-1-026c6109c7a1@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAHp/VGgC/y2NWw6CMBQFt0LutyV90Cb45T4MMQVu4RqgpFXUk
 O7dSvyck5yZHSIGwgjnYoeAG0XySwZ5KqAb7TIgoz4zSC41N5KzemXP2N78hsFN/sWkbl2nsW7
 RKcivNaCj92G8NplHig8fPkdgE7/17xJGKKlVXRpVqYoJ1tuF4p1y9DLMlqay8zM0KaUvVTFZO
 6UAAAA=
X-Change-ID: 20250620-9p-usb_overflow-25bfc5e9bef3
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 security@kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=sd75KIQYdSHcNYSxHvOsd/ZrBkByS+On5VAz8Wg9id0=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBoVH98nfmseHzKhOwth426LG3xCNHGuKrMrPYIS
 6knofnzWnuJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaFR/fAAKCRCrTpvsapjm
 cKyeD/oCJfejbpmPwkb/cnIW8YPsRFbmsDmvntEQHaill6n6KcyQB3v3oKHUGopejHFtiUl8TYQ
 NToXHtB3AKIWS7xpi4nHpHT+0QBUKW8TADf4peHz6SC9Mtnz3tUGLcrDMEFEjOBz9z+dQMfzEXT
 cLulWcIkJfGJQzNr0WON4ekRHI/EH0KSETffLJ5uedpG15CJPSypltjzs2RYIBtHyYiR6rcfSx6
 /snUGfZrEbSz/XfTLB3LOdxrFPEk6Ue/lJ7i2A4ANJGxL9SNKoF7iOnzPBjqhvgENnn/XgWi1Td
 +eq24+g3eeygU8qsaYnmtRHZYGa9Tm6ea8a1yG7wBS234sgRNMOfKTjH5nbLmvTDM9uQrbYdb+W
 vMeOdDJfeTh9ebLmRxdHGBkdZvliQKm/l0uU6G/wJ8DRmprt+sun73E7h90Zd53/u39mH3kj/3i
 i1l2jIGgVbBCjbxa9Nhdo0cfQcv1EdYRviS7m5azPRYRwKrRxaVXEc0sx9ef3X/iYNpZiewb6J9
 hxTVpZIe+YgQ1CTyAUlMWpv79xb/B8Ondu6yAX83B1+bfoZlJCRoThx2jtyR10yNjvRg11gY4Bj
 EDmfB3Zd6juPxcftwIgFSKK8fE1WgtERblihLOmKiO7xz+qjINPl/nurkKs7eF+xY7Zju1y4GX0
 Vq4Nxjjs6kH9Neg==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

From: Dominique Martinet <asmadeus@codewreck.org>

A buffer overflow vulnerability exists in the USB 9pfs transport layer
where inconsistent size validation between packet header parsing and
actual data copying allows a malicious USB host to overflow heap buffers.

The issue occurs because:
- usb9pfs_rx_header() validates only the declared size in packet header
- usb9pfs_rx_complete() uses req->actual (actual received bytes) for
memcpy

This allows an attacker to craft packets with small declared size
(bypassing validation) but large actual payload (triggering overflow
in memcpy).

Add validation in usb9pfs_rx_complete() to ensure req->actual does not
exceed the buffer capacity before copying data.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Closes: https://lkml.kernel.org/r/20250616132539.63434-1-danisjiang@gmail.com
Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Not actually tested, I'll try to find time to figure out how to run with
qemu for real this time...

Changes in v2:
- run through p9_client_cb() on error
- Link to v1: https://lore.kernel.org/r/20250616132539.63434-1-danisjiang@gmail.com
---
 net/9p/trans_usbg.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 6b694f117aef296a66419fed5252305e7a1d0936..43078e0d4ca3f4063660f659d28452c81bef10b4 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -231,6 +231,8 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 	struct f_usb9pfs *usb9pfs = ep->driver_data;
 	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
 	struct p9_req_t *p9_rx_req;
+	unsigned int req_size = req->actual;
+	int status = REQ_STATUS_RCVD;
 
 	if (req->status) {
 		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
@@ -242,11 +244,19 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 	if (!p9_rx_req)
 		return;
 
-	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
+	if (req_size > p9_rx_req->rc.capacity) {
+		dev_err(&cdev->gadget->dev,
+			"%s received data size %u exceeds buffer capacity %zu\n",
+			ep->name, req_size, p9_rx_req->rc.capacity);
+		req_size = 0;
+		status = REQ_STATUS_ERROR;
+	}
 
-	p9_rx_req->rc.size = req->actual;
+	memcpy(p9_rx_req->rc.sdata, req->buf, req_size);
 
-	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
+	p9_rx_req->rc.size = req_sizel;
+
+	p9_client_cb(usb9pfs->client, p9_rx_req, status);
 	p9_req_put(usb9pfs->client, p9_rx_req);
 
 	complete(&usb9pfs->received);

---
base-commit: 74b4cc9b8780bfe8a3992c9ac0033bf22ac01f19
change-id: 20250620-9p-usb_overflow-25bfc5e9bef3

Best regards,
-- 
Dominique Martinet <asmadeus@codewreck.org>



