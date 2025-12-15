Return-Path: <stable+bounces-201022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D3DCBD647
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 11:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BD4530102BF
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AAD314A8E;
	Mon, 15 Dec 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Z2siKmbE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7AC3164C8
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795245; cv=none; b=K7WhGVYtFvKD3rF1I7xUSZTdHodfhBY1LYLpPyzcx8BpiWCqW7dYleapTRvsnVIR4s4Doi8ZywHsTb94QLa8CH5n/UKJSWV0Xwm5kFyBs1Cheh6jsrC0SJJ79tS0W1UTqFm/Nfu2iUbpZXmjrgB1zxU/Ke3zeX3L0ifalycEteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795245; c=relaxed/simple;
	bh=/SxEaFMNo7pFquIiCNEE+7QNb48DDtpf3LMr/IucKtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EI+iHrCL7FE9wmY68nam32BqTHmhDFAoigWyPmzTWsFTQqeGnKSGHchfx+jOMEcqelFrjawItRb53/KjqAKE63X1IYifah33HmMs/hMFQ2Xy605W7y1BfiWtzsx515KxYuMFDc1Vvx4AiMH2WV+YVN3sTe9G2CLd3d32qT9YbXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Z2siKmbE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47a80d4a065so20441245e9.2
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 02:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1765795241; x=1766400041; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XypjIFMPPz3oCrw1uobW8ajykibBtZzwnq44lW9wyhM=;
        b=Z2siKmbEAovfvAFYb1gQrbvU4mO19Ou658kmAoCobkPDTac3rGsOaCpHp7DJTpUSOP
         a8qM23r5G46Obvoo7ylHVHKXXjFFMbq+WrrrWbt5wBlhe0AGQankjWehJJ0X6HLL0Plb
         1Wnf6EeyT/xW6Zqt5y5Ctodl0FrXUoOnbW127bmTV5XEU8JQySh3o6MrkHNMfH8HJ48H
         VdvLwxdDcsbmdVQ/TnnIze8yEj2CrCqwvSSWgmk2Rd8arVyYLWynuQctGFCcrinfLDFE
         4V/rc9PmLOtipA/V1NjKghHk/G1dTN7OPNwtBaIRer0WiTZ8fGpPN3ttoWP83o7UNOzw
         uiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765795241; x=1766400041;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XypjIFMPPz3oCrw1uobW8ajykibBtZzwnq44lW9wyhM=;
        b=GyO0TuNJ8ZfyIUtkwKt1PwBc1E2OW0mx4DMrEZwB9K+Ig7hdaDC99YGOtQoh5LDeaq
         oYOOdjAwbVusPU1VZceEZAZrsW79YQbfMfx0XdaeLcrDC3yFFDLpSv+Kt6+Q2pUwuCMl
         aC1Y/GVTYz+PAxtz5BzqDpT5ci/lkXbMRVryTh8nsFEBZnEeYyvwqx6GXPGXInkrqc8g
         KobReJgcIcteli+kILWaECTsj/EaOQJku2Jmru+h9P+00zeaBh/7kJBEhtuh9U6WUifg
         6MtEFNQGe1PKNHIL02e/yTrN/Us/hbhVrN3/292tECU6M3JHgnxpsSQr7FAjvXdVdhXf
         JxXw==
X-Forwarded-Encrypted: i=1; AJvYcCWBSIDhEvia1Fp/gs69E1DbNiM7PxQilsF/j6RmJ2dXz5wyMr+s1p0PYQ6ts4KVTwrjn8+/yW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOGb5N4X6RFRxM58pCkkw2zwpprNioh0fm61LHjV4JYiml/C9r
	0Vis63/nwz5UaDYCDQEXNeUhLKpzCZTR6ADnBKoeDEEbEXjTILAVzFmsBo5AmeUSCMI=
X-Gm-Gg: AY/fxX7K96JlHNJ17AXFpVZxvYZrSxHtX/Z/vRuNiACIJSR73BJzOXTA/iN6lGclF/1
	T/ZsktzV5BLh/ZOsGfrvFCIF8BE3J5EJKKYJDLpzXPPMn2a2WaTMQF6YTyIFyQ4vHckQOdle5/a
	TNA/hGSXN6BEbBxastOtZm4lAZLBXp4B61jQi+rP+jnDAIcYnO3Lvn64yiC/vwCJNgIOTl54JJ8
	T+Rz1vSvSbdBuRjLxQvaf89uYg3dw30yYK9+PQjpkUqMQVvHd/cWPj4fUR+wprUYwyhOASaV0bd
	Ne4hocekJU+83JJx4KpmuIyu4J7TVR7MrcVdOemNdjGSlvnTE3aCQM6fxB4qhwDLwZQXCW80Ahc
	jE1ZzhcmAJ+BioJYLJFag8elqDfu9mXdWo18rqcuKr1ncTcJtgkJyO7r2PRbbA07K4X8L4zIP00
	FhWqSGR8IuTgmEpkQa0h2lgS4ZsDWeTc5VMD/Ct2x6CRYUjyAI+hKKx7jI43XcvgJR298+4EkQ9
	n0U/b+XF8A=
X-Google-Smtp-Source: AGHT+IFKg33PwsCdfmLQrXSGuuWbN6asFRauDAwGkuKbmzIP0FQVXEdLitzX17zXx3ezt3wX8qRQXw==
X-Received: by 2002:a05:600c:3151:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-47a8f8c0a52mr118993485e9.10.1765795241347;
        Mon, 15 Dec 2025 02:40:41 -0800 (PST)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f49da20sm178569895e9.5.2025.12.15.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 02:40:41 -0800 (PST)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 15 Dec 2025 10:40:13 +0000
Subject: [PATCH] virtio: console: fix lost wakeup when device is written
 and polled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-virtio-console-lost-wakeup-v1-1-79a5c57815e7@isovalent.com>
X-B4-Tracking: v=1; b=H4sIAIzlP2kC/x3MwQqDMAwA0F+RnBdoO+LBXxk7SE23YGmkcToQ/
 93i8V3eAcZV2GDoDqi8iYmWBv/oIH7H8mGUqRmCC+SDJ9ykrqIYtZhmxqy24j7O/FvQJer7SHF
 6UoIWLJWT/O/89T7PC4hn8hBsAAAA
X-Change-ID: 20251215-virtio-console-lost-wakeup-0f566c5cd35f
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

A process issuing blocking writes to a virtio console may get stuck
indefinitely if another thread polls the device. Here is how to trigger
the bug:

- Thread A writes to the port until the virtqueue is full.
- Thread A calls wait_port_writable() and goes to sleep, waiting on
  port->waitqueue.
- The host processes some of the write, marks buffers as used and raises
  an interrupt.
- Before the interrupt is serviced, thread B executes port_fops_poll().
  This calls reclaim_consumed_buffers() via will_write_block() and
  consumes all used buffers.
- The interrupt is serviced. vring_interrupt() finds no used buffers
  via more_used() and returns without waking port->waitqueue.
- Thread A is still in wait_event(port->waitqueue), waiting for a
  wakeup that never arrives.

The crux is that invoking reclaim_consumed_buffers() may cause
vring_interrupt() to omit wakeups.

Fix this by making reclaim_consumed_buffers() issue an additional wake
up if it consumed any buffers.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
As far as I can tell all currently maintained stable series kernels need
this commit. I've tested that it applies cleanly to 5.10.247, however
wasn't able to build the kernel due to an unrelated link error. Instead
I applied it to 5.15.197, which compiled and verified to be fixed.
---
 drivers/char/virtio_console.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 088182e54debd6029ea2c2a5542d7a28500e67b8..7cd3ad9da9b53a7a570410f12501acc7fd7e3b9b 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -581,6 +581,7 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 static void reclaim_consumed_buffers(struct port *port)
 {
 	struct port_buffer *buf;
+	bool freed = false;
 	unsigned int len;
 
 	if (!port->portdev) {
@@ -589,7 +590,15 @@ static void reclaim_consumed_buffers(struct port *port)
 	}
 	while ((buf = virtqueue_get_buf(port->out_vq, &len))) {
 		free_buf(buf, false);
+		freed = true;
+	}
+	if (freed) {
+		/* We freed all used buffers. Issue a wake up so that other pending
+		 * tasks do not get stuck. This is necessary because vring_interrupt()
+		 * will drop wakeups from the host if there are no used buffers.
+		 */
 		port->outvq_full = false;
+		wake_up_interruptible(&port->waitqueue);
 	}
 }
 

---
base-commit: d358e5254674b70f34c847715ca509e46eb81e6f
change-id: 20251215-virtio-console-lost-wakeup-0f566c5cd35f

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


