Return-Path: <stable+bounces-242441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKiCL4u09GlaDwIAu9opvQ
	(envelope-from <stable+bounces-242441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:11:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 919934AD1F7
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DDF53026C32
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96383C061A;
	Fri,  1 May 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+mzosBL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sCdALyzo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED93A783B
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644596; cv=pass; b=gBNDeupkQN28y/BoaEGnOgjAZU9iBHcy+EpBOgRFQ4vc058qe1LDIBPYxpFnPTfJGMdWY35VXZYgEqPVVyxxP6nljJa2NKAdhOVtxuFSvSx39XtSEl5723UpmGAaMM+4EOvzw7A5N8YG7EySZQFGU0mi750OyNcIza/mEjZH2Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644596; c=relaxed/simple;
	bh=k6OWyC1wIaaJUvYnlBgLcvRuEJP9DNWmNq5cQpabATk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUpYvY4EwIZOMCsVLHHKZudBosJUcdlM/8gzE2nxHQgPLM7h1Qw9h2PR+U/OMFO3NWTzqlnKsSs0L0CplmUPuHpW5NFEibT96sZQImTsZOfqOqVGW72gTC3huIkrCdmmgWNwn1G1mJNh/NAei2ltTVHjKkGZE4Qe0d9EHp5XG+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+mzosBL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sCdALyzo; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777644587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tau4shtWAXCSO3mLQH5ZCykf9+5bBabdW7TvrIltIlI=;
	b=F+mzosBLdzZLiGPnfegxP7J5WXGoOwM+IJwLGnOeXaO2ge7ozz8gAB8dfNTSPf2cTlzDf+
	0HeuCSEtv+0Os1Pg6gKs6Cf8lAmzTMFXDOGsyt2Jt+TMTDTnwNhewmNqmoIrUtzyo9vXOp
	RX0J6YS0DxrRIUNIl+01H44LZjX7z48=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-EJ1wdRTmNraewc8oBKin2g-1; Fri, 01 May 2026 10:09:44 -0400
X-MC-Unique: EJ1wdRTmNraewc8oBKin2g-1
X-Mimecast-MFC-AGG-ID: EJ1wdRTmNraewc8oBKin2g_1777644584
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7dbbb806e10so4209554a34.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777644584; cv=none;
        d=google.com; s=arc-20240605;
        b=MR44vgKzfvSZfoBesGXETyljFWZJ2nHVlkBO0183kg4idZtkR4AmqVtsyo9pfDif/8
         sMDaw4BW0b+dP8QTQi5De2eaByRjyH6WinKy6u7PrUd0MFnPd8aBkJ3ay6D4rRAz/+PB
         cXCT6ujuebEpAz+BZUs0Tm/yU+4bK33Vf4BFrwlh/E/yDt07ydRzqqwm3xILl1bQfxbU
         M7Qyx5ycS/LcLfOAV+7GBubzEG/Rjs+vEQFBlL29e8K8agAS6aStLRkLOUY5/SCL7NLN
         0hcEGnekWlfL3RyQ/X9nYpR34S1GQ3utI8osgCKT3ZY7hD3x8PdDdj1mg+V5gKOkQI/t
         CAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tau4shtWAXCSO3mLQH5ZCykf9+5bBabdW7TvrIltIlI=;
        fh=5TKVI5pfGR7CWTGHEEC4NfFwXU33wo+uot+EfAAdRo4=;
        b=S3hNlKeehEZlzzOwoHxBcxm8jXb1C/JEnoHvKzSrQJDi+rx1pas8VH1cXvmmiOpRg6
         5prER2t6yXTMx9AKaCBNidDt5zsp5gepnyAN+SgsAiUEIM4iEFOH0iDsfQ2e+R8zpm8L
         xFVcfG3Z09xWoejxN5scTMiXGG1E9gwhx7KkN7wclrObqYrnVIoal/XPYDeE3IR9+Y8+
         r/6JUe4vkL3G9emHbgUbAQjyr/z+4VtpNXDIFXb+dYMQrRgYpu4337GtJ8tDWGNkQq8z
         C9YuUhoT7VrkxqXr09EcjX3KQ/iBOj052dWih0G1/K/84Ys2EEBBIe1XzLOh0tvqjz6J
         o6lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777644584; x=1778249384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tau4shtWAXCSO3mLQH5ZCykf9+5bBabdW7TvrIltIlI=;
        b=sCdALyzobyVZqJofzeFD1XqJxvKq2VofB08uRXCVRipxExFpS82hzwHhd9NRdJmzEZ
         oDKKPCJGkbhsEE3RDDLvoG7bW9wuuIP4q7MecMHYc4dDorPpplYbUeh+FwPORd77csyC
         0mByM9mzPAARz2CfxNeT/P0/UGi38VvnTQq9LmuXA73boOQVpGHd/2YJw0bDQI2gzGd/
         95KjSVAyoxKrywD2zGJIoF53pKOS0PLk1M6aAHDwOMGyrYywROcszstWdNRAKy6zGoZc
         Zy0bHjvjhUh/AOudA/EWXTn60vZfxqIHQKJGpKQ8YCHbyjhZw/kdGYsWKUc39ZgpuHcp
         pobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777644584; x=1778249384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tau4shtWAXCSO3mLQH5ZCykf9+5bBabdW7TvrIltIlI=;
        b=bELz20w7qWZoDKjAMZze+m2KiGyFxJ9ffrY5ztxuVMWGO4jstZCVw3IU30x7cckCql
         4jAbJHoaFMSS062/0TQXwtApK9DTx495oQPm/J6VJQD42nOo7cDCl1Twrw4575krj9SL
         KsMTL9Z7LWsVI1iDCmeqnpqyciKmYF2ch7KxEOoMDCrXX+GmOYGsGFplJJS3ljy3yoB6
         J+2it09PZpgaT6jxLrmoZX5w+6pf15wmOyRwb8MMhApu+UWNbq+b8+y0b9QwY3l3lXIC
         eNujlNV75gYx+aqxKH8Pi9Z8jQAwEZyhQgUcu+WLQI56kOZiKeqSTQYW3K5DFPboqnug
         jRoQ==
X-Forwarded-Encrypted: i=1; AFNElJ97IMHzjw4jCtozuYwMSzpyWygbkA6sPzYDqnmwLsgX4jjnUAXvEjwIFyiUU9Y1nOetkQPxNTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpf48sm6UUXkEQd3nZehO4zH5rhuN5/fTCJRsuHuCJSweVaYKz
	uzxvejK8tyLkMKy/De7Jwptndz8siwkIP6dTHFbyWK07jAcqDp9tx1x/LHuTSToddPA5QIFdkiX
	HSgegHAvoKIYdU/lzwmWxurNu5Pl2H+Ah4vW8x83Dbu6JbEynr2dtLFVZ2KW53sLHpw6eyWi6x3
	3FatjXa7aGGoUKONqJGfavAfmoqvNDsm6WwnUSIGEfm/k=
X-Gm-Gg: AeBDiety9aRYzF3Muct53e/JML0SwWoOhspnAE1KPt2LuFvogKf9H9Mzu5nRP9SOGd9
	rLlOd26307Idvq8mE6PcYiAAWQj82B+eX2CFZnUs5GE9e/X8dJelEyAJuth608GUZBQIz6BY9Oo
	M3D/BY75vO/3Kl0MIKCUaW/p0VTXXD6YLCEYGsIPUxg5W89mNI5xqKVQqBqtsRj4EPvtc7wUXJy
	F9mt0i8avYRLL9+axZxg2EgmCDpjz1SbVxz85qkY1abqR5ytA==
X-Received: by 2002:a05:6820:298f:b0:696:89d9:e215 with SMTP id 006d021491bc7-6968bbcdeecmr1582652eaf.20.1777644581014;
        Fri, 01 May 2026 07:09:41 -0700 (PDT)
X-Received: by 2002:a05:6820:298f:b0:696:89d9:e215 with SMTP id
 006d021491bc7-6968bbcdeecmr1582536eaf.20.1777644578944; Fri, 01 May 2026
 07:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430014817.2006885-1-desnesn@redhat.com> <20260430104850.352bd946.michal.pecio@gmail.com>
 <CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com> <20260430235453.2288c973.michal.pecio@gmail.com>
In-Reply-To: <20260430235453.2288c973.michal.pecio@gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Fri, 1 May 2026 11:09:27 -0300
X-Gm-Features: AVHnY4J2GIkeajs2-Tm-_SjYLeOFfrBdF81W_5A6M08D_bjGMJutxl2DndiluXA
Message-ID: <CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci: bound wait command completion to avoid kdump deadlock
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 919934AD1F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242441-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[desnesn@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello Michal,

On Thu, Apr 30, 2026 at 6:55=E2=80=AFPM Michal Pecio <michal.pecio@gmail.co=
m> wrote:
> When xhci_handle_command_timeout() logs USBSTS, does it help to add:
>
> if (usbsts & STS_FATAL) {
>         xhci_halt(xhci);
>         xhci_hc_died(xhci);
>         goto time_out_completed;
> }
> It may not be perfect solution (race conditions?) but it could hint
> that we are on the right track, if it works.

This panicked the system as soon as I hit `echo c > /proc/sysrq-trigger`:

[  141.683476] sysrq: Trigger a crash
[  141.686970] Kernel panic - not syncing: sysrq triggered crash
[  141.692821] CPU: 10 UID: 0 PID: 5479 Comm: bash Not tainted
7.0.0-michal.pecio #2 PREEMPT(full)
[  141.701755] Hardware name: Intel Corporation Arrow Lake Client
Platform/MTL-S UDIMM 1DPC EVCRB, BIOS MTLSFWI1.R00.5385.D80.2509230731
09/23/2025
[  141.714927] Call Trace:
[  141.717417]  <TASK>
[  141.719553]  dump_stack_lvl+0x4e/0x70
[  141.723279]  vpanic+0x20a/0x410
[  141.726473]  panic+0x6b/0x70
[  141.729402]  sysrq_handle_crash+0x1a/0x20
[  141.733479]  __handle_sysrq.cold+0x99/0xde
[  141.737643]  write_sysrq_trigger+0x59/0xb0
[  141.741810]  proc_reg_write+0x5a/0xa0
[  141.745535]  vfs_write+0xcf/0x450
[  141.748906]  ? do_syscall_64+0x153/0x6a0
[  141.752896]  ? do_fcntl+0x99/0x6c0
[  141.756357]  ksys_write+0x6b/0xe0
[  141.759727]  do_syscall_64+0x11b/0x6a0
[  141.763539]  ? do_syscall_64+0x153/0x6a0
[  141.767529]  ? do_sys_openat2+0x9d/0xe0
[  141.771433]  ? filp_flush+0x59/0x80
[  141.774979]  ? do_syscall_64+0x153/0x6a0
[  141.778967]  ? __x64_sys_fcntl+0x80/0x110
[  141.783044]  ? do_syscall_64+0x153/0x6a0
[  141.787033]  ? count_memcg_events+0xc4/0x160
[  141.791376]  ? handle_mm_fault+0x23f/0x350
[  141.795541]  ? do_user_addr_fault+0x206/0x680
[  141.799972]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  141.805109] RIP: 0033:0x7fb6196e0544
[  141.808745] Code: 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 40 00 f3 0f 1e fa 80 3d a5 cb 0d 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
18 48
[  141.827829] RSP: 002b:00007ffc0b71f128 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[  141.835527] RAX: ffffffffffffffda RBX: 00007fb6197b65c0 RCX: 00007fb6196=
e0544
[  141.842781] RDX: 0000000000000002 RSI: 000055c7a348b170 RDI: 00000000000=
00001
[  141.850036] RBP: 0000000000000002 R08: 0000000000000073 R09: 00000000fff=
fffff
[  141.857290] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[  141.864545] R13: 000055c7a348b170 R14: 0000000000000002 R15: 00007fb6197=
b3f00
[  141.871801]  </TASK>
[  141.874311] Kernel Offset: 0x30800000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  141.885278] ---[ end Kernel panic - not syncing: sysrq triggered crash ]=
---

> > This debug version of the patch printed:
> >
> > [   17.481330] xhci_hcd 0000:80:14.0: TRB_ENABLE_SLOT: no command
> > completion after 10000ms, USBSTS: 0x00000015 HCHalted HSE PCD
>
> OK, so this chip is busted at that point. But it might still be better
> to improve xhci_handle_command_timeout() to deal with this and complete
> the command, instead of patching here and in other similar places.

Didn't get a good result with the STS_FATAL suggestion on
xhci_handle_command_timeout() from above, but I will investigate ways
to improve xhci_handle_command_timeout() as well.

> > [Thu Apr 30 12:28:22 2026] xhci_hcd 0000:80:14.0: Command timeout,
> > USBSTS: 0x00000015 HCHalted HSE PCD
> > [Thu Apr 30 12:28:22 2026] xhci_hcd 0000:80:14.0: Command timeout on
> > stopped ring
> > [Thu Apr 30 12:28:22 2026] xhci_hcd 0000:80:14.0: Turn aborted command
> > 000000005921b827 to no-op
> > [Thu Apr 30 12:28:22 2026] xhci_hcd 0000:80:14.0: // Ding dong!
> > ...
>
> Hmm, the "Command timeout on stopped ring" case doesn't obviously lead
> to any immediate command completion, and ringing the command doorbell
> under HSE won't achieve any progress. Maybe that's the bug.
>
> Could you post full crash kernel dmesg up to that point? Not sure how
> it got to this place.

Sure - kexec-dmesg of 7.0.0-clean as follows:

###################

[Fri May  1 09:46:33 2026] Linux version 7.0.0-clean (root@FQDN) (gcc
(GCC) 14.3.1 20251022 (Red Hat 14.3.1-4), GNU ld version 2.41-65.el10)
#1 SMP PREEMPT_DYNAMIC Thu Apr 30 12:16:02 EDT 2026
[Fri May  1 09:46:33 2026] Command line: elfcorehdr=3D0xfff000000
BOOT_IMAGE=3D/vmlinuz-7.0.0-clean ro
resume=3DUUID=3D64db6567-0caf-4678-8399-0b196e43b3f3
console=3DttyS1,115200n81 usbcore.dyndbg=3D+p xhci_hcd.dyndbg=3D+p
xhci_pci.dyndbg=3D+p thunderbolt.dyndbg=3D+p novmcoredd hugetlb_cma=3D0
kfence.sample_interval=3D0 initramfs_options=3Dsize=3D90% irqpoll nr_cpus=
=3D1
reset_devices cgroup_disable=3Dmemory mce=3Doff numa=3Doff
udev.children-max=3D2 panic=3D10 acpi_no_memhotplug
transparent_hugepage=3Dnever nokaslr hest_disable cma=3D0
pcie_ports=3Dcompat usbcore.dyndbg=3D+p xhci_hcd.dyndbg=3D+p
xhci_pci.dyndbg=3D+p disable_cpu_apicid=3D0 iTCO_wdt.pretimeout=3D0
rd.systemd.gpt_auto=3Dno
[Fri May  1 09:46:33 2026] x86/tme: not enabled by BIOS
[Fri May  1 09:46:33 2026] x86/split lock detection: #AC: crashing the
kernel on kernel split_locks and warning on user-space split_locks
[Fri May  1 09:46:33 2026] BIOS-provided physical RAM map:
[Fri May  1 09:46:33 2026] BIOS-e820: [mem
0x0000000000000000-0x0000000000000fff]  device reserved
[Fri May  1 09:46:33 2026] BIOS-e820: [mem
0x0000000000001000-0x000000000009efff]  System RAM
[Fri May  1 09:46:33 2026] BIOS-e820: [mem
0x000000000009f000-0x00000000000fffff]  device reserved
[Fri May  1 09:46:33 2026] BIOS-e820: [gap
0x0000000000100000-0x000000002effffff]
[Fri May  1 09:46:33 2026] BIOS-e820: [mem
0x000000002f000000-0x000000003effffff]  System RAM
[Fri May  1 09:46:33 2026] BIOS-e820: [gap
0x000000003f000000-0x000000005b368fff]
[Fri May  1 09:46:33 2026] BIOS-e820: [mem
0x000000005b369000-0x000000005b369fff]  device reserved
[Fri May  1 09:46:33 2026] BIOS-e820: [gap
0x000000005b36a000-0x0000000060a55fff]
[Fri May  1 09:46:33 2026] BIOS-e820: [mem
0x0000000060a56000-0x0000000063dcffff]  device reserved
[Fri May  1 09:46:33 2026] BIOS-e820: [mem
0x0000000063dd0000-0x0000000063eb7fff]  ACPI NVS
[Fri May  1 09:46:33 2026] BIOS-e820: [mem
0x0000000063eb8000-0x0000000063ffefff]  ACPI data
[Fri May  1 09:46:33 2026] BIOS-e820: [gap
0x0000000063fff000-0x0000000063ffffff]
[Fri May  1 09:46:33 2026] BIOS-e820: [mem
0x0000000064000000-0x00000000787fffff]  device reserved
[Fri May  1 09:46:33 2026] BIOS-e820: [gap
0x0000000078800000-0x00000000fed1ffff]
[Fri May  1 09:46:33 2026] BIOS-e820: [mem
0x00000000fed20000-0x00000000fed7ffff]  device reserved
[Fri May  1 09:46:33 2026] BIOS-e820: [gap
0x00000000fed80000-0x0000000fff0e00af]
[Fri May  1 09:46:33 2026] BIOS-e820: [mem
0x0000000fff0e00b0-0x000000107effffff]  System RAM
[Fri May  1 09:46:33 2026] random: crng init done
[Fri May  1 09:46:33 2026] NX (Execute Disable) protection: active
[Fri May  1 09:46:33 2026] APIC: Static calls initialized
[Fri May  1 09:46:33 2026] efi: EFI v2.7 by Intel
[Fri May  1 09:46:33 2026] efi: ACPI=3D0x63ffe000 ACPI 2.0=3D0x63ffe014
TPMFinalLog=3D0x63dfe000 SMBIOS=3D0x60b2d000 MEMATTR=3D0xffffffffffffffff
ESRT=3D0x5b369e18 RNG=3D0x63ef7018 TPMEventLog=3D0x63ef2018
[Fri May  1 09:46:33 2026] efi: Remove mem00: MMIO
range=3D[0xff200000-0xffffffff] (14MB) from e820 map
[Fri May  1 09:46:33 2026] e820: remove [mem 0xff200000-0xffffffff]
device reserved
[Fri May  1 09:46:33 2026] efi: Remove mem01: MMIO
range=3D[0xc0000000-0xcfffffff] (256MB) from e820 map
[Fri May  1 09:46:33 2026] e820: remove [mem 0xc0000000-0xcfffffff]
device reserved
[Fri May  1 09:46:33 2026] SMBIOS 3.8 present.
[Fri May  1 09:46:33 2026] DMI: Intel Corporation Arrow Lake Client
Platform/MTL-S UDIMM 1DPC EVCRB, BIOS MTLSFWI1.R00.5385.D80.2509230731
09/23/2025
[Fri May  1 09:46:33 2026] DMI: Memory slots populated: 2/2
[Fri May  1 09:46:33 2026] tsc: Detected 3900.000 MHz processor
[Fri May  1 09:46:33 2026] tsc: Detected 3878.400 MHz TSC
[Fri May  1 09:46:33 2026] e820: update [mem 0x00000000-0x00000fff]
System RAM =3D=3D> device reserved
[Fri May  1 09:46:33 2026] e820: remove [mem 0x000a0000-0x000fffff] System =
RAM
[Fri May  1 09:46:33 2026] last_pfn =3D 0x107f000 max_arch_pfn =3D 0x400000=
000
[Fri May  1 09:46:33 2026] MTRR map: 8 entries (3 fixed + 5 variable;
max 23), built from 10 variable MTRRs
[Fri May  1 09:46:33 2026] x86/PAT: Configuration [0-7]: WB  WC  UC-
UC  WB  WP  UC- WT
[Fri May  1 09:46:33 2026] x2apic: enabled by BIOS, switching to x2apic ops
[Fri May  1 09:46:33 2026] last_pfn =3D 0x63fff max_arch_pfn =3D 0x40000000=
0
[Fri May  1 09:46:33 2026] esrt: Reserving ESRT space from
0x000000005b369e18 to 0x000000005b369f40.
[Fri May  1 09:46:33 2026] e820: update [mem 0x5b369000-0x5b369fff]
System RAM =3D=3D> device reserved
[Fri May  1 09:46:33 2026] Using GB pages for direct mapping
[Fri May  1 09:46:33 2026] Secure boot disabled
[Fri May  1 09:46:33 2026] RAMDISK: [mem 0x10716cb000-0x107b3fffff]
[Fri May  1 09:46:33 2026] ACPI: Early table checksum verification disabled
[Fri May  1 09:46:33 2026] ACPI: RSDP 0x0000000063FFE014 000024 (v02 INTEL =
)
[Fri May  1 09:46:33 2026] ACPI: XSDT 0x0000000063F00228 00018C (v01
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: FACP 0x0000000063FDD000 000114 (v06
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: DSDT 0x0000000063F3E000 09B9B6 (v02
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: FACS 0x0000000063DE4000 000040
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FFC000 00038C (v02
PmaxDv Pmax_Dev 00000001 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FFB000 00072E (v02
PmRef  Cpu0Ist  00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FFA000 0005FB (v02
PmRef  Cpu0Hwp  00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FF9000 0001AB (v02
PmRef  Cpu0Psd  00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FF8000 000394 (v02
PmRef  Cpu0Cst  00003001 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FF6000 001BAF (v02
PmRef  ApIst    00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FF4000 001620 (v02
PmRef  ApHwp    00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FF2000 001349 (v02
PmRef  ApPsd    00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FF1000 000FBB (v02
PmRef  ApCst    00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FED000 003BC8 (v02
CpuRef CpuSsdt  00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: DTPR 0x0000000063FEC000 000088 (v01
              00000000      00000000)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FEB000 000D03 (v02
INTEL  PDatTabl 00001000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FE8000 00247E (v02
INTEL  IgfxSsdt 00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FDE000 009C1C (v02
INTEL  TcssSsdt 00001000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: HPET 0x0000000063FDC000 000038 (v01
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: APIC 0x0000000063FDB000 000358 (v05
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: MCFG 0x0000000063FDA000 00003C (v01
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063F2C000 0119FB (v02
INTEL  MtlS_Rvp 00001000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063F2A000 00147F (v02
INTEL  I2Pm_Rvp 00001000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063F26000 00389C (v02
INTEL  Ther_Rvp 00001000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063F1F000 00535A (v02
DptfTb DptfTabl 00001000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063FFD000 00060E (v02
INTEL  Tpm2Tabl 00001000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: TPM2 0x0000000063F1E000 00004C (v04
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: LPIT 0x0000000063F1D000 0000CC (v01
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: WSMT 0x0000000063F1C000 000028 (v01
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063F1B000 000CA6 (v02
INTEL  PtidDevc 00001000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063F15000 005E42 (v02
INTEL  TbtTypeC 00000000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: DBGP 0x0000000063F14000 000034 (v01
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: DBG2 0x0000000063F13000 000054 (v00
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: NHLT 0x0000000063F12000 000FC3 (v00
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063F10000 00115C (v02
INTEL  UsbCTabl 00001000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063F0A000 005F7B (v02
INTEL  EcSsdt   00000000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: ECDT 0x0000000063F09000 000069 (v01
     ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: DMAR 0x0000000063F08000 000098 (v01
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: UEFI 0x0000000063DDF000 00063A (v01
INTEL  RstVmdE  00000000 INTL 00000000)
[Fri May  1 09:46:33 2026] ACPI: UEFI 0x0000000063DDE000 00005C (v01
INTEL  RstVmdV  00000000 INTL 00000000)
[Fri May  1 09:46:33 2026] ACPI: FPDT 0x0000000063F07000 000044 (v01
INTEL  ARL      00000002      01000013)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063F06000 00012E (v02
INTEL  TxtSsdt  00001000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063F04000 00141E (v02
INTEL  xh_mtlsR 00000000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063F01000 00281A (v02
SocGpe SocGpe   00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063EFD000 0028D3 (v02
SocCmn SocCmn   00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063EFA000 002DD6 (v02
PchGpe PchGpe   00003000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: SSDT 0x0000000063EF8000 0011A0 (v02
INTEL  St00Ssdt 00001000 INTL 20210930)
[Fri May  1 09:46:33 2026] ACPI: PHAT 0x0000000063F25000 000810 (v01
INTEL  ARL      00000005 MSFT 0100000D)
[Fri May  1 09:46:33 2026] ACPI: Reserving FACP table memory at [mem
0x63fdd000-0x63fdd113]
[Fri May  1 09:46:33 2026] ACPI: Reserving DSDT table memory at [mem
0x63f3e000-0x63fd99b5]
[Fri May  1 09:46:33 2026] ACPI: Reserving FACS table memory at [mem
0x63de4000-0x63de403f]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63ffc000-0x63ffc38b]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63ffb000-0x63ffb72d]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63ffa000-0x63ffa5fa]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63ff9000-0x63ff91aa]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63ff8000-0x63ff8393]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63ff6000-0x63ff7bae]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63ff4000-0x63ff561f]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63ff2000-0x63ff3348]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63ff1000-0x63ff1fba]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63fed000-0x63ff0bc7]
[Fri May  1 09:46:33 2026] ACPI: Reserving DTPR table memory at [mem
0x63fec000-0x63fec087]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63feb000-0x63febd02]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63fe8000-0x63fea47d]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63fde000-0x63fe7c1b]
[Fri May  1 09:46:33 2026] ACPI: Reserving HPET table memory at [mem
0x63fdc000-0x63fdc037]
[Fri May  1 09:46:33 2026] ACPI: Reserving APIC table memory at [mem
0x63fdb000-0x63fdb357]
[Fri May  1 09:46:33 2026] ACPI: Reserving MCFG table memory at [mem
0x63fda000-0x63fda03b]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63f2c000-0x63f3d9fa]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63f2a000-0x63f2b47e]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63f26000-0x63f2989b]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63f1f000-0x63f24359]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63ffd000-0x63ffd60d]
[Fri May  1 09:46:33 2026] ACPI: Reserving TPM2 table memory at [mem
0x63f1e000-0x63f1e04b]
[Fri May  1 09:46:33 2026] ACPI: Reserving LPIT table memory at [mem
0x63f1d000-0x63f1d0cb]
[Fri May  1 09:46:33 2026] ACPI: Reserving WSMT table memory at [mem
0x63f1c000-0x63f1c027]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63f1b000-0x63f1bca5]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63f15000-0x63f1ae41]
[Fri May  1 09:46:33 2026] ACPI: Reserving DBGP table memory at [mem
0x63f14000-0x63f14033]
[Fri May  1 09:46:33 2026] ACPI: Reserving DBG2 table memory at [mem
0x63f13000-0x63f13053]
[Fri May  1 09:46:33 2026] ACPI: Reserving NHLT table memory at [mem
0x63f12000-0x63f12fc2]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63f10000-0x63f1115b]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63f0a000-0x63f0ff7a]
[Fri May  1 09:46:33 2026] ACPI: Reserving ECDT table memory at [mem
0x63f09000-0x63f09068]
[Fri May  1 09:46:33 2026] ACPI: Reserving DMAR table memory at [mem
0x63f08000-0x63f08097]
[Fri May  1 09:46:33 2026] ACPI: Reserving UEFI table memory at [mem
0x63ddf000-0x63ddf639]
[Fri May  1 09:46:33 2026] ACPI: Reserving UEFI table memory at [mem
0x63dde000-0x63dde05b]
[Fri May  1 09:46:33 2026] ACPI: Reserving FPDT table memory at [mem
0x63f07000-0x63f07043]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63f06000-0x63f0612d]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63f04000-0x63f0541d]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63f01000-0x63f03819]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63efd000-0x63eff8d2]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63efa000-0x63efcdd5]
[Fri May  1 09:46:33 2026] ACPI: Reserving SSDT table memory at [mem
0x63ef8000-0x63ef919f]
[Fri May  1 09:46:33 2026] ACPI: Reserving PHAT table memory at [mem
0x63f25000-0x63f2580f]
[Fri May  1 09:46:33 2026] APIC: Switched APIC routing to: cluster x2apic
[Fri May  1 09:46:33 2026] NUMA turned off
[Fri May  1 09:46:33 2026] Faking a node at [mem
0x0000000000000000-0x000000107effffff]
[Fri May  1 09:46:33 2026] NODE_DATA(0) allocated [mem
0x107efcf4c0-0x107effa23f]
[Fri May  1 09:46:33 2026] ACPI: PM-Timer IO Port: 0x1808
[Fri May  1 09:46:33 2026] CPU topo: Boot CPU APIC ID not the first
enumerated APIC ID: 4c !=3D 0
[Fri May  1 09:46:33 2026] CPU topo: Crash kernel detected. Disabling
real BSP to prevent machine INIT
[Fri May  1 09:46:33 2026] CPU topo: CPU limit of 1 reached. Ignoring
further CPUs
[Fri May  1 09:46:33 2026] ACPI: X2APIC_NMI (uid[0xffffffff] high
level lint[0x1])
[Fri May  1 09:46:33 2026] IOAPIC[0]: apic_id 2, version 32, address
0xfec00000, GSI 0-119
[Fri May  1 09:46:33 2026] ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
[Fri May  1 09:46:33 2026] ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 9 high level)
[Fri May  1 09:46:33 2026] ACPI: Using ACPI (MADT) for SMP
configuration information
[Fri May  1 09:46:33 2026] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[Fri May  1 09:46:33 2026] TSC deadline timer available
[Fri May  1 09:46:33 2026] CPU topo: Max. logical packages:   1
[Fri May  1 09:46:33 2026] CPU topo: Max. logical nodes:      1
[Fri May  1 09:46:33 2026] CPU topo: Num. nodes per package:  1
[Fri May  1 09:46:33 2026] CPU topo: Max. logical dies:       1
[Fri May  1 09:46:33 2026] CPU topo: Max. dies per package:   1
[Fri May  1 09:46:33 2026] CPU topo: Max. threads per core:   1
[Fri May  1 09:46:33 2026] CPU topo: Num. cores per package:     1
[Fri May  1 09:46:33 2026] CPU topo: Num. threads per package:   1
[Fri May  1 09:46:33 2026] CPU topo: Allowing 1 present CPUs plus 0 hotplug=
 CPUs
[Fri May  1 09:46:33 2026] CPU topo: Rejected CPUs 19
[Fri May  1 09:46:33 2026] PM: hibernation: Registered nosave memory:
[mem 0x00000000-0x00000fff]
[Fri May  1 09:46:33 2026] PM: hibernation: Registered nosave memory:
[mem 0x0009f000-0x2effffff]
[Fri May  1 09:46:33 2026] PM: hibernation: Registered nosave memory:
[mem 0x3f000000-0xfff0e0fff]
[Fri May  1 09:46:33 2026] [gap 0x78800000-0xfed1ffff] available for PCI de=
vices
[Fri May  1 09:46:33 2026] Booting paravirtualized kernel on bare hardware
[Fri May  1 09:46:33 2026] clocksource: refined-jiffies: mask:
0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[Fri May  1 09:46:33 2026] Zone ranges:
[Fri May  1 09:46:33 2026]   DMA      [mem
0x0000000000001000-0x0000000000ffffff]
[Fri May  1 09:46:33 2026]   DMA32    [mem
0x0000000001000000-0x00000000ffffffff]
[Fri May  1 09:46:33 2026]   Normal   [mem
0x0000000100000000-0x000000107effffff]
[Fri May  1 09:46:33 2026]   Device   empty
[Fri May  1 09:46:33 2026] Movable zone start for each node
[Fri May  1 09:46:33 2026] Early memory node ranges
[Fri May  1 09:46:33 2026]   node   0: [mem
0x0000000000001000-0x000000000009efff]
[Fri May  1 09:46:33 2026]   node   0: [mem
0x000000002f000000-0x000000003effffff]
[Fri May  1 09:46:33 2026]   node   0: [mem
0x0000000fff0e1000-0x000000107effffff]
[Fri May  1 09:46:33 2026] Initmem setup node 0 [mem
0x0000000000001000-0x000000107effffff]
[Fri May  1 09:46:33 2026] On node 0, zone DMA: 1 pages in unavailable rang=
es
[Fri May  1 09:46:33 2026] On node 0, zone DMA32: 61281 pages in
unavailable ranges
[Fri May  1 09:46:33 2026] On node 0, zone Normal: 32993 pages in
unavailable ranges
[Fri May  1 09:46:33 2026] On node 0, zone Normal: 4096 pages in
unavailable ranges
[Fri May  1 09:46:33 2026] setup_percpu: NR_CPUS:8192
nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
[Fri May  1 09:46:33 2026] percpu: Embedded 62 pages/cpu s217088 r8192
d28672 u2097152
[Fri May  1 09:46:33 2026] pcpu-alloc: s217088 r8192 d28672 u2097152
alloc=3D1*2097152
[Fri May  1 09:46:33 2026] pcpu-alloc: [0] 0
[Fri May  1 09:46:33 2026] Kernel command line: elfcorehdr=3D0xfff000000
BOOT_IMAGE=3D/vmlinuz-7.0.0-clean ro
resume=3DUUID=3D64db6567-0caf-4678-8399-0b196e43b3f3
console=3DttyS1,115200n81 usbcore.dyndbg=3D+p xhci_hcd.dyndbg=3D+p
xhci_pci.dyndbg=3D+p thunderbolt.dyndbg=3D+p novmcoredd hugetlb_cma=3D0
kfence.sample_interval=3D0 initramfs_options=3Dsize=3D90% irqpoll nr_cpus=
=3D1
reset_devices cgroup_disable=3Dmemory mce=3Doff numa=3Doff
udev.children-max=3D2 panic=3D10 acpi_no_memhotplug
transparent_hugepage=3Dnever nokaslr hest_disable cma=3D0
pcie_ports=3Dcompat usbcore.dyndbg=3D+p xhci_hcd.dyndbg=3D+p
xhci_pci.dyndbg=3D+p disable_cpu_apicid=3D0 iTCO_wdt.pretimeout=3D0
rd.systemd.gpt_auto=3Dno
[Fri May  1 09:46:33 2026] Misrouted IRQ fixup and polling support enabled
[Fri May  1 09:46:33 2026] This may significantly impact system performance
[Fri May  1 09:46:33 2026] cgroup: Disabling memory control group subsystem
[Fri May  1 09:46:33 2026] Unknown kernel command line parameters
"nokaslr disable_cpu_apicid=3D0", will be passed to user space.
[Fri May  1 09:46:33 2026] printk: log buffer data + meta data:
1048576 + 4456448 =3D 5505024 bytes
[Fri May  1 09:46:33 2026] Dentry cache hash table entries: 524288
(order: 10, 4194304 bytes, linear)
[Fri May  1 09:46:33 2026] Inode-cache hash table entries: 262144
(order: 9, 2097152 bytes, linear)
[Fri May  1 09:46:33 2026] software IO TLB: area num 1.
[Fri May  1 09:46:33 2026] Fallback order for Node 0: 0
[Fri May  1 09:46:33 2026] Built 1 zonelists, mobility grouping on.
Total pages: 589757
[Fri May  1 09:46:33 2026] Policy zone: Normal
[Fri May  1 09:46:33 2026] mem auto-init: stack:all(zero), heap
alloc:off, heap free:off
[Fri May  1 09:46:33 2026] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0,
CPUs=3D1, Nodes=3D1
[Fri May  1 09:46:33 2026] ftrace: allocating 54523 entries in 216 pages
[Fri May  1 09:46:33 2026] ftrace: allocated 216 pages with 4 groups
[Fri May  1 09:46:33 2026] Dynamic Preempt: full
[Fri May  1 09:46:33 2026] rcu: Preemptible hierarchical RCU implementation=
.
[Fri May  1 09:46:33 2026] rcu:     RCU event tracing is enabled.
[Fri May  1 09:46:33 2026] rcu:     RCU restricting CPUs from
NR_CPUS=3D8192 to nr_cpu_ids=3D1.
[Fri May  1 09:46:33 2026]     Trampoline variant of Tasks RCU enabled.
[Fri May  1 09:46:33 2026]     Rude variant of Tasks RCU enabled.
[Fri May  1 09:46:33 2026]     Tracing variant of Tasks RCU enabled.
[Fri May  1 09:46:33 2026] rcu: RCU calculated value of
scheduler-enlistment delay is 100 jiffies.
[Fri May  1 09:46:33 2026] rcu: Adjusting geometry for
rcu_fanout_leaf=3D16, nr_cpu_ids=3D1
[Fri May  1 09:46:33 2026] RCU Tasks: Setting shift to 0 and lim to 1
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D1.
[Fri May  1 09:46:33 2026] RCU Tasks Rude: Setting shift to 0 and lim
to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D1.
[Fri May  1 09:46:33 2026] NR_IRQS: 524544, nr_irqs: 256, preallocated irqs=
: 16
[Fri May  1 09:46:33 2026] rcu: srcu_init: Setting srcu_struct sizes
based on contention.
[Fri May  1 09:46:33 2026] Spurious LAPIC timer interrupt on cpu 0
[Fri May  1 09:46:33 2026] Console: colour dummy device 80x25
[Fri May  1 09:46:33 2026] printk: legacy console [ttyS1] enabled
[Fri May  1 09:46:33 2026] ACPI: Core revision 20251212
[Fri May  1 09:46:33 2026] hpet: HPET dysfunctional in PC10. Force disabled=
.
[Fri May  1 09:46:33 2026] APIC: Switch to symmetric I/O mode setup
[Fri May  1 09:46:33 2026] DMAR: Host address width 42
[Fri May  1 09:46:33 2026] DMAR: DRHD base: 0x000000fc800000 flags: 0x0
[Fri May  1 09:46:33 2026] DMAR: dmar0: reg_base_addr fc800000 ver 7:0
cap e9de008cee690462 ecap 1aca9a00f0ef5e
[Fri May  1 09:46:33 2026] DMAR: DRHD base: 0x000000fc810000 flags: 0x1
[Fri May  1 09:46:33 2026] DMAR: dmar1: reg_base_addr fc810000 ver 7:0
cap e9de008cee690462 ecap 1aca9a00f0efde
[Fri May  1 09:46:33 2026] DMAR: SATC flags: 0x1
[Fri May  1 09:46:33 2026] DMAR-IR: IOAPIC id 2 under DRHD base
0xfc810000 IOMMU 1
[Fri May  1 09:46:33 2026] DMAR-IR: HPET id 0 under DRHD base 0xfc810000
[Fri May  1 09:46:33 2026] DMAR-IR: Queued invalidation will be
enabled to support x2apic and Intr-remapping.
[Fri May  1 09:46:33 2026] DMAR-IR: Copied IR table for dmar0 from
previous kernel
[Fri May  1 09:46:33 2026] DMAR-IR: Copied IR table for dmar1 from
previous kernel
[Fri May  1 09:46:33 2026] DMAR-IR: Enabled IRQ remapping in x2apic mode
[Fri May  1 09:46:33 2026] clocksource: tsc-early: mask:
0xffffffffffffffff max_cycles: 0x6fcf4cc6405, max_idle_ns:
881590767330 ns
[Fri May  1 09:46:33 2026] Calibrating delay loop (skipped), value
calculated using timer frequency.. 7756.80 BogoMIPS (lpj=3D3878400)
[Fri May  1 09:46:33 2026] CPU0: Thermal monitoring enabled (TM1)
[Fri May  1 09:46:33 2026] x86/cpu: User Mode Instruction Prevention
(UMIP) activated
[Fri May  1 09:46:33 2026] CET detected: Indirect Branch Tracking enabled
[Fri May  1 09:46:33 2026] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[Fri May  1 09:46:33 2026] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1G=
B 0
[Fri May  1 09:46:33 2026] process: using mwait in idle threads
[Fri May  1 09:46:33 2026] mitigations: Enabled attack vectors:
user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
[Fri May  1 09:46:33 2026] Speculative Store Bypass: Mitigation:
Speculative Store Bypass disabled via prctl
[Fri May  1 09:46:33 2026] Spectre V2 : Mitigation: Enhanced / Automatic IB=
RS
[Fri May  1 09:46:33 2026] VMSCAPE: Mitigation: IBPB before exit to userspa=
ce
[Fri May  1 09:46:33 2026] Spectre V1 : Mitigation: usercopy/swapgs
barriers and __user pointer sanitization
[Fri May  1 09:46:33 2026] Spectre V2 : mitigation: Enabling
conditional Indirect Branch Prediction Barrier
[Fri May  1 09:46:33 2026] x86/fpu: Supporting XSAVE feature 0x001:
'x87 floating point registers'
[Fri May  1 09:46:33 2026] x86/fpu: Supporting XSAVE feature 0x002:
'SSE registers'
[Fri May  1 09:46:33 2026] x86/fpu: Supporting XSAVE feature 0x004:
'AVX registers'
[Fri May  1 09:46:33 2026] x86/fpu: Supporting XSAVE feature 0x200:
'Protection Keys User registers'
[Fri May  1 09:46:33 2026] x86/fpu: Supporting XSAVE feature 0x800:
'Control-flow User registers'
[Fri May  1 09:46:33 2026] x86/fpu: Supporting XSAVE feature 0x1000:
'Control-flow Kernel registers (KVM only)'
[Fri May  1 09:46:33 2026] x86/fpu: xstate_offset[2]:  576,
xstate_sizes[2]:  256
[Fri May  1 09:46:33 2026] x86/fpu: xstate_offset[9]:  832,
xstate_sizes[9]:    8
[Fri May  1 09:46:33 2026] x86/fpu: xstate_offset[11]:  840,
xstate_sizes[11]:   16
[Fri May  1 09:46:33 2026] x86/fpu: xstate_offset[12]:  856,
xstate_sizes[12]:   24
[Fri May  1 09:46:33 2026] x86/fpu: Enabled xstate features 0x1a07,
context size is 880 bytes, using 'compacted' format.
[Fri May  1 09:46:33 2026] Freeing SMP alternatives memory: 48K
[Fri May  1 09:46:33 2026] pid_max: default: 32768 minimum: 301
[Fri May  1 09:46:33 2026] Yama: becoming mindful.
[Fri May  1 09:46:33 2026] SELinux:  Initializing.
[Fri May  1 09:46:33 2026] LSM support for eBPF active
[Fri May  1 09:46:33 2026] landlock: Up and running.
[Fri May  1 09:46:33 2026] Mount-cache hash table entries: 8192
(order: 4, 65536 bytes, linear)
[Fri May  1 09:46:33 2026] Mountpoint-cache hash table entries: 8192
(order: 4, 65536 bytes, linear)
[Fri May  1 09:46:33 2026] VFS: Finished mounting rootfs on nullfs
[Fri May  1 09:46:33 2026] smpboot: CPU0: Intel(R) Core(TM) Ultra 7
265K (family: 0x6, model: 0xc6, stepping: 0x2)
[Fri May  1 09:46:33 2026] Performance Events: XSAVE Architectural
LBR, PEBS fmt6+-baseline,  AnyThread deprecated, Lunarlake Hybrid
events, 32-deep LBR, full-width counters, Broken BIOS detected,
complain to your hardware vendor.
[Fri May  1 09:46:33 2026] [Firmware Bug]: the BIOS has corrupted
hw-PMU resources (MSR 38d is b0)
[Fri May  1 09:46:33 2026] Intel PMU driver.
[Fri May  1 09:46:33 2026] core: The event 0x5d0 is not supported as
an auto-counter reload event.
[Fri May  1 09:46:33 2026] Broken BIOS detected, complain to your
hardware vendor.
[Fri May  1 09:46:33 2026] [Firmware Bug]: the BIOS has corrupted
hw-PMU resources (MSR 38d is b0)
[Fri May  1 09:46:33 2026] core: cpu_atom PMU driver:
[Fri May  1 09:46:33 2026] ... version:                   6
[Fri May  1 09:46:33 2026] ... bit width:                 48
[Fri May  1 09:46:33 2026] ... generic counters:          8
[Fri May  1 09:46:33 2026] ... generic bitmap:            00000000000000ff
[Fri May  1 09:46:33 2026] ... fixed-purpose counters:    6
[Fri May  1 09:46:33 2026] ... fixed-purpose bitmap:      0000000000000077
[Fri May  1 09:46:33 2026] ... value mask:                0000ffffffffffff
[Fri May  1 09:46:33 2026] ... max period:                00007fffffffffff
[Fri May  1 09:46:33 2026] ... global_ctrl mask:          00000077000000ff
[Fri May  1 09:46:33 2026] signal: max sigframe size: 3632
[Fri May  1 09:46:33 2026] Estimated ratio of average max frequency by
base frequency (times 1024): 1365
[Fri May  1 09:46:33 2026] rcu: Hierarchical SRCU implementation.
[Fri May  1 09:46:33 2026] rcu:     Max phase no-delay instances is 400.
[Fri May  1 09:46:33 2026] NMI watchdog: Enabled. Permanently consumes
one hw-PMU counter.
[Fri May  1 09:46:33 2026] smp: Bringing up secondary CPUs ...
[Fri May  1 09:46:33 2026] smp: Brought up 1 node, 1 CPU
[Fri May  1 09:46:33 2026] smpboot: Total of 1 processors activated
(7756.80 BogoMIPS)
[Fri May  1 09:46:33 2026] node 0 deferred pages initialised in 2ms
[Fri May  1 09:46:33 2026] Memory: 2022080K/2359028K available (17608K
kernel code, 6618K rwdata, 8848K rodata, 4404K init, 5512K bss,
328792K reserved, 0K cma-reserved)
[Fri May  1 09:46:33 2026] devtmpfs: initialized
[Fri May  1 09:46:33 2026] x86/mm: Memory block size: 2048MB
[Fri May  1 09:46:33 2026] ACPI: PM: Registering ACPI NVS region [mem
0x63dd0000-0x63eb7fff] (950272 bytes)
[Fri May  1 09:46:33 2026] clocksource: jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[Fri May  1 09:46:33 2026] posixtimers hash table entries: 512 (order:
1, 8192 bytes, linear)
[Fri May  1 09:46:33 2026] futex hash table entries: 256 (16384 bytes
on 1 NUMA nodes, total 16 KiB, linear).
[Fri May  1 09:46:33 2026] NET: Registered PF_NETLINK/PF_ROUTE protocol fam=
ily
[Fri May  1 09:46:33 2026] DMA: preallocated 256 KiB GFP_KERNEL pool
for atomic allocations
[Fri May  1 09:46:33 2026] DMA: preallocated 256 KiB
GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[Fri May  1 09:46:33 2026] audit: initializing netlink subsys (disabled)
[Fri May  1 09:46:33 2026] audit: type=3D2000 audit(1777628793.012:1):
state=3Dinitialized audit_enabled=3D0 res=3D1
[Fri May  1 09:46:33 2026] thermal_sys: Registered thermal governor 'fair_s=
hare'
[Fri May  1 09:46:33 2026] thermal_sys: Registered thermal governor 'step_w=
ise'
[Fri May  1 09:46:33 2026] thermal_sys: Registered thermal governor 'user_s=
pace'
[Fri May  1 09:46:33 2026] cpuidle: using governor menu
[Fri May  1 09:46:33 2026] acpiphp: ACPI Hot Plug PCI Controller
Driver version: 0.5
[Fri May  1 09:46:33 2026] PCI: ECAM [mem 0xc0000000-0xcdffffff] (base
0xc0000000) for domain 0000 [bus 00-df]
[Fri May  1 09:46:33 2026] PCI: Using configuration type 1 for base access
[Fri May  1 09:46:33 2026] kprobes: kprobe jump-optimization is
enabled. All kprobes are optimized if possible.
[Fri May  1 09:46:33 2026] HugeTLB: registered 1.00 GiB page size,
pre-allocated 0 pages
[Fri May  1 09:46:33 2026] HugeTLB: 16380 KiB vmemmap can be freed for
a 1.00 GiB page
[Fri May  1 09:46:33 2026] HugeTLB: registered 2.00 MiB page size,
pre-allocated 0 pages
[Fri May  1 09:46:33 2026] HugeTLB: 28 KiB vmemmap can be freed for a
2.00 MiB page
[Fri May  1 09:46:33 2026] ACPI: Added _OSI(Module Device)
[Fri May  1 09:46:33 2026] ACPI: Added _OSI(Processor Device)
[Fri May  1 09:46:33 2026] ACPI: Added _OSI(Processor Aggregator Device)
[Fri May  1 09:46:34 2026] ACPI: 29 ACPI AML tables successfully
acquired and loaded
[Fri May  1 09:46:34 2026] ACPI: EC: EC started
[Fri May  1 09:46:34 2026] ACPI: EC: interrupt blocked
[Fri May  1 09:46:34 2026] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[Fri May  1 09:46:34 2026] ACPI: EC: Boot ECDT EC used to handle transactio=
ns
[Fri May  1 09:46:34 2026] ACPI: \_SB_: platform _OSC: OS support mask
[006e7eff]
[Fri May  1 09:46:34 2026] ACPI: \_SB_: platform _OSC: OS control mask
[006e7eff]
[Fri May  1 09:46:34 2026] ACPI: USB4 _OSC: OS supports USB3+
DisplayPort+ PCIe+ XDomain+
[Fri May  1 09:46:34 2026] ACPI: USB4 _OSC: OS controls USB3+
DisplayPort+ PCIe+ XDomain+
[Fri May  1 09:46:34 2026] ACPI: Interpreter enabled
[Fri May  1 09:46:34 2026] ACPI: PM: (supports S0 S4 S5)
[Fri May  1 09:46:34 2026] ACPI: Using IOAPIC for interrupt routing
[Fri May  1 09:46:34 2026] HEST: Table parsing disabled.
[Fri May  1 09:46:34 2026] GHES: HEST is not enabled!
[Fri May  1 09:46:34 2026] PCI: Using host bridge windows from ACPI;
if necessary, use "pci=3Dnocrs" and report a bug
[Fri May  1 09:46:34 2026] PCI: Ignoring E820 reservations for host
bridge windows
[Fri May  1 09:46:34 2026] ACPI: Enabled 10 GPEs in block 00 to 7F
[Fri May  1 09:46:34 2026] ACPI: Enabled 8 GPEs in block 80 to DF
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC00.RP01.PXP_: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC00.RP17.PXP_: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC00.RP21.PXP_: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC00.TBT0: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC00.TBT1: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC00.D3C_: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC02.XHCI.RHUB.HS14.BTRT: New
power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC02.XHCI.RHUB.HS14.DBTR: New
power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC02.PAUD: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC02.RP01.PXP_: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC02.RP05.PXP_: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC02.RP09.PXP_: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC02.RP13.PXP_: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC02.RP21.PXP_: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_SB_.PC02.CNVW.WRST: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_TZ_.FN00: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_TZ_.FN01: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_TZ_.FN02: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_TZ_.FN03: New power resource
[Fri May  1 09:46:34 2026] ACPI: \_TZ_.FN04: New power resource
[Fri May  1 09:46:34 2026] ACPI: \PIN_: New power resource
[Fri May  1 09:46:34 2026] ACPI: \PPIN: New power resource
[Fri May  1 09:46:34 2026] ACPI: \SPR4: New power resource
[Fri May  1 09:46:34 2026] ACPI: \SPR5: New power resource
[Fri May  1 09:46:34 2026] ACPI: \SPR6: New power resource
[Fri May  1 09:46:34 2026] ACPI: \SPR7: New power resource
[Fri May  1 09:46:34 2026] ACPI: PCI Root Bridge [PC00] (domain 0000
[bus 00-7f])
[Fri May  1 09:46:34 2026] acpi PNP0A08:00: _OSC: OS supports
[ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[Fri May  1 09:46:34 2026] acpi PNP0A08:00: PCIe port services
disabled; not requesting _OSC control
[Fri May  1 09:46:34 2026] PCI host bridge to bus 0000:00
[Fri May  1 09:46:34 2026] pci_bus 0000:00: root bus resource [io
0x0000-0x0cf7 window]
[Fri May  1 09:46:34 2026] pci_bus 0000:00: root bus resource [io
0x9000-0xffff window]
[Fri May  1 09:46:34 2026] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[Fri May  1 09:46:34 2026] pci_bus 0000:00: root bus resource [mem
0x80000000-0xb7ffffff window]
[Fri May  1 09:46:34 2026] pci_bus 0000:00: root bus resource [mem
0xa000000000-0x3ffbfffffff window]
[Fri May  1 09:46:34 2026] pci_bus 0000:00: root bus resource [bus 00-7f]
[Fri May  1 09:46:34 2026] pci 0000:00:00.0: [8086:7d1b] type 00 class
0x060000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:01.0: [8086:7ecc] type 01 class
0x060400 PCIe Root Port
[Fri May  1 09:46:34 2026] pci 0000:00:01.0: PCI bridge to [bus 01]
[Fri May  1 09:46:34 2026] pci 0000:00:01.0:   bridge window [mem
0x8e400000-0x8e4fffff]
[Fri May  1 09:46:34 2026] pci 0000:00:01.0: PME# supported from D0 D3hot D=
3cold
[Fri May  1 09:46:34 2026] pci 0000:00:01.0: PTM enabled (root), 4ns granul=
arity
[Fri May  1 09:46:34 2026] pci 0000:00:02.0: [8086:7d67] type 00 class
0x030000 PCIe Root Complex Integrated Endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:02.0: BAR 0 [mem
0xb82a000000-0xb82affffff 64bit pref]
[Fri May  1 09:46:34 2026] pci 0000:00:02.0: BAR 2 [mem
0xa810000000-0xa81fffffff 64bit pref]
[Fri May  1 09:46:34 2026] pci 0000:00:02.0: DMAR: Skip IOMMU
disabling for graphics
[Fri May  1 09:46:34 2026] pci 0000:00:02.0: Video device with
shadowed ROM at [mem 0x000c0000-0x000dffff]
[Fri May  1 09:46:34 2026] pci 0000:00:02.0: PME# supported from D0 D3hot
[Fri May  1 09:46:34 2026] pci 0000:00:02.0: VF BAR 0 [mem
0xa801000000-0xa801ffffff 64bit pref]
[Fri May  1 09:46:34 2026] pci 0000:00:02.0: VF BAR 0 [mem
0xa801000000-0xa807ffffff 64bit pref]: contains BAR 0 for 7 VFs
[Fri May  1 09:46:34 2026] pci 0000:00:04.0: [8086:ad03] type 00 class
0x118000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:04.0: BAR 0 [mem
0xb82c080000-0xb82c09ffff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:06.0: [8086:ae4d] type 01 class
0x060400 PCIe Root Port
[Fri May  1 09:46:34 2026] pci 0000:00:06.0: PCI bridge to [bus 02-05]
[Fri May  1 09:46:34 2026] pci 0000:00:06.0:   bridge window [mem
0x8d000000-0x8e0fffff]
[Fri May  1 09:46:34 2026] pci 0000:00:06.0:   bridge window [mem
0xa000000000-0xa8007fffff 64bit pref]
[Fri May  1 09:46:34 2026] pci 0000:00:06.0: PME# supported from D0 D3hot D=
3cold
[Fri May  1 09:46:34 2026] pci 0000:00:06.0: PTM enabled (root), 4ns granul=
arity
[Fri May  1 09:46:34 2026] pci 0000:00:07.0: [8086:7ec4] type 01 class
0x060400 PCIe Root Port
[Fri May  1 09:46:34 2026] pci 0000:00:07.0: PCI bridge to [bus 06-2f]
[Fri May  1 09:46:34 2026] pci 0000:00:07.0:   bridge window [io  0x9000-0x=
9fff]
[Fri May  1 09:46:34 2026] pci 0000:00:07.0:   bridge window [mem
0x86000000-0x8bffffff]
[Fri May  1 09:46:34 2026] pci 0000:00:07.0:   bridge window [mem
0xa820000000-0xb01fffffff 64bit pref]
[Fri May  1 09:46:34 2026] pci 0000:00:07.0: PME# supported from D0 D3hot D=
3cold
[Fri May  1 09:46:34 2026] pci 0000:00:07.0: PTM enabled (root), 4ns granul=
arity
[Fri May  1 09:46:34 2026] pci 0000:00:07.1: [8086:7ec5] type 01 class
0x060400 PCIe Root Port
[Fri May  1 09:46:34 2026] pci 0000:00:07.1: PCI bridge to [bus 30-59]
[Fri May  1 09:46:34 2026] pci 0000:00:07.1:   bridge window [io  0xa000-0x=
afff]
[Fri May  1 09:46:34 2026] pci 0000:00:07.1:   bridge window [mem
0x80000000-0x85ffffff]
[Fri May  1 09:46:34 2026] pci 0000:00:07.1:   bridge window [mem
0xb020000000-0xb81fffffff 64bit pref]
[Fri May  1 09:46:34 2026] pci 0000:00:07.1: PME# supported from D0 D3hot D=
3cold
[Fri May  1 09:46:34 2026] pci 0000:00:07.1: PTM enabled (root), 4ns granul=
arity
[Fri May  1 09:46:34 2026] pci 0000:00:08.0: [8086:ae4c] type 00 class
0x088000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:08.0: BAR 0 [mem
0xb82c0b7000-0xb82c0b7fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:0a.0: [8086:ad0d] type 00 class
0x118000 PCIe Root Complex Integrated Endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:0a.0: BAR 0 [mem
0xb82c040000-0xb82c07ffff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:0a.0: enabling Extended Tags
[Fri May  1 09:46:34 2026] pci 0000:00:0b.0: [8086:ad1d] type 00 class
0x120000 PCIe Root Complex Integrated Endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:0b.0: BAR 0 [mem
0xb820000000-0xb827ffffff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:0b.0: BAR 4 [mem
0xb82c0b6000-0xb82c0b6fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:0d.0: [8086:7ec0] type 00 class
0x0c0330 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:0d.0: BAR 0 [mem
0xb82c0a0000-0xb82c0affff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:0d.0: PME# supported from D3hot D3co=
ld
[Fri May  1 09:46:34 2026] pci 0000:00:0d.2: [8086:7ec2] type 00 class
0x0c0340 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:0d.2: BAR 0 [mem
0xb82c000000-0xb82c03ffff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:0d.2: BAR 2 [mem
0xb82c0b5000-0xb82c0b5fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:0d.2: supports D1 D2
[Fri May  1 09:46:34 2026] pci 0000:00:0d.2: PME# supported from D0 D1
D2 D3hot D3cold
[Fri May  1 09:46:34 2026] pci 0000:00:0e.0: [8086:ad0b] type 00 class
0x010400 PCIe Root Complex Integrated Endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:0e.0: BAR 0 [mem
0xb828000000-0xb829ffffff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:0e.0: BAR 2 [mem 0x8c000000-0x8cffff=
ff]
[Fri May  1 09:46:34 2026] pci 0000:00:0e.0: BAR 4 [mem
0xb82b000000-0xb82bffffff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:14.0: [8086:ae7f] type 00 class
0x050000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:14.0: BAR 0 [mem
0xb82c0b0000-0xb82c0b3fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:14.0: BAR 2 [mem
0xb82c0b4000-0xb82c0b4fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:1f.0: [8086:ae0d] type 00 class
0x060100 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:1f.5: [8086:ae23] type 00 class
0x0c8000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:00:1f.5: BAR 0 [mem 0x8e100000-0x8e100f=
ff]
[Fri May  1 09:46:34 2026] pci 0000:01:00.0: [144d:a80a] type 00 class
0x010802 PCIe Endpoint
[Fri May  1 09:46:34 2026] pci 0000:01:00.0: BAR 0 [mem
0x8e400000-0x8e403fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:00:01.0: PCI bridge to [bus 01]
[Fri May  1 09:46:34 2026] pci 0000:02:00.0: [8086:e2ff] type 01 class
0x060400 PCIe Switch Upstream Port
[Fri May  1 09:46:34 2026] pci 0000:02:00.0: BAR 0 [mem
0x00000000-0x007fffff 64bit pref]
[Fri May  1 09:46:34 2026] pci 0000:02:00.0: PCI bridge to [bus 00]
[Fri May  1 09:46:34 2026] pci 0000:02:00.0:   bridge window [io  0x0000-0x=
0fff]
[Fri May  1 09:46:34 2026] pci 0000:02:00.0:   bridge window [mem
0x00000000-0x000fffff]
[Fri May  1 09:46:34 2026] pci 0000:02:00.0:   bridge window [mem
0x00000000-0x000fffff 64bit pref]
[Fri May  1 09:46:34 2026] pci 0000:02:00.0: Max Payload Size set to
256 (was 128, max 256)
[Fri May  1 09:46:34 2026] pci 0000:02:00.0: PME# supported from D0 D3hot D=
3cold
[Fri May  1 09:46:34 2026] pci 0000:00:06.0: ASPM: current common
clock configuration is inconsistent, reconfiguring
[Fri May  1 09:46:34 2026] pci 0000:00:06.0: PCI bridge to [bus 02-05]
[Fri May  1 09:46:34 2026] pci 0000:02:00.0: bridge configuration
invalid ([bus 00-00]), reconfiguring
[Fri May  1 09:46:34 2026] pci 0000:03:01.0: [8086:e2f0] type 01 class
0x060400 PCIe Switch Downstream Port
[Fri May  1 09:46:34 2026] pci 0000:03:01.0: PCI bridge to [bus 00]
[Fri May  1 09:46:34 2026] pci 0000:03:01.0:   bridge window [io  0x0000-0x=
0fff]
[Fri May  1 09:46:34 2026] pci 0000:03:01.0:   bridge window [mem
0x00000000-0x000fffff]
[Fri May  1 09:46:34 2026] pci 0000:03:01.0:   bridge window [mem
0x00000000-0x000fffff 64bit pref]
[Fri May  1 09:46:34 2026] pci 0000:03:01.0: Max Payload Size set to
256 (was 128, max 256)
[Fri May  1 09:46:34 2026] pci 0000:03:01.0: enabling Extended Tags
[Fri May  1 09:46:34 2026] pci 0000:03:01.0: PME# supported from D0 D3hot D=
3cold
[Fri May  1 09:46:34 2026] pci 0000:03:02.0: [8086:e2f1] type 01 class
0x060400 PCIe Switch Downstream Port
[Fri May  1 09:46:34 2026] pci 0000:03:02.0: PCI bridge to [bus 00]
[Fri May  1 09:46:34 2026] pci 0000:03:02.0:   bridge window [io  0x0000-0x=
0fff]
[Fri May  1 09:46:34 2026] pci 0000:03:02.0:   bridge window [mem
0x00000000-0x000fffff]
[Fri May  1 09:46:34 2026] pci 0000:03:02.0:   bridge window [mem
0x00000000-0x000fffff 64bit pref]
[Fri May  1 09:46:34 2026] pci 0000:03:02.0: Max Payload Size set to
256 (was 128, max 256)
[Fri May  1 09:46:34 2026] pci 0000:03:02.0: enabling Extended Tags
[Fri May  1 09:46:34 2026] pci 0000:03:02.0: PME# supported from D0 D3hot D=
3cold
[Fri May  1 09:46:34 2026] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[Fri May  1 09:46:34 2026] pci 0000:03:01.0: bridge configuration
invalid ([bus 00-00]), reconfiguring
[Fri May  1 09:46:34 2026] pci 0000:03:02.0: bridge configuration
invalid ([bus 00-00]), reconfiguring
[Fri May  1 09:46:34 2026] pci 0000:04:00.0: [8086:e223] type 00 class
0x030000 PCIe Endpoint
[Fri May  1 09:46:34 2026] pci 0000:04:00.0: BAR 0 [mem
0x00000000-0x00ffffff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:04:00.0: BAR 2 [mem
0x00000000-0x7ffffffff 64bit pref]
[Fri May  1 09:46:34 2026] pci 0000:04:00.0: ROM [mem
0x00000000-0x001fffff pref]
[Fri May  1 09:46:34 2026] pci 0000:04:00.0: Max Payload Size set to
256 (was 128, max 256)
[Fri May  1 09:46:34 2026] pci 0000:04:00.0: PME# supported from D0 D3hot
[Fri May  1 09:46:34 2026] pci 0000:03:01.0: PCI bridge to [bus 04-05]
[Fri May  1 09:46:34 2026] pci_bus 0000:04: busn_res: [bus 04-05] end
is updated to 04
[Fri May  1 09:46:34 2026] pci 0000:05:00.0: [8086:e2f7] type 00 class
0x040300 PCIe Endpoint
[Fri May  1 09:46:34 2026] pci 0000:05:00.0: BAR 0 [mem
0x00000000-0x00003fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:05:00.0: Max Payload Size set to
256 (was 128, max 256)
[Fri May  1 09:46:34 2026] pci 0000:05:00.0: enabling Extended Tags
[Fri May  1 09:46:34 2026] pci 0000:05:00.0: PME# supported from D3hot D3co=
ld
[Fri May  1 09:46:34 2026] pci 0000:03:02.0: PCI bridge to [bus 05]
[Fri May  1 09:46:34 2026] pci_bus 0000:05: busn_res: [bus 05] end is
updated to 05
[Fri May  1 09:46:34 2026] pci_bus 0000:03: busn_res: [bus 03-05] end
is updated to 05
[Fri May  1 09:46:34 2026] pci 0000:00:07.0: PCI bridge to [bus 06-2f]
[Fri May  1 09:46:34 2026] pci 0000:00:07.1: PCI bridge to [bus 30-59]
[Fri May  1 09:46:34 2026] ACPI: PCI Root Bridge [PC02] (domain 0000
[bus 80-df])
[Fri May  1 09:46:34 2026] acpi PNP0A08:01: _OSC: OS supports
[ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[Fri May  1 09:46:34 2026] acpi PNP0A08:01: PCIe port services
disabled; not requesting _OSC control
[Fri May  1 09:46:34 2026] PCI host bridge to bus 0000:80
[Fri May  1 09:46:34 2026] pci_bus 0000:80: root bus resource [io
0x2000-0x8bff window]
[Fri May  1 09:46:34 2026] pci_bus 0000:80: root bus resource [mem
0xb8000000-0xbdffffff window]
[Fri May  1 09:46:34 2026] pci_bus 0000:80: root bus resource [mem
0x8000000000-0x9fdfffffff window]
[Fri May  1 09:46:34 2026] pci_bus 0000:80: root bus resource [bus 80-df]
[Fri May  1 09:46:34 2026] pci 0000:80:14.0: [8086:7f6e] type 00 class
0x0c0330 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:14.0: BAR 0 [mem
0x8000200000-0x800020ffff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:80:14.0: PME# supported from D3hot D3co=
ld
[Fri May  1 09:46:34 2026] pci 0000:80:14.3: [8086:7f70] type 00 class
0x028000 PCIe Root Complex Integrated Endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:14.3: BAR 0 [mem
0x8000214000-0x8000217fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:80:14.3: PME# supported from D0 D3hot D=
3cold
[Fri May  1 09:46:34 2026] pci 0000:80:14.5: [8086:7f2f] type 00 class
0x000000 PCIe Root Complex Integrated Endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:15.0: [8086:7f4c] type 00 class
0x0c8000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:15.0: BAR 0 [mem
0x00000000-0x00000fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:80:15.1: [8086:7f4d] type 00 class
0x0c8000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:15.1: BAR 0 [mem
0x00000000-0x00000fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:80:15.2: [8086:7f4e] type 00 class
0x0c8000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:15.2: BAR 0 [mem
0x00000000-0x00000fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:80:15.3: [8086:7f4f] type 00 class
0x0c8000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:15.3: BAR 0 [mem
0x00000000-0x00000fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:80:16.0: [8086:7f68] type 00 class
0x078000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:16.0: BAR 0 [mem
0x800021d000-0x800021dfff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:80:16.0: PME# supported from D3hot
[Fri May  1 09:46:34 2026] pci 0000:80:17.0: [8086:7f62] type 00 class
0x010601 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:17.0: BAR 0 [mem 0xb8120000-0xb8121f=
ff]
[Fri May  1 09:46:34 2026] pci 0000:80:17.0: BAR 1 [mem 0xb8124000-0xb81240=
ff]
[Fri May  1 09:46:34 2026] pci 0000:80:17.0: BAR 2 [io  0x4040-0x4047]
[Fri May  1 09:46:34 2026] pci 0000:80:17.0: BAR 3 [io  0x4048-0x404b]
[Fri May  1 09:46:34 2026] pci 0000:80:17.0: BAR 4 [io  0x4020-0x403f]
[Fri May  1 09:46:34 2026] pci 0000:80:17.0: BAR 5 [mem 0xb8123000-0xb81237=
ff]
[Fri May  1 09:46:34 2026] pci 0000:80:17.0: PME# supported from D3hot
[Fri May  1 09:46:34 2026] pci 0000:80:19.0: [8086:7f7a] type 00 class
0x0c8000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:19.0: BAR 0 [mem
0x00000000-0x00000fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:80:19.1: [8086:7f7b] type 00 class
0x0c8000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:19.1: BAR 0 [mem
0x00000000-0x00000fff 64bit]
[Fri May  1 09:46:34 2026] pci 0000:80:1c.0: [8086:7f3c] type 01 class
0x060400 PCIe Root Port
[Fri May  1 09:46:34 2026] pci 0000:80:1c.0: PCI bridge to [bus 81]
[Fri May  1 09:46:34 2026] pci 0000:80:1c.0:   bridge window [io  0x3000-0x=
3fff]
[Fri May  1 09:46:34 2026] pci 0000:80:1c.0:   bridge window [mem
0xb8000000-0xb80fffff]
[Fri May  1 09:46:34 2026] pci 0000:80:1c.0: PME# supported from D0 D3hot D=
3cold
[Fri May  1 09:46:34 2026] pci 0000:80:1c.0: PTM enabled (root), 4ns granul=
arity
[Fri May  1 09:46:34 2026] pci 0000:80:1e.0: [8086:7f28] type 00 class
0x078000 conventional PCI endpoint
[Fri May  1 09:46:34 2026] pci 0000:80:1e.0: BAR 0 [mem
0x00000000-0x00000fff 64bit]
[Fri May  1 09:46:35 2026] pci 0000:80:1e.3: [8086:7f2b] type 00 class
0x0c8000 conventional PCI endpoint
[Fri May  1 09:46:35 2026] pci 0000:80:1e.3: BAR 0 [mem
0x00000000-0x00000fff 64bit]
[Fri May  1 09:46:35 2026] pci 0000:80:1f.0: [8086:7f04] type 00 class
0x060100 conventional PCI endpoint
[Fri May  1 09:46:35 2026] pci 0000:80:1f.3: [8086:7f50] type 00 class
0x040100 conventional PCI endpoint
[Fri May  1 09:46:35 2026] pci 0000:80:1f.3: BAR 0 [mem
0x8000210000-0x8000213fff 64bit]
[Fri May  1 09:46:35 2026] pci 0000:80:1f.3: BAR 4 [mem
0x8000000000-0x80001fffff 64bit]
[Fri May  1 09:46:35 2026] pci 0000:80:1f.3: PME# supported from D3hot D3co=
ld
[Fri May  1 09:46:35 2026] pci 0000:80:1f.4: [8086:7f23] type 00 class
0x0c0500 conventional PCI endpoint
[Fri May  1 09:46:35 2026] pci 0000:80:1f.4: BAR 0 [mem
0x8000218000-0x80002180ff 64bit]
[Fri May  1 09:46:35 2026] pci 0000:80:1f.4: BAR 4 [io  0x4000-0x401f]
[Fri May  1 09:46:35 2026] pci 0000:80:1f.5: [8086:7f24] type 00 class
0x0c8000 conventional PCI endpoint
[Fri May  1 09:46:35 2026] pci 0000:80:1f.5: BAR 0 [mem 0xb8122000-0xb8122f=
ff]
[Fri May  1 09:46:35 2026] pci 0000:80:1f.6: [8086:550c] type 00 class
0x020000 conventional PCI endpoint
[Fri May  1 09:46:35 2026] pci 0000:80:1f.6: BAR 0 [mem 0xb8100000-0xb811ff=
ff]
[Fri May  1 09:46:35 2026] pci 0000:80:1f.6: PME# supported from D0 D3hot D=
3cold
[Fri May  1 09:46:35 2026] pci 0000:81:00.0: [9710:9922] type 00 class
0x070002 PCIe Legacy Endpoint
[Fri May  1 09:46:35 2026] pci 0000:81:00.0: BAR 0 [io  0x3000-0x3007]
[Fri May  1 09:46:35 2026] pci 0000:81:00.0: BAR 1 [mem 0xb8001000-0xb8001f=
ff]
[Fri May  1 09:46:35 2026] pci 0000:81:00.0: BAR 5 [mem 0xb8000000-0xb8000f=
ff]
[Fri May  1 09:46:35 2026] pci 0000:81:00.0: PME# supported from D3hot D3co=
ld
[Fri May  1 09:46:35 2026] pci 0000:80:1c.0: PCI bridge to [bus 81]
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: Unable to map lapic to logical cpu number
[Fri May  1 09:46:35 2026] ACPI: \_SB_.PEPD: Duplicate LPS0 _DSM
functions (mask: 0x1)
[Fri May  1 09:46:35 2026] Low-power S0 idle used by default for system sus=
pend
[Fri May  1 09:46:35 2026] ACPI: EC: interrupt unblocked
[Fri May  1 09:46:35 2026] ACPI: EC: event unblocked
[Fri May  1 09:46:35 2026] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[Fri May  1 09:46:35 2026] ACPI: EC: GPE=3D0x46
[Fri May  1 09:46:35 2026] ACPI: \_SB_.PC00.LPCB.H_EC: Boot ECDT EC
initialization complete
[Fri May  1 09:46:35 2026] ACPI: \_SB_.PC00.LPCB.H_EC: EC: Used to
handle transactions and events
[Fri May  1 09:46:35 2026] iommu: Default domain type: Translated
[Fri May  1 09:46:35 2026] iommu: DMA domain TLB invalidation policy: lazy =
mode
[Fri May  1 09:46:35 2026] SCSI subsystem initialized
[Fri May  1 09:46:35 2026] ACPI: bus type USB registered
[Fri May  1 09:46:35 2026] usbcore: registered new interface driver usbfs
[Fri May  1 09:46:35 2026] usbcore: registered new interface driver hub
[Fri May  1 09:46:35 2026] usbcore: registered new device driver usb
[Fri May  1 09:46:35 2026] pps_core: LinuxPPS API ver. 1 registered
[Fri May  1 09:46:35 2026] pps_core: Software ver. 5.3.6 - Copyright
2005-2007 Rodolfo Giometti <giometti@linux.it>
[Fri May  1 09:46:35 2026] PTP clock support registered
[Fri May  1 09:46:35 2026] EDAC MC: Ver: 3.0.0
[Fri May  1 09:46:35 2026] efivars: Registered efivars operations
[Fri May  1 09:46:35 2026] NetLabel: Initializing
[Fri May  1 09:46:35 2026] NetLabel:  domain hash size =3D 128
[Fri May  1 09:46:35 2026] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIP=
SO
[Fri May  1 09:46:35 2026] NetLabel:  unlabeled traffic allowed by default
[Fri May  1 09:46:35 2026] PCI: Using ACPI for IRQ routing
[Fri May  1 09:46:35 2026] PCI: pci_cache_line_size set to 64 bytes
[Fri May  1 09:46:35 2026] e820: register RAM buffer resource [mem
0x0009f000-0x0009ffff]
[Fri May  1 09:46:35 2026] e820: register RAM buffer resource [mem
0x3f000000-0x3fffffff]
[Fri May  1 09:46:35 2026] e820: register RAM buffer resource [mem
0x107f000000-0x107fffffff]
[Fri May  1 09:46:35 2026] pci 0000:00:02.0: vgaarb: setting as boot VGA de=
vice
[Fri May  1 09:46:35 2026] pci 0000:00:02.0: vgaarb: bridge control possibl=
e
[Fri May  1 09:46:35 2026] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: vgaarb: bridge control possibl=
e
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
[Fri May  1 09:46:35 2026] vgaarb: loaded
[Fri May  1 09:46:35 2026] Monitor-Mwait will be used to enter C-1 state
[Fri May  1 09:46:35 2026] Monitor-Mwait will be used to enter C-2 state
[Fri May  1 09:46:35 2026] Monitor-Mwait will be used to enter C-3 state
[Fri May  1 09:46:35 2026] clocksource: Switched to clocksource tsc-early
[Fri May  1 09:46:35 2026] VFS: Disk quotas dquot_6.6.0
[Fri May  1 09:46:35 2026] VFS: Dquot-cache hash table entries: 512
(order 0, 4096 bytes)
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Skipped [io  0x002e-0x002f]
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Skipped [io  0x004e-0x004f]
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Skipped [io  0x0061]
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Skipped [io  0x0063]
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Skipped [io  0x0065]
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Skipped [io  0x0067]
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Skipped [io  0x0070]
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Skipped [io  0x0080]
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Skipped [io  0x0092]
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Skipped [io  0x00b2-0x00b3]
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Reserved [io  0x0680-0x069f]
[Fri May  1 09:46:35 2026] acpi PNP0C02:00: Reserved [io  0x164e-0x164f]
[Fri May  1 09:46:35 2026] acpi PNP0C02:01: Reserved [io  0x06a4]
[Fri May  1 09:46:35 2026] acpi PNP0C02:01: Reserved [io  0x06a0]
[Fri May  1 09:46:35 2026] acpi PNP0C02:04: Reserved [mem 0xfedc0000-0xfedc=
7fff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:04: Could not reserve [mem
0x00000000-0x00000fff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:04: Could not reserve [mem
0x00000000-0x00000fff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:04: Reserved [mem 0xc0000000-0xcfff=
ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:04: Could not reserve [mem
0xfed20000-0xfed7ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:04: Could not reserve [mem
0xfc800000-0xfc81ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:04: Could not reserve [mem
0xfed45000-0xfed8ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:04: Reserved [mem 0xfee00000-0xfeef=
ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:07: Reserved [mem 0xfe000000-0xfe01=
ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:07: Reserved [mem 0xfe04c000-0xfe04=
ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:07: Reserved [mem 0xfe050000-0xfe0a=
ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:07: Reserved [mem 0xfe0d0000-0xfe0f=
ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:07: Reserved [mem 0xfe200000-0xfe7f=
ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:07: Reserved [mem 0xff000000-0xffff=
ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:07: Could not reserve [io
0x1800-0x18fe]
[Fri May  1 09:46:35 2026] acpi PNP0C02:07: Reserved [mem 0xe0000000-0xe0d0=
ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:07: Reserved [mem 0xe0d60000-0xefff=
ffff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:08: Reserved [io  0x2000-0x20fe]
[Fri May  1 09:46:35 2026] acpi PNP0C01:00: Could not reserve [mem
0x00000000-0x0009cfff]
[Fri May  1 09:46:35 2026] acpi PNP0C02:0c: Reserved [io  0x8c00-0x8cfe]
[Fri May  1 09:46:35 2026] pnp: PnP ACPI init
[Fri May  1 09:46:35 2026] pnp: PnP ACPI: found 0 devices
[Fri May  1 09:46:35 2026] clocksource: acpi_pm: mask: 0xffffff
max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[Fri May  1 09:46:35 2026] NET: Registered PF_INET protocol family
[Fri May  1 09:46:35 2026] IP idents hash table entries: 65536 (order:
7, 524288 bytes, linear)
[Fri May  1 09:46:35 2026] tcp_listen_portaddr_hash hash table
entries: 2048 (order: 3, 32768 bytes, linear)
[Fri May  1 09:46:35 2026] Table-perturb hash table entries: 65536
(order: 6, 262144 bytes, linear)
[Fri May  1 09:46:35 2026] TCP established hash table entries: 32768
(order: 6, 262144 bytes, linear)
[Fri May  1 09:46:35 2026] TCP bind hash table entries: 32768 (order:
8, 1048576 bytes, linear)
[Fri May  1 09:46:35 2026] TCP: Hash tables configured (established
32768 bind 32768)
[Fri May  1 09:46:35 2026] MPTCP token hash table entries: 4096
(order: 5, 98304 bytes, linear)
[Fri May  1 09:46:35 2026] UDP hash table entries: 2048 (order: 5,
131072 bytes, linear)
[Fri May  1 09:46:35 2026] UDP-Lite hash table entries: 2048 (order:
5, 131072 bytes, linear)
[Fri May  1 09:46:35 2026] NET: Registered PF_UNIX/PF_LOCAL protocol family
[Fri May  1 09:46:35 2026] NET: Registered PF_XDP protocol family
[Fri May  1 09:46:35 2026] pci 0000:03:01.0: bridge window [mem
0x01000000-0x01ffffff] to [bus 04] add_size 200000 add_align 1000000
[Fri May  1 09:46:35 2026] pci 0000:02:00.0: bridge window [mem
0x01000000-0x020fffff] to [bus 03-05] add_size 200000 add_align
1000000
[Fri May  1 09:46:35 2026] pci 0000:00:01.0: PCI bridge to [bus 01]
[Fri May  1 09:46:35 2026] pci 0000:00:01.0:   bridge window [mem
0x8e400000-0x8e4fffff]
[Fri May  1 09:46:35 2026] pci 0000:02:00.0: bridge window [mem
0xa000000000-0xa7ffffffff 64bit pref]: assigned
[Fri May  1 09:46:35 2026] pci 0000:02:00.0: bridge window [mem size
0x01300000]: can't assign; no space
[Fri May  1 09:46:35 2026] pci 0000:02:00.0: bridge window [mem size
0x01300000]: failed to assign
[Fri May  1 09:46:35 2026] pci 0000:02:00.0: BAR 0 [mem
0xa800000000-0xa8007fffff 64bit pref]: assigned
[Fri May  1 09:46:35 2026] pci 0000:02:00.0: bridge window [mem
0x8d000000-0x8e0fffff]: assigned
[Fri May  1 09:46:35 2026] pci 0000:02:00.0: bridge window [mem
0x8d000000-0x8e0fffff]: failed to expand by 0x200000
[Fri May  1 09:46:35 2026] pci 0000:02:00.0: bridge window [mem
0x8d000000-0x8e0fffff]: failed to add optional 200000
[Fri May  1 09:46:35 2026] pci 0000:03:01.0: bridge window [mem
0xa000000000-0xa7ffffffff 64bit pref]: assigned
[Fri May  1 09:46:35 2026] pci 0000:03:01.0: bridge window [mem
0x8d000000-0x8dffffff]: assigned
[Fri May  1 09:46:35 2026] pci 0000:03:02.0: bridge window [mem
0x8e000000-0x8e0fffff]: assigned
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: BAR 2 [mem
0xa000000000-0xa7ffffffff 64bit pref]: assigned
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: BAR 0 [mem
0x8d000000-0x8dffffff 64bit]: assigned
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: ROM [mem size 0x00200000
pref]: can't assign; no space
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: ROM [mem size 0x00200000
pref]: failed to assign
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: BAR 2 [mem
0xa000000000-0xa7ffffffff 64bit pref]: releasing
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: BAR 0 [mem
0x8d000000-0x8dffffff 64bit]: releasing
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: BAR 2 [mem
0xa000000000-0xa7ffffffff 64bit pref]: assigned
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: BAR 0 [mem
0x8d000000-0x8dffffff 64bit]: assigned
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: ROM [mem size 0x00200000
pref]: can't assign; no space
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: ROM [mem size 0x00200000
pref]: failed to assign
[Fri May  1 09:46:35 2026] pci 0000:03:01.0: PCI bridge to [bus 04]
[Fri May  1 09:46:35 2026] pci 0000:03:01.0:   bridge window [mem
0x8d000000-0x8dffffff]
[Fri May  1 09:46:35 2026] pci 0000:03:01.0:   bridge window [mem
0xa000000000-0xa7ffffffff 64bit pref]
[Fri May  1 09:46:35 2026] pci 0000:05:00.0: BAR 0 [mem
0x8e000000-0x8e003fff 64bit]: assigned
[Fri May  1 09:46:35 2026] pci 0000:03:02.0: PCI bridge to [bus 05]
[Fri May  1 09:46:35 2026] pci 0000:03:02.0:   bridge window [mem
0x8e000000-0x8e0fffff]
[Fri May  1 09:46:35 2026] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[Fri May  1 09:46:35 2026] pci 0000:02:00.0:   bridge window [mem
0x8d000000-0x8e0fffff]
[Fri May  1 09:46:35 2026] pci 0000:02:00.0:   bridge window [mem
0xa000000000-0xa7ffffffff 64bit pref]
[Fri May  1 09:46:35 2026] pci 0000:00:06.0: PCI bridge to [bus 02-05]
[Fri May  1 09:46:35 2026] pci 0000:00:06.0:   bridge window [mem
0x8d000000-0x8e0fffff]
[Fri May  1 09:46:35 2026] pci 0000:00:06.0:   bridge window [mem
0xa000000000-0xa8007fffff 64bit pref]
[Fri May  1 09:46:35 2026] pci 0000:00:07.0: PCI bridge to [bus 06-2f]
[Fri May  1 09:46:35 2026] pci 0000:00:07.0:   bridge window [io  0x9000-0x=
9fff]
[Fri May  1 09:46:35 2026] pci 0000:00:07.0:   bridge window [mem
0x86000000-0x8bffffff]
[Fri May  1 09:46:35 2026] pci 0000:00:07.0:   bridge window [mem
0xa820000000-0xb01fffffff 64bit pref]
[Fri May  1 09:46:35 2026] pci 0000:00:07.1: PCI bridge to [bus 30-59]
[Fri May  1 09:46:35 2026] pci 0000:00:07.1:   bridge window [io  0xa000-0x=
afff]
[Fri May  1 09:46:35 2026] pci 0000:00:07.1:   bridge window [mem
0x80000000-0x85ffffff]
[Fri May  1 09:46:35 2026] pci 0000:00:07.1:   bridge window [mem
0xb020000000-0xb81fffffff 64bit pref]
[Fri May  1 09:46:35 2026] pci_bus 0000:00: Some PCI device resources
are unassigned, try booting with pci=3Drealloc
[Fri May  1 09:46:35 2026] pci_bus 0000:00: resource 4 [io
0x0000-0x0cf7 window]
[Fri May  1 09:46:35 2026] pci_bus 0000:00: resource 5 [io
0x9000-0xffff window]
[Fri May  1 09:46:35 2026] pci_bus 0000:00: resource 6 [mem
0x000a0000-0x000bffff window]
[Fri May  1 09:46:35 2026] pci_bus 0000:00: resource 7 [mem
0x80000000-0xb7ffffff window]
[Fri May  1 09:46:35 2026] pci_bus 0000:00: resource 8 [mem
0xa000000000-0x3ffbfffffff window]
[Fri May  1 09:46:35 2026] pci_bus 0000:01: resource 1 [mem
0x8e400000-0x8e4fffff]
[Fri May  1 09:46:35 2026] pci_bus 0000:02: resource 1 [mem
0x8d000000-0x8e0fffff]
[Fri May  1 09:46:35 2026] pci_bus 0000:02: resource 2 [mem
0xa000000000-0xa8007fffff 64bit pref]
[Fri May  1 09:46:35 2026] pci_bus 0000:03: resource 1 [mem
0x8d000000-0x8e0fffff]
[Fri May  1 09:46:35 2026] pci_bus 0000:03: resource 2 [mem
0xa000000000-0xa7ffffffff 64bit pref]
[Fri May  1 09:46:35 2026] pci_bus 0000:04: resource 1 [mem
0x8d000000-0x8dffffff]
[Fri May  1 09:46:35 2026] pci_bus 0000:04: resource 2 [mem
0xa000000000-0xa7ffffffff 64bit pref]
[Fri May  1 09:46:35 2026] pci_bus 0000:05: resource 1 [mem
0x8e000000-0x8e0fffff]
[Fri May  1 09:46:35 2026] pci_bus 0000:06: resource 0 [io  0x9000-0x9fff]
[Fri May  1 09:46:35 2026] pci_bus 0000:06: resource 1 [mem
0x86000000-0x8bffffff]
[Fri May  1 09:46:35 2026] pci_bus 0000:06: resource 2 [mem
0xa820000000-0xb01fffffff 64bit pref]
[Fri May  1 09:46:35 2026] pci_bus 0000:30: resource 0 [io  0xa000-0xafff]
[Fri May  1 09:46:35 2026] pci_bus 0000:30: resource 1 [mem
0x80000000-0x85ffffff]
[Fri May  1 09:46:35 2026] pci_bus 0000:30: resource 2 [mem
0xb020000000-0xb81fffffff 64bit pref]
[Fri May  1 09:46:35 2026] pci 0000:80:15.0: BAR 0 [mem
0x8000219000-0x8000219fff 64bit]: assigned
[Fri May  1 09:46:35 2026] pci 0000:80:15.1: BAR 0 [mem
0x800021a000-0x800021afff 64bit]: assigned
[Fri May  1 09:46:35 2026] pci 0000:80:15.2: BAR 0 [mem
0x800021b000-0x800021bfff 64bit]: assigned
[Fri May  1 09:46:35 2026] pci 0000:80:15.3: BAR 0 [mem
0x800021c000-0x800021cfff 64bit]: assigned
[Fri May  1 09:46:35 2026] pci 0000:80:19.0: BAR 0 [mem
0x800021e000-0x800021efff 64bit]: assigned
[Fri May  1 09:46:35 2026] pci 0000:80:19.1: BAR 0 [mem
0x800021f000-0x800021ffff 64bit]: assigned
[Fri May  1 09:46:35 2026] pci 0000:80:1e.0: BAR 0 [mem
0x8000220000-0x8000220fff 64bit]: assigned
[Fri May  1 09:46:35 2026] pci 0000:80:1e.3: BAR 0 [mem
0x8000221000-0x8000221fff 64bit]: assigned
[Fri May  1 09:46:35 2026] pci 0000:80:1c.0: PCI bridge to [bus 81]
[Fri May  1 09:46:35 2026] pci 0000:80:1c.0:   bridge window [io  0x3000-0x=
3fff]
[Fri May  1 09:46:35 2026] pci 0000:80:1c.0:   bridge window [mem
0xb8000000-0xb80fffff]
[Fri May  1 09:46:35 2026] pci_bus 0000:80: resource 4 [io
0x2000-0x8bff window]
[Fri May  1 09:46:35 2026] pci_bus 0000:80: resource 5 [mem
0xb8000000-0xbdffffff window]
[Fri May  1 09:46:35 2026] pci_bus 0000:80: resource 6 [mem
0x8000000000-0x9fdfffffff window]
[Fri May  1 09:46:35 2026] pci_bus 0000:81: resource 0 [io  0x3000-0x3fff]
[Fri May  1 09:46:35 2026] pci_bus 0000:81: resource 1 [mem
0xb8000000-0xb80fffff]
[Fri May  1 09:46:35 2026] PCI: CLS 64 bytes, default 64
[Fri May  1 09:46:35 2026] Trying to unpack rootfs image as initramfs...
[Fri May  1 09:46:35 2026] DMAR: Intel-IOMMU force enabled due to
platform opt in
[Fri May  1 09:46:35 2026] DMAR: No RMRR found
[Fri May  1 09:46:35 2026] DMAR: No ATSR found
[Fri May  1 09:46:35 2026] DMAR: dmar0: Using Queued invalidation
[Fri May  1 09:46:35 2026] DMAR: Translation already enabled - trying
to copy translation structures
[Fri May  1 09:46:35 2026] DMAR: Copied translation tables from
previous kernel for dmar0
[Fri May  1 09:46:35 2026] DMAR: dmar1: Using Queued invalidation
[Fri May  1 09:46:35 2026] DMAR: Translation already enabled - trying
to copy translation structures
[Fri May  1 09:46:35 2026] DMAR: Copied translation tables from
previous kernel for dmar1
[Fri May  1 09:46:35 2026] pci 0000:00:02.0: Adding to iommu group 0
[Fri May  1 09:46:35 2026] pci 0000:00:00.0: Adding to iommu group 1
[Fri May  1 09:46:35 2026] pci 0000:00:01.0: Adding to iommu group 2
[Fri May  1 09:46:35 2026] pci 0000:00:04.0: Adding to iommu group 3
[Fri May  1 09:46:35 2026] pci 0000:00:06.0: Adding to iommu group 4
[Fri May  1 09:46:35 2026] pci 0000:00:07.0: Adding to iommu group 5
[Fri May  1 09:46:35 2026] pci 0000:00:07.1: Adding to iommu group 6
[Fri May  1 09:46:35 2026] pci 0000:00:08.0: Adding to iommu group 7
[Fri May  1 09:46:35 2026] pci 0000:00:0a.0: Adding to iommu group 8
[Fri May  1 09:46:35 2026] pci 0000:00:0b.0: Adding to iommu group 9
[Fri May  1 09:46:35 2026] pci 0000:00:0d.0: Adding to iommu group 10
[Fri May  1 09:46:35 2026] pci 0000:00:0d.2: Adding to iommu group 10
[Fri May  1 09:46:35 2026] pci 0000:00:0e.0: Adding to iommu group 11
[Fri May  1 09:46:35 2026] pci 0000:00:14.0: Adding to iommu group 12
[Fri May  1 09:46:35 2026] pci 0000:00:1f.0: Adding to iommu group 13
[Fri May  1 09:46:35 2026] pci 0000:00:1f.5: Adding to iommu group 13
[Fri May  1 09:46:35 2026] pci 0000:01:00.0: Adding to iommu group 14
[Fri May  1 09:46:35 2026] pci 0000:02:00.0: Adding to iommu group 15
[Fri May  1 09:46:35 2026] pci 0000:03:01.0: Adding to iommu group 16
[Fri May  1 09:46:35 2026] pci 0000:03:02.0: Adding to iommu group 17
[Fri May  1 09:46:35 2026] pci 0000:04:00.0: Adding to iommu group 18
[Fri May  1 09:46:35 2026] pci 0000:05:00.0: Adding to iommu group 19
[Fri May  1 09:46:35 2026] pci 0000:80:14.0: Adding to iommu group 20
[Fri May  1 09:46:35 2026] pci 0000:80:14.3: Adding to iommu group 21
[Fri May  1 09:46:35 2026] pci 0000:80:14.5: Adding to iommu group 22
[Fri May  1 09:46:35 2026] pci 0000:80:15.0: Adding to iommu group 23
[Fri May  1 09:46:35 2026] pci 0000:80:15.1: Adding to iommu group 23
[Fri May  1 09:46:35 2026] pci 0000:80:15.2: Adding to iommu group 23
[Fri May  1 09:46:35 2026] pci 0000:80:15.3: Adding to iommu group 23
[Fri May  1 09:46:35 2026] pci 0000:80:16.0: Adding to iommu group 24
[Fri May  1 09:46:35 2026] pci 0000:80:17.0: Adding to iommu group 25
[Fri May  1 09:46:35 2026] pci 0000:80:19.0: Adding to iommu group 26
[Fri May  1 09:46:35 2026] pci 0000:80:19.1: Adding to iommu group 26
[Fri May  1 09:46:35 2026] pci 0000:80:1c.0: Adding to iommu group 27
[Fri May  1 09:46:35 2026] pci 0000:80:1e.0: Adding to iommu group 28
[Fri May  1 09:46:35 2026] pci 0000:80:1e.3: Adding to iommu group 28
[Fri May  1 09:46:35 2026] pci 0000:80:1f.0: Adding to iommu group 29
[Fri May  1 09:46:35 2026] pci 0000:80:1f.3: Adding to iommu group 29
[Fri May  1 09:46:35 2026] pci 0000:80:1f.4: Adding to iommu group 29
[Fri May  1 09:46:35 2026] pci 0000:80:1f.5: Adding to iommu group 29
[Fri May  1 09:46:35 2026] pci 0000:80:1f.6: Adding to iommu group 29
[Fri May  1 09:46:35 2026] pci 0000:81:00.0: Adding to iommu group 30
[Fri May  1 09:46:35 2026] DMAR: Intel(R) Virtualization Technology
for Directed I/O
[Fri May  1 09:46:35 2026] PCI-DMA: Using software bounce buffering
for IO (SWIOTLB)
[Fri May  1 09:46:35 2026] software IO TLB: mapped [mem
0x000000003b000000-0x000000003f000000] (64MB)
[Fri May  1 09:46:35 2026] ACPI: bus type thunderbolt registered
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: total paths: 12
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: IOMMU DMA
protection is enabled
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: allocating TX
ring 0 of size 10
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: allocating RX
ring 0 of size 10
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: control channel create=
d
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: using software
connection manager
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: created link from
0000:00:07.0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: created link from
0000:00:07.1
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: NHI initialized,
starting thunderbolt
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: control channel starti=
ng...
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: starting TX ring 0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: enabling
interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: starting RX ring 0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: enabling
interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: security level set to =
user
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: current switch config:
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  USB4 Switch:
8087:7ec2 (Revision: 16, TB Version: 32)
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max Port Number: 13
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Config:
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:    Upstream Port
Number: 7 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:    unknown1: 0x0
unknown4: 0x0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: initializing
Switch at 0x0 (depth: 0, up port: 7)
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0: credit
allocation parameters:
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0:  USB3: 32
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0:  DP AUX: 1
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0:  DP main: 0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0:  PCIe: 64
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0:  DMA: 14
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0: DROM version: 3
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0: uid: 0xdb5da2808087=
34f8
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: acking hot plug
event on 0:5
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: acking hot plug
event on 0:6
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 1:
8087:15ea (Revision: 0, TB Version: 1, Type: Port (0x1))
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max hop id
(in/out): 19/19
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max counters: 16
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   NFC Credits: 0x83c00=
000
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Credits
(total/control): 60/2
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 2:
8087:15ea (Revision: 0, TB Version: 1, Type: Port (0x1))
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max hop id
(in/out): 19/19
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max counters: 16
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   NFC Credits: 0x83c00=
000
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Credits
(total/control): 60/2
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 3:
8087:15ea (Revision: 0, TB Version: 1, Type: Port (0x1))
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max hop id
(in/out): 19/19
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max counters: 16
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   NFC Credits: 0x83c00=
000
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Credits
(total/control): 60/2
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 4:
8087:15ea (Revision: 0, TB Version: 1, Type: Port (0x1))
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max hop id
(in/out): 19/19
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max counters: 16
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   NFC Credits: 0x83c00=
000
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Credits
(total/control): 60/2
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 5:
8087:15ea (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max hop id (in/out):=
 9/9
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max counters: 2
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   NFC Credits: 0x10000=
0d
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Credits
(total/control): 16/0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 6:
8087:15ea (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max hop id (in/out):=
 9/9
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max counters: 2
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   NFC Credits: 0x10000=
0d
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Credits
(total/control): 16/0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 7:
8086:15ea (Revision: 0, TB Version: 1, Type: NHI (0x2))
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max hop id
(in/out): 11/11
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max counters: 16
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   NFC Credits: 0x1c000=
00
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Credits
(total/control): 28/0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 8:
8087:15ea (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max hop id (in/out):=
 8/8
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max counters: 2
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   NFC Credits: 0x80000=
0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Credits
(total/control): 8/0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 9:
8087:15ea (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max hop id (in/out):=
 8/8
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max counters: 2
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   NFC Credits: 0x80000=
0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Credits
(total/control): 8/0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 10: not implemen=
ted
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 11: not implemen=
ted
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 12: 8087:0
(Revision: 0, TB Version: 1, Type: USB (0x200101))
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max hop id (in/out):=
 8/8
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max counters: 2
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   NFC Credits: 0x80000=
0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Credits
(total/control): 8/0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:  Port 13: 8087:0
(Revision: 0, TB Version: 1, Type: USB (0x200101))
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max hop id (in/out):=
 8/8
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Max counters: 2
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   NFC Credits: 0x80000=
0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2:   Credits
(total/control): 8/0
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0: running
quirk_usb3_maximum_bandwidth
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0:12: USB3
maximum bandwidth limited to 16376 Mb/s
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0:13: USB3
maximum bandwidth limited to 16376 Mb/s
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0: linked ports 1 <-> =
2
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0: linked ports 3 <-> =
4
[Fri May  1 09:46:35 2026] Freeing initrd memory: 160980K
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0: TMU: supports
uni-directional mode
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0: TMU: current mode: =
off
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0: TMU: mode
change off -> uni-directional, LowRes requested
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0: TMU: mode set
to: uni-directional, LowRes
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0: resetting
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0:5: DP IN
resource available
[Fri May  1 09:46:35 2026] thunderbolt 0000:00:0d.2: 0:6: DP IN
resource available
[Fri May  1 09:46:35 2026] clocksource: tsc: mask: 0xffffffffffffffff
max_cycles: 0x6fcf4cc6405, max_idle_ns: 881590767330 ns
[Fri May  1 09:46:35 2026] clocksource: Switched to clocksource tsc
[Fri May  1 09:46:35 2026] platform rtc_cmos: registered platform RTC
device (no PNP device found)
[Fri May  1 09:46:35 2026] Initialise system trusted keyrings
[Fri May  1 09:46:35 2026] Key type blacklist registered
[Fri May  1 09:46:35 2026] workingset: timestamp_bits=3D36 max_order=3D20
bucket_order=3D0
[Fri May  1 09:46:35 2026] integrity: Platform Keyring initialized
[Fri May  1 09:46:35 2026] integrity: Machine keyring initialized
[Fri May  1 09:46:35 2026] cryptd: max_cpu_qlen set to 1000
[Fri May  1 09:46:35 2026] NET: Registered PF_ALG protocol family
[Fri May  1 09:46:35 2026] Key type asymmetric registered
[Fri May  1 09:46:35 2026] Asymmetric key parser 'x509' registered
[Fri May  1 09:46:35 2026] Block layer SCSI generic (bsg) driver
version 0.4 loaded (major 245)
[Fri May  1 09:46:35 2026] io scheduler mq-deadline registered
[Fri May  1 09:46:35 2026] io scheduler kyber registered
[Fri May  1 09:46:35 2026] io scheduler bfq registered
[Fri May  1 09:46:35 2026] atomic64_test: passed for x86-64 platform
with CX8 and with SSE
[Fri May  1 09:46:35 2026] vmd 0000:00:0e.0: Unknown Bus Offset Setting (3)
[Fri May  1 09:46:35 2026] input: Sleep Button as
/devices/platform/PNP0C0E:00/input/input0
[Fri May  1 09:46:35 2026] ACPI: button: Sleep Button [SLPB]
[Fri May  1 09:46:35 2026] input: Power Button as
/devices/platform/PNP0C0C:00/input/input1
[Fri May  1 09:46:35 2026] ACPI: button: Power Button [PWRB]
[Fri May  1 09:46:35 2026] input: Power Button as
/devices/platform/LNXPWRBN:00/input/input2
[Fri May  1 09:46:35 2026] ACPI: button: Power Button [PWRF]
[Fri May  1 09:46:35 2026] acpi LNXTHERM:00: registered as thermal_zone0
[Fri May  1 09:46:35 2026] ACPI: thermal: Thermal Zone [TZ00] (45 C)
[Fri May  1 09:46:35 2026] Serial: 8250/16550 driver, 4 ports, IRQ
sharing enabled
[Fri May  1 09:46:35 2026] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4,
base_baud =3D 115200) is a 16550A
[Fri May  1 09:46:35 2026] printk: legacy console [ttyS1] disabled
[Fri May  1 09:46:35 2026] 0000:81:00.0: ttyS1 at I/O 0x3000 (irq =3D
140, base_baud =3D 115200) is a 16550A
[Fri May  1 09:46:35 2026] printk: legacy console [ttyS1] enabled
[Fri May  1 09:46:36 2026] DMAR: DRHD: handling fault status reg 3
[Fri May  1 09:46:36 2026] DMAR: [DMA Write NO_PASID] Request device
[80:1f.6] fault addr 0x15fa71000 [fault reason 0x39] SM: Present bit
in Root Entry is clear
[Fri May  1 09:46:40 2026] hpet_acpi_add: no address or irqs in _CRS
[Fri May  1 09:46:40 2026] Non-volatile memory driver v1.3
[Fri May  1 09:46:40 2026] ACPI: bus type drm_connector registered
[Fri May  1 09:46:40 2026] dw-apb-uart.6: ttyS2 at MMIO 0x8000220000
(irq =3D 16, base_baud =3D 6250000) is a 16550A
[Fri May  1 09:46:40 2026] rdac: device handler registered
[Fri May  1 09:46:40 2026] hp_sw: device handler registered
[Fri May  1 09:46:40 2026] emc: device handler registered
[Fri May  1 09:46:40 2026] alua: device handler registered
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: new USB bus
registered, assigned bus number 1
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: // Halt the HC
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Resetting HCD
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: // Reset the HC
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Wait for controller
to be ready for doorbell rings
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Reset complete
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Enabling 64-bit DMA addre=
sses.
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Calling HCD init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Starting xhci_init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: HCD page size set to 4K
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Device context base
array address =3D 0x0x00000010015f7000 (DMA), 000000000f13e3de (virt)
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Allocated command
ring at 0000000012764f8e
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: First segment DMA is
0x0x00000010015f8000
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Allocating primary event =
ring
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Allocating 34
scratchpad buffers
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Ext Cap
0000000071f5e8be, port offset =3D 1, count =3D 1, revision =3D 0x2
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: PSIV:1 PSIE:2 PLT:0
PFD:0 LP:0 PSIM:12
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: PSIV:2 PSIE:1 PLT:0
PFD:0 LP:0 PSIM:1500
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: PSIV:3 PSIE:2 PLT:0
PFD:0 LP:0 PSIM:480
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: xHCI 1.0: support
USB2 hardware lpm
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Ext Cap
00000000fbeb9b4e, port offset =3D 2, count =3D 2, revision =3D 0x3
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: PSIV:4 PSIE:3 PLT:0
PFD:1 LP:0 PSIM:5
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: PSIV:5 PSIE:3 PLT:0
PFD:1 LP:1 PSIM:10
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: PSIV:6 PSIE:3 PLT:0
PFD:1 LP:1 PSIM:10
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: PSIV:7 PSIE:3 PLT:0
PFD:1 LP:1 PSIM:20
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Found 1 USB 2.0
ports and 2 USB 3.0 ports.
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: xHC can handle at
most 64 device slots
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Setting Max device
slots reg =3D 0x40
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Setting command ring
address to 0x10015f8001
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Doorbell array is
located at offset 0x3000 from cap regs base addr
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: // Write event ring
dequeue pointer, preserving EHB bit
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Finished xhci_init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Called HCD init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: hcc params
0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Got SBRN 50
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: MWI active
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Finished xhci_pci_reinit
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: supports USB remote wakeu=
p
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: xhci_run
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: ERST deq =3D 64'h10015f90=
00
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Finished xhci_run for mai=
n hcd
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: new USB bus
registered, assigned bus number 2
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Host supports USB
3.2 Enhanced SuperSpeed
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: supports USB remote wakeu=
p
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Enable interrupts
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Enable primary interrupte=
r
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: // Turn on HC, cmd =3D 0x=
5.
[Fri May  1 09:46:40 2026] usb usb1: default language 0x0409
[Fri May  1 09:46:40 2026] usb usb1: udev 1, busnum 1, minor =3D 0
[Fri May  1 09:46:40 2026] usb usb1: New USB device found,
idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D 7.00
[Fri May  1 09:46:40 2026] usb usb1: New USB device strings: Mfr=3D3,
Product=3D2, SerialNumber=3D1
[Fri May  1 09:46:40 2026] usb usb1: Product: xHCI Host Controller
[Fri May  1 09:46:40 2026] usb usb1: Manufacturer: Linux 7.0.0-clean xhci-h=
cd
[Fri May  1 09:46:40 2026] usb usb1: SerialNumber: 0000:00:0d.0
[Fri May  1 09:46:40 2026] usb usb1: usb_probe_device
[Fri May  1 09:46:40 2026] usb usb1: configuration #1 chosen from 1 choice
[Fri May  1 09:46:40 2026] xHCI xhci_add_endpoint called for root hub
[Fri May  1 09:46:40 2026] xHCI xhci_check_bandwidth called for root hub
[Fri May  1 09:46:40 2026] usb usb1: adding 1-0:1.0 (config #1, interface 0=
)
[Fri May  1 09:46:40 2026] hub 1-0:1.0: usb_probe_interface
[Fri May  1 09:46:40 2026] hub 1-0:1.0: usb_probe_interface - got id
[Fri May  1 09:46:40 2026] hub 1-0:1.0: USB hub found
[Fri May  1 09:46:40 2026] hub 1-0:1.0: 1 port detected
[Fri May  1 09:46:40 2026] hub 1-0:1.0: standalone hub
[Fri May  1 09:46:40 2026] hub 1-0:1.0: no power switching (usb 1.0)
[Fri May  1 09:46:40 2026] hub 1-0:1.0: individual port over-current protec=
tion
[Fri May  1 09:46:40 2026] hub 1-0:1.0: Single TT
[Fri May  1 09:46:40 2026] hub 1-0:1.0: TT requires at most 8 FS bit
times (666 ns)
[Fri May  1 09:46:40 2026] hub 1-0:1.0: power on to power good time: 20ms
[Fri May  1 09:46:40 2026] hub 1-0:1.0: local power source is good
[Fri May  1 09:46:40 2026] hub 1-0:1.0: trying to enable port power on
non-switchable hub
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: set port power 1-1
ON, portsc: 0x2a0
[Fri May  1 09:46:40 2026] usb usb2: skipped 1 descriptor after endpoint
[Fri May  1 09:46:40 2026] usb usb2: default language 0x0409
[Fri May  1 09:46:40 2026] usb usb2: udev 1, busnum 2, minor =3D 128
[Fri May  1 09:46:40 2026] usb usb2: New USB device found,
idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D 7.00
[Fri May  1 09:46:40 2026] usb usb2: New USB device strings: Mfr=3D3,
Product=3D2, SerialNumber=3D1
[Fri May  1 09:46:40 2026] usb usb2: Product: xHCI Host Controller
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: Get port status 1-1
read: 0x2a0, return 0x100
[Fri May  1 09:46:40 2026] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[Fri May  1 09:46:40 2026] hub 1-0:1.0: hub_suspend
[Fri May  1 09:46:40 2026] usb usb1: bus auto-suspend, wakeup 1
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0:
xhci_hub_status_data: stopping usb1 port polling
[Fri May  1 09:46:40 2026] usb usb2: Manufacturer: Linux 7.0.0-clean xhci-h=
cd
[Fri May  1 09:46:40 2026] usb usb2: SerialNumber: 0000:00:0d.0
[Fri May  1 09:46:40 2026] usb usb2: usb_probe_device
[Fri May  1 09:46:40 2026] usb usb2: configuration #1 chosen from 1 choice
[Fri May  1 09:46:40 2026] xHCI xhci_add_endpoint called for root hub
[Fri May  1 09:46:40 2026] xHCI xhci_check_bandwidth called for root hub
[Fri May  1 09:46:40 2026] usb usb2: adding 2-0:1.0 (config #1, interface 0=
)
[Fri May  1 09:46:40 2026] hub 2-0:1.0: usb_probe_interface
[Fri May  1 09:46:40 2026] hub 2-0:1.0: usb_probe_interface - got id
[Fri May  1 09:46:40 2026] hub 2-0:1.0: USB hub found
[Fri May  1 09:46:40 2026] hub 2-0:1.0: 2 ports detected
[Fri May  1 09:46:40 2026] hub 2-0:1.0: standalone hub
[Fri May  1 09:46:40 2026] hub 2-0:1.0: no power switching (usb 1.0)
[Fri May  1 09:46:40 2026] hub 2-0:1.0: individual port over-current protec=
tion
[Fri May  1 09:46:40 2026] hub 2-0:1.0: TT requires at most 8 FS bit
times (666 ns)
[Fri May  1 09:46:40 2026] hub 2-0:1.0: power on to power good time: 100ms
[Fri May  1 09:46:40 2026] hub 2-0:1.0: local power source is good
[Fri May  1 09:46:40 2026] usb usb2: port-1 disable U1/U2 _DSM: 1
[Fri May  1 09:46:40 2026] usb usb2: port-2 disable U1/U2 _DSM: 1
[Fri May  1 09:46:40 2026] hub 2-0:1.0: trying to enable port power on
non-switchable hub
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: set port power 2-1
ON, portsc: 0x2a0
[Fri May  1 09:46:40 2026] xhci_hcd 0000:00:0d.0: set port power 2-2
ON, portsc: 0x2a0
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: xHCI Host Controller
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: new USB bus
registered, assigned bus number 3
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: // Halt the HC
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Resetting HCD
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: // Reset the HC
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Wait for controller
to be ready for doorbell rings
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Reset complete
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Enabling 64-bit DMA addre=
sses.
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Calling HCD init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Starting xhci_init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: HCD page size set to 4K
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Device context base
array address =3D 0x0x000000100167c000 (DMA), 00000000d042f7e3 (virt)
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Allocated command
ring at 0000000016f013a6
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: First segment DMA is
0x0x000000100167d000
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Allocating primary event =
ring
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Allocating 34
scratchpad buffers
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Ext Cap
000000001bef6947, port offset =3D 1, count =3D 14, revision =3D 0x2
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:1 PSIE:2 PLT:0
PFD:0 LP:0 PSIM:12
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:2 PSIE:1 PLT:0
PFD:0 LP:0 PSIM:1500
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:3 PSIE:2 PLT:0
PFD:0 LP:0 PSIM:480
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: xHCI 1.0: support
USB2 hardware lpm
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Ext Cap
00000000a5bcc554, port offset =3D 17, count =3D 8, revision =3D 0x3
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:4 PSIE:3 PLT:0
PFD:1 LP:0 PSIM:5
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:5 PSIE:3 PLT:0
PFD:1 LP:1 PSIM:10
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:6 PSIE:3 PLT:0
PFD:1 LP:1 PSIM:10
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:7 PSIE:3 PLT:0
PFD:1 LP:1 PSIM:20
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Found 14 USB 2.0
ports and 8 USB 3.0 ports.
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: xHC can handle at
most 64 device slots
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Setting Max device
slots reg =3D 0x40
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Setting command ring
address to 0x100167d001
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Doorbell array is
located at offset 0x3000 from cap regs base addr
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: // Write event ring
dequeue pointer, preserving EHB bit
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Finished xhci_init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Called HCD init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: hcc params
0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Got SBRN 50
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: MWI active
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Finished xhci_pci_reinit
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: supports USB remote wakeu=
p
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: xhci_run
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: ERST deq =3D 64'h100167e0=
00
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Finished xhci_run for mai=
n hcd
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: xHCI Host Controller
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: new USB bus
registered, assigned bus number 4
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Host supports USB
3.2 Enhanced SuperSpeed
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: supports USB remote wakeu=
p
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Enable interrupts
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Enable primary interrupte=
r
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: // Turn on HC, cmd =3D 0x=
5.
[Fri May  1 09:46:41 2026] DMAR: DRHD: handling fault status reg 2
[Fri May  1 09:46:41 2026] DMAR: [DMA Read NO_PASID] Request device
[80:14.0] fault addr 0x1001680000 [fault reason 0x39] SM: Present bit
in Root Entry is clear
[Fri May  1 09:46:41 2026] usb usb3: default language 0x0409
[Fri May  1 09:46:41 2026] usb usb3: udev 1, busnum 3, minor =3D 256
[Fri May  1 09:46:41 2026] usb usb3: New USB device found,
idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D 7.00
[Fri May  1 09:46:41 2026] usb usb3: New USB device strings: Mfr=3D3,
Product=3D2, SerialNumber=3D1
[Fri May  1 09:46:41 2026] usb usb3: Product: xHCI Host Controller
[Fri May  1 09:46:41 2026] usb usb3: Manufacturer: Linux 7.0.0-clean xhci-h=
cd
[Fri May  1 09:46:41 2026] usb usb3: SerialNumber: 0000:80:14.0
[Fri May  1 09:46:41 2026] usb usb3: usb_probe_device
[Fri May  1 09:46:41 2026] usb usb3: configuration #1 chosen from 1 choice
[Fri May  1 09:46:41 2026] xHCI xhci_add_endpoint called for root hub
[Fri May  1 09:46:41 2026] xHCI xhci_check_bandwidth called for root hub
[Fri May  1 09:46:41 2026] usb usb3: adding 3-0:1.0 (config #1, interface 0=
)
[Fri May  1 09:46:41 2026] hub 3-0:1.0: usb_probe_interface
[Fri May  1 09:46:41 2026] hub 3-0:1.0: usb_probe_interface - got id
[Fri May  1 09:46:41 2026] hub 3-0:1.0: USB hub found
[Fri May  1 09:46:41 2026] hub 3-0:1.0: 14 ports detected
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: Get port status 2-1
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: Get port status 2-2
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: set port remote wake
mask, actual port 2-1 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: set port remote wake
mask, actual port 2-2 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] hub 2-0:1.0: hub_suspend
[Fri May  1 09:46:41 2026] usb usb2: bus auto-suspend, wakeup 1
[Fri May  1 09:46:41 2026] usb usb2: suspend raced with wakeup event
[Fri May  1 09:46:41 2026] usb usb2: usb auto-resume
[Fri May  1 09:46:41 2026] hub 3-0:1.0: standalone hub
[Fri May  1 09:46:41 2026] hub 3-0:1.0: no power switching (usb 1.0)
[Fri May  1 09:46:41 2026] hub 3-0:1.0: individual port over-current protec=
tion
[Fri May  1 09:46:41 2026] hub 3-0:1.0: Single TT
[Fri May  1 09:46:41 2026] hub 3-0:1.0: TT requires at most 8 FS bit
times (666 ns)
[Fri May  1 09:46:41 2026] hub 3-0:1.0: power on to power good time: 20ms
[Fri May  1 09:46:41 2026] hub 3-0:1.0: local power source is good
[Fri May  1 09:46:41 2026] usb usb3-port14: DeviceRemovable is changed
to 1 according to platform information.
[Fri May  1 09:46:41 2026] hub 3-0:1.0: trying to enable port power on
non-switchable hub
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-1
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-2
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-3
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-4
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-5
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-6
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-7
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-8
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-9
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-10
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-11
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-12
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-13
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 3-14
ON, portsc: 0x206e1
[Fri May  1 09:46:41 2026] usb usb4: skipped 1 descriptor after endpoint
[Fri May  1 09:46:41 2026] usb usb4: default language 0x0409
[Fri May  1 09:46:41 2026] usb usb4: udev 1, busnum 4, minor =3D 384
[Fri May  1 09:46:41 2026] usb usb4: New USB device found,
idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D 7.00
[Fri May  1 09:46:41 2026] hub 2-0:1.0: hub_resume
[Fri May  1 09:46:41 2026] usb usb4: New USB device strings: Mfr=3D3,
Product=3D2, SerialNumber=3D1
[Fri May  1 09:46:41 2026] usb usb4: Product: xHCI Host Controller
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-1
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-2
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-3
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-4
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-5
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-6
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-7
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-8
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-9
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-10
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-11
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-12
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-13
read: 0x2a0, return 0x100
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-14
read: 0x206e1, return 0x10101
[Fri May  1 09:46:41 2026] usb usb3-port14: status 0101 change 0001
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: clear port14 connect
change, portsc: 0x6e1
[Fri May  1 09:46:41 2026] usb usb4: Manufacturer: Linux 7.0.0-clean xhci-h=
cd
[Fri May  1 09:46:41 2026] usb usb4: SerialNumber: 0000:80:14.0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: Get port status 2-1
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: Get port status 2-2
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
[Fri May  1 09:46:41 2026] usb usb4: usb_probe_device
[Fri May  1 09:46:41 2026] usb usb4: configuration #1 chosen from 1 choice
[Fri May  1 09:46:41 2026] xHCI xhci_add_endpoint called for root hub
[Fri May  1 09:46:41 2026] xHCI xhci_check_bandwidth called for root hub
[Fri May  1 09:46:41 2026] usb usb4: adding 4-0:1.0 (config #1, interface 0=
)
[Fri May  1 09:46:41 2026] hub 4-0:1.0: usb_probe_interface
[Fri May  1 09:46:41 2026] hub 4-0:1.0: usb_probe_interface - got id
[Fri May  1 09:46:41 2026] hub 4-0:1.0: USB hub found
[Fri May  1 09:46:41 2026] hub 4-0:1.0: 8 ports detected
[Fri May  1 09:46:41 2026] hub 4-0:1.0: standalone hub
[Fri May  1 09:46:41 2026] hub 4-0:1.0: no power switching (usb 1.0)
[Fri May  1 09:46:41 2026] hub 4-0:1.0: individual port over-current protec=
tion
[Fri May  1 09:46:41 2026] hub 4-0:1.0: TT requires at most 8 FS bit
times (666 ns)
[Fri May  1 09:46:41 2026] hub 4-0:1.0: power on to power good time: 100ms
[Fri May  1 09:46:41 2026] hub 4-0:1.0: local power source is good
[Fri May  1 09:46:41 2026] usb usb4-port1: peered to usb3-port9
[Fri May  1 09:46:41 2026] usb usb4-port2: peered to usb3-port12
[Fri May  1 09:46:41 2026] usb usb4-port3: peered to usb3-port8
[Fri May  1 09:46:41 2026] usb usb4-port4: peered to usb3-port7
[Fri May  1 09:46:41 2026] usb usb4-port5: peered to usb3-port10
[Fri May  1 09:46:41 2026] usb usb4-port6: peered to usb3-port3
[Fri May  1 09:46:41 2026] usb usb4-port7: peered to usb3-port4
[Fri May  1 09:46:41 2026] usb usb4-port8: peered to usb3-port5
[Fri May  1 09:46:41 2026] usb usb4: port-1 no _DSM function 5
[Fri May  1 09:46:41 2026] usb usb4: port-1 disable U1/U2 _DSM: -19
[Fri May  1 09:46:41 2026] usb usb4: port-2 no _DSM function 5
[Fri May  1 09:46:41 2026] usb usb4: port-2 disable U1/U2 _DSM: -19
[Fri May  1 09:46:41 2026] usb usb4: port-3 no _DSM function 5
[Fri May  1 09:46:41 2026] usb usb4: port-3 disable U1/U2 _DSM: -19
[Fri May  1 09:46:41 2026] usb usb4: port-4 no _DSM function 5
[Fri May  1 09:46:41 2026] usb usb4: port-4 disable U1/U2 _DSM: -19
[Fri May  1 09:46:41 2026] usb usb4: port-5 no _DSM function 5
[Fri May  1 09:46:41 2026] usb usb4: port-5 disable U1/U2 _DSM: -19
[Fri May  1 09:46:41 2026] usb usb4: port-6 no _DSM function 5
[Fri May  1 09:46:41 2026] usb usb4: port-6 disable U1/U2 _DSM: -19
[Fri May  1 09:46:41 2026] usb usb4: port-7 no _DSM function 5
[Fri May  1 09:46:41 2026] usb usb4: port-7 disable U1/U2 _DSM: -19
[Fri May  1 09:46:41 2026] usb usb4: port-8 no _DSM function 5
[Fri May  1 09:46:41 2026] usb usb4: port-8 disable U1/U2 _DSM: -19
[Fri May  1 09:46:41 2026] hub 4-0:1.0: trying to enable port power on
non-switchable hub
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 4-1
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 4-2
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 4-3
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 4-4
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 4-5
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 4-6
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 4-7
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port power 4-8
ON, portsc: 0x2a0
[Fri May  1 09:46:41 2026] usbcore: registered new interface driver
usbserial_generic
[Fri May  1 09:46:41 2026] usbserial: USB Serial support registered for gen=
eric
[Fri May  1 09:46:41 2026] hub 3-0:1.0: state 7 ports 14 chg 4000 evt 0000
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 3-14
read: 0x6e1, return 0x101
[Fri May  1 09:46:41 2026] usb usb3-port14: status 0101, change 0000, 12 Mb=
/s
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-1
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-2
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-3
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-4
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-5
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-6
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-7
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-8
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] hub 4-0:1.0: state 7 ports 8 chg 0000 evt 0000
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-1 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-2 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-3 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-4 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-5 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-6 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-7 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-8 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] hub 4-0:1.0: hub_suspend
[Fri May  1 09:46:41 2026] usb usb4: bus auto-suspend, wakeup 1
[Fri May  1 09:46:41 2026] usb usb4: suspend raced with wakeup event
[Fri May  1 09:46:41 2026] usb usb4: usb auto-resume
[Fri May  1 09:46:41 2026] hub 4-0:1.0: hub_resume
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-1
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-2
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-3
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-4
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-5
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-6
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-7
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-8
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] hub 4-0:1.0: state 7 ports 8 chg 0000 evt 0000
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: set port remote wake
mask, actual port 2-1 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: set port remote wake
mask, actual port 2-2 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] hub 2-0:1.0: hub_suspend
[Fri May  1 09:46:41 2026] usb usb2: bus auto-suspend, wakeup 1
[Fri May  1 09:46:41 2026] usb usb2: suspend raced with wakeup event
[Fri May  1 09:46:41 2026] usb usb2: usb auto-resume
[Fri May  1 09:46:41 2026] hub 2-0:1.0: hub_resume
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: Get port status 2-1
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: Get port status 2-2
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-1 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-2 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-3 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-4 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-5 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-6 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-7 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-8 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] hub 4-0:1.0: hub_suspend
[Fri May  1 09:46:41 2026] usb usb4: bus auto-suspend, wakeup 1
[Fri May  1 09:46:41 2026] usb usb4: suspend raced with wakeup event
[Fri May  1 09:46:41 2026] usb usb4: usb auto-resume
[Fri May  1 09:46:41 2026] hub 4-0:1.0: hub_resume
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-1
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-2
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-3
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-4
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-5
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-6
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-7
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Get port status 4-8
read: 0x2a0, return 0x2a0
[Fri May  1 09:46:41 2026] hub 4-0:1.0: state 7 ports 8 chg 0000 evt 0000
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: set port remote wake
mask, actual port 2-1 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: set port remote wake
mask, actual port 2-2 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] hub 2-0:1.0: hub_suspend
[Fri May  1 09:46:41 2026] usb usb2: bus auto-suspend, wakeup 1
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0:
xhci_hub_status_data: stopping usb2 port polling
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: config port 2-1 wake
bits, portsc: 0xa0002a0, write: 0xa0202a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: config port 2-2 wake
bits, portsc: 0xa0002a0, write: 0xa0202a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: config port 1-1 wake
bits, portsc: 0xa0002a0, write: 0xa0202a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: xhci_suspend:
stopping usb1 port polling.
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: Setting command ring
address to 0x10015f8001
[Fri May  1 09:46:41 2026] xhci_hcd 0000:00:0d.0: hcd_pci_runtime_suspend: =
0
[Fri May  1 09:46:41 2026] i8042: PNP: No PS/2 controller found.
[Fri May  1 09:46:41 2026] mousedev: PS/2 mouse device common for all mice
[Fri May  1 09:46:41 2026] rtc_cmos rtc_cmos: RTC can wake from S4
[Fri May  1 09:46:41 2026] rtc_cmos rtc_cmos: registered as rtc0
[Fri May  1 09:46:41 2026] rtc_cmos rtc_cmos: setting system clock to
2026-05-01T09:46:41 UTC (1777628801)
[Fri May  1 09:46:41 2026] rtc_cmos rtc_cmos: alarms up to one month,
y3k, 114 bytes nvram
[Fri May  1 09:46:41 2026] intel_pstate: HWP enabled by BIOS
[Fri May  1 09:46:41 2026] intel_pstate: Intel P-state driver initializing
[Fri May  1 09:46:41 2026] Hybrid CPU capacity scaling enabled
[Fri May  1 09:46:41 2026] processor cpu0: EM: created perf domain
[Fri May  1 09:46:41 2026] intel_pstate: HWP enabled
[Fri May  1 09:46:41 2026] hid: raw HID events driver (C) Jiri Kosina
[Fri May  1 09:46:41 2026] usbcore: registered new interface driver usbhid
[Fri May  1 09:46:41 2026] usbhid: USB HID core driver
[Fri May  1 09:46:41 2026] drop_monitor: Initializing network drop
monitor service
[Fri May  1 09:46:41 2026] Initializing XFRM netlink socket
[Fri May  1 09:46:41 2026] NET: Registered PF_INET6 protocol family
[Fri May  1 09:46:41 2026] Segment Routing with IPv6
[Fri May  1 09:46:41 2026] In-situ OAM (IOAM) with IPv6
[Fri May  1 09:46:41 2026] NET: Registered PF_PACKET protocol family
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-1 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-2 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-3 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-4 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-5 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-6 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-7 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: set port remote wake
mask, actual port 4-8 status  =3D 0xe0002a0
[Fri May  1 09:46:41 2026] hub 4-0:1.0: hub_suspend
[Fri May  1 09:46:41 2026] usb usb4: bus auto-suspend, wakeup 1
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0:
xhci_hub_status_data: stopping usb4 port polling
[Fri May  1 09:46:41 2026] mpls_gso: MPLS GSO support
[Fri May  1 09:46:41 2026] mce: Unable to init MCE device (rc: -5)
[Fri May  1 09:46:41 2026] microcode: Current revision: 0x0000011b
[Fri May  1 09:46:41 2026] IPI shorthand broadcast: enabled
[Fri May  1 09:46:41 2026] sched_clock: Marking stable (7848000635,
76426096)->(7958222697, -33795966)
[Fri May  1 09:46:41 2026] registered taskstats version 1
[Fri May  1 09:46:41 2026] Loading compiled-in X.509 certificates
[Fri May  1 09:46:41 2026] Loaded X.509 cert 'Build time autogenerated
kernel key: 2fabb652f04b42abf1ff4a5783ae735b5aa5a2ce'
[Fri May  1 09:46:41 2026] Demotion targets for Node 0: null
[Fri May  1 09:46:41 2026] page_owner is disabled
[Fri May  1 09:46:41 2026] Key type .fscrypt registered
[Fri May  1 09:46:41 2026] Key type fscrypt-provisioning registered
[Fri May  1 09:46:41 2026] Key type big_key registered
[Fri May  1 09:46:41 2026] Key type trusted registered
[Fri May  1 09:46:41 2026] Key type encrypted registered
[Fri May  1 09:46:41 2026] Loading compiled-in module X.509 certificates
[Fri May  1 09:46:41 2026] Loaded X.509 cert 'Build time autogenerated
kernel key: 2fabb652f04b42abf1ff4a5783ae735b5aa5a2ce'
[Fri May  1 09:46:41 2026] ima: Allocated hash algorithm: sha256
[Fri May  1 09:46:41 2026] ima: No architecture policies found
[Fri May  1 09:46:41 2026] evm: Initialising EVM extended attributes:
[Fri May  1 09:46:41 2026] evm: security.selinux
[Fri May  1 09:46:41 2026] evm: security.SMACK64 (disabled)
[Fri May  1 09:46:41 2026] evm: security.SMACK64EXEC (disabled)
[Fri May  1 09:46:41 2026] evm: security.SMACK64TRANSMUTE (disabled)
[Fri May  1 09:46:41 2026] evm: security.SMACK64MMAP (disabled)
[Fri May  1 09:46:41 2026] evm: security.apparmor (disabled)
[Fri May  1 09:46:41 2026] evm: security.ima
[Fri May  1 09:46:41 2026] evm: security.capability
[Fri May  1 09:46:41 2026] evm: HMAC attrs: 0x1
[Fri May  1 09:46:41 2026] Running certificate verification RSA selftest
[Fri May  1 09:46:41 2026] Loaded X.509 cert 'Certificate verification
self-testing key: f58703bb33ce1b73ee02eccdee5b8817518fe3db'
[Fri May  1 09:46:41 2026] Running certificate verification ECDSA selftest
[Fri May  1 09:46:41 2026] Loaded X.509 cert 'Certificate verification
ECDSA self-testing key: 2900bcea1deb7bc8479a84a23d758efdfdd2b2d3'
[Fri May  1 09:46:42 2026] clk: Disabling unused clocks
[Fri May  1 09:46:42 2026] PM: genpd: Disabling unused power domains
[Fri May  1 09:46:42 2026] Freeing unused decrypted memory: 2036K
[Fri May  1 09:46:42 2026] Freeing unused kernel image (initmem) memory: 44=
04K
[Fri May  1 09:46:42 2026] Write protecting the kernel read-only data: 2867=
2k
[Fri May  1 09:46:42 2026] Freeing unused kernel image (text/rodata
gap) memory: 820K
[Fri May  1 09:46:42 2026] Freeing unused kernel image (rodata/data
gap) memory: 1392K
[Fri May  1 09:46:42 2026] x86/mm: Checked W+X mappings: passed, no
W+X pages found.
[Fri May  1 09:46:42 2026] Run /init as init process
[Fri May  1 09:46:42 2026]   with arguments:
[Fri May  1 09:46:42 2026]     /init
[Fri May  1 09:46:42 2026]     nokaslr
[Fri May  1 09:46:42 2026]   with environment:
[Fri May  1 09:46:42 2026]     HOME=3D/
[Fri May  1 09:46:42 2026]     TERM=3Dlinux
[Fri May  1 09:46:42 2026]     disable_cpu_apicid=3D0
[Fri May  1 09:46:42 2026] loop: module loaded
[Fri May  1 09:46:42 2026] loop0: detected capacity change from 0 to 271624
[Fri May  1 09:46:42 2026] erofs (device loop0): mounted with root
inode @ nid 37.
[Fri May  1 09:46:42 2026] overlayfs: upper fs does not support RENAME_WHIT=
EOUT.
[Fri May  1 09:46:42 2026] overlayfs: failed to set xattr on upper
[Fri May  1 09:46:42 2026] overlayfs: ...falling back to uuid=3Dnull.
[Fri May  1 09:46:43 2026] typec port0: bound usb2-port1 (ops connector_ops=
)
[Fri May  1 09:46:43 2026] typec port0: bound usb4_port1 (ops connector_ops=
)
[Fri May  1 09:46:43 2026] typec port0: bound usb3-port1 (ops connector_ops=
)
[Fri May  1 09:46:43 2026] systemd[1]: RTC configured in localtime,
applying delta of -240 minutes to system time.
[Fri May  1 09:46:44 2026] systemd[1]: Successfully made /usr/ read-only.
[Fri May  1 09:46:44 2026] systemd[1]: systemd 257-24.el10-ge0fd51b
running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +IPE
+SMACK +SECCOMP -GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS
+FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS
+LIBFDISK +PCRE2 +PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ
+ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP +SYSVINIT
+LIBARCHIVE)
[Fri May  1 09:46:44 2026] systemd[1]: Detected architecture x86-64.
[Fri May  1 09:46:44 2026] systemd[1]: Running in initrd.
[Fri May  1 09:46:44 2026] systemd[1]: Hostname set to <FQDN>.
[Fri May  1 09:46:44 2026] systemd[1]: bpf-restrict-fs: Failed to load
BPF object: No such process
[Fri May  1 09:46:44 2026] typec port1: bound usb2-port2 (ops connector_ops=
)
[Fri May  1 09:46:44 2026] typec port1: bound usb4_port3 (ops connector_ops=
)
[Fri May  1 09:46:44 2026] typec port1: bound usb3-port6 (ops connector_ops=
)
[Fri May  1 09:46:44 2026] systemd[1]: Queued start job for default
target initrd.target.
[Fri May  1 09:46:44 2026] systemd[1]: Started
systemd-ask-password-console.path - Dispatch Password Requests to
Console Directory Watch.
[Fri May  1 09:46:44 2026] systemd[1]: Expecting device
dev-mapper-rhel_intel\x2d\x2darrowlake\x2d\x2ds\x2d\x2d01\x2droot.device
- /dev/mapper/rhel_intel--arrowlake--s--01-root...
[Fri May  1 09:46:44 2026] systemd[1]: Reached target
initrd-usr-fs.target - Initrd /usr File System.
[Fri May  1 09:46:44 2026] systemd[1]: Reached target paths.target - Path U=
nits.
[Fri May  1 09:46:44 2026] systemd[1]: Reached target slices.target -
Slice Units.
[Fri May  1 09:46:44 2026] systemd[1]: Reached target swap.target - Swaps.
[Fri May  1 09:46:44 2026] systemd[1]: Reached target timers.target -
Timer Units.
[Fri May  1 09:46:44 2026] systemd[1]: Listening on
systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[Fri May  1 09:46:44 2026] systemd[1]: Listening on
systemd-journald.socket - Journal Sockets.
[Fri May  1 09:46:44 2026] systemd[1]: Listening on
systemd-udevd-control.socket - udev Control Socket.
[Fri May  1 09:46:44 2026] systemd[1]: Listening on
systemd-udevd-kernel.socket - udev Kernel Socket.
[Fri May  1 09:46:44 2026] systemd[1]: Reached target sockets.target -
Socket Units.
[Fri May  1 09:46:44 2026] systemd[1]: Starting
kmod-static-nodes.service - Create List of Static Device Nodes...
[Fri May  1 09:46:44 2026] systemd[1]: memstrack.service - Memstrack
Anylazing Service was skipped because no trigger condition checks were
met.
[Fri May  1 09:46:45 2026] systemd[1]: Starting
systemd-battery-check.service - Check battery level during early
boot...
[Fri May  1 09:46:45 2026] systemd[1]: Starting
systemd-journald.service - Journal Service...
[Fri May  1 09:46:45 2026] systemd-journald[122]: Collecting audit
messages is disabled.
[Fri May  1 09:46:45 2026] systemd[1]: Starting
systemd-modules-load.service - Load Kernel Modules...
[Fri May  1 09:46:45 2026] systemd[1]: systemd-pcrphase-initrd.service
- TPM PCR Barrier (initrd) was skipped because of an unmet condition
check (ConditionSecurity=3Dmeasured-uki).
[Fri May  1 09:46:45 2026] systemd[1]: Starting
systemd-vconsole-setup.service - Virtual Console Setup...
[Fri May  1 09:46:45 2026] i2c_dev: i2c /dev entries driver
[Fri May  1 09:46:45 2026] systemd[1]: Started
systemd-journald.service - Journal Service.
[Fri May  1 09:46:45 2026] evm: overlay not supported
[Fri May  1 09:46:46 2026] device-mapper: core:
CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will
not be recorded in the IMA log.
[Fri May  1 09:46:46 2026] device-mapper: uevent: version 1.0.3
[Fri May  1 09:46:46 2026] device-mapper: ioctl: 4.50.0-ioctl
(2025-04-28) initialised: dm-devel@lists.linux.dev
[Fri May  1 09:46:46 2026] gpio gpiochip1: line cnt 592 is greater
than fast path cnt 512
[Fri May  1 09:46:46 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:46:46 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:46:46 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:46:46 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:46:46 2026] intel_vpu 0000:00:0b.0: [drm] Firmware:
intel/vpu/vpu_37xx_v1.bin, version:
20251113*MTL_CLIENT_SILICON-NVR+NN-deployment*72f907ffc780df5579a2fed65afc4=
944da8b0e44*72f907ffc780df5579a2fed65afc4944da8b0e44*72f907ffc78
[Fri May  1 09:46:46 2026] intel_vpu 0000:00:0b.0: [drm] Scheduler mode: HW
[Fri May  1 09:46:46 2026] Key type psk registered
[Fri May  1 09:46:46 2026] pxa2xx-spi pxa2xx-spi.7: no DMA channels
available, using PIO
[Fri May  1 09:46:46 2026] nvme 0000:01:00.0: platform quirk: setting
simple suspend
[Fri May  1 09:46:46 2026] nvme nvme0: pci function 0000:01:00.0
[Fri May  1 09:46:47 2026] nvme nvme0: D3 entry latency set to 10 seconds
[Fri May  1 09:46:47 2026] nvme nvme0: 1/0/0 default/read/poll queues
[Fri May  1 09:46:47 2026]  nvme0n1: p1 p2 p3
[Fri May  1 09:46:47 2026] [drm] Initialized intel_vpu 1.0.0 for
0000:00:0b.0 on minor 0
[Fri May  1 09:46:51 2026] i915 0000:00:02.0: [drm] Found meteorlake
(device ID 7d67) integrated display version 14.00 stepping D0
[Fri May  1 09:46:51 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:46:51 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:46:51 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:46:51 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:46:51 2026] i915 0000:00:02.0: [drm] VT-d active for gfx acc=
ess
[Fri May  1 09:46:51 2026] i915 0000:00:02.0: vgaarb: deactivate vga consol=
e
[Fri May  1 09:46:51 2026] i915 0000:00:02.0: [drm] Using Transparent Hugep=
ages
[Fri May  1 09:46:51 2026] i915 0000:00:02.0: [drm] *ERROR* DC state
mismatch (0x0 -> 0x2)
[Fri May  1 09:46:51 2026] i915 0000:00:02.0: vgaarb: VGA decodes
changed: olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
[Fri May  1 09:46:51 2026] i915 0000:00:02.0: [drm] Finished loading
DMC firmware i915/mtl_dmc.bin (v2.23)
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] [ENCODER:505:DDI
A/PHY A] failed to retrieve link info, disabling eDP
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] GT0: GuC firmware
i915/mtl_guc_70.bin version 70.53.0
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] GT0: GUC: submission en=
abled
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] GT1: GuC firmware
i915/mtl_guc_70.bin version 70.53.0
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] GT1: HuC firmware
i915/mtl_huc_gsc.bin version 8.5.4
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] GT1: GUC: submission en=
abled
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] GT1: GUC: SLPC enabled
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] GT1: GUC: RC enabled
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] Protected Xe Path
(PXP) protected content support initialized
[Fri May  1 09:46:53 2026] [drm] Initialized i915 1.6.0 for
0000:00:02.0 on minor 0
[Fri May  1 09:46:53 2026] ACPI: video: Video Device [GFX0]
(multi-head: yes  rom: no  post: no)
[Fri May  1 09:46:53 2026] input: Video Bus as
/devices/pci0000:00/acpi.video_bus.0/input/input3
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] Cannot find any
crtc or sizes
[Fri May  1 09:46:53 2026] pci 0000:02:00.0: enabling device (0000 -> 0002)
[Fri May  1 09:46:53 2026] pci 0000:03:01.0: enabling device (0000 -> 0002)
[Fri May  1 09:46:53 2026] i915 0000:00:02.0: [drm] Cannot find any
crtc or sizes
[Fri May  1 09:46:53 2026] xe 0000:04:00.0: enabling device (0000 -> 0002)
[Fri May  1 09:46:53 2026] xe 0000:04:00.0: [drm] unbounded parent pci
bridge, device won't support any PM support.
[Fri May  1 09:46:53 2026] xe 0000:04:00.0: [drm] Found battlemage
(device ID e223) discrete display version 14.01 stepping C0
[Fri May  1 09:46:53 2026] xe 0000:04:00.0: [drm] VISIBLE VRAM:
0x000000a000000000, 0x0000000800000000
[Fri May  1 09:46:53 2026] xe 0000:04:00.0: [drm] VRAM[0]: Actual
physical size 0x0000000800000000, usable size exclude stolen
0x00000007f9000000, CPU accessible size 0x00000007f9000000
[Fri May  1 09:46:53 2026] xe 0000:04:00.0: [drm] VRAM[0]: DPA range:
[0x0000000000000000-800000000], io range:
[0x000000a000000000-a7f9000000]
[Fri May  1 09:46:53 2026] xe 0000:04:00.0: [drm] VRAM[0]: Actual
physical size 0x0000000800000000, usable size exclude stolen
0x00000007f9000000, CPU accessible size 0x00000007f9000000
[Fri May  1 09:46:53 2026] xe 0000:04:00.0: [drm] VRAM[0]: DPA range:
[0x0000000000000000-800000000], io range:
[0x000000a000000000-a7f9000000]
[Fri May  1 09:46:53 2026] xe 0000:04:00.0: [drm] Finished loading DMC
firmware i915/bmg_dmc.bin (v2.6)
[Fri May  1 09:46:53 2026] xe 0000:04:00.0: [drm] Tile0: GT0: Using
GuC firmware from xe/bmg_guc_70.bin version 70.55.3
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT0: ccs1 fused of=
f
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT0: ccs2 fused of=
f
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT0: ccs3 fused of=
f
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT1: Using
GuC firmware from xe/bmg_guc_70.bin version 70.55.3
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT1: Using
HuC firmware from xe/bmg_huc.bin version 8.2.10
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT1: vcs1 fused of=
f
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT1: vcs3 fused of=
f
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT1: vcs4 fused of=
f
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT1: vcs5 fused of=
f
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT1: vcs6 fused of=
f
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT1: vcs7 fused of=
f
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT1: vecs2 fused o=
ff
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Tile0: GT1: vecs3 fused o=
ff
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Can't init xe mei
late bind missing mei component
[Fri May  1 09:46:54 2026] [drm] Initialized xe 1.1.0 for 0000:04:00.0
on minor 1
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Cannot find any crtc or s=
izes
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Using mailbox
commands for power limits
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] PL2 is supported on chann=
el 0
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Cannot find any crtc or s=
izes
[Fri May  1 09:46:54 2026] xe 0000:04:00.0: [drm] Cannot find any crtc or s=
izes
[Fri May  1 09:46:56 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:46:56 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:46:56 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:46:56 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:02 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:02 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:02 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:02 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:07 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:07 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:07 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:07 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:12 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:12 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:12 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:12 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:17 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:17 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:17 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:17 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:22 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:22 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:22 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:22 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:27 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:27 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:27 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:27 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:32 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:32 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:32 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:32 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:37 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:37 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:37 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:37 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:42 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:42 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:42 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:42 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:48 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:48 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:48 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:48 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:53 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:53 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:53 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:53 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:47:58 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:47:58 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:47:58 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:47:58 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:03 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:03 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:03 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:03 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:08 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:08 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:08 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:08 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:13 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:13 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:13 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:13 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:18 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:18 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:18 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:18 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:23 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:23 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:23 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:23 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:29 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:29 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:29 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:29 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:34 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:34 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:34 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:34 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:39 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:39 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:39 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:39 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:44 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:44 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:44 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:44 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:49 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:49 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:49 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:49 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:54 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:54 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:54 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:54 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:48:59 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:48:59 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:48:59 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:48:59 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:04 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:49:04 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:49:04 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:49:04 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:10 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:49:10 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:49:10 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:49:10 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:15 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:49:15 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:49:15 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:49:15 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:20 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:49:20 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:49:20 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:49:20 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:25 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:49:25 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:49:25 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:49:25 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:30 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:49:30 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:49:30 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:49:30 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:35 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:49:35 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:49:35 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:49:35 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:40 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:49:40 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:49:40 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:49:40 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:45 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:49:45 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:49:45 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:49:45 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:50 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:49:50 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:49:50 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:49:50 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:56 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:49:56 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:49:56 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:49:56 2026] xhci_hcd 0000:80:14.0: // Ding dong!
[Fri May  1 09:49:58 2026] SGI XFS with ACLs, security attributes,
scrub, quota, no debug enabled
[Fri May  1 09:49:58 2026] XFS (dm-0): Mounting V5 Filesystem
02a3398d-033b-4d71-a1be-005b520abf57
[Fri May  1 09:49:58 2026] XFS (dm-0): Starting recovery (logdev: internal)
[Fri May  1 09:49:58 2026] XFS (dm-0): Ending recovery (logdev: internal)
[Fri May  1 09:50:01 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Fri May  1 09:50:01 2026] xhci_hcd 0000:80:14.0: Command timeout on
stopped ring
[Fri May  1 09:50:01 2026] xhci_hcd 0000:80:14.0: Turn aborted command
0000000020833431 to no-op
[Fri May  1 09:50:01 2026] xhci_hcd 0000:80:14.0: // Ding dong!
May 01 09:46:45 FQDN systemd-journald[122]: Journal started
May 01 09:46:45 FQDN systemd-journald[122]: Runtime Journal
(/run/log/journal/ebcac80e44f54ba8a2d6adcebe7f9332) is 8M, max 107.4M,
99.4M free.
May 01 09:46:45 FQDN systemd-modules-load[125]: Inserted module 'i2c_dev'
May 01 09:46:45 FQDN systemd-modules-load[125]: Module 'msr' is built in
May 01 09:46:45 FQDN systemd[1]: Finished kmod-static-nodes.service -
Create List of Static Device Nodes.
May 01 09:46:45 FQDN systemd[1]: Finished
systemd-battery-check.service - Check battery level during early boot.
May 01 09:46:45 FQDN systemd[1]: Finished systemd-modules-load.service
- Load Kernel Modules.
May 01 09:46:45 FQDN systemd[1]: Starting systemd-sysctl.service -
Apply Kernel Variables...
May 01 09:46:45 FQDN systemd[1]: Starting
systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes
in /dev gracefully...
May 01 09:46:45 FQDN systemd[1]: Finished systemd-sysctl.service -
Apply Kernel Variables.
May 01 09:46:45 FQDN systemd-vconsole-setup[128]: setfont: ERROR
kdfontop.c:183 put_font_kdfontop: Unable to load such font with such
kernel version
May 01 09:46:45 FQDN systemd-vconsole-setup[126]: /usr/bin/setfont
failed with a "system error" (EX_OSERR), ignoring.
May 01 09:46:45 FQDN systemd-vconsole-setup[126]: Setting source
virtual console failed, ignoring remaining ones.
May 01 09:46:45 FQDN systemd[1]: Finished
systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes
in /dev gracefully.
May 01 09:46:45 FQDN systemd[1]: Finished
systemd-vconsole-setup.service - Virtual Console Setup.
May 01 09:46:45 FQDN systemd[1]: Starting dracut-cmdline-ask.service -
dracut ask for additional cmdline parameters...
May 01 09:46:45 FQDN systemd[1]: Starting systemd-sysusers.service -
Create System Users...
May 01 09:46:45 FQDN systemd-sysusers[142]: Creating group 'nobody'
with GID 65534.
May 01 09:46:45 FQDN systemd-sysusers[142]: Creating group 'users' with GID=
 100.
May 01 09:46:45 FQDN systemd-sysusers[142]: Creating group
'systemd-journal' with GID 190.
May 01 09:46:45 FQDN systemd-sysusers[142]: Creating group 'tss' with GID 5=
9.
May 01 09:46:45 FQDN systemd-sysusers[142]: Creating user 'tss'
(Account used for TPM access) with UID 59 and GID 59.
May 01 09:46:45 FQDN systemd[1]: Finished systemd-sysusers.service -
Create System Users.
May 01 09:46:45 FQDN systemd[1]: Finished dracut-cmdline-ask.service -
dracut ask for additional cmdline parameters.
May 01 09:46:45 FQDN systemd[1]: Starting dracut-cmdline.service -
dracut cmdline hook...
May 01 09:46:45 FQDN systemd[1]: Starting
systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in
/dev...
May 01 09:46:45 FQDN dracut-cmdline[154]: dracut-107-4.el10
May 01 09:46:45 FQDN dracut-cmdline[154]: Using kernel command line
parameters:  rd.lvm.lv=3Drhel_intel-arrowlake-s-01/root
elfcorehdr=3D0xfff000000 BOOT_IMAGE=3D/vmlinuz-7.0.0-clean ro
resume=3DUUID=3D64db6567-0caf-4678-8399-0b196e43b3f3
console=3DttyS1,115200n81 usbcore.dyndbg=3D+p xhci_hcd.dyndbg=3D+p
xhci_pci.dyndbg=3D+p thunderbolt.dyndbg=3D+p novmcoredd hugetlb_cma=3D0
kfence.sample_interval=3D0 initramfs_options=3Dsize=3D90% irqpoll nr_cpus=
=3D1
reset_devices cgroup_disable=3Dmemory mce=3Doff numa=3Doff
udev.children-max=3D2 panic=3D10 acpi_no_memhotplug
transparent_hugepage=3Dnever nokaslr hest_disable cma=3D0
pcie_ports=3Dcompat usbcore.dyndbg=3D+p xhci_hcd.dyndbg=3D+p
xhci_pci.dyndbg=3D+p disable_cpu_apicid=3D0 iTCO_wdt.pretimeout=3D0
rd.systemd.gpt_auto=3Dno
May 01 09:46:45 FQDN systemd[1]: Finished dracut-cmdline.service -
dracut cmdline hook.
May 01 09:46:45 FQDN systemd[1]: Starting dracut-pre-udev.service -
dracut pre-udev hook...
May 01 09:46:45 FQDN systemd[1]: Finished
systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in
/dev.
May 01 09:46:45 FQDN systemd[1]: Reached target local-fs-pre.target -
Preparation for Local File Systems.
May 01 09:46:45 FQDN systemd[1]: Reached target local-fs.target -
Local File Systems.
May 01 09:46:45 FQDN systemd[1]: Starting
systemd-tmpfiles-setup.service - Create System Files and
Directories...
May 01 09:46:45 FQDN systemd-tmpfiles[231]:
/usr/lib/tmpfiles.d/var.conf:14: Duplicate line for path "/var/log",
ignoring.
May 01 09:46:45 FQDN systemd[1]: Finished
systemd-tmpfiles-setup.service - Create System Files and Directories.
May 01 09:46:46 FQDN systemd[1]: Finished dracut-pre-udev.service -
dracut pre-udev hook.
May 01 09:46:46 FQDN systemd[1]: Starting systemd-udevd.service -
Rule-based Manager for Device Events and Files...
May 01 09:46:46 FQDN systemd-udevd[247]: Using default interface
naming scheme 'rhel-10.0'.
May 01 09:46:46 FQDN systemd[1]: Started systemd-udevd.service -
Rule-based Manager for Device Events and Files.
May 01 09:46:46 FQDN systemd[1]: dracut-pre-trigger.service - dracut
pre-trigger hook was skipped because no trigger condition checks were
met.
May 01 09:46:46 FQDN systemd[1]: Starting systemd-udev-trigger.service
- Coldplug All udev Devices...
May 01 09:46:46 FQDN systemd[1]: Created slice system-modprobe.slice -
Slice /system/modprobe.
May 01 09:46:46 FQDN systemd[1]: Starting modprobe@configfs.service -
Load Kernel Module configfs...
May 01 09:46:46 FQDN systemd[1]: Finished systemd-udev-trigger.service
- Coldplug All udev Devices.
May 01 09:46:46 FQDN systemd[1]: modprobe@configfs.service:
Deactivated successfully.
May 01 09:46:46 FQDN systemd[1]: Finished modprobe@configfs.service -
Load Kernel Module configfs.
May 01 09:46:46 FQDN systemd[1]: Reached target tpm2.target - Trusted
Platform Module.
May 01 09:46:46 FQDN systemd[1]: Starting dracut-initqueue.service -
dracut initqueue hook...
May 01 09:46:46 FQDN systemd[1]: Mounting sys-kernel-config.mount -
Kernel Configuration File System...
May 01 09:46:46 FQDN systemd[1]: Mounted sys-kernel-config.mount -
Kernel Configuration File System.
May 01 09:46:46 FQDN systemd[1]: Reached target sysinit.target -
System Initialization.
May 01 09:46:46 FQDN systemd[1]: Reached target basic.target - Basic System=
.
May 01 09:46:46 FQDN systemd[1]: System is tainted: local-hwclock
May 01 09:46:46 FQDN systemd[1]: systemd-vconsole-setup.service:
Deactivated successfully.
May 01 09:46:46 FQDN systemd[1]: Stopped
systemd-vconsole-setup.service - Virtual Console Setup.
May 01 09:46:46 FQDN systemd[1]: Stopping
systemd-vconsole-setup.service - Virtual Console Setup...
May 01 09:46:46 FQDN systemd[1]: Starting
systemd-vconsole-setup.service - Virtual Console Setup...
May 01 09:46:46 FQDN systemd-vconsole-setup[283]: setfont: ERROR
kdfontop.c:183 put_font_kdfontop: Unable to load such font with such
kernel version
May 01 09:46:46 FQDN systemd-vconsole-setup[281]: /usr/bin/setfont
failed with a "system error" (EX_OSERR), ignoring.
May 01 09:46:46 FQDN systemd-vconsole-setup[281]: Setting source
virtual console failed, ignoring remaining ones.
May 01 09:46:46 FQDN systemd[1]: Finished
systemd-vconsole-setup.service - Virtual Console Setup.
May 01 09:47:47 FQDN systemd-udevd[247]: usb3: Worker [260] processing
SEQNUM=3D2193 is taking a long time
May 01 09:48:46 FQDN dracut-initqueue[280]: Timed out while waiting
for udev queue to empty.
May 01 09:49:57 FQDN systemd-udevd[247]: usb3: Worker [260] processing
SEQNUM=3D2193 killed
May 01 09:49:57 FQDN systemd-udevd[247]: usb3: Worker [260] terminated
by signal 9 (KILL).
May 01 09:49:57 FQDN dracut-initqueue[350]: Scanning devices nvme0n1p3
for LVM logical volumes rhel_intel-arrowlake-s-01/root
May 01 09:49:57 FQDN dracut-initqueue[350]:
rhel_intel-arrowlake-s-01/root linear
May 01 09:49:57 FQDN systemd[1]: Found device
dev-mapper-rhel_intel\x2d\x2darrowlake\x2d\x2ds\x2d\x2d01\x2droot.device
- /dev/mapper/rhel_intel--arrowlake--s--01-root.
May 01 09:49:57 FQDN systemd[1]: Finished dracut-initqueue.service -
dracut initqueue hook.
May 01 09:49:57 FQDN systemd[1]: Reached target
initrd-root-device.target - Initrd Root Device.
May 01 09:49:57 FQDN systemd[1]: Reached target remote-fs-pre.target -
Preparation for Remote File Systems.
May 01 09:49:57 FQDN systemd[1]: Reached target remote-fs.target -
Remote File Systems.
May 01 09:49:57 FQDN systemd[1]: dracut-pre-mount.service - dracut
pre-mount hook was skipped because no trigger condition checks were
met.
May 01 09:49:57 FQDN systemd[1]: Starting systemd-fsck-root.service -
File System Check on /dev/mapper/rhel_intel--arrowlake--s--01-root...
May 01 09:49:57 FQDN systemd-fsck[388]: /usr/sbin/fsck.xfs: XFS file system=
.
May 01 09:49:57 FQDN systemd[1]: Finished systemd-fsck-root.service -
File System Check on /dev/mapper/rhel_intel--arrowlake--s--01-root.
May 01 09:49:57 FQDN systemd[1]: Mounting sysroot.mount - /sysroot...
May 01 09:49:58 FQDN systemd[1]: Mounted sysroot.mount - /sysroot.
May 01 09:49:58 FQDN systemd[1]: Reached target initrd-root-fs.target
- Initrd Root File System.
May 01 09:49:58 FQDN systemd[1]: initrd-parse-etc.service -
Mountpoints Configured in the Real Root was skipped because of an
unmet condition check (ConditionPathExists=3D!/proc/vmcore).
May 01 09:49:58 FQDN systemd[1]: Reached target initrd-fs.target -
Initrd File Systems.
May 01 09:49:58 FQDN systemd[1]: Reached target initrd.target - Initrd
Default Target.
May 01 09:49:58 FQDN systemd[1]: dracut-mount.service - dracut mount
hook was skipped because no trigger condition checks were met.
May 01 09:49:58 FQDN systemd[1]: Starting dracut-pre-pivot.service -
dracut pre-pivot and cleanup hook...
May 01 09:49:58 FQDN systemd[1]: Finished dracut-pre-pivot.service -
dracut pre-pivot and cleanup hook.
May 01 09:49:58 FQDN systemd[1]: Starting kdump-capture.service -
Kdump Vmcore Save Service...
May 01 09:49:58 FQDN kdump[433]: Kdump is using the default log level(3).
May 01 09:49:59 FQDN kdump[550]: saving to
/sysroot/var/crash/127.0.0.1-2026-05-01-09:49:58/
May 01 09:49:59 FQDN kdump[555]: saving vmcore-dmesg.txt to
/sysroot/var/crash/127.0.0.1-2026-05-01-09:49:58/
May 01 09:49:59 FQDN kdump[561]: saving vmcore-dmesg.txt complete
May 01 09:49:59 FQDN kdump[563]: saving vmcore
May 01 09:50:02 FQDN kdump[568]: saving vmcore complete

###################

And after this, on the system's console:

[  208.789764] kdump[573]: saving the /run/initramfs/kexec-dmesg.log
to /sysroot/var/crash/127.0.0.1-2026-05-01-09:49:58///
[  208.801131] kdump[576]: Executing final action systemctl reboot -f
[  208.808123] systemd[1]: Reboot requested from client PID 577
('systemctl') (unit kdump-capture.service)...
[  208.820045] systemd[1]: Shutting down.
[  208.960314] systemd-shutdown[1]: Syncing filesystems and block devices.
[  208.984370] systemd-shutdown[1]: Sending SIGTERM to remaining processes.=
..
[  208.992834] systemd-journald[122]: Received SIGTERM from PID 1
(systemd-shutdow).
[  209.002956] systemd-shutdown[1]: Sending SIGKILL to remaining processes.=
..
[  209.010884] systemd-shutdown[1]: Unmounting file systems.
[  209.016600] (sd-remount)[582]: Remounting '/sysroot' read-only with
options 'inode64,logbufs=3D8,logbsize=3D32k,noquota'.
[  209.047818] (sd-umount)[583]: Unmounting '/sysroot'.
[  209.064270] XFS (dm-0): Unmounting Filesystem
02a3398d-033b-4d71-a1be-005b520abf57
[  209.088525] (sd-umount)[584]: Unmounting
'/run/credentials/systemd-journald.service'.
[  209.096658] (sd-remount)[585]: Remounting '/usr' read-only with
options 'lowerdir=3D/squash/root,upperdir=3D/squash/overlay/upper,workdir=
=3D/squash/overlay/work/,uuid=3Dnull'.
[  209.112548] (sd-remount)[586]: Remounting '/' read-only with
options 'lowerdir=3D/squash/root,upperdir=3D/squash/overlay/upper,workdir=
=3D/squash/overlay/work/,uuid=3Dnull'.
[  209.127676] (sd-umount)[587]: Unmounting '/squash/root'.
[  209.133199] (sd-umount)[588]: Unmounting '/squash'.
[  209.138282] systemd-shutdown[1]: All filesystems unmounted.
[  209.143961] systemd-shutdown[1]: Deactivating swaps.
[  209.149031] systemd-shutdown[1]: All swaps deactivated.
[  209.154353] systemd-shutdown[1]: Detaching loop devices.
[  209.159936] systemd-shutdown[1]: Detaching loopback /dev/loop0.
[  209.166014] systemd-shutdown[1]: Syncing /dev/loop0.
[  209.171148] systemd-shutdown[1]: Could not detach loopback
/dev/loop0: Device or resource busy
[  209.179914] systemd-shutdown[1]: Not all loop devices detached, 1 left.
[  209.186641] systemd-shutdown[1]: Stopping MD devices.
[  209.191812] systemd-shutdown[1]: All MD devices stopped.
[  209.197221] systemd-shutdown[1]: Detaching DM devices.
[  209.202521] systemd-shutdown[1]: Detaching DM /dev/dm-0 (253:0).
[  209.208680] systemd-shutdown[1]: Syncing /dev/dm-0.
[  209.237637] systemd-shutdown[1]: All DM devices detached.
[  209.243159] systemd-shutdown[1]: Detaching loop devices.
[  209.248666] systemd-shutdown[1]: Detaching loopback /dev/loop0.
[  209.254746] systemd-shutdown[1]: Syncing /dev/loop0.
[  209.259894] systemd-shutdown[1]: Could not detach loopback
/dev/loop0: Device or resource busy
[  209.268659] systemd-shutdown[1]: Not all loop devices detached, 1 left.
[  209.275402] systemd-shutdown[1]: Detaching loop devices.
[  209.280889] systemd-shutdown[1]: Detaching loopback /dev/loop0.
[  209.286963] systemd-shutdown[1]: Syncing /dev/loop0.
[  209.292094] systemd-shutdown[1]: Could not detach loopback
/dev/loop0: Device or resource busy
[  209.300859] systemd-shutdown[1]: Not all loop devices detached, 1 left.
[  209.307585] systemd-shutdown[1]: Cannot finalize remaining loop
devices, continuing.
[  209.315487] systemd-shutdown[1]: Unable to finalize remaining loop
devices, ignoring.
[  209.323487] systemd-shutdown[1]: Syncing filesystems and block devices.
[  209.330299] systemd-shutdown[1]: Rebooting.
[  246.858584] INFO: task kworker/0:1:11 blocked for more than 122 seconds.
[  246.865415]       Not tainted 7.0.0-clean #1
[  246.869766] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  246.877728] task:kworker/0:1     state:D stack:0     pid:11
tgid:11    ppid:2      task_flags:0x4208160 flags:0x00080000
[  246.889047] Workqueue: usb_hub_wq hub_event
[  246.893306] Call Trace:
[  246.895795]  <TASK>
[  246.897930]  __schedule+0x299/0x5c0
[  246.901480]  schedule+0x27/0x80
[  246.904675]  schedule_timeout+0xbd/0x100
[  246.908666]  __wait_for_common+0x97/0x1b0
[  246.912742]  ? __pfx_schedule_timeout+0x10/0x10
[  246.917350]  xhci_alloc_dev+0x9e/0x2b0
[  246.921166]  usb_alloc_dev+0x7a/0x3b0
[  246.924893]  hub_port_connect+0x285/0x960
[  246.928972]  hub_port_connect_change+0x94/0x290
[  246.933581]  port_event+0x4bb/0x840
[  246.937128]  hub_event+0x141/0x460
[  246.940587]  process_one_work+0x196/0x390
[  246.944668]  worker_thread+0x1af/0x320
[  246.948480]  ? __pfx_worker_thread+0x10/0x10
[  246.952821]  kthread+0xe3/0x120
[  246.956017]  ? __pfx_kthread+0x10/0x10
[  246.959831]  ret_from_fork+0x199/0x260
[  246.963647]  ? __pfx_kthread+0x10/0x10
[  246.967458]  ret_from_fork_asm+0x1a/0x30
[  246.971450]  </TASK>
[  369.738574] INFO: task systemd-shutdow:1 blocked for more than 122 secon=
ds.
[  369.745659]       Not tainted 7.0.0-clean #1
[  369.750001] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  369.757962] task:systemd-shutdow state:D stack:0     pid:1
tgid:1     ppid:0      task_flags:0x400100 flags:0x00080000
[  369.769190] Call Trace:
[  369.771677]  <TASK>
[  369.773813]  __schedule+0x299/0x5c0
[  369.777361]  schedule+0x27/0x80
[  369.780557]  schedule_preempt_disabled+0x15/0x30
[  369.785252]  __mutex_lock.constprop.0+0x547/0xac0
[  369.790037]  device_shutdown+0xac/0x1b0
[  369.793940]  kernel_restart+0x3a/0x70
[  369.797665]  __do_sys_reboot+0x147/0x240
[  369.801655]  do_syscall_64+0x11b/0x6a0
[  369.805467]  ? do_sys_openat2+0x9d/0xe0
[  369.809371]  ? __x64_sys_openat+0x54/0xa0
[  369.813448]  ? do_syscall_64+0x153/0x6a0
[  369.817436]  ? irqentry_exit+0x7a/0x4d0
[  369.821338]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  369.826476] RIP: 0033:0x7fa1b7097917
[  369.830114] RSP: 002b:00007ffcf44802b8 EFLAGS: 00000206 ORIG_RAX:
00000000000000a9
[  369.837811] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa1b70=
97917
[  369.845069] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee=
1dead
[  369.852326] RBP: 00007ffcf4480430 R08: 0000000000000069 R09: 00000000fff=
fffff
[  369.859580] R10: 0000000000000000 R11: 0000000000000206 R12: 00000000000=
00000
[  369.866837] R13: 0000000000000000 R14: 00007ffcf4480568 R15: 00000000000=
00000
[  369.874095]  </TASK>
[  369.876319] INFO: task systemd-shutdow:1 is blocked on a mutex
likely owned by task kworker/0:1:11.
[  369.885519] INFO: task kworker/0:1:11 blocked for more than 245 seconds.
[  369.892334]       Not tainted 7.0.0-clean #1
[  369.896675] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  369.904636] task:kworker/0:1     state:D stack:0     pid:11
tgid:11    ppid:2      task_flags:0x4208160 flags:0x00080000
[  369.915954] Workqueue: usb_hub_wq hub_event
[  369.920210] Call Trace:
[  369.922697]  <TASK>
[  369.924833]  __schedule+0x299/0x5c0
[  369.928380]  schedule+0x27/0x80
[  369.931576]  schedule_timeout+0xbd/0x100
[  369.935568]  __wait_for_common+0x97/0x1b0
[  369.939644]  ? __pfx_schedule_timeout+0x10/0x10
[  369.944253]  xhci_alloc_dev+0x9e/0x2b0
[  369.948067]  usb_alloc_dev+0x7a/0x3b0
[  369.951793]  hub_port_connect+0x285/0x960
[  369.955871]  hub_port_connect_change+0x94/0x290
[  369.960478]  port_event+0x4bb/0x840
[  369.964026]  hub_event+0x141/0x460
[  369.967484]  process_one_work+0x196/0x390
[  369.971564]  worker_thread+0x1af/0x320
[  369.975378]  ? __pfx_worker_thread+0x10/0x10
[  369.979719]  kthread+0xe3/0x120
[  369.982913]  ? __pfx_kthread+0x10/0x10
[  369.986727]  ret_from_fork+0x199/0x260
[  369.990540]  ? __pfx_kthread+0x10/0x10
[  369.994354]  ret_from_fork_asm+0x1a/0x30
[  369.998342]  </TASK>

=3D> System hangs and doesn't reboot
###################

Thanks for all the help so far on the matter Michal,

Best Regards,


