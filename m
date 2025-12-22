Return-Path: <stable+bounces-203227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07395CD6A08
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 17:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9BC303ADCF
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D2932B9AA;
	Mon, 22 Dec 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="b54AkQ7H"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720927990A
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766419529; cv=none; b=e9IIBHvKlTYTBJAxiteLsKAj2PZVIOcznFTG/RGalLLaI6E0Ci0yzgWQ5gWvKS4vPlqibfhkH76AsmF/1/MRa0HxjfPS/rGUZySMEQqD2wC2I2+zoylCwy/6Kf+stBiZCO1xCVlducmheQRz1qWMDp3U6HUp1pzb4Kr59q7b/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766419529; c=relaxed/simple;
	bh=LMbD+mGVr4R54oqbuSPJjT7hgxHNDpTTEhrQ8kp91Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A8a1p6FAGCi6O8sGAFbbzOXkItijcfPb15fBHjX9PWOeaZYNKv0sIAlcZ1SZT5ex8/ETXCSBILikF+xq9eHamjrVuqEUXQDIYEHj+aT9dyizrNrD4PMeUx4gvdMaQ3+e3aLGsKUgtte4ZZdmO9lJqz4cHTzWDvKqUGEV1sKq8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=b54AkQ7H; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so2139918f8f.1
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 08:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1766419525; x=1767024325; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HctcY/WyAFhr2CuJcQ/EAsavvvLqYgvVfTp40T2+6/U=;
        b=b54AkQ7HHP/tq12bLyOTeHEo7+nVfCF3CRchTgiHUadAoQWB2C/9H40S/JJRmK6kV+
         8isfjSwS6j8ZoLi+EnO3Bj7jU96pxWuHnmOYi8pmRk0uzX6nwXuk4lO3Y0q5C031PTSq
         nCkIXfta/BiEeGynoTbW5ADH3MdjzYQUluA6mp75u8enojIjccMtNPlYyQg/lzjEyG9X
         X7j2Az+60/2dBIn4FAH2qPFp4/qaLf55B1y0tHHOHu0yQEnINtHoU1qep1LQZS75b2Mq
         iZU6UtZG+ullkr1S2bFJmk3UvNnaUcmVa82QkENPWlKKd0inE73ncoGdaMAT76LE7c/G
         xCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766419525; x=1767024325;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HctcY/WyAFhr2CuJcQ/EAsavvvLqYgvVfTp40T2+6/U=;
        b=xLB3QD3CJPpazYZqubcEcw9OMXzFYFzJxDwzSAMt4puILuJPPqAqKeWLfns9OoiQSb
         rvD8DqOzu4kGTxt+jMukM14oR6f6krZgWi1bhmbgwd61YgAnlHLQS25FvHCmTDi4HCqh
         AqCyPTi6sGDDUHiT5rr12ao/nPALCe4k/e3sRsI5tFpvCvq/LEq9BFf1tCvIG0k/j2sT
         Z1nrJZeR+JVUjl1vbhdE+l2ih9S7yLPdL3Sz93kN8RrI+5SlI8xBZbVdOdfM9PUWgGTn
         wZuPfzfQr72SQN/rbNxAnl37B551Hv37wjvWuiF8QWrllTQUw9iTDRw2iawwfnX9mL4S
         JVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuEep7hgv72nZi+bC62CqzmO/uHuB7FL0Bx8xJOe/+pyskB9akRvatnvj47ZSv+DAcLaboAlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbHap7nDYShYWLjwLw8bWznJuzrME3vPt/dT0lS2GcEX5xnwJl
	6Y4Lb2ORMtB5RmvjGymf+LMJiv8y6Tos4ZvWrwX6IrJ6PXmPhj02GehT1eBQZ1vl2KI=
X-Gm-Gg: AY/fxX4Vjco3x9Txe/KTebz6iwriOYVr+E8ZK9qVYKojldeaMAxHy/cxaIaEV+WrjMI
	ROJ9kvsYQ6OE4Z5TWaiq+aVYH+ze4IdpMLRa5w/vK2o12qSufrtT2hNUXA4gd027x4h/2hMRCLN
	y5ZOrArqtk33BYcnVl35JiUpdBKGwdPconMArP9xTEM1n11Ncl2WwESChDti836mk5E3r6AntlT
	HU6+f3020/ljG71bQ7R0RR06yG3TG4CZ5pkgO2YbF3yPAUXf7YZaq6rfC58ZwM5kqstTOwUv8ki
	ueYf6cMHVjzxLdYjYPHUyZwswdvNhd4OZ5R6VThsu7lX2fNlfLhbcqKOEA9HP2q5vVdLEANhqwl
	2w5KpnluRA6gHS8zkWjIuYsnPmc1tRd2h6VepE+oHQRSfhaE5QlrHTpXULfKCSVOGBRw31Fs8Xw
	2ikPo8b8Ll4PaDzek=
X-Google-Smtp-Source: AGHT+IGSknRdbsa5PQMVNQHcORhsGBo5WTH0vm6MkjJM8fZl6NeQc1jKFM6m/ElAUYfOJ5bhBHDSTQ==
X-Received: by 2002:a05:6000:2dc7:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4324e50b88emr12613044f8f.46.1766419524478;
        Mon, 22 Dec 2025 08:05:24 -0800 (PST)
Received: from fedora.fritz.box ([2001:a61:11b4:1201:32:bc57:e0b3:1183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm22954962f8f.37.2025.12.22.08.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:05:23 -0800 (PST)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 22 Dec 2025 17:04:53 +0100
Subject: [PATCH v2] virtio: console: fix lost wakeup when device is written
 and polled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-virtio-console-lost-wakeup-v2-1-5de93cb3f1c1@isovalent.com>
X-B4-Tracking: v=1; b=H4sIACRsSWkC/43NQQ6CMBCF4auQrh1DawbUlfcwLJoyyETskLZWD
 eHuVk7g8nuL/y0qUmCK6lwtKlDmyOILzK5SbrT+RsB9sTK1QW00QuaQWMCJjzIRTBITvOydnjP
 UAzaNQ9cfcFAlMAca+L3Fr13xyDFJ+GxfWf/Wv7JZg4b2ZNFhe9RI7YWjZDuRT3snD9Wt6/oFT
 8iq9cgAAAA=
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

Fix this by calling reclaim_consumed_buffers() in out_int() before
waking. This is similar to the call to discard_port_data() in
in_intr() which also frees buffer from a non-sleepable context.
This in turn guarantees that port->outvq_full is up to date when
handling polling. Since in_intr() already populates port->inbuf we
use that to avoid changing reader state.

Cc: stable@vger.kernel.org
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
As far as I can tell all currently maintained stable series kernels need
this commit. Applies and builds cleanly on 5.10.247, verified to fix
the issue.
---
Changes in v2:
- Call reclaim_consumed_buffers() in out_intr instead of
  issuing another wake.
- Link to v1: https://lore.kernel.org/r/20251215-virtio-console-lost-wakeup-v1-1-79a5c57815e7@isovalent.com
---
 drivers/char/virtio_console.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 088182e54debd6029ea2c2a5542d7a28500e67b8..351e445da35e25910671615a8ecc79165dfc66b7 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -971,10 +971,17 @@ static __poll_t port_fops_poll(struct file *filp, poll_table *wait)
 		return EPOLLHUP;
 	}
 	ret = 0;
-	if (!will_read_block(port))
+
+	spin_lock(&port->inbuf_lock);
+	if (port->inbuf)
 		ret |= EPOLLIN | EPOLLRDNORM;
-	if (!will_write_block(port))
+	spin_unlock(&port->inbuf_lock);
+
+	spin_lock(&port->outvq_lock);
+	if (!port->outvq_full)
 		ret |= EPOLLOUT;
+	spin_unlock(&port->outvq_lock);
+
 	if (!port->host_connected)
 		ret |= EPOLLHUP;
 
@@ -1698,6 +1705,7 @@ static void flush_bufs(struct virtqueue *vq, bool can_sleep)
 static void out_intr(struct virtqueue *vq)
 {
 	struct port *port;
+	unsigned long flags;
 
 	port = find_port_by_vq(vq->vdev->priv, vq);
 	if (!port) {
@@ -1705,6 +1713,10 @@ static void out_intr(struct virtqueue *vq)
 		return;
 	}
 
+	spin_lock_irqsave(&port->outvq_lock, flags);
+	reclaim_consumed_buffers(port);
+	spin_unlock_irqrestore(&port->outvq_lock, flags);
+
 	wake_up_interruptible(&port->waitqueue);
 }
 

---
base-commit: d358e5254674b70f34c847715ca509e46eb81e6f
change-id: 20251215-virtio-console-lost-wakeup-0f566c5cd35f

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


