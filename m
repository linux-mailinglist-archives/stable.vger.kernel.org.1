Return-Path: <stable+bounces-242595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHjkDk7i9WnNQAIAu9opvQ
	(envelope-from <stable+bounces-242595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 13:38:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 789F84B1D1A
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 13:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6D3D3007C98
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5078336EF8;
	Sat,  2 May 2026 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzIkNJ6a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iH3g/LQ3"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F6D2EACEF
	for <stable@vger.kernel.org>; Sat,  2 May 2026 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777721930; cv=pass; b=VwiTWOFg1kEwuIJCGx5JhpoMQrNh/C40BNeSYr0AIJ3COwFpdlAsWfdH5xurFKTG7i9zRG1tKruifgeIrhLzz4mTKxyur0Go7WeD+DJ33+fmAAOfDgnNePwF5CowMeunx/fsX0xs1rYScR4AMHA6AtfFo9MT8rQfRBj4VL+90V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777721930; c=relaxed/simple;
	bh=+hMtGHg8CBkIb22c9TM6NGCK8GKg3irj7497dkql3hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mErd2TBna+JW3d4/DBfEaNeTO5VHomTOClCTDhztdSr1BqszJnBBrIqXjS4pcMiFCxRyOq/7hS6vXTqngcLD0tDsZtdjyB2xLQ9c1D7wSeVxth/rUJUdAK+mEeYSPPNpCtFnpFY/kBnSAQdZxye7W9dv0XJ2p77C4VB/mkOtR2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzIkNJ6a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iH3g/LQ3; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777721928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDANvVeZ2nLpLj7QFjvch59jhhFZf8aZV+Bmbxo50Jc=;
	b=ZzIkNJ6aMutafxbYnh4e6DZyC6MPsho8T18vCBWfgtAD2t/bzuC4rLivDn5K2RvQGcFJJ8
	/r9Z1wFcKEpbwRK6ZZaPXXifU/QCizifxIX9h97zpyDZE8YTKqfrxSxZkAJCMbq8VtpBF6
	G+8kvRWQBVjczldRfhkhTMJt8YBVJxs=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-HpzXgnWwMp-E8VTRULjyrQ-1; Sat, 02 May 2026 07:38:46 -0400
X-MC-Unique: HpzXgnWwMp-E8VTRULjyrQ-1
X-Mimecast-MFC-AGG-ID: HpzXgnWwMp-E8VTRULjyrQ_1777721926
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6963482e03dso3843370eaf.3
        for <stable@vger.kernel.org>; Sat, 02 May 2026 04:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777721926; cv=none;
        d=google.com; s=arc-20240605;
        b=OE0+vhUTlgPcEvlZRmmpqKM5dHFRHl8ZJtJ7C4HIwR6mI8Ek+CWb+GfZNlMke+tw3n
         mPuLVDVLhGPJitHV1rI4qB7Xpx6NSS4hbr6TUgQsis53q6+fb+mGSuJvom8P53DogsCx
         qc38APHqNZmbZigscq23UrE6GvOUWl6Vu6ErP04CdFC+haCkR1sN2klpThAt3MdANOlu
         0VoNtJo523vUMqpbxjcykpPfbZpPsFTqX4UBYtczydhngnwNkLoPYExc9xdZaeT48LHB
         i8n2N4Hcm0j5EO+ek2eoBg9DSMxV5iif8OL4urEnlxXCddgoccvehEbNvKXTicvcWUxx
         PBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WDANvVeZ2nLpLj7QFjvch59jhhFZf8aZV+Bmbxo50Jc=;
        fh=sb3FG3K8hT56n+hoCfbzXtOE37Pb/6oQ99eYIfFNEF8=;
        b=WFPa2O7k9dYz8kTi5T0vnho9UcGXuV2r10Jpt3P/S2ai/Vz9rmgOvYUaHFeJ4eSi8g
         NylvxnIeyCabSx5uJWSuurWJApOWYjAh1Z2ITYshkGtvFmFo5TXb7gGsxRAV4/087QCS
         e5g65wRRughDQtrumJZ3trcuo5UlvXcTA/m8cgFeLo9jy+OfIdmcuuuS52D5Pat9BG/e
         Hg7rfyKLgbqOmuo/+CiXbV+sMULs0uphfEDJurwYQ8MpgKd0akQC8fE1E2mrmKolIxDt
         910mOUMvq3Cr32S1KcKC7Sgc4aJiW6Q40p4tTYauoYegsmm7OBwobT19rpobH5cJPRxC
         Qufw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777721926; x=1778326726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDANvVeZ2nLpLj7QFjvch59jhhFZf8aZV+Bmbxo50Jc=;
        b=iH3g/LQ3/fYX2C9PCXsS+p95r25tRzj2Ab3l8QJ4Abx2SiIbuLIAxrM2d25yez22ds
         fiAykjYkVMj7oWIomrkeS60c8mbDkXs8loO5yhPyNDkzdIPnGtMonq1ttdkt5tnaFw6x
         3mUfvxTou/3T2VY4AoJYmjoBTkAwMoy9K0ffLbdqkB7XEvwQytGWboWK1/tbs9kphf8R
         BsdnbuGS0OWBv7Ebu34CYqtotkhND5WP2AaqGg49TXXX3DNMa7IAmeq1JmvGyfkelxDp
         r4LNA/FaDwq9SzUD70iVWJkU356xlNv6jtge1hpsl2EfZVfSBnHhlW6QvVIeVsGtl5lt
         t1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777721926; x=1778326726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WDANvVeZ2nLpLj7QFjvch59jhhFZf8aZV+Bmbxo50Jc=;
        b=q6dvf/j791EuG4rkZSRpF/6Fi2YAmn7fkH07CJmp2en8/3AXIp7aHSBd6qiJLjAAR8
         IGsf+ySKp9oprRC4kLEOJsUagR/TpzhINKIzb1b0N0rXWASfM6su4Gw9WFZ3pDCUNbAs
         Aw+rirPj8Lr63FyrJwcHRupNK4Y+ovRJUrujsKDCA5mjFpXq6WA4uR0fXKKAWH+4+MpP
         82xo4jMcCfDyDcc68z4V2h8M/V4yguDGcigmqELvql2EM+Wc7tygRkzBeShNoEic6hpk
         vTH9JPY8BYkgenvonuwkDgaVDN4PAZLcMyW65+mhThxOQFu4sehtw95FAqD9npAzKVpQ
         DogQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+CZOyA0I7hZediwIitI84po0X8zBI5fdoXsNKZMCsmX8fFqJLUZtgaxlSfiski3AjnzmU+nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwalVy2dXIB/HrMI3HvtsRkD/TIXwDGftmDmkg56mQOEudYib0I
	E92+2RqeGO+9bVJsV+CA6MEFwn/xbrPtSlM1HQvcyN7Ld5x7BX5M7LfVpOsKCqhG4oxPLzSC8vy
	ZSkTFpOZ3FJ25Ek/KrM2OxCBGIYIMiwx7HME1QWH9oUYUo3VaHV9oxX7dATPjrmFaCOIlMfiOq7
	dzBOtL/eo0xuBaZ953sM589Z+hkgSPhWe1
X-Gm-Gg: AeBDieutEwbizGKioYYjk9zlZWprapTdHMUkvKVfO4VAy2l5qYUtLd6RliJ/r0PLgIb
	r3yEGQkrBm9/PxE0lgEQWKbBTWnS94LCC8GVOLFqE3dWfGXMvuDGtpfUGxFV00ASQAf/FkBdKse
	2VW8jAH6ht4LWtg+WN0zhRByUSCHaJM46YAXEyRSElgfC/Eh2UVjo22WNcx9V1dE8OCPnC+rJ+z
	m0cAY/rKpSG/e5ySP2ScqbPVOwt3ArFdoJ2TO0ZWAB+BXrIxw==
X-Received: by 2002:a05:6820:a02:b0:694:914a:ebe1 with SMTP id 006d021491bc7-69697e44a5emr1114932eaf.47.1777721925798;
        Sat, 02 May 2026 04:38:45 -0700 (PDT)
X-Received: by 2002:a05:6820:a02:b0:694:914a:ebe1 with SMTP id
 006d021491bc7-69697e44a5emr1114926eaf.47.1777721925355; Sat, 02 May 2026
 04:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430014817.2006885-1-desnesn@redhat.com> <20260430104850.352bd946.michal.pecio@gmail.com>
 <CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com>
 <20260430235453.2288c973.michal.pecio@gmail.com> <CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
 <20260502114644.76e6b5a3.michal.pecio@gmail.com>
In-Reply-To: <20260502114644.76e6b5a3.michal.pecio@gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Sat, 2 May 2026 08:38:34 -0300
X-Gm-Features: AVHnY4JfAFn7WTLCO7EsS41xWnH6XeCJQOFcGpPJcf6_iI34LBg_ZNFxNGaVuBc
Message-ID: <CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command timeout
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 789F84B1D1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242595-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hello again Michal,

On Sat, May 2, 2026 at 6:47=E2=80=AFAM Michal Pecio <michal.pecio@gmail.com=
> wrote:
>
> On Fri, 1 May 2026 11:09:27 -0300, Desnes Nunes wrote:
> > On Thu, Apr 30, 2026 at 6:55=E2=80=AFPM Michal Pecio <michal.pecio@gmai=
l.com> wrote:
> > > When xhci_handle_command_timeout() logs USBSTS, does it help to add:
> > >
> > > if (usbsts & STS_FATAL) {
> > >         xhci_halt(xhci);
> > >         xhci_hc_died(xhci);
> > >         goto time_out_completed;
> > > }
> > > It may not be perfect solution (race conditions?) but it could hint
> > > that we are on the right track, if it works.
> >
> > This panicked the system as soon as I hit `echo c > /proc/sysrq-trigger=
`:
> >
> > [  141.683476] sysrq: Trigger a crash
> > [  141.686970] Kernel panic - not syncing: sysrq triggered crash
>
> Damn, that sucks. Any chance it's not a problem with my proposed change
> but some sort of issue on your side?

Indeed - bummer.

Don't think so, since I'm using the same system and procedures I used
for the wait_for_completion_timeout() patch:
https://lore.kernel.org/linux-usb/20260430014817.2006885-1-desnesn@redhat.c=
om/T/#ma6ce987cea510349082831bbb822136e5c5c57da

> Anyway, I think the patch below might cover it. It works for me in the
> sense that the bus does get killed, without ill effect. I tested on
> VL805 where HSE is easily triggered by disabling XHCI_TRB_OVERFETCH.
> However, the patch isn't necessary here - VL805 doesn't clear CRCR.CRR
> on HSE, so normal abort path is taken and times out, then hc_died().
...
> I also wonder if it wouldn't make sense to just hc_died() on every
> command timeout except Address Device. We rely on Stop Endpoint
> timeouts to kill chips which go unresponsive without setting HCE/HSE,
> because sooner or later somebody loses patience and unlinks an URB,
> but this story (real or hallucinated, but plausible) shows that this
> may not help when there are no devices created yet.
>
> ---
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index e5823650850a..3041deb67b57 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1761,13 +1761,15 @@ void xhci_handle_command_timeout(struct work_stru=
ct *work)
>         /* mark this command to be cancelled */
>         xhci->current_cmd->status =3D COMP_COMMAND_ABORTED;
>
> -       /* Make sure command ring is running before aborting it */
> +       /* check for crashed or disconnected chip */
>         hw_ring_state =3D xhci_read_64(xhci, &xhci->op_regs->cmd_ring);
> -       if (hw_ring_state =3D=3D ~(u64)0) {
> +       if (hw_ring_state =3D=3D ~(u64)0 || usbsts & (STS_FATAL | STS_HCE=
)) {
> +               xhci_info(xhci, "kill the damn thing\n");
>                 xhci_hc_died(xhci);
>                 goto time_out_completed;
>         }
>
> +       /* Make sure command ring is running before aborting it */
>         if ((xhci->cmd_ring_state & CMD_RING_STATE_RUNNING) &&
>             (hw_ring_state & CMD_RING_RUNNING))  {
>                 /* Prevent new doorbell, and start command abort */

FYI, sorry to be the bearer of bad news, but this also panics the
system as soon as I run `echo c > /proc/sysrq-trigger`. Kdump doesn't
run and no vmcore is produced:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Kernel 7.0.0-michal.pecio.v2 on x86_64

FQDN login:
[ 1063.290020] sysrq: Trigger a crash
[ 1063.293504] Kernel panic - not syncing: sysrq triggered crash
[ 1063.299348] CPU: 12 UID: 0 PID: 5483 Comm: bash Not tainted
7.0.0-michal.pecio.v2 #1 PREEMPT(full)
[ 1063.308548] Hardware name: Intel Corporation Arrow Lake Client
Platform/MTL-S UDIMM 1DPC EVCRB, BIOS MTLSFWI1.R00.5385.D80.2509230731
09/23/2025
[ 1063.321718] Call Trace:
[ 1063.324210]  <TASK>
[ 1063.326347]  dump_stack_lvl+0x4e/0x70
[ 1063.330084]  vpanic+0x20a/0x410
[ 1063.333281]  panic+0x6b/0x70
[ 1063.336210]  sysrq_handle_crash+0x1a/0x20
[ 1063.340290]  __handle_sysrq.cold+0x99/0xde
[ 1063.344456]  write_sysrq_trigger+0x59/0xb0
[ 1063.348624]  proc_reg_write+0x5a/0xa0
[ 1063.352348]  vfs_write+0xcf/0x450
[ 1063.355721]  ksys_write+0x6b/0xe0
[ 1063.359092]  do_syscall_64+0x11b/0x6a0
[ 1063.362906]  ? do_user_addr_fault+0x206/0x680
[ 1063.367337]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1063.372474] RIP: 0033:0x7fc8e8a9a544
[ 1063.376112] Code: 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 40 00 f3 0f 1e fa 80 3d a5 cb 0d 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
18 48
[ 1063.395199] RSP: 002b:00007ffcb7ccb328 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1063.402898] RAX: ffffffffffffffda RBX: 00007fc8e8b705c0 RCX: 00007fc8e8a=
9a544
[ 1063.410153] RDX: 0000000000000002 RSI: 000055ae272da170 RDI: 00000000000=
00001
[ 1063.417409] RBP: 0000000000000002 R08: 0000000000000073 R09: 00000000fff=
fffff
[ 1063.424664] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[ 1063.431919] R13: 000055ae272da170 R14: 0000000000000002 R15: 00007fc8e8b=
6df00
[ 1063.439177]  </TASK>
[ 1063.441691] Kernel Offset: 0x4200000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1063.452571] ---[ end Kernel panic - not syncing: sysrq triggered crash ]=
---
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Best Regards

Desnes Nunes


