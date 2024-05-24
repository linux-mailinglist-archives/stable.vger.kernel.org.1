Return-Path: <stable+bounces-46111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6698CEBC5
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 23:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122AB1F21E54
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 21:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3C5FDD2;
	Fri, 24 May 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="1k+be9Ts"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E829403;
	Fri, 24 May 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716585848; cv=none; b=oz9vGXEn3TmQ76/tMsfOB2E6ffZR/S/vzexL7WZUmGnXGQ92wSZ7kLvb/Gv6p62hrvR6/WaoYXu7YuJn1w1YCOmfyG97kSxR/Jlbe15IBezRdgQrfFjTrtfUbW2CUEanQikotJYStOkRpDadWi/EAczbDk4J6OTDYow6yP7afc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716585848; c=relaxed/simple;
	bh=OnT0ERB5zKLH9kD5fL3L6+B4DbAD4KG7m4kxTmk6MYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u3xIgxavGUyP+tnkHv6zfSRtbhbVHsSYexS/go7N0q+ktrRKY00VgiEokW/OnVPN0bSuxg5uz1R4/7gVbS/uw2/eqoMakC+OHQ92MyMLjI436kfsXWY0XJdfoAFanhGsOwl0VWlnyu2TFDqLv+ANSHmzj8IlgqOFNiVtk8DcHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=1k+be9Ts; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1716585819; x=1717190619; i=christian@heusel.eu;
	bh=ulDWQhWqJP62rc0X/eTDyrxkZ6hC3+kkVW41WxDECoM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=1k+be9Ts4Kxsie2b1cKKXozRN8ldReVRgSeq5S1Cq2CGrt17gEqLCYWSjvsZbAYP
	 0UoIA2yBapP7AkaUuypPh6mkPD+j2XyoOE1Gt0BytHCg/Dp7Dq0tSNX+P8txGnOcG
	 quuCYjhWrTyPBbJ8yY3/rueIpHo+ivoiRjx/iXCJ/ErekqSQf6tAZPuRTfcHjljAj
	 HvIvkHiI72UBDNMLH3ytYf+nb7p9VhKqC7CVvqsWnNjbYSPDaFKb3LILYUVVxHik+
	 GjY1sB2tkbHzQQlh1jueNKGZpdnnp/BVSxEezX9Woyah0YunO5VCE6NklOBXE8/Lp
	 VAKbA3xMnKgJUCYsXQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MeTwY-1sl38R2ZT2-00aTIJ; Fri, 24
 May 2024 23:23:39 +0200
Date: Fri, 24 May 2024 23:23:38 +0200
From: Christian Heusel <christian@heusel.eu>
To: Thomas Gleixner <tglx@linutronix.de>, regressions@lists.linux.dev
Cc: Tim Teichmann <teichmanntim@outlook.de>, x86@kernel.org, 
	stable@vger.kernel.org
Subject: [REGRESSION][BISECTED] Scheduling errors with the AMD FX 8300 CPU
Message-ID: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qlcbt2qxytcfp5ud"
Content-Disposition: inline
X-Provags-ID: V03:K1:HruDHgDYWgn3W9t1GcEs6rhJFkf1uKWnJzitZ1PLQYUUhWKkLq0
 uZGaS9wmtdufeC0kvGiQOT3HpVj0xDFPCn9mwoW6ayIWlq7Kr/ojNkhNDGUSyqIpFAQMxwh
 +SqvqlkQBplUpsx5Mk21O+h92/sfS20o6xbWN52Da9lNohalqd+OB9/hD1OhtmxtrdzUexv
 EVTkr9VEehpRO7YR89R2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1S0dtfB6S6M=;1qJOQCSNvdNqO98cLhW57VoPc5p
 JelG+qikfPIN1RkJ7JnrdLxO//FTt4CA5Xk6MrWdjXIOnC87DmnTTQDKwt70gX+ZgWKQ9zGXd
 JkBwmSGZWl2pNcnJVK02HZihtH6CmkDlSPcWI6gCTJf3BjY54N1mhVzd9QUqmEb1MyC84f9ib
 Gt9OmHdqv1iKoXJFeINhqajmCvzhmq7/IWeR/egf56OxiJuNavD9+LPNtRKiew//5kfHIR2eD
 aLj35gbczrPMH6oX5N/rRVyJNNzgRM+BgRm8SxUgQJp1Znjfoz9AkZphSO+YcZIRefl2K5OMW
 dethDTGMJZ6WiB+ii5P7m6XRVbn4CCcoOAQHh1O72inSToiQNOrsm8QV92IddTylX+oOZ5lbr
 YNUYhDdAMbPnAecyqY/iDyIjtIZGu5iHyErX7+Q5JmouX/LzBh8o5duOVdMGEaAdK/FBjwnI9
 F/4KVjclm8RzTi7jSAphRVjfU2//3qIVSFEpcwv/cB6wSe8GQ5ITrKsZuU8aDJc18KmWvVf/K
 CnyzaOLRIostMZZXMf/7c1zM3haLWXM2GeT7pRToC3wqzlztoLqcO4wmIGYAT0frEWMUxfwGe
 iKhxrjYceFTlO8d8/tgQBpsmME5r/yATJmfPsf4DdSDKz6usARYv4e82U5zfJKtRaWs44Xry7
 LpP29OX8CO15+Owbud9QomZu7SLTRWizyg4qqUYC8CBnPRjUrysZl2r4Fb7+NYIofCoPVrNqG
 Wwo2UmieiDEOvgKMd0LGw8Ff3nEd46Fij96CVsGyeN5GxRijqT+8A8=


--qlcbt2qxytcfp5ud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

Tim reports a regression on his AMD FX 8300 CPU that causes him
scheduling errors (see dmesg below), initially on the latest stable
kernel from Arch Linux. The issue reproduces by simply booting the
kernel on his hardware. He also reported some ATA related errors (also
attached below the dmesg), of which I dont know whether they are
relevant or not.

We have debugged the issue together in the ticket in our bugtracker[0]
and collectively bisected it down to the following commit:

    c749ce393b8f ("x86/cpu: Use common topology code for AMD")

Tim (in CC) offered to be available for further debugging in this
thread.

Reported-by: Tim Teichmann <teichmanntim@outlook.de>
Bisected-by: Christian Heusel <christian@heusel.eu>

Cheers,
Chris


[0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issu=
es/56

---

#regzbot link: https://gitlab.archlinux.org/archlinux/packaging/packages/li=
nux/-/issues/56
#regzbot introduced: c749ce393b8f=20
#regzbot title: Scheduling errors with the AMD FX 8300 CPU

---

dmesg output:

May 23 23:36:49 archlinux kernel: smp: Bringing up secondary CPUs ...
May 23 23:36:49 archlinux kernel: smpboot: x86: Booting SMP configuration:
May 23 23:36:49 archlinux kernel: .... node  #0, CPUs:      #2 #4 #6
May 23 23:36:49 archlinux kernel: __common_interrupt: 2.55 No irq handler f=
or vector
May 23 23:36:49 archlinux kernel: __common_interrupt: 4.55 No irq handler f=
or vector
May 23 23:36:49 archlinux kernel: __common_interrupt: 6.55 No irq handler f=
or vector
May 23 23:36:49 archlinux kernel:  #1 #3 #5 #7
May 23 23:36:49 archlinux kernel: ------------[ cut here ]------------
May 23 23:36:49 archlinux kernel: WARNING: CPU: 1 PID: 0 at kernel/sched/co=
re.c:6482 sched_cpu_starting+0x183/0x250
May 23 23:36:49 archlinux kernel: Modules linked in:
May 23 23:36:49 archlinux kernel: CPU: 1 PID: 0 Comm: swapper/1 Not tainted=
 6.9.1-arch1-2 #1 06928436e5a6b4805e171d14d8efa397d7db9ad0
May 23 23:36:49 archlinux kernel: Hardware name: Gigabyte Technology Co., L=
td. GA-78LMT-USB3 R2/GA-78LMT-USB3 R2, BIOS F1 11/08/2017
May 23 23:36:49 archlinux kernel: RIP: 0010:sched_cpu_starting+0x183/0x250
May 23 23:36:49 archlinux kernel: Code: 00 8b 0d b0 e0 10 02 39 c8 0f 83 71=
 ff ff ff 48 63 d0 48 8b 3c d5 20 53 71 a6 4c 01 e7 39 c3 75 c7 4c 89 bf 48=
 0d 00 00 eb c7 <0f> 0b eb c3 be 04 00>
May 23 23:36:49 archlinux kernel: RSP: 0000:ffffa6a3c00cfe38 EFLAGS: 000100=
87
May 23 23:36:49 archlinux kernel: RAX: 0000000000000002 RBX: 00000000000000=
01 RCX: 0000000000000008
May 23 23:36:49 archlinux kernel: RDX: 0000000000000002 RSI: ffffffffffffff=
fc RDI: ffff9367aeb36540
May 23 23:36:49 archlinux kernel: RBP: ffff9367aea99b00 R08: ffff9367aea99b=
00 R09: 0000000000000003
May 23 23:36:49 archlinux kernel: R10: ffff9367aea99b00 R11: 00000000000000=
06 R12: 0000000000036540
May 23 23:36:49 archlinux kernel: R13: 0000000000036540 R14: 00000000000000=
01 R15: ffff9367aea36540
May 23 23:36:49 archlinux kernel: FS:  0000000000000000(0000) GS:ffff9367ae=
a80000(0000) knlGS:0000000000000000
May 23 23:36:49 archlinux kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
May 23 23:36:49 archlinux kernel: CR2: 0000000000000000 CR3: 000000036dc200=
00 CR4: 00000000000406f0
May 23 23:36:49 archlinux kernel: Call Trace:
May 23 23:36:49 archlinux kernel:  <TASK>
May 23 23:36:49 archlinux kernel:  ? sched_cpu_starting+0x183/0x250
May 23 23:36:49 archlinux kernel:  ? __warn.cold+0x8e/0xe8
May 23 23:36:49 archlinux kernel:  ? sched_cpu_starting+0x183/0x250
May 23 23:36:49 archlinux kernel:  ? report_bug+0xff/0x140
May 23 23:36:49 archlinux kernel:  ? handle_bug+0x3c/0x80
May 23 23:36:49 archlinux kernel:  ? exc_invalid_op+0x17/0x70
May 23 23:36:49 archlinux kernel:  ? asm_exc_invalid_op+0x1a/0x20
May 23 23:36:49 archlinux kernel:  ? sched_cpu_starting+0x183/0x250
May 23 23:36:49 archlinux kernel:  ? sched_cpu_starting+0x15a/0x250
May 23 23:36:49 archlinux kernel:  ? __pfx_sched_cpu_starting+0x10/0x10
May 23 23:36:49 archlinux kernel:  cpuhp_invoke_callback+0x122/0x410
May 23 23:36:49 archlinux kernel:  __cpuhp_invoke_callback_range+0x64/0xc0
May 23 23:36:49 archlinux kernel:  start_secondary+0x9c/0x140
May 23 23:36:49 archlinux kernel:  common_startup_64+0x13e/0x141
May 23 23:36:49 archlinux kernel:  </TASK>
May 23 23:36:49 archlinux kernel: ---[ end trace 0000000000000000 ]---
May 23 23:36:49 archlinux kernel: __common_interrupt: 1.55 No irq handler f=
or vector
May 23 23:36:49 archlinux kernel: __common_interrupt: 3.55 No irq handler f=
or vector
May 23 23:36:49 archlinux kernel: __common_interrupt: 5.55 No irq handler f=
or vector
May 23 23:36:49 archlinux kernel: __common_interrupt: 7.55 No irq handler f=
or vector
May 23 23:36:49 archlinux kernel: smp: Brought up 1 node, 8 CPUs
May 23 23:36:49 archlinux kernel: smpboot: Total of 8 processors activated =
(53173.28 BogoMIPS)
May 23 23:36:49 archlinux kernel: ------------[ cut here ]------------
May 23 23:36:49 archlinux kernel: WARNING: CPU: 0 PID: 1 at kernel/sched/to=
pology.c:2408 build_sched_domains+0x76b/0x12b0
May 23 23:36:49 archlinux kernel: Modules linked in:
May 23 23:36:49 archlinux kernel: CPU: 0 PID: 1 Comm: swapper/0 Tainted: G =
       W          6.9.1-arch1-2 #1 06928436e5a6b4805e171d14d8efa397d7db9ad0
May 23 23:36:49 archlinux kernel: Hardware name: Gigabyte Technology Co., L=
td. GA-78LMT-USB3 R2/GA-78LMT-USB3 R2, BIOS F1 11/08/2017
May 23 23:36:49 archlinux kernel: RIP: 0010:build_sched_domains+0x76b/0x12b0
May 23 23:36:49 archlinux kernel: Code: 63 4d 14 39 34 8a 0f 8e 73 fe ff ff=
 25 e9 ef ff ff 80 cc 04 41 89 46 3c e9 62 fe ff ff 41 c7 46 30 01 00 00 00=
 e9 55 fe ff ff <0f> 0b bb f4 ff ff ff>
May 23 23:36:49 archlinux kernel: RSP: 0018:ffffa6a3c001fe10 EFLAGS: 000102=
02
May 23 23:36:49 archlinux kernel: RAX: 00000000ffffff01 RBX: 00000000000000=
00 RCX: 00000000ffffff01
May 23 23:36:49 archlinux kernel: RDX: 00000000fffffff8 RSI: 00000000000000=
03 RDI: ffff9367aea19b00
May 23 23:36:49 archlinux kernel: RBP: ffff936480367a00 R08: ffff9367aea19b=
00 R09: 0000000000000000
May 23 23:36:49 archlinux kernel: R10: ffffa6a3c001fdd8 R11: 00000000000000=
00 R12: 0000000000000001
May 23 23:36:49 archlinux kernel: R13: ffff9367aea99b00 R14: 00000000000000=
01 R15: ffff936480942e80
May 23 23:36:49 archlinux kernel: FS:  0000000000000000(0000) GS:ffff9367ae=
a00000(0000) knlGS:0000000000000000
May 23 23:36:49 archlinux kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
May 23 23:36:49 archlinux kernel: CR2: ffff9366eea01000 CR3: 000000036dc200=
00 CR4: 00000000000406f0
May 23 23:36:49 archlinux kernel: Call Trace:
May 23 23:36:49 archlinux kernel:  <TASK>
May 23 23:36:49 archlinux kernel:  ? build_sched_domains+0x76b/0x12b0
May 23 23:36:49 archlinux kernel:  ? __warn.cold+0x8e/0xe8
May 23 23:36:49 archlinux kernel:  ? build_sched_domains+0x76b/0x12b0
May 23 23:36:49 archlinux kernel:  ? report_bug+0xff/0x140
May 23 23:36:49 archlinux kernel:  ? handle_bug+0x3c/0x80
May 23 23:36:49 archlinux kernel:  ? exc_invalid_op+0x17/0x70
May 23 23:36:49 archlinux kernel:  ? asm_exc_invalid_op+0x1a/0x20
May 23 23:36:49 archlinux kernel:  ? build_sched_domains+0x76b/0x12b0
May 23 23:36:49 archlinux kernel:  ? kmalloc_trace+0x13a/0x320
May 23 23:36:49 archlinux kernel:  sched_init_smp+0x3e/0xc0
May 23 23:36:49 archlinux kernel:  ? stop_machine+0x30/0x40
May 23 23:36:49 archlinux kernel:  kernel_init_freeable+0x109/0x250
May 23 23:36:49 archlinux kernel:  ? __pfx_kernel_init+0x10/0x10
May 23 23:36:49 archlinux kernel:  kernel_init+0x1a/0x140
May 23 23:36:49 archlinux kernel:  ret_from_fork+0x34/0x50
May 23 23:36:49 archlinux kernel:  ? __pfx_kernel_init+0x10/0x10
May 23 23:36:49 archlinux kernel:  ret_from_fork_asm+0x1a/0x30
May 23 23:36:49 archlinux kernel:  </TASK>
May 23 23:36:49 archlinux kernel: ---[ end trace 0000000000000000 ]---

---

ATA stuff:

May 23 23:36:59 archlinux kernel: ata2.00: exception Emask 0x10 SAct 0x1fff=
e000 SErr 0x40d0002 action 0xe frozen
May 23 23:36:59 archlinux kernel: ata2.00: irq_stat 0x00000040, connection =
status changed
May 23 23:36:59 archlinux kernel: ata2: SError: { RecovComm PHYRdyChg CommW=
ake 10B8B DevExch }
May 23 23:36:59 archlinux kernel: ata2.00: failed command: WRITE FPDMA QUEU=
ED
May 23 23:36:59 archlinux kernel: ata2.00: cmd 61/10:68:10:f8:07/00:00:00:0=
0:00/40 tag 13 ncq dma 8192 out
                                           res 40/00:01:00:00:00/00:00:00:0=
0:00/00 Emask 0x10 (ATA bus error)
May 23 23:36:59 archlinux kernel: ata2.00: status: { DRDY }
May 23 23:36:59 archlinux kernel: ata2.00: failed command: WRITE FPDMA QUEU=
ED
May 23 23:36:59 archlinux kernel: ata2.00: cmd 61/08:70:28:f8:07/00:00:00:0=
0:00/40 tag 14 ncq dma 4096 out
                                           res 40/00:00:00:00:00/00:00:00:0=
0:00/00 Emask 0x10 (ATA bus error)
May 23 23:36:59 archlinux kernel: ata2.00: status: { DRDY }
May 23 23:36:59 archlinux kernel: ata2.00: failed command: WRITE FPDMA QUEU=
ED
May 23 23:36:59 archlinux kernel: ata2.00: cmd 61/18:78:50:f8:07/00:00:00:0=
0:00/40 tag 15 ncq dma 12288 out
                                           res 40/00:68:00:00:00/00:00:00:0=
0:00/40 Emask 0x10 (ATA


--qlcbt2qxytcfp5ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZRBVoACgkQwEfU8yi1
JYXDDw//atBJcjRPn5F/GenmtNpzl7oW1af5BmVuJDjun4aAnaM2kppJ/IlFjVIx
NjH+YRgPoLIQdnPEYlMKRAgS0846mugSLv+92cJraUkw58AXxsXcjxiZbtskclWH
YoMGksBGwSfb3tIGvVvAWn5WTq7/iV19to+rUFHj+CPVin+H3QGdfaLYdBZhakcT
FqwkZEILJmypOUwgTZ0HuS0y4iAFQc5jIoHjAAJPQBb02nhgUSbzBPZfGRlzIuFo
XptnhdAudFCuWXMiPQjvlj+WFjaTm0ohRZUDt4rZnN2RT1ht1x2uFzwE9sBcUE4C
34oPQKEVRtRd7tcvNomDK45GM02Xvw0WqQlB6XZSQ2/fOV6XmJhpGSRoOnGoyNjI
Iad7jed6Zso5Gkv7KZfK6rqrZTwObC1mlfv5CtP1znPbZU1QsKvHLTLyVUCsIN5G
J3rMfDk+8650/19uBt42WvZ2vrLZH2asyJz8NSEWkcX4vhos81JLk9dG91RVMhFd
bi3G76IMw/+Z07GmHqLydRqCzqpJcVTiakrpjN69FjhuJBzjS508yH2eOW9SKIa/
3+XRCHett81APQ3b22lne94Z2VYmKXui1Mu6SAM8RSnW85845Kv3dSHuCobdDPqc
zzPWvZ/86hfta9XZdTLIHTzzNFPvyL2PfSQpI5wU5xSbw9ZhmF0=
=y/UT
-----END PGP SIGNATURE-----

--qlcbt2qxytcfp5ud--

