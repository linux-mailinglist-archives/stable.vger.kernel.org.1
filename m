Return-Path: <stable+bounces-106853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DF1A027C2
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B43D3A2CEB
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981761DB92A;
	Mon,  6 Jan 2025 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vfrr8YWb"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0641DA100
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736173292; cv=none; b=S45pZO7ojnoPgqn0K9vZ2sm+cxsCCnhra7Vi1GZtx+eWy158rId3zX4ldrBtjVii+GTRWya3dMUYAOhAbXSnw3vkDwWmKIxKSAUUzDEPRVJinEVQRperr+douLMEFKejLHMzhdctMyqOvXsStDlcz6QUG/3mMVZgJ16taSK+eO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736173292; c=relaxed/simple;
	bh=bpcQ5iTdn6CB5361++j1CZnyzJyU1mFT39iHUXgNkQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZsrXz5kQJyfPN6YOEF9bljLyXSIKpJhBN3GgJ9j0yqNbyEQ35A6Bk5IsC9X3vajG78nasO/3bw4lbu1yJ9e6mewNBPu/G49vOBtPz0FMwMY9Zs2FXX1tf4vsE6aL03RB0wDYplNqrzY/yPz+rorTNXaxZtsLhxiiVu8+WWq2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vfrr8YWb; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ACF9E400B0
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736173287;
	bh=qbDWqCuNcewT8f9DXqrmemzcQOt3kQMP17+0aEFRW6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=vfrr8YWbmWk1hqhFXXQrc6NT7d1c/kZSRPpxs/qQ3uAP+lD0dwgrbtDo9ttB/1hsP
	 beGUlUCUZIp4uOPFiLX/BAbOvcRexAIHvYEHVVdXW3ViZMSJPLnfCQT5PGR9oOYInQ
	 /z3rdApKMpuZq5admgEvAnr50VMrSF54zA2Y7wr4UX+hA9zANiokNqE0acfFIt62qA
	 bjDDuV2UIiz+p2Gyppy6Kj/obsnd342iHdyeLILrm+9SlIt2ffGlvwDobpWq1C+VVX
	 LQm7Tu4wBrcY4IKYS4ULbKovn4NHoBAkMxrwUl1yUzorU1m9mcgE0tWWcaotzXEK3f
	 c17rtdWlqkSCA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2163c2f32fdso325910875ad.2
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 06:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736173286; x=1736778086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbDWqCuNcewT8f9DXqrmemzcQOt3kQMP17+0aEFRW6I=;
        b=g0bqD4iN0ze0NH1lct87n/0WN/6p8Z/wgwFvNScFQzgstdc870QLKNCI7lUMaz646M
         YuYEzt41rpyvcm522QJYjCkC/CP09Zp6icC6wOb0UB6DFmJGyBGo07U/qHUyIReIbKtl
         cdjXzm7+LUuLnl4auH0bYjTLFSCpxXZ6oIGaxny8ZuNcMXREJmCrS3jBcdZeoJk2ZW9Q
         QWgqHYJEdE0Q0cS5lR25mGSFebxjJVImFTPNyzmzPYz52yCM4GaazABXEhdrMHnn4ELp
         DkY73VibNTY7b/5xp7KXVlatvTTaj6qe3IDGWFufylwmnBLixcUlaQd0zsbDK8J2MvXQ
         KC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMPw+F2dpcZ4KrdPR/+wN1z6JrGj2oFCDdn5c+YJZJ87vOGGDVkMSDVIjM2vY3jdc7ny52w2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxidi45JPqNMpQWbP/Qeo/U2PcH3cdgEmH3YIRV2TeHiJ7qVAq8
	AngciyopCwXyWVKN6SkbA74R+/nn2jE4aG2QtsXUYuuHNzrOgUxYdRT2sk36vqQbRwse4L3AuVy
	/OiArNpJnz/+gJbpjAN7DnxaipR/KrU8wRFKyGMzJ7/4drcUjTCY8ccXJ4lp+l8ODT++FWg==
X-Gm-Gg: ASbGnctDQt4UpxhfCA9tYfYz9f0Np0lWdUEuq/GBMRUxirAjSxdAxsRzVbsvFU9Te2h
	LTsNFLh25u06OKwMikArvy3e54i5xfP0C/VnPGUBeGmxU4yZN9YUtYYl4xo2GUpoQ4laBHNvzhS
	6J81gH36p9Uo+JJ+H/zcij79D4CHnt5VXb8KC737z1UNgdwQM1vWRwjgUAWNc//0ZKJYTzzJV/9
	d489TnMPeMqlBv/QL3xGlfVm2zrB2TJLC2RmsJYZe89+Ctom0bJkMzt
X-Received: by 2002:a05:6a21:e92:b0:1e1:a885:3e21 with SMTP id adf61e73a8af0-1e5e044ed2cmr93245967637.7.1736173286004;
        Mon, 06 Jan 2025 06:21:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMz0viZgHKzG8gwnx4F3jtIuw4qMDBR5tML/mVasoPhC1+TTPfikgUn8Q/WjYFWIaXDpXEkw==
X-Received: by 2002:a05:6a21:e92:b0:1e1:a885:3e21 with SMTP id adf61e73a8af0-1e5e044ed2cmr93245937637.7.1736173285663;
        Mon, 06 Jan 2025 06:21:25 -0800 (PST)
Received: from localhost ([240f:74:7be:1:de1c:d045:9b:980c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8344desm31371636b3a.54.2025.01.06.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:21:25 -0800 (PST)
Date: Mon, 6 Jan 2025 23:21:23 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: Linux 6.13-rc6
Message-ID: <g4sefofdrwu72ijhse7k57wuvrwhvn2eoqmc4jdoepkcgs7h5n@hmuhkwnye6pe>
References: <CAHk-=wgjfaLyhU2L84XbkY+Jj47hryY_f1SBxmnnZi4QOJKGaw@mail.gmail.com>
 <20250106131817.GAZ3vYGVr3-hWFFPLj@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106131817.GAZ3vYGVr3-hWFFPLj@fat_crate.local>

On Mon, Jan 06, 2025 at 02:18:17PM +0100, Borislav Petkov wrote:
> On Sun, Jan 05, 2025 at 02:20:54PM -0800, Linus Torvalds wrote:
> > So we had a slight pickup in commits this last week, but as expected
> > and hoped for, things were still pretty quiet. About twice as many
> > commits as the holiday week, but that's still not all that many.
> > 
> > I expect things will start becoming more normal now that people are
> > back from the holidays and are starting to recover and wake up from
> > their food comas.
> > 
> > In the meantime, below is the shortlog for the last week. Nothing
> > particularly stands out, the changes are dominated by various driver
> > updates (gpu, rdma and networking), with a random smattering of fixes
> > elsewhere.
> 
> Something not well baked managed to sneak in and it is tagged for stable:
> 
> adcfb264c3ed ("vmstat: disable vmstat_work on vmstat_cpu_down_prep()")
> 
> Reverting it fixes the warn splat below.
> 
> [    0.310373] smpboot: x86: Booting SMP configuration:
> [    0.311074] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
> [    0.313798] ------------[ cut here ]------------
> [    0.317530] workqueue: work disable count underflowed
> [    0.317530] WARNING: CPU: 1 PID: 21 at kernel/workqueue.c:4317 enable_work+0xa4/0xb0
> [    0.317530] Modules linked in:
> [    0.317530] CPU: 1 UID: 0 PID: 21 Comm: cpuhp/1 Not tainted 6.13.0-rc6 #11
> [    0.317530] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2023.11-8 02/21/2024
> [    0.317530] RIP: 0010:enable_work+0xa4/0xb0
> [    0.317530] Code: c0 48 83 c4 18 5b 5d e9 ca 25 9f 00 80 3d 0a c7 48 08 00 75 b3 c6 05 01 c7 48 08 01 90 48 c7 c7 c8 eb 1d 82 e8 5d 77 fd ff 90 <0f> 0b 90 90 eb 98 90 0f 0b 90 eb b1 90 90 90 90 90 90 90 90 90 90
> [    0.317530] RSP: 0018:ffffc90000137e18 EFLAGS: 00010082
> [    0.317530] RAX: 0000000000000029 RBX: ffff88807d66dda0 RCX: 00000000ffefffff
> [    0.317530] RDX: 0000000000000001 RSI: ffffc90000137ce0 RDI: 0000000000000001
> [    0.317530] RBP: 0000000000000000 R08: 00000000ffefffff R09: 0000000000000058
> [    0.317530] R10: 0000000000000000 R11: ffffffff8244df00 R12: 0000000000000000
> [    0.317530] R13: ffff88807d6604e0 R14: ffffffff812439f0 R15: ffff88807d660508
> [    0.317530] FS:  0000000000000000(0000) GS:ffff88807d640000(0000) knlGS:0000000000000000
> [    0.317530] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.317530] CR2: 0000000000000000 CR3: 0000000002c1a000 CR4: 00000000003506f0
> [    0.317530] Call Trace:
> [    0.317530]  <TASK>
> [    0.317530]  ? __warn+0xa0/0x160
> [    0.317530]  ? enable_work+0xa4/0xb0
> [    0.317530]  ? report_bug+0x18c/0x1c0
> [    0.317530]  ? handle_bug+0x54/0x90
> [    0.317530]  ? exc_invalid_op+0x1b/0x80
> [    0.317530]  ? asm_exc_invalid_op+0x1a/0x20
> [    0.317530]  ? __pfx_vmstat_cpu_online+0x10/0x10
> [    0.317530]  ? enable_work+0xa4/0xb0
> [    0.317530]  ? enable_work+0xa3/0xb0
> [    0.317530]  vmstat_cpu_online+0x61/0x80
> [    0.317530]  cpuhp_invoke_callback+0x10f/0x480
> [    0.317530]  ? srso_return_thunk+0x5/0x5f
> [    0.317530]  cpuhp_thread_fun+0xd4/0x160
> [    0.317530]  smpboot_thread_fn+0xdd/0x1f0
> [    0.317530]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [    0.317530]  kthread+0xca/0xf0
> [    0.317530]  ? __pfx_kthread+0x10/0x10
> [    0.317530]  ret_from_fork+0x50/0x60
> [    0.317530]  ? __pfx_kthread+0x10/0x10
> [    0.317530]  ret_from_fork_asm+0x1a/0x30
> [    0.317530]  </TASK>
> [    0.317530] ---[ end trace 0000000000000000 ]---
> [    0.377680] smp: Brought up 1 node, 16 CPUs
> [    0.378345] smpboot: Total of 16 processors activated (118393.24 BogoMIPS)

Thanks for letting me know, and apologies for the inconvenience caused.
In the thread [1], I'm working on a follow-up fix with help from Lorenzo
and others. Please feel free to take any necessary action (e.g. revert).
Also, thank you, Greg, for [2].

[1]: https://lore.kernel.org/all/20241221033321.4154409-1-koichiro.den@canonical.com/T/#m11d983715699d3cea295b8618aba7b6ccec4db55
[2]: https://lore.kernel.org/stable/2025010603-tabasco-laziness-db0e@gregkh/

-Koichiro Den

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

