Return-Path: <stable+bounces-59234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF809306CC
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 19:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56B91C230E6
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2F213C691;
	Sat, 13 Jul 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW23k1hz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2D101D5;
	Sat, 13 Jul 2024 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720893187; cv=none; b=RojmLUsbMV8o7xDk5TkP5g6HDlECDXpTNCQRgjxkQbxIeR9x9X4NJIpdlTYah2zZiz5NvC2H9RYPjEhlQSKnSiHXvuomHIa0oyGpRKUKG3PI2NKeDwLsdkSfxUZd/xEWdDBO4CCCfVeJsiW3ZmuQlLSQmQNL45QU6Ud0bxQG2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720893187; c=relaxed/simple;
	bh=1lvgCU27aV1dz0/qda6JCIq5RcSbyN+LcZfZ1Bxgyks=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SCCEmRumdTIx1KOXCq2tkI5NtoLMzfVsKxehpi/a/69+MU9KUWm8BhxeJ8Zwmri6TkDlyQ+awnftPmfX7x14i2V6gL545Wk5ScQAgLvn9v0H7lIAyVumwajfkMmoCwOxgQMbhAFyK7sX69zNazq8AQPfgIK3eawuAnfyUbTyI8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cW23k1hz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso3975711a12.0;
        Sat, 13 Jul 2024 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720893184; x=1721497984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u/RkeX3Xco1WYoGbcnmJXKVnmBdfHSoQjMRfEZfId7s=;
        b=cW23k1hze1cWe5YWWXFhl9YnPYhcwgdqt0zZr2fT1M/pK8apmwdQRVwZ4It0KWv173
         9akjS4qiMozNN3WJ/TpfydvzV6fgJ4ltHjN9EA+tGF0R2Qebuq+NfYrCvW1aun9i+icy
         hpkv48FCrcApt1WX637kLy2JOrdZo5C7YDEKR9CIXY4R77lmwbxSRHeR/rzl5eYOLYAA
         UWiDrOaKAtfRpE/dmBi3t4uotJR8IknLjD/BGUoZWe4JNIkrm+ON7B+7wazXlEBAzW8I
         pIqT+1+H1MtdVPQzJaWox+N3MV2rAx8eoz5LaNQ0lfPUxjuMP5CdM7oq7duR0soSo3mO
         oNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720893184; x=1721497984;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/RkeX3Xco1WYoGbcnmJXKVnmBdfHSoQjMRfEZfId7s=;
        b=qAfFL8ND9INgj5SXwlphhgb0TF5DoiAKDTKROyuGPYRAqs63XnbP8JBJfDWD4yIQGx
         oQJx0YWyW9zPuVtq6r4IMzisTP5b4fxzo3PnCot5Xb0ZPur6zLdtEehZoP8LXcIeFSsi
         7zTKA/OykCvEgP50aMWbM83EolgCrdEOKNqDYb6Gulvbva09/TewRrFnyVVxHnTcl076
         fQ2ZwMLWbMnZ0GEkTsHkX9aHXrca2YyXgeQz5KlMOVF3fQ2E8gdN1kBBBsRNDRJXhQ7L
         Z3ESPJiGtcXrPj0WBinAbYJ4Tf9MqQDStE+ADUpbnmfQGMW2BDbhlS5UO/hBcEO+CfG7
         lBAA==
X-Forwarded-Encrypted: i=1; AJvYcCXYmdR3XZPIeXgVg+ey/Oa9+oe9n5KJCqjnUX88TwBtYiaTj+X6pi5Pe7MeuFFvROb38KMSK//56rkwZUZ9TP0HKf61oMBbWB39rDPD/QuKjRYRHii+oyTthvrm73dGlp7F6xNt4L03MY/L5lLgpJ9tkNyl0yNzZk35VqSARH47
X-Gm-Message-State: AOJu0YwwuekcnB101wWsybMhKuw4eDkPoRgoi0v2tuoz1jLNmjp1TqwF
	VqnROSXrizfmD9Rz6ptf09GT3Sad4ZmPqrB+f5a30sxfZ6knHttmQpGcEdy5Cc5ZwKU8eDaga4R
	LunTzspmQi5t6eUBByvfAIhIoHuQ=
X-Google-Smtp-Source: AGHT+IFnRZLY1jn1uwzLZcCd+kdfCxCUJnCQb6JbZOgPu4Iq1rLlRaXSIxiKJTwRms6+6Z4kndq6RswVHLrw6BUwsIA=
X-Received: by 2002:a05:6402:11cb:b0:58e:4088:ed2 with SMTP id
 4fb4d7f45d1cf-594baf8d6e7mr11132273a12.16.1720893183431; Sat, 13 Jul 2024
 10:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Lewis <elatllat@gmail.com>
Date: Sat, 13 Jul 2024 13:52:52 -0400
Message-ID: <CA+3zgmvct7BWib9A7O1ykUf=0nZpdbdpXBdPWOCqfPuyCT3fug@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The patch
    usb: xhci: prevent potential failure in handle_tx_event() for
Transfer events without TRB
    https://patches.linaro.org/project/linux-usb/patch/20240429140245.3955523-11-mathias.nyman@linux.intel.com/
causes The Linux kernel
    6.1.98
    https://lkml.org/lkml/2024/7/9/645
to crash when plugging in a USB Seagate drive.
    https://www.seagate.com/ca/en/products/gaming-drives/pc-gaming/firecuda-gaming-hub/
This is a regression.

Behavior of 6.1.98:
==============================================================================
scsi host1: uas_eh_device_reset_handler start
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:     0-...!: (1 GPs behind) idle=686c/0/0x1 softirq=1841/1841 fqs=610
(detected by 4, t=5253 jiffies, g=2269, q=225 ncpus=6)
Task dump for CPU 0:
task:swapper/0       state:R  running task     stack:0     pid:0
ppid:0      flags:0x0000000
8
Call trace:
__switch_to+0xe4/0x160
0xd7f8f808
rcu: rcu_preempt kthread timer wakeup didn't happen for 4037 jiffies!
g2269 f0x0 RCU_GP_WAIT_FQS
(5) ->state=0x402
rcu:     Possible timer handling issue on cpu=5 timer-softirq=1141
rcu: rcu_preempt kthread starved for 4043 jiffies! g2269 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x402 -
>cpu=5
rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is
now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:0     pid:14    ppid:2      flags:0x00000008
Call trace:
__switch_to+0xe4/0x160
__schedule+0x28c/0x710
schedule+0x5c/0xd0
schedule_timeout+0x8c/0x100
rcu_gp_fqs_loop+0x140/0x4a0
rcu_gp_kthread+0x13c/0x170
kthread+0x108/0x10c
ret_from_fork+0x10/0x20
rcu: Stack dump where RCU GP kthread last ran:
Task dump for CPU 5:
task:kworker/5:1     state:R  running task     stack:0     pid:89
ppid:2      flags:0x0000000
8
Workqueue: events xhci_handle_command_timeout
Call trace:
__switch_to+0xe4/0x160
0x0


Behavior of 6.1.97 (or 6.1.978 with the patch reverted):
==============================================================================
scsi host1: uas_eh_device_reset_handler start
usb 2-1.4.2.1: reset SuperSpeed USB device number 6 using xhci-hcd
scsi host1: uas_eh_device_reset_handler success
sd 1:0:0:0:31251759103 512-byte logical blocks: (16.0 TB/14.6 TiB)
sd 1:0:0:0:Write Protect is off
sd 1:0:0:0:Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0:Preferred minimum I/O size 512 bytes
sd 1:0:0:0:Optimal transfer size 33553920 bytes
sdb: sdb1
sd 1:0:0:0:Attached SCSI disk
sd 0:0:0:0:tag#6 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
sd 0:0:0:0:tag#6 CDB: opcode=0x9e, sa=0x10 9e 10 00 00 00 00 00 00 00
00 00 00 00 20 00 0
0
scsi host0: uas_eh_device_reset_handler start
usb 2-1.4.1: reset SuperSpeed USB device number 5 using xhci-hcd
scsi host0: uas_eh_device_reset_handler success
sd 0:0:0:0:31251759103 512-byte logical blocks: (16.0 TB/14.6 TiB)
sd 0:0:0:0:Write Protect is off
sd 0:0:0:0:Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0:Preferred minimum I/O size 512 bytes
sd 0:0:0:0:Optimal transfer size 33553920 bytes
sda: sda1
sd 0:0:0:0:Attached SCSI disk

