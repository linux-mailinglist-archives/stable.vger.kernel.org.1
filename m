Return-Path: <stable+bounces-155253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A739AE301F
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 15:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E193B2DA9
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 13:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C336C1E50E;
	Sun, 22 Jun 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmWPqyh1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719301DE3AC;
	Sun, 22 Jun 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750599603; cv=none; b=ZIH0BedIvOduo2stExyWO5sYV3QY9l1KtjJXcLQbpWm2bfb0sO6C06KFIf5Q6VJf4OSPSJWyLODm4mas5Qd89RsnW5kDCcVtCF8bue+OoLXFrzoP6QPf7vtyJ1N3nNzjq3UvZV+FkAr5AJWWELHIoFckk1ykWiECyeVuLcQeekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750599603; c=relaxed/simple;
	bh=diw1gDUh3SnWwKE6aIZJAx5qoa+BAbsc1mkKUgL3k5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=spWAbyxMyzH3qjaoUdN90+qnGFFQYCV06hWy9/B7U9OVvPNf7h4WhS6ZC1YZXhbn1P+5mqqVwH7hcFp1CZuwW0gY9D2IqNR2QNEcnFiBFZqivLvus0zx1H6B3c4GEdJantZRmslBP5qh+fp/cF7LnzFsts+x1LF1K+GiKZ8CaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmWPqyh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09640C4CEE3;
	Sun, 22 Jun 2025 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750599603;
	bh=diw1gDUh3SnWwKE6aIZJAx5qoa+BAbsc1mkKUgL3k5Q=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZmWPqyh1qqtDzx7vmqYTPoj/Hnb3q8qPCAhMzq7skUMzPUymnBwuGJvUQyhG/jpLX
	 8/zyog1YlYrS741gKGZg6UYxoVlnT47mRN7sF+kBY5+O3WaphQyq+04hmf8ero4lFS
	 AjLZhAemnJ57vRhKbiwu2FEGzSKixlH4hL3pBjOrHshCjjhZx7ius/ZtnKY6vxTqkq
	 kWy5Mr+FlPfbw1XE3WTGWFZICmQFQMV04umI9DoNKd1YGZzqTrlDVK6pUQpcOBCJVZ
	 F+H1deEeBzjGRo/XsmGr1nLz1jW/udBrEibWTcBfpfEvQpeN2D47bDIttyxvKaDTm/
	 hJNIocq0MHUvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32DAC77B7F;
	Sun, 22 Jun 2025 13:40:02 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Sun, 22 Jun 2025 22:39:56 +0900
Subject: [PATCH v3] net/9p: Fix buffer overflow in USB transport layer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250622-9p-usb_overflow-v3-1-ab172691b946@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAKsHWGgC/22OzQ6CMBAGX8X0bEl/oAZPvIchppQFVoGSVouG8
 O4W4sGDx9lk5tuFeHAInpwPC3EQ0KMdI8jjgZhOjy1QrCMTwUTGlGA0n+jTV1cbwDW9nanIqsZ
 kkFfQSBKtyUGDr714KSN36B/WvfeBwLfrt8UVlyKTeaJkKlPKaa1H9DeMo0U7aOwTYweyJYL40
 f68EES0mVBGcZabk+aFsTXMDsw9sa4l5bquH0JV0cjpAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3088;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=uRA+tj1CGV3hDEWLR7ul9klUmiXd1el2FvT0X0zpwug=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBoWAexM97EqqDps4uLE21H9hDjaDGpdSirjktFo
 j7iGJVVIYmJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaFgHsQAKCRCrTpvsapjm
 cEMWD/44v6jhy3s94nL9wsfiMpO26Of4JpPM+LjflzPMLbWWJAVoQnS7qsy/Kb7napyi4cki2X/
 jPPBfmt11kd5SWWGD1V07N/EMB1E2RwLAdWIroP+QUmOC1xjJ+zy+z3MUIp6fVFQX8NMWnKprLD
 XJdy8jSwcLjJDP51zZvqXttcYffvn5f/ph9fIeMNBUbpJ7aqYldW9afXD43//fpcy0qCR8Q1PrQ
 AhUlIZGuuzGcxTJhmsDietbjMz6uXDwyghu6N2G2X0oo5C6jT3HjAJ7B1kaUTUHNB7DKT0dX0yq
 OT962DE2EQTUaPOAH+n6HescgdUK7pktU6EKzdiUwSQCakTN7LophVtJiBbSILAvo9QdBCHHq0u
 N3/tD3evkVq2Y/hSSkUy9T5xuHv+IufLlhX0R0sQUKeAtzel53p+TeEIkp9aW/D6cLd/NZS6LjD
 ZWZao9VlbAoy7KRVFyiqDQ9MfMM8P65j0vVVBwGnwlFgQTwwyikmaIkYZQDkH0hCmuls98byVlB
 M/sIcbUGpbpVhS6R+Kdc+amkjT+uUpj2d7T0GdsmsQnr6XAZOy2JP9xHMX0UWu2kAqvyatDA6SB
 m0rrjgfsOpiSZJ3NUXL/o4l/S5Jf7eqP70mGqeoLNyq3dQd0zfGRovnTxumXni1CHPs0HwakhM0
 WHRuZ6CViWFMsPg==
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
(still not actually tested, can't get dummy_hcd/gt to create a device
listed by p9_fwd.py/useable in qemu, I give up..)

Changes in v3:
- fix typo s/req_sizel/req_size/ -- sorry for that, module wasn't
  built...
- Link to v2: https://lore.kernel.org/r/20250620-9p-usb_overflow-v2-1-026c6109c7a1@codewreck.org

Changes in v2:
- run through p9_client_cb() on error
- Link to v1: https://lore.kernel.org/r/20250616132539.63434-1-danisjiang@gmail.com
---
 net/9p/trans_usbg.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 6b694f117aef296a66419fed5252305e7a1d0936..468f7e8f0277b9ae5f1bb3c94c649fca97d28857 100644
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
+	p9_rx_req->rc.size = req_size;
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



