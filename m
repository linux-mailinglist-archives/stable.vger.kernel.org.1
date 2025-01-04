Return-Path: <stable+bounces-106750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A5A01622
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 18:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8AA1635DD
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 17:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BF213777E;
	Sat,  4 Jan 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ1P9ek5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081E145A17;
	Sat,  4 Jan 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736012594; cv=none; b=H3TqeonluIA1z11KF427k3WN8p0QcR0HL+vw1zuoDXTqZX3rXlt9Jhw2UTyhyueN9jGkKZiqN1w2ZLr9dPpLnz7LcbJJtb/8WihBLOd6qcD4pUZaKXoa4J+wuIipGlFQuyGc/Qez18dbQ3An2pID4TdcmLdIMJFOB/jy6htyngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736012594; c=relaxed/simple;
	bh=M5qC+yzPsHXGOJmWwMV/pgP7Tg3RNM1jdjWBMQZrbmo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uv9Yvuw5oD2sKHxVn+YyxrfXTjsblsJ05Dgv4Zg7UWNqwH8kvUcPlGVveP6xqn8efIFndI61gQ5IVROZN+UShNQxz1JRSGdoWwTFPO+clkKyvqXR72epnrh1pRjYRXsvcSYUvjP/97uDJtrk+95TEJcoHTnDfZmETko+XwJquXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ1P9ek5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436a03197b2so42137145e9.2;
        Sat, 04 Jan 2025 09:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736012591; x=1736617391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DDSJyQ6F94m2ttAwkSGm2/AFzKvt4sFEJ2cRvllZEqw=;
        b=VQ1P9ek5CszZ8tBDIiiapY0FkXOpxaJt4znnmHLJnVAU7nMv+XsG/Lnth/alSXeJYX
         IZxCNtpfFhZJEyalVegIFqSgyVgiq/SC0Z27JKd0MeBty4svbW7/qEqvOTKaa5mexLFe
         YOe8g9paemRfcxJZJmLgwCnu2KvdtM0luKHqbIbgzzoFQdCeGfppr//vuVl/39Zpei23
         KcDo9UA5qO0jASU0g8FM2SeqNy2DOAxPxgsWAuNxMfjfkZhDlVnyhLvO4abo54dtxD05
         55DGq1Z5yQ7hTdaN6bSFMN8k1NO0T6AexrWFrKXROTd+gz1Z7xFDhFOBfy+EtfUImWsl
         hE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736012591; x=1736617391;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDSJyQ6F94m2ttAwkSGm2/AFzKvt4sFEJ2cRvllZEqw=;
        b=P6onRDukKhUzcZEaoHL4aqiKBCc3iKS6KB6RXdh/bQ/5d+yf/+ksfrS4HfjxPHI2gy
         ienkmALy8uqWqVC55PL8798iOPGXPxL7vzJkEzKLOp8JKyBm5yvuVVFzCz9IFodt9JRR
         ROvXK3m8UHURfylbk2uLXAlMMHiAYT6vs7Y53OcXNWpNTK0ZMQCcVwoDlURPdK8iQ5HD
         crmvhmc1Fam1BbuhIDtMaSM5MxUv+XMp/pHniuLss+Ij5kp7yiSOOwa9mnaWP1TJGZez
         T5OObG4K0q602kHXeS69Uo5vfWJErNB1y6yjycn6wsflGaBYUlDmElpCYbYT/T+FlF1T
         0iWA==
X-Forwarded-Encrypted: i=1; AJvYcCUHyxXMkq7sLfTWlBU55cHyl/tHn9tO4HojWJdR0Na9XGULJGwrK+BCcrBqIjR4CfhAUzC01exm@vger.kernel.org, AJvYcCVvAfNRXizYlpYBJwOb9SlKTOrkh9RcGxaEEmy5yM9vQrISpP7lApqw3ZbVsSp04ODYBV5PQVtaqZN+Jpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7C6k7WMjhv4rQj5O8UxdfGRVflDig8OvjLoglqQPtzGz31Qq
	EEJ6P5q/HFJsnS3rA2itr8xHUw9BeDIkJWRM28p7q+xZugCxT+hZ
X-Gm-Gg: ASbGncs6IxDxT6ZxoNTKfm11e2UNO/7MJiBs+P20sEL9khYCL+e3UOk20faPoPtnkOw
	gO+ykjtinQpP8fnw5SjUN+VJm1BL+5Ne2OmL9Althn96rfGCNPjz8OgkS8oitRuSbbLubM5KcyY
	W+SkN5S8pBmGlPgX3pKsHyYwBiwaVqqEJy0yL7EFXkuh71rPLMcA8tg0aw3/ZSsTSoL0d4kGlBz
	KM8DhRKrbYsN76aEcA7qr6ALILb849i76iu2//xnyghySZHpFCRy+Ag22vZqauX5XA26lQ=
X-Google-Smtp-Source: AGHT+IGaJoY/1fD09aZAag7bMuFPGbWyB/PQrJdO5193y0TrZSLsLCJWbRDxRbkxPOvztGjnB9sQyA==
X-Received: by 2002:adf:9591:0:b0:38a:624b:e619 with SMTP id ffacd0b85a97d-38a624be73fmr8331311f8f.43.1736012591136;
        Sat, 04 Jan 2025 09:43:11 -0800 (PST)
Received: from [192.168.1.177] ([45.143.100.199])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43656b119ccsm550816245e9.24.2025.01.04.09.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 09:43:10 -0800 (PST)
From: Andrea Amorosi <andrea.amorosi76@gmail.com>
X-Google-Original-From: Andrea Amorosi <Andrea.Amorosi76@gmail.com>
Message-ID: <73129e45-cf51-4e8d-95e8-49bc39ebc246@gmail.com>
Date: Sat, 4 Jan 2025 18:43:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION][BISECTED] Re: 6.12.7 stable new error: event xe_bo_move
 has unsafe dereference of argument 4
To: lists@sapience.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lucas.demarchi@intel.com,
 regressions@lists.linux.dev, rostedt@goodmis.org, stable@vger.kernel.org,
 thomas.hellstrom@linux.intel.com
References: <9dee19b6185d325d0e6fa5f7cbba81d007d99166.camel@sapience.com>
Content-Language: it-IT
In-Reply-To: <9dee19b6185d325d0e6fa5f7cbba81d007d99166.camel@sapience.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi to all,

I've just updated my archlinux to |6.12.8-arch1-1 and I still get the 
same issue:|

|gen 04 18:01:34 D9330 kernel: ------------[ cut here ]------------
gen 04 18:01:34 D9330 kernel: WARNING: CPU: 2 PID: 209 at 
kernel/trace/trace_events.c:577 trace_event_raw_init+0x159/0x660
gen 04 18:01:34 D9330 kernel: Modules linked in: xe(+) drm_ttm_helper 
gpu_sched drm_suballoc_helper drm_gpuvm drm_exec uas usb_storage i915 
i2c_algo_bit drm_buddy ttm serio_raw atkbd intel>
gen 04 18:01:34 D9330 kernel: CPU: 2 UID: 0 PID: 209 Comm: (udev-worker) 
Not tainted 6.12.8-arch1-1 #1 099de49ddaebb26408f097c48b36e50b2c8e21c9
gen 04 18:01:34 D9330 kernel: Hardware name: Dell Inc. Latitude 
9330/0RN079, BIOS 1.25.0 11/12/2024
gen 04 18:01:34 D9330 kernel: RIP: 0010:trace_event_raw_init+0x159/0x660
gen 04 18:01:34 D9330 kernel: Code: 89 ea 0f 83 3b 04 00 00 e8 44 db ff 
ff 84 c0 74 10 8b 0c 24 48 c7 c0 fe ff ff ff 48 d3 c0 49 21 c6 4d 85 f6 
0f 84 d6 fe ff ff <0f> 0b bb 01 00 00 00 41 >
gen 04 18:01:34 D9330 kernel: RSP: 0018:ffffa9b940987730 EFLAGS: 00010206
gen 04 18:01:34 D9330 kernel: RAX: ffffffffffffffdf RBX: 
ffffffffc0ca4731 RCX: 0000000000000005
gen 04 18:01:34 D9330 kernel: RDX: 0000000000000002 RSI: 
0000000000000001 RDI: ffffffffc0ca4727
gen 04 18:01:34 D9330 kernel: RBP: ffffffffc0ca4640 R08: 
0000000000000039 R09: 0000000000000000
gen 04 18:01:34 D9330 kernel: R10: 0000000000000076 R11: 
000000000000004e R12: 00000000000000f2
gen 04 18:01:34 D9330 kernel: R13: ffffffffc0ca5760 R14: 
0000000000000018 R15: 0000000000000000
gen 04 18:01:34 D9330 kernel: FS:  00007ba0e9fe9880(0000) 
GS:ffff9d957f500000(0000) knlGS:0000000000000000
gen 04 18:01:34 D9330 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
gen 04 18:01:34 D9330 kernel: CR2: 00007ba0e9dac000 CR3: 
00000001019ac000 CR4: 0000000000f50ef0
gen 04 18:01:34 D9330 kernel: PKRU: 55555554
gen 04 18:01:34 D9330 kernel: Call Trace:
gen 04 18:01:34 D9330 kernel:  <TASK>
gen 04 18:01:34 D9330 kernel:  ? trace_event_raw_init+0x159/0x660
gen 04 18:01:34 D9330 kernel:  ? __warn.cold+0x93/0xf6
gen 04 18:01:34 D9330 kernel:  ? trace_event_raw_init+0x159/0x660
gen 04 18:01:34 D9330 kernel:  ? report_bug+0xff/0x140
gen 04 18:01:34 D9330 kernel:  ? handle_bug+0x58/0x90
gen 04 18:01:34 D9330 kernel:  ? exc_invalid_op+0x17/0x70
gen 04 18:01:34 D9330 kernel:  ? asm_exc_invalid_op+0x1a/0x20
gen 04 18:01:34 D9330 kernel:  ? trace_event_raw_init+0x159/0x660
gen 04 18:01:34 D9330 kernel:  event_init+0x28/0x70
gen 04 18:01:34 D9330 kernel:  trace_module_notify+0x1a4/0x260
gen 04 18:01:34 D9330 kernel:  notifier_call_chain+0x5a/0xd0
gen 04 18:01:34 D9330 kernel: blocking_notifier_call_chain_robust+0x65/0xc0
gen 04 18:01:34 D9330 kernel:  load_module+0x1822/0x1cf0
gen 04 18:01:34 D9330 kernel:  ? vmap+0x83/0xe0
gen 04 18:01:34 D9330 kernel:  ? __vunmap_range_noflush+0x325/0x470
gen 04 18:01:34 D9330 kernel:  ? init_module_from_file+0x89/0xe0
gen 04 18:01:34 D9330 kernel:  init_module_from_file+0x89/0xe0
gen 04 18:01:34 D9330 kernel: idempotent_init_module+0x11e/0x310
gen 04 18:01:34 D9330 kernel:  __x64_sys_finit_module+0x5e/0xb0
gen 04 18:01:34 D9330 kernel:  do_syscall_64+0x82/0x190
gen 04 18:01:34 D9330 kernel:  ? vfs_read+0x299/0x370
gen 04 18:01:34 D9330 kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
gen 04 18:01:34 D9330 kernel:  ? do_syscall_64+0x8e/0x190
gen 04 18:01:34 D9330 kernel:  ? terminate_walk+0xee/0x100
gen 04 18:01:34 D9330 kernel:  ? path_openat+0x495/0x12e0
gen 04 18:01:34 D9330 kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
gen 04 18:01:34 D9330 kernel:  ? do_syscall_64+0x8e/0x190
gen 04 18:01:34 D9330 kernel:  ? do_filp_open+0xc4/0x170
gen 04 18:01:34 D9330 kernel:  ? __pfx_page_put_link+0x10/0x10
gen 04 18:01:34 D9330 kernel:  ? do_sys_openat2+0x9c/0xe0
gen 04 18:01:34 D9330 kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
gen 04 18:01:34 D9330 kernel:  ? do_syscall_64+0x8e/0x190
gen 04 18:01:34 D9330 kernel:  ? do_syscall_64+0x8e/0x190
gen 04 18:01:34 D9330 kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
gen 04 18:01:34 D9330 kernel: RIP: 0033:0x7ba0ea7e01fd
gen 04 18:01:34 D9330 kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 
90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 
8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 >
gen 04 18:01:34 D9330 kernel: RSP: 002b:00007ffe5dee8d58 EFLAGS: 
00000246 ORIG_RAX: 0000000000000139
gen 04 18:01:34 D9330 kernel: RAX: ffffffffffffffda RBX: 
00005f717b3029c0 RCX: 00007ba0ea7e01fd
gen 04 18:01:34 D9330 kernel: RDX: 0000000000000004 RSI: 
00007ba0e9fe305d RDI: 0000000000000031
gen 04 18:01:34 D9330 kernel: RBP: 00007ffe5dee8e10 R08: 
0000000000000001 R09: 00007ffe5dee8da0
gen 04 18:01:34 D9330 kernel: R10: 0000000000000040 R11: 
0000000000000246 R12: 00007ba0e9fe305d
gen 04 18:01:34 D9330 kernel: R13: 0000000000020000 R14: 
00005f717b303600 R15: 00005f717b304360
gen 04 18:01:34 D9330 kernel:  </TASK>
gen 04 18:01:34 D9330 kernel: ---[ end trace 0000000000000000 ]---
gen 04 18:01:34 D9330 kernel: event xe_bo_move has unsafe dereference of 
argument 4
gen 04 18:01:34 D9330 kernel: print_fmt: "move_lacks_source:%s, migrate 
object %p [size %zu] from %s to %s device_id:%s", REC->move_lacks_source 
? "yes" : "no", REC->bo, REC->size, xe_mem_>|

|
|

|Later I get this other one which I do not know if it is related to the 
previous one or not:|

|gen 04 18:01:45 D9330 kernel: ------------[ cut here ]------------
gen 04 18:01:45 D9330 kernel: WARNING: CPU: 7 PID: 139 at 
drivers/usb/typec/ucsi/ucsi.c:1361 ucsi_reset_ppm+0x1b4/0x1c0 [typec_ucsi]
gen 04 18:01:45 D9330 kernel: Modules linked in: fat kvm_intel 
snd_soc_core mei_vsc snd_compress spi_pxa2xx_platform intel_ishtp_hid 
iwlmvm dell_rbtn hid_multitouch dw_dmac ac97_bus moused>
gen 04 18:01:45 D9330 kernel:  processor_thermal_rapl cfg80211 ucsi_acpi 
soundcore mei_me intel_rapl_common intel_lpss_pci i2c_mux typec_ucsi 
thunderbolt intel_lpss mei processor_thermal_w>
gen 04 18:01:45 D9330 kernel:  video cec spi_intel nvme_auth i8042 wmi serio
gen 04 18:01:45 D9330 kernel: CPU: 7 UID: 0 PID: 139 Comm: kworker/7:1 
Tainted: G        W  OE      6.12.8-arch1-1 #1 
099de49ddaebb26408f097c48b36e50b2c8e21c9
gen 04 18:01:45 D9330 kernel: Tainted: [W]=WARN, [O]=OOT_MODULE, 
[E]=UNSIGNED_MODULE
gen 04 18:01:45 D9330 kernel: Hardware name: Dell Inc. Latitude 
9330/0RN079, BIOS 1.25.0 11/12/2024
gen 04 18:01:45 D9330 kernel: Workqueue: events_long ucsi_init_work 
[typec_ucsi]
gen 04 18:01:45 D9330 kernel: RIP: 0010:ucsi_reset_ppm+0x1b4/0x1c0 
[typec_ucsi]
gen 04 18:01:45 D9330 kernel: Code: 8b 44 24 04 a9 00 00 00 08 0f 85 36 
ff ff ff 4c 89 74 24 10 48 8b 05 cb be 59 cf 49 39 c5 79 8f bb 92 ff ff 
ff e9 1b ff ff ff <0f> 0b e9 50 ff ff ff e8 >
gen 04 18:01:45 D9330 kernel: RSP: 0018:ffffa9b9407bfda8 EFLAGS: 00010206
gen 04 18:01:45 D9330 kernel: RAX: 0000000008000000 RBX: 
0000000000000000 RCX: 0000000000000002
gen 04 18:01:45 D9330 kernel: RDX: 00000000fffeaba3 RSI: 
ffffa9b9407bfdac RDI: ffff9d92089d7800
gen 04 18:01:45 D9330 kernel: RBP: ffff9d92089d7800 R08: 
0000000000000000 R09: 0000000000000014
gen 04 18:01:45 D9330 kernel: R10: 0000000000000001 R11: 
0000000000000000 R12: ffffa9b9407bfdac
gen 04 18:01:45 D9330 kernel: R13: 00000000fffeaba0 R14: 
ffff9d92089d7860 R15: ffff9d92089d78c0
gen 04 18:01:45 D9330 kernel: FS:  0000000000000000(0000) 
GS:ffff9d957f780000(0000) knlGS:0000000000000000
gen 04 18:01:45 D9330 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
gen 04 18:01:45 D9330 kernel: CR2: 0000585143bba648 CR3: 
000000023a822000 CR4: 0000000000f50ef0
gen 04 18:01:45 D9330 kernel: PKRU: 55555554
gen 04 18:01:45 D9330 kernel: Call Trace:
gen 04 18:01:45 D9330 kernel:  <TASK>
gen 04 18:01:45 D9330 kernel:  ? ucsi_reset_ppm+0x1b4/0x1c0 [typec_ucsi 
97866a6a8562a088cda45de0ae83658868b451bb]
gen 04 18:01:45 D9330 kernel:  ? __warn.cold+0x93/0xf6
gen 04 18:01:45 D9330 kernel:  ? ucsi_reset_ppm+0x1b4/0x1c0 [typec_ucsi 
97866a6a8562a088cda45de0ae83658868b451bb]
gen 04 18:01:45 D9330 kernel:  ? report_bug+0xff/0x140
gen 04 18:01:45 D9330 kernel:  ? handle_bug+0x58/0x90
gen 04 18:01:45 D9330 kernel:  ? exc_invalid_op+0x17/0x70
gen 04 18:01:45 D9330 kernel:  ? asm_exc_invalid_op+0x1a/0x20
gen 04 18:01:45 D9330 kernel:  ? ucsi_reset_ppm+0x1b4/0x1c0 [typec_ucsi 
97866a6a8562a088cda45de0ae83658868b451bb]
gen 04 18:01:45 D9330 kernel:  ? ucsi_reset_ppm+0xc6/0x1c0 [typec_ucsi 
97866a6a8562a088cda45de0ae83658868b451bb]
gen 04 18:01:45 D9330 kernel:  ucsi_init_work+0x3c/0xac0 [typec_ucsi 
97866a6a8562a088cda45de0ae83658868b451bb]
gen 04 18:01:45 D9330 kernel:  process_one_work+0x17b/0x330
gen 04 18:01:45 D9330 kernel:  worker_thread+0x2ce/0x3f0
gen 04 18:01:45 D9330 kernel:  ? __pfx_worker_thread+0x10/0x10
gen 04 18:01:45 D9330 kernel:  kthread+0xcf/0x100
gen 04 18:01:45 D9330 kernel:  ? __pfx_kthread+0x10/0x10
gen 04 18:01:45 D9330 kernel:  ret_from_fork+0x31/0x50
gen 04 18:01:45 D9330 kernel:  ? __pfx_kthread+0x10/0x10
gen 04 18:01:45 D9330 kernel:  ret_from_fork_asm+0x1a/0x30
gen 04 18:01:45 D9330 kernel:  </TASK>
gen 04 18:01:45 D9330 kernel: ---[ end trace 0000000000000000 ]---
|

|
|

|
|


