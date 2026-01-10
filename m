Return-Path: <stable+bounces-207968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CBAD0D88B
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 16:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5615F300CA1A
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F48346AF5;
	Sat, 10 Jan 2026 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX8nwCoS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6953451AA
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768058839; cv=none; b=CzTcgGKJS7zk3kNTro6vWfO000JKhloh9T/fv6f0Jv5P/3f/AFDRCWDKOf9ZyDuCfBuCsE8eDzHVHYVxWqzxR0hcpjJh6/lhRHoPdXV+AZOiiw1jDgoZmXvKyFyGgXvOgxpFkJi5LsSFsivYeFIh98ZIS9RegMGseivyBL7Phl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768058839; c=relaxed/simple;
	bh=xu8YmLa9g/+vSRsD/1C8fTOol2NBa1KWM6qO1hoOa0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mX5qYUYwfrp0IwNdivCo7Z0qpp5b3HyLbmbTUDLS+gcq+CLC5q+OIUc3Oqul4/uLsFDXwbOlStDi2jnTViHq54m1X0VvW1fStjvHE3FMNlX/wWZRF4WUAx805eFBtGD4Zx16XeVB5tYsBUR9ueSgRKhcxF6kusv3HKZ4ItWHid8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX8nwCoS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so3469480a12.2
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 07:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768058837; x=1768663637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs1NcoSCG83oetkS9nkeOp/DwLHdbXKpQV7fIcvsjA4=;
        b=QX8nwCoSQoP8SmgRFl2wE+K70xsxPkoH7S/UBQ9DkkUcu82NjTCmMJlYQqfXZyWkN9
         b8jPXJgUfyAbT4O3KMFPZC85PToYo06vAIHYhyoo7HwBXwGLP12RA/MAdBchuDNbGZhA
         4gDWoDB5HzV/V+MvZfjf2XINJqM8i/Ixz0j9goTSNMazdofuzxEpVXpC+Bf8Eak89ZB8
         WoTfJRQYE9UilO5XxB13tTEuYoQiOmVhjrzgemhFCRDxDyzHR4HMTF1hFpwSImVGef3E
         QTTBweR+KEPB1GL3UD9z10K+nCaNADXo0wpbdeh6jDQw5djw5Fm5pQCE8Coy2CmI1pv2
         YGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768058837; x=1768663637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs1NcoSCG83oetkS9nkeOp/DwLHdbXKpQV7fIcvsjA4=;
        b=iBg0/ccyeRlUitEfMaurThrvIt8+gzK9mXM3RT1fdwfFam1Oiqzt1uRyommqSGtXLV
         nIVlEF/Huhk8MvhICH465TKetYt2rsKzQIYzBr/Wv4E+Dwe9Tmfi4+i6Rr12550BMho7
         EDoI2YqyhU+/HrGAq7lpJlIPTST/8L09Wr88i+ogTKL+LCSl4vcsCv4TLvlXlh7Az/Eh
         YJva9cRHej/45qaypcDoWBzrVHdAIbx/0lO1NjT+4oQS736S/5MWVI2WV7LrQ/tI1jsW
         sVFcjCKdNU0WxwLUhJGAhQFHGCvPtQP0mLjGcR4123FW7uVsmyCLPMk7TLnqMkdWAcHx
         Pw4g==
X-Forwarded-Encrypted: i=1; AJvYcCWgIid7hVmTiXsqpdk+msqSsqc/1yip5it8MwJa/Wo+y5frT1029sGkuIZvQAMakBI6gjZmDZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0h5F9KsuRJK3xkFiWi2UPqKEYdnt3w5NGGty04D/Bd0GCuYp
	oECVjZbGDRxF/trzvT8+3TG9FJwrAAcPiRdBXXybLL+ef+pW1mgdWHwm8O+LfRqw
X-Gm-Gg: AY/fxX6uc8ltZBwWT7B6wzndpFU48xrh5M91ITwiitNK++63q8DWi4WaLx3aRNo2G/w
	vdox3lXTAOCFrcOzsqmkTqvRHqo2CwWDKt9IB57jM40YCQQAcXQrZXs7zpXHR7b/YYqfC4JGS6N
	kvGYYv7WJAERF87NycaRg2FX2usa1kqAHFrwbYiTE3VKvZbpVDdsN9Pameqz03EDbZqh7illzVS
	n+1AvoYONGfs0lJaikqLnWKTu33h2D1JFuu8VfaSVd/k6qn1rZVdXLB2WDNUTxA+7QVx8pl1yTp
	n3D6iw+CLG2KUWUAFl9uAPmro5aN95MWqx79L7Mu6Wq5K0Ioa5sq9+JVM/+X5/n/papKCw0m998
	MLwNlUallBfAuP5wgtw0IBNTOLYkzrMc4LFABGIpo3Ygr32/im5xSeGYkW1Tkd0bMdiGzOyOra1
	3A3nDudi6VFwHdFhXde/rDya/4cW7yJzs0d0xbvA==
X-Google-Smtp-Source: AGHT+IFS7Czhg55hKmIHgUDpb396S6tfxneJqb6vjnaIo6fdMRy08wY3beDzB8AqxuS9tTnynMe9Pw==
X-Received: by 2002:a17:903:3c27:b0:2a0:86cd:1e3a with SMTP id d9443c01a7336-2a3ee4b23a9mr131778325ad.44.1768058836907;
        Sat, 10 Jan 2026 07:27:16 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a512sm133838105ad.10.2026.01.10.07.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:27:16 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+47321e8fd5a4c84088db@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v3] media: as102: fix to not free memory after the device is registered in as102_usb_probe()
Date: Sun, 11 Jan 2026 00:17:53 +0900
Message-Id: <20260110151753.1274725-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In as102_usb driver, the following race condition occurs:
```
		CPU0						CPU1
as102_usb_probe()
  kzalloc(); // alloc as102_dev_t
  ....
  usb_register_dev();
						fd = sys_open("/path/to/dev"); // open as102 fd
						....
  usb_deregister_dev();
  ....
  kfree(); // free as102_dev_t
  ....
						sys_close(fd);
						  as102_release() // UAF!!
						    as102_usb_release()
						      kfree(); // DFB!!
```

When a USB character device registered with usb_register_dev() is later
unregistered (via usb_deregister_dev() or disconnect), the device node is
removed so new open() calls fail. However, file descriptors that are
already open do not go away immediately: they remain valid until the last
reference is dropped and the driver's .release() is invoked.

In as102, as102_usb_probe() calls usb_register_dev() and then, on an
error path, does usb_deregister_dev() and frees as102_dev_t right away.
If userspace raced a successful open() before the deregistration, that
open FD will later hit as102_release() --> as102_usb_release() and access
or free as102_dev_t again, occur a race to use-after-free and
double-free vuln.

The fix is to never kfree(as102_dev_t) directly once usb_register_dev()
has succeeded. After deregistration, defer freeing memory to .release().

In other words, let release() perform the last kfree when the final open
FD is closed.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+47321e8fd5a4c84088db@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=47321e8fd5a4c84088db
Fixes: cd19f7d3e39b ("[media] as102: fix leaks at failure paths in as102_usb_probe()")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
v3: Add missing initialize intf pointer
- Link to v2: https://lore.kernel.org/all/20250904054629.3849431-1-aha310510@gmail.com/
v2: Fix incorrect patch description style and CC stable mailing list
- Link to v1: https://lore.kernel.org/all/20250822143539.1157329-1-aha310510@gmail.com/
---
 drivers/media/usb/as102/as102_usb_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/as102/as102_usb_drv.c b/drivers/media/usb/as102/as102_usb_drv.c
index e0ef66a522e2..44565f0297cd 100644
--- a/drivers/media/usb/as102/as102_usb_drv.c
+++ b/drivers/media/usb/as102/as102_usb_drv.c
@@ -403,7 +403,9 @@ static int as102_usb_probe(struct usb_interface *intf,
 failed_dvb:
 	as102_free_usb_stream_buffer(as102_dev);
 failed_stream:
+	usb_set_intfdata(intf, NULL);
 	usb_deregister_dev(intf, &as102_usb_class_driver);
+	return ret;
 failed:
 	usb_put_dev(as102_dev->bus_adap.usb_dev);
 	usb_set_intfdata(intf, NULL);
--

