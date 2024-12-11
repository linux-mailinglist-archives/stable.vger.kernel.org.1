Return-Path: <stable+bounces-100568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F0C9EC731
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A743167D02
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272BF1D8A0B;
	Wed, 11 Dec 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GM/L7iXN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2459A1D88D3
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905798; cv=none; b=BhMMOiO7/JvXyX4Jph1+zaiqZPnnxft1QBBd6Hd3DDt0hAKfnG36he+Nry3LtoT8yXgEALNp90bsoN1IpLent1b0gpsTlVeKPlJjOv3fVGEFAN8PBjw8255jCPTmjizYvBjBYbIHswcx7pWBtIpochP6AeO+HEw2/qYNe7id0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905798; c=relaxed/simple;
	bh=YtV3gfrL5Epo/HLnPt1bosKyDEqU2Hc026JKDGnSqQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfuEKw3iONznVLo0fTK45uL0zdZJK9htaV1BxXljQ84pN+iPOXhn6owgnW9TfM/YplXfG4IA+mPNaS1IweheEwF+hBztrUqYoTGEHdEcAU3TxhvFAAgo1f+Q6307HRvONyCN3wB2hvIzimRDd5EVMqNtr7muALTzXCd6cnQ6FTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GM/L7iXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733905796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJupWoP2iVL0N0FJclUF1u8a/weZkOaK3UJVouW1iP0=;
	b=GM/L7iXNf6mD48Qz24P2u+h+0dhOX1V5/n53/XXcCEA5MAtkatJHTVrucBRBflE8tPXTFW
	niYqJITgDKi4f/4j5o3ROcSDC+z9vHWD4JLSx1Y4mKfD6ipwW/rsbIIMuDSC4PDDlThIjM
	eO7dFf60LxIVs3dAbf7bbAZVoJV1Yck=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-cIG1oYK_PlK2_g0YnbAn3A-1; Wed, 11 Dec 2024 03:29:55 -0500
X-MC-Unique: cIG1oYK_PlK2_g0YnbAn3A-1
X-Mimecast-MFC-AGG-ID: cIG1oYK_PlK2_g0YnbAn3A
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa665246a3cso34663966b.0
        for <stable@vger.kernel.org>; Wed, 11 Dec 2024 00:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905791; x=1734510591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJupWoP2iVL0N0FJclUF1u8a/weZkOaK3UJVouW1iP0=;
        b=pfim7O7vuB2SqJSau8H56h4ooEFxMQA0B6k5hTnzqbLD83fOYgqcH3O9oaseuCaA9e
         wgBtjxoCSYBBlCHwD9Dj09sMM8VPbbOSTZ8S81iBap6gR3RIgG2cEoeQUKEvllGp5R3Z
         O9lFyAk6Yc3m8LR+CwfSjaMmw6oC4d5wroL0jlT3TYu6+zJ3/snI1JYZE3nDNLUT4IYc
         4rlBAxX+6+jZml/cNsfj2Cq1dUzQCuzha3ut5/PUXg/TKQ8c0/wLWZiHlGx4FQH9k6+k
         FvA9zOg7Mju3a8wS3ZFlmsNx8t2QUbhHlw5sRi0aw7253R7yeQHdIM+mJC1t0B0f4Xzd
         Zelw==
X-Gm-Message-State: AOJu0YwGig0EH4E4GzQJjb/JC66Nt1nn9+6NFKSHRTbMQKVrkbTu8Ppr
	EPz1lp1R4K/WNWlNz1pjeAF2xxP54REqLkaxheDb2ELIP478EhMCwMGgMkEf50IH62aT1x1aKT7
	kCBzrYtuLpEkI9gEzVl/ocYPxfb0KDbCScS9hajFH7Mk00+c/O90EhDZQ6EqVcp8OYr5Fqw5Pur
	II9mK7CyPSeZnkXgtQTA4rE3AcZw5Lm0mRAu9HdDM=
X-Gm-Gg: ASbGncuc07GanYGg/ElBoS8vLdW5XQmqNFYpKBSOlJxzpdTbPjjth+DWfAoyVubqN4p
	X4cAwhjT9TZQ352ed0UXNj5rhtxxRS7X4nBS/4w7jsMeBFA==
X-Received: by 2002:a17:906:9c0f:b0:aa6:8e9e:1b5 with SMTP id a640c23a62f3a-aa6b10f5634mr151254066b.3.1733905791400;
        Wed, 11 Dec 2024 00:29:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEIhtxgesQ9MIxPwJM9ce8Ywk4lp6nxHKhc4X2Jq6MTcU6aTzHqCmM4APxZG2q+URn6bOlS2rdXWYdnNjzGKU=
X-Received: by 2002:a17:906:9c0f:b0:aa6:8e9e:1b5 with SMTP id
 a640c23a62f3a-aa6b10f5634mr151251766b.3.1733905790965; Wed, 11 Dec 2024
 00:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210213948.3598143-1-sashal@kernel.org>
In-Reply-To: <20241210213948.3598143-1-sashal@kernel.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 11 Dec 2024 09:29:39 +0100
Message-ID: <CAO-hwJLkfhsk9Yg0vQRsQwwOROuUb8O=crxn0+19UJuZ=U1=5Q@mail.gmail.com>
Subject: Re: Patch "HID: bpf: Fix NKRO on Mistel MD770" has been added to the
 5.10-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, bentiss@kernel.org, 
	Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 10:40=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> This is a note to let you know that I've just added the patch titled
>
>     HID: bpf: Fix NKRO on Mistel MD770
>
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      hid-bpf-fix-nkro-on-mistel-md770.patch
> and it can be found in the queue-5.10 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

Please drop this patch (and in all previous releases).

Again, it makes no sense to backport any files in
drivers/hid/bpf/progs on kernels before 6.11, and even then, it makes
very little value as they are also tracked in a different userspace
project (udev-hid-bpf).

FWIW, HID-BPF was introduced in v6.3, so it's surprising to see such a
patch added here.

Cheers,
Benjamin

>
>
> commit 6a88aee0a4644ce4b15bbaadb7d1f1ce2c0e0c6c
> Author: Benjamin Tissoires <bentiss@kernel.org>
> Date:   Thu Oct 17 18:34:58 2024 +0200
>
>     HID: bpf: Fix NKRO on Mistel MD770
>
>     [ Upstream commit 9bc089307e8dff7797233308372b4a90ce8f79be ]
>
>     Mistel MD770 keyboard (using Holtek Semiconductor, Inc. controller) h=
as
>     a quirk in report descriptor in one of its interfaces (more detail in
>     the source file). Fix up the descriptor to allow NKRO to work again.
>
>     Tested by loading the BPF program and confirming that 8 simultaneous
>     keypresses work.
>
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218495
>     Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_re=
quests/122
>     Signed-off-by: Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
>     Acked-by: Jiri Kosina <jkosina@suse.com>
>     Link: https://patch.msgid.link/20241017-import_bpf_6-13-v2-1-6a7acb89=
a97f@kernel.org
>     Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/hid/bpf/progs/Mistel__MD770.bpf.c b/drivers/hid/bpf/=
progs/Mistel__MD770.bpf.c
> new file mode 100644
> index 0000000000000..fb8b5a6968b12
> --- /dev/null
> +++ b/drivers/hid/bpf/progs/Mistel__MD770.bpf.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Tatsuyuki Ishi
> + */
> +
> +#include "vmlinux.h"
> +#include "hid_bpf.h"
> +#include "hid_bpf_helpers.h"
> +#include <bpf/bpf_tracing.h>
> +
> +#define VID_HOLTEK     0x04D9
> +#define PID_MD770      0x0339
> +#define RDESC_SIZE     203
> +
> +HID_BPF_CONFIG(
> +       HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_HOLTEK, PID_MD770)
> +);
> +
> +/*
> + * The Mistel MD770 keyboard reports the first 6 simultaneous key presse=
s
> + * through the first interface, and anything beyond that through a secon=
d
> + * interface. Unfortunately, the second interface's report descriptor ha=
s an
> + * error, causing events to be malformed and ignored. This HID-BPF drive=
r
> + * fixes the descriptor to allow NKRO to work again.
> + *
> + * For reference, this is the original report descriptor:
> + *
> + * 0x05, 0x01,        // Usage Page (Generic Desktop)        0
> + * 0x09, 0x80,        // Usage (System Control)              2
> + * 0xa1, 0x01,        // Collection (Application)            4
> + * 0x85, 0x01,        //  Report ID (1)                      6
> + * 0x19, 0x81,        //  Usage Minimum (129)                8
> + * 0x29, 0x83,        //  Usage Maximum (131)                10
> + * 0x15, 0x00,        //  Logical Minimum (0)                12
> + * 0x25, 0x01,        //  Logical Maximum (1)                14
> + * 0x95, 0x03,        //  Report Count (3)                   16
> + * 0x75, 0x01,        //  Report Size (1)                    18
> + * 0x81, 0x02,        //  Input (Data,Var,Abs)               20
> + * 0x95, 0x01,        //  Report Count (1)                   22
> + * 0x75, 0x05,        //  Report Size (5)                    24
> + * 0x81, 0x01,        //  Input (Cnst,Arr,Abs)               26
> + * 0xc0,              // End Collection                      28
> + * 0x05, 0x0c,        // Usage Page (Consumer Devices)       29
> + * 0x09, 0x01,        // Usage (Consumer Control)            31
> + * 0xa1, 0x01,        // Collection (Application)            33
> + * 0x85, 0x02,        //  Report ID (2)                      35
> + * 0x15, 0x00,        //  Logical Minimum (0)                37
> + * 0x25, 0x01,        //  Logical Maximum (1)                39
> + * 0x95, 0x12,        //  Report Count (18)                  41
> + * 0x75, 0x01,        //  Report Size (1)                    43
> + * 0x0a, 0x83, 0x01,  //  Usage (AL Consumer Control Config) 45
> + * 0x0a, 0x8a, 0x01,  //  Usage (AL Email Reader)            48
> + * 0x0a, 0x92, 0x01,  //  Usage (AL Calculator)              51
> + * 0x0a, 0x94, 0x01,  //  Usage (AL Local Machine Browser)   54
> + * 0x09, 0xcd,        //  Usage (Play/Pause)                 57
> + * 0x09, 0xb7,        //  Usage (Stop)                       59
> + * 0x09, 0xb6,        //  Usage (Scan Previous Track)        61
> + * 0x09, 0xb5,        //  Usage (Scan Next Track)            63
> + * 0x09, 0xe2,        //  Usage (Mute)                       65
> + * 0x09, 0xea,        //  Usage (Volume Down)                67
> + * 0x09, 0xe9,        //  Usage (Volume Up)                  69
> + * 0x0a, 0x21, 0x02,  //  Usage (AC Search)                  71
> + * 0x0a, 0x23, 0x02,  //  Usage (AC Home)                    74
> + * 0x0a, 0x24, 0x02,  //  Usage (AC Back)                    77
> + * 0x0a, 0x25, 0x02,  //  Usage (AC Forward)                 80
> + * 0x0a, 0x26, 0x02,  //  Usage (AC Stop)                    83
> + * 0x0a, 0x27, 0x02,  //  Usage (AC Refresh)                 86
> + * 0x0a, 0x2a, 0x02,  //  Usage (AC Bookmarks)               89
> + * 0x81, 0x02,        //  Input (Data,Var,Abs)               92
> + * 0x95, 0x01,        //  Report Count (1)                   94
> + * 0x75, 0x0e,        //  Report Size (14)                   96
> + * 0x81, 0x01,        //  Input (Cnst,Arr,Abs)               98
> + * 0xc0,              // End Collection                      100
> + * 0x05, 0x01,        // Usage Page (Generic Desktop)        101
> + * 0x09, 0x02,        // Usage (Mouse)                       103
> + * 0xa1, 0x01,        // Collection (Application)            105
> + * 0x09, 0x01,        //  Usage (Pointer)                    107
> + * 0xa1, 0x00,        //  Collection (Physical)              109
> + * 0x85, 0x03,        //   Report ID (3)                     111
> + * 0x05, 0x09,        //   Usage Page (Button)               113
> + * 0x19, 0x01,        //   Usage Minimum (1)                 115
> + * 0x29, 0x08,        //   Usage Maximum (8)                 117
> + * 0x15, 0x00,        //   Logical Minimum (0)               119
> + * 0x25, 0x01,        //   Logical Maximum (1)               121
> + * 0x75, 0x01,        //   Report Size (1)                   123
> + * 0x95, 0x08,        //   Report Count (8)                  125
> + * 0x81, 0x02,        //   Input (Data,Var,Abs)              127
> + * 0x05, 0x01,        //   Usage Page (Generic Desktop)      129
> + * 0x09, 0x30,        //   Usage (X)                         131
> + * 0x09, 0x31,        //   Usage (Y)                         133
> + * 0x16, 0x01, 0x80,  //   Logical Minimum (-32767)          135
> + * 0x26, 0xff, 0x7f,  //   Logical Maximum (32767)           138
> + * 0x75, 0x10,        //   Report Size (16)                  141
> + * 0x95, 0x02,        //   Report Count (2)                  143
> + * 0x81, 0x06,        //   Input (Data,Var,Rel)              145
> + * 0x09, 0x38,        //   Usage (Wheel)                     147
> + * 0x15, 0x81,        //   Logical Minimum (-127)            149
> + * 0x25, 0x7f,        //   Logical Maximum (127)             151
> + * 0x75, 0x08,        //   Report Size (8)                   153
> + * 0x95, 0x01,        //   Report Count (1)                  155
> + * 0x81, 0x06,        //   Input (Data,Var,Rel)              157
> + * 0x05, 0x0c,        //   Usage Page (Consumer Devices)     159
> + * 0x0a, 0x38, 0x02,  //   Usage (AC Pan)                    161
> + * 0x95, 0x01,        //   Report Count (1)                  164
> + * 0x81, 0x06,        //   Input (Data,Var,Rel)              166
> + * 0xc0,              //  End Collection                     168
> + * 0xc0,              // End Collection                      169
> + * 0x05, 0x01,        // Usage Page (Generic Desktop)        170
> + * 0x09, 0x06,        // Usage (Keyboard)                    172
> + * 0xa1, 0x01,        // Collection (Application)            174
> + * 0x85, 0x04,        //  Report ID (4)                      176
> + * 0x05, 0x07,        //  Usage Page (Keyboard)              178
> + * 0x95, 0x01,        //  Report Count (1)                   180
> + * 0x75, 0x08,        //  Report Size (8)                    182
> + * 0x81, 0x03,        //  Input (Cnst,Var,Abs)               184
> + * 0x95, 0xe8,        //  Report Count (232)                 186
> + * 0x75, 0x01,        //  Report Size (1)                    188
> + * 0x15, 0x00,        //  Logical Minimum (0)                190
> + * 0x25, 0x01,        //  Logical Maximum (1)                192
> + * 0x05, 0x07,        //  Usage Page (Keyboard)              194
> + * 0x19, 0x00,        //  Usage Minimum (0)                  196
> + * 0x29, 0xe7,        //  Usage Maximum (231)                198
> + * 0x81, 0x00,        //  Input (Data,Arr,Abs)               200  <- cha=
nge to 0x81, 0x02 (Data,Var,Abs)
> + * 0xc0,              // End Collection                      202
> + */
> +
> +SEC(HID_BPF_RDESC_FIXUP)
> +int BPF_PROG(hid_rdesc_fixup_mistel_md770, struct hid_bpf_ctx *hctx)
> +{
> +       __u8 *data =3D hid_bpf_get_data(hctx, 0, HID_MAX_DESCRIPTOR_SIZE)=
;
> +
> +       if (!data)
> +               return 0; /* EPERM check */
> +
> +       if (data[201] =3D=3D 0x00)
> +               data[201] =3D 0x02;
> +
> +       return 0;
> +}
> +
> +HID_BPF_OPS(mistel_md770) =3D {
> +       .hid_rdesc_fixup =3D (void *)hid_rdesc_fixup_mistel_md770,
> +};
> +
> +SEC("syscall")
> +int probe(struct hid_bpf_probe_args *ctx)
> +{
> +       ctx->retval =3D ctx->rdesc_size !=3D RDESC_SIZE;
> +       if (ctx->retval)
> +               ctx->retval =3D -EINVAL;
> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
>


