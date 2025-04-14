Return-Path: <stable+bounces-132667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A718EA88BDF
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 21:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D400B189AB25
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D428A1D2;
	Mon, 14 Apr 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNFN5N3S"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F34C74
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657339; cv=none; b=mDOPn4T+7xQ7NwFn3Ugxyk7Ytdz8J6Ixufe8LVr/RgIK8pWyXz+zoITcttSKIPdvP4kRspB4P38SEJ7Sv1IxG+XuuKG90DTfAPmtsULjPVdEz/26Yvi5E8nLLRixkSH6v8DSnJSFINH8hi48Kvxu4buWmoVXkGTOonTw3vHSJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657339; c=relaxed/simple;
	bh=lmVL5iXx8UtM9yGScibg2MyfyJuub7bM6yPpWGeTZS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6PBkcOifVmHi9eHSm7tFZLJMoSXDNumqbCRLmeOvEgVn1IAGY64BX4xsoWbjd4nNeb5WqhrxvCbkAAfnH4qfGa8CMUi4dXGRwBjBmHrGbqxJPXCSiclbSgbb4SPCmCYvWgLLNDdadWQzPbwTRTu0bJSDODa/RhZXdcBYpjhlos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNFN5N3S; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so6867363a12.2
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744657336; x=1745262136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LY3Z65IQjRhzzZTzIq8s4BIA0G+Zu9nAcODU8uzb1U=;
        b=kNFN5N3SZkg8PsECo0Fc8CEF6Q/BLVipmTegAKlBfOPiXQTFP5ICdI6skkwCJWiTXg
         BNnlOn7b+J2zNn914pxA5klsYWLB3Xb4XtADHjKrCVEnPgzizWYhtpY7r1ee1JLAO4eY
         Fbe81E5YbqX0ig6SvfhLk1HCzu7TvvKl5k9LfRQz0NkVeRHkVTCsRfsEbLMC6HnLIo5v
         niugiUWcIFcOaAlLrieXas51HO7nlqxAxxnIWl9YgwH17tryde039Rz0WVGAPEU3Nmtf
         FqCOJZi8qVkpEtz4IOuf2ZByvNPlKMm3uS0rDeseaWrYf0NByXKvTK8rsihIKQzn3Azk
         HfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744657336; x=1745262136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LY3Z65IQjRhzzZTzIq8s4BIA0G+Zu9nAcODU8uzb1U=;
        b=aTZde3rOsjlXX9tcyQ1YCyVKfRyZNhDqqN4lIJMr5hIYPqS0ZxYLaNTaMt4LnYM7lu
         ZJx5gwkYHqBDV6Z5l5DKV6Yn7Xomj3NnmElKBE6Ry8b2U20l93kQyM3JSC1iPX1wLfiE
         CU9O+8TipCjwBxT6/Iln7bcKqicUzOCpe9PiJtMEcFhHFlRrFvXuycd9unmZo1upmUrj
         4YTtTv18IDxjDo+qvloKhKUj/sg0nYxT2hp7DCC307QFHgmLAxxJeykr3498MndYv3dN
         jcrzsWg+AWnqHdFpdn/SxX06g/jyVyRDbNcerLYRYF5hjs/56bMBnf1VpG2vqiP4Pyuf
         h3bA==
X-Forwarded-Encrypted: i=1; AJvYcCW9kpkqPeeL0FXptGpPMY/1xxmoEGYFskc1Wjrj2J/cXx39ZraLAgHU/gJlhXBkHtY72TTro4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpEqimyOXyL/DIZMrg56J85kVbZizLx/pt3meDMSY8xQ9N2Bk
	SqEi2Co9pPxHnyajp51KqFKUS3lYi67PHkI5P2EUahkXvFXlPD/a
X-Gm-Gg: ASbGncucdFc8q6SBOJdVUrSv5UDFq4AvCmQd0MuEi+LpBCWVKiD9b8Ha+QQlCyIA3Bk
	NG0dQC0RrmBkCnnf3/HIx9DrBOtLjlqbsuD5eZ3a/qL1Sp9PucTh1rMvm+qF2kR8GxNBRm65/r6
	LxfAJGSpqV4TXt2sbp2qkvCqDu26+zFFbavKzqs82Un3M00ZVvVLvK20CwLHEFnFf7//6lPhOgn
	X7PdfXH9hAeXGT/mkOlecf2xDo6GkabQ29rtHT37JQ5QDSEPMq9CzePMZoHy0m/FPGadPmnR1VB
	b2JuxY7bX7RqvnCTWM213npCpjSdEO8Vq4BcrNcHWTBk3M3DZ14fiMQjmy7ITL2uZRSQCNFkD4I
	jaEqXDfom
X-Google-Smtp-Source: AGHT+IFWkE1Glhu6cGY2ezqU0g1m+eeErpXkykD7wcWilXB3BpQqNt8TFncACH+ooaDNRap/v9EI9A==
X-Received: by 2002:a17:907:7f14:b0:ac7:edfb:5210 with SMTP id a640c23a62f3a-acad3496114mr1183905866b.20.1744657335667;
        Mon, 14 Apr 2025 12:02:15 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce7fdcsm969991366b.176.2025.04.14.12.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 12:02:15 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 2D6C5BE2DE0; Mon, 14 Apr 2025 21:02:14 +0200 (CEST)
Date: Mon, 14 Apr 2025 21:02:14 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Jan Beulich <jbeulich@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 051/198] Xen/swiotlb: mark xen_swiotlb_fixup() __init
Message-ID: <Z_1btrSDlzd-ac20@eldamar.lan>
References: <20250325122156.633329074@linuxfoundation.org>
 <20250325122157.975417185@linuxfoundation.org>
 <20250407181218.GA737271@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407181218.GA737271@ax162>

Hi,

On Mon, Apr 07, 2025 at 11:12:18AM -0700, Nathan Chancellor wrote:
> Hi Greg,
> 
> On Tue, Mar 25, 2025 at 08:20:13AM -0400, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Jan Beulich <jbeulich@suse.com>
> > 
> > [ Upstream commit 75ad02318af2e4ae669e26a79f001bd5e1f97472 ]
> > 
> > It's sole user (pci_xen_swiotlb_init()) is __init, too.
> 
> This is not true in 6.1 though... which results in:
> 
>   WARNING: modpost: vmlinux.o: section mismatch in reference: pci_xen_swiotlb_init_late (section: .text) -> xen_swiotlb_fixup (section: .init.text)
> 
> Perhaps commit f9a38ea5172a ("x86: always initialize xen-swiotlb when
> xen-pcifront is enabling") and its dependency 358cd9afd069 ("xen/pci:
> add flag for PCI passthrough being possible") should be added (I did not
> test if they applied cleanly though) but it seems like a revert would be
> more appropriate. I don't see this change as a dependency of another one
> and the reason it exists upstream does not apply in this tree so why
> should it be here?

Might be following bugreport we got in Debian be related?
https://bugs.debian.org/1103153

The kernel log contains:

[    1.370662] pcifront pci-0: Installing PCI frontend
[    1.370674] software IO TLB: area num 4.
[    1.370853] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[    1.370861] BUG: unable to handle page fault for address: ffffffff830c7c05
[    1.370865] #PF: supervisor instruction fetch in kernel mode
[    1.370869] #PF: error_code(0x0011) - permissions violation
[    1.370873] PGD 2a15067 P4D 2a15067 PUD 2a16067 PMD 4a1e067 PTE 80100000030c7067
[    1.370879] Oops: 0011 [#1] PREEMPT SMP NOPTI
[    1.370884] CPU: 3 PID: 42 Comm: xenwatch Not tainted 6.1.0-33-amd64 #1  Debian 6.1.133-1
[    1.370889] RIP: e030:xen_swiotlb_fixup+0x0/0xb7
[    1.370895] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <cc> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[    1.370904] RSP: e02b:ffffc90040177dd8 EFLAGS: 00010286
[    1.370907] RAX: ffffffff830c7c05 RBX: ffff88810a800000 RCX: 0000000000000001
[    1.370912] RDX: 000000000000000a RSI: 0000000000000800 RDI: ffff88810a800000
[    1.370916] RBP: 0000000000000800 R08: 000000000000002a R09: 0000000000000000
[    1.370920] R10: 000000000000000a R11: 0000000000000000 R12: 0000000000000001
[    1.370923] R13: 0000000000002cc0 R14: 0000000000000002 R15: 000000000000000a
[    1.370931] FS:  0000000000000000(0000) GS:ffff888277780000(0000) knlGS:0000000000000000
[    1.370936] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.370940] CR2: ffffffff830c7c05 CR3: 0000000101e88000 CR4: 0000000000050660
[    1.370946] Call Trace:
[    1.370950]  <TASK>
[    1.370952]  ? __die_body.cold+0x1a/0x1f
[    1.370958]  ? platform_driver_init+0x1a/0x1a
[    1.370963]  ? page_fault_oops+0xd2/0x2b0
[    1.370967]  ? search_module_extables+0x15/0x60
[    1.370973]  ? platform_driver_init+0x1a/0x1a
[    1.370976]  ? exc_page_fault+0xca/0x170
[    1.370982]  ? asm_exc_page_fault+0x22/0x30
[    1.370986]  ? platform_driver_init+0x1a/0x1a
[    1.370989]  ? platform_driver_init+0x1a/0x1a
[    1.370993]  ? __get_free_pages+0xd/0x40
[    1.370997]  swiotlb_init_late+0xd5/0x2b0
[    1.371001]  ? platform_driver_init+0x1a/0x1a
[    1.371004]  ? xenbus_dev_request_and_reply+0x80/0x80
[    1.371009]  pci_xen_swiotlb_init_late+0x4c/0x60
[    1.371015]  pcifront_connect_and_init_dma.cold+0x42/0x66 [xen_pcifront]
[    1.371021]  pcifront_backend_changed+0x274/0x397 [xen_pcifront]
[    1.371028]  ? xenbus_dev_request_and_reply+0x80/0x80
[    1.371031]  ? xenbus_read_driver_state+0x41/0x70
[    1.371035]  ? xenbus_otherend_changed+0x5b/0x110
[    1.371039]  xenwatch_thread+0x8f/0x1b0
[    1.371042]  ? cpuusage_read+0x10/0x10
[    1.371046]  kthread+0xd7/0x100
[    1.371051]  ? kthread_complete_and_exit+0x20/0x20
[    1.371055]  ret_from_fork+0x1f/0x30
[    1.371060]  </TASK>
[    1.371062] Modules linked in: crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel xen_pcifront(+)
[    1.371070] CR2: ffffffff830c7c05
[    1.371072] ---[ end trace 0000000000000000 ]---
[    1.371076] RIP: e030:xen_swiotlb_fixup+0x0/0xb7
[    1.371080] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <cc> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[    1.371088] RSP: e02b:ffffc90040177dd8 EFLAGS: 00010286
[    1.371092] RAX: ffffffff830c7c05 RBX: ffff88810a800000 RCX: 0000000000000001
[    1.371096] RDX: 000000000000000a RSI: 0000000000000800 RDI: ffff88810a800000
[    1.371100] RBP: 0000000000000800 R08: 000000000000002a R09: 0000000000000000
[    1.371104] R10: 000000000000000a R11: 0000000000000000 R12: 0000000000000001
[    1.371107] R13: 0000000000002cc0 R14: 0000000000000002 R15: 000000000000000a
[    1.371114] FS:  0000000000000000(0000) GS:ffff888277780000(0000) knlGS:0000000000000000
[    1.371118] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.371122] CR2: ffffffff830c7c05 CR3: 0000000101e88000 CR4: 0000000000050660
[    1.371127] note: xenwatch[42] exited with irqs disabled
[    1.377029] xen_netfront: Initialising Xen virtual ethernet driver
[    6.464888] xenbus_probe_frontend: Waiting for devices to initialise: 25s...
[    6.472956] xenbus_probe_frontend: Waiting for devices to initialise:
[    6.472992] xenbus_probe_frontend: Waiting for devices to initialise:

And we have other reports of (KVM) VMs with pci-passthrough devices
not booting up.

Regards,
Salvatore

