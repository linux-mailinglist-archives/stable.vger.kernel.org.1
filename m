Return-Path: <stable+bounces-152710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F309ADB1A3
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 15:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B017A931B
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFBB295DAA;
	Mon, 16 Jun 2025 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlYg7lMM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7F322A
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080121; cv=none; b=gOqIhbtbrj4bvrMiCwAk4sRXTs1UrJ+EbnEeReJedn5Y9ozmYuX7+rhjQLntsM0eAJzMbVOm58T0M5L6dxZhJcQqlm9fMsYnVywUlYcjpvxNCBH15ida058Zz6zKCBjMHDtYQOPr8UYKhfZ92MzpH/eNQ5GKOQp2osQSuQJLao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080121; c=relaxed/simple;
	bh=snoRr8xqPCX1q6v5UT3e3qOJLLdkgkfB8xSf2/kc2og=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EFLrgfQYkl5sCU+M71JrZpEVsbGt8c9/IAXVq/SIsGuX7G4yMHHtuW/IlZsTzGBmntB9zzj3RhU6VvJ9/hmeZ2THWd/jJpxhF3HP6gZG74oGd4PhbZNtgGvEK4RmWzUn84V98UXTM0tzo7sXJNnnuGqkJFkxZJAX7WlN5xSVprc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlYg7lMM; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-32b378371b1so18858571fa.2
        for <stable@vger.kernel.org>; Mon, 16 Jun 2025 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750080118; x=1750684918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+wpesHRUPDqi60RLXef7EtIJEHtOo2/d8OA6QGc6qao=;
        b=mlYg7lMMRBZdpCKfK5wDvDPK56fWpJ1S7CdMF5dM/RlMe9Z0EmdncWPY8T8+k/NxLW
         5RBMNJv/1rAqd8fQiUu6bNyENERPbZTdru5xNCMPQsF4J3nO6RwtbPiT0Qlv4amuwfiL
         jfkvRCDj5Rqrs44jy97FX4dpH9aboNddRBFdmS+0aX8DLKk4QRdyXUBEedy3vanm8zZO
         Pqb34J4Xbn3ICxil3HZ9Mgv5SkK6TW7xvxSBpvDIspzNDrwAQruvkntgoExDvtrOQoL7
         eMlB+LK9Dctw0+KCB9aw4gOkX+egAtXSKvvb15Il5JGj5vutX+KFXEDeFZNi3nz6he1b
         NFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080118; x=1750684918;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wpesHRUPDqi60RLXef7EtIJEHtOo2/d8OA6QGc6qao=;
        b=UFAYsmcQXSI85JSDykzMkDoC7YHX3KW9JN97lKXAgVBtbJtwU51lcGNqR99FDjW0Ew
         RFr8o//SKxsllVrOdF/s3+jkzwiCwhr1aJ2XfQ9+buV03d20J8S2nctpINGsm+Xr6jOr
         nrc0raarHJ0dUKaSCIt8bml69qCDF+/P7ZX7iQMKEwrCL8SWHMZprJcOuMlXWR5SbcTw
         v4Jfg04C3nCIsyaKY+U4kAV1kvV0KP+VhAz5dFq3X+qTdrZ0iy1x21wm7jabtuFfxMq3
         lnZzztspZuhJZOSM9VuaBgPcEF8O5tM22BzT9YSOH8CeKM6z9QHPTlsDdCCWPcXO+AUz
         GCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIr2z0KXiBcda4JsS0O3xYE9pz/XlXWy51ApnOF8gNbhy4Ya7S+Y17YLiCd/NIid8lvEGW854=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0ot9vq/dCv3tYTIk5EKk/tE17qRKDgABbVPQhSMJRmKRG4MN
	MP0lKM8u7uVy/Ealg1wW5G/VLwxo62RvAkOL/6TNAjau8KkSLy/xKdwU54TrOTqe1IeFoxN/Wm/
	QzcoIXg==
X-Google-Smtp-Source: AGHT+IEUw7ShAXSFd4hYcxCe9dpyjAp50IoBjuXCACE4y+U6F8ljTk3RT64JstZyf6/UEAq3f4cLeQifNjs=
X-Received: from ljpy22.prod.google.com ([2002:a05:651c:1556:b0:328:a1d:30a9])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a05:651c:b20:b0:32a:847c:a1c0
 with SMTP id 38308e7fff4ca-32b4a0c5893mr21717061fa.6.1750080118053; Mon, 16
 Jun 2025 06:21:58 -0700 (PDT)
Date: Mon, 16 Jun 2025 21:21:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250616132152.1544096-1-khtsai@google.com>
Subject: [PATCH 1/2] Revert "usb: gadget: u_serial: Add null pointer check in gs_start_io"
From: Kuen-Han Tsai <khtsai@google.com>
To: gregkh@linuxfoundation.org, prashanth.k@oss.qualcomm.com, 
	khtsai@google.com, hulianqin@vivo.com, krzysztof.kozlowski@linaro.org, 
	mwalle@kernel.org, jirislaby@kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit ffd603f214237e250271162a5b325c6199a65382.

Commit ffd603f21423 ("usb: gadget: u_serial: Add null pointer check in
gs_start_io") adds null pointer checks at the beginning of the
gs_start_io() function to prevent a null pointer dereference. However,
these checks are redundant because the function's comment already
requires callers to hold the port_lock and ensure port.tty and port_usb
are not null. All existing callers already follow these rules.

The true cause of the null pointer dereference is a race condition. When
gs_start_io() calls either gs_start_rx() or gs_start_tx(), the port_lock
is temporarily released for usb_ep_queue(). This allows port.tty and
port_usb to be cleared.

Cc: stable@vger.kernel.org
Fixes: ffd603f21423 ("usb: gadget: u_serial: Add null pointer check in gs_start_io")
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/u_serial.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index ab544f6824be..c043bdc30d8a 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -544,20 +544,16 @@ static int gs_alloc_requests(struct usb_ep *ep, struct list_head *head,
 static int gs_start_io(struct gs_port *port)
 {
 	struct list_head	*head = &port->read_pool;
-	struct usb_ep		*ep;
+	struct usb_ep		*ep = port->port_usb->out;
 	int			status;
 	unsigned		started;
 
-	if (!port->port_usb || !port->port.tty)
-		return -EIO;
-
 	/* Allocate RX and TX I/O buffers.  We can't easily do this much
 	 * earlier (with GFP_KERNEL) because the requests are coupled to
 	 * endpoints, as are the packet sizes we'll be using.  Different
 	 * configurations may use different endpoints with a given port;
 	 * and high speed vs full speed changes packet sizes too.
 	 */
-	ep = port->port_usb->out;
 	status = gs_alloc_requests(ep, head, gs_read_complete,
 		&port->read_allocated);
 	if (status)
-- 
2.50.0.rc2.692.g299adb8693-goog


