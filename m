Return-Path: <stable+bounces-100564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D559EC72A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B77188C170
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498071D89E5;
	Wed, 11 Dec 2024 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REK6ny+q"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC811D88D3
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905683; cv=none; b=jWAIKDZD/Qw9yEiiMOd6I+61iTLYqGXkkNXaoOh+wxiuqzVPhtaTBQDIzzyd0/ZVVJeF8RE4TxkPCvGISnPhfHxOW6GX1E3bO1u5+IJWqBGA3FmBljjluloiBKXBztQUyM9clD3U9UMROJD2VdQT0GX0DOSVLyMyfSja2W9C6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905683; c=relaxed/simple;
	bh=u13Ji6DbeVY23+kQkikMZwFbi8EQS0hzRz5rVyLnIhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgdOWZgR8YDNmeXIvq75C6ADz8Bj4LpDx50PH5xQJWRRf3DiKMzXa5DpHgNHcptbbosyOb2qq+81iv3NYQrgxA+0+f1Wv3GfiUHBIhcdYa1eG1WkKKt3iiE/2wA85NHRdL7nH4H+aPdd+VmNebka4nwSLKCwkeI5hhSMl9rDbh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REK6ny+q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733905679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0612gSzQEyciS7NmgB8kBGNqNbBg8SB70b74t7w1MBQ=;
	b=REK6ny+qsYTRLVXRTr+a5mBdxXzgb+G8nkEVUIcc4caEdWyd72EmPszRE+q0++G+1amVGH
	bvr1nuOI30P113PbWRgsMZUVEixAwWTw+SHTqkTdP+faMOg/Z3BsB8WMq8hELKvauqxdYo
	l2eWsvzpVdSsHQnwmnTdqseNzZzOIJA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-i8o4MCG7OWi_LI9qmo1inQ-1; Wed, 11 Dec 2024 03:27:58 -0500
X-MC-Unique: i8o4MCG7OWi_LI9qmo1inQ-1
X-Mimecast-MFC-AGG-ID: i8o4MCG7OWi_LI9qmo1inQ
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3d2d60d3fso5571798a12.3
        for <stable@vger.kernel.org>; Wed, 11 Dec 2024 00:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905674; x=1734510474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0612gSzQEyciS7NmgB8kBGNqNbBg8SB70b74t7w1MBQ=;
        b=LABl7Ji4+5o43hGGmc0sgpvqnkHT/uE8BsjWVXDHoOeziIW5vdUGPb4omkiY556Lhi
         VSyff21tcHHwtyYB6OepuUbD/GV2b6vGrbzZq5eY+IYynWPXaXNTZyroLgVul/8yW56k
         UEGSuZzkGiC7tEiO2Z4LTu4QXTqIcMzURmhDVAkTr97AvYpJNwFcKEw9gnbqSMBYpBrx
         bKBn9vUb+ef6fXid6/jWaLcIW2/7pN3KonmFPLjyxBl4AxgnvAirRVMqwzrdcJ/7W0NM
         Av1jaGmO3iHKhnQlg0PY5Vmqd7IE5oVmHexLy+Sr8MlNRCGPvAErrY+yc1k9V5R+nZui
         0Z7Q==
X-Gm-Message-State: AOJu0YzwVoAB+OHK4f1hAaO0tf/urYN+dHbeBoHgrEhSLCQrIzL/8G+v
	b8cP5r1u6xjCPMWhZRPY170SWzZLtHopjGS0gyTdSKzLdSlhZI9YHYQMPFM1LFxilumzUIXArgg
	9yqSPmo7OyrheI1HFcmLxjlYaqf2/ZjMcEVD2rs33Dg0nt9x1h7wnFZVfNSVJmQmZ2sdGyaRbDy
	RbgV7gDvbekntexEzS1BvPqLn+394ys/jz/ZNn
X-Gm-Gg: ASbGncv+dGkJJ5YyDGpCrDqV6+00oRPelyPwcVhInK1P2GSQGQjCfNlX/WooBy18pXM
	a2U1Iz370M+X4h2eTV5Al9meTe88c1un4ok2tAMSU2Z3Y9Q==
X-Received: by 2002:a05:6402:274c:b0:5d0:b455:36ad with SMTP id 4fb4d7f45d1cf-5d43315b3bfmr1807931a12.27.1733905674007;
        Wed, 11 Dec 2024 00:27:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDC0/7THtRm/ERJNPK155GAYhOzPrBeq4Bno6v1vr1KPdkSB3J97X2MdvBauWd8CywoR/DTAeJqxAPTN3lfZE=
X-Received: by 2002:a05:6402:274c:b0:5d0:b455:36ad with SMTP id
 4fb4d7f45d1cf-5d43315b3bfmr1807909a12.27.1733905673630; Wed, 11 Dec 2024
 00:27:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210210012.3586101-1-sashal@kernel.org>
In-Reply-To: <20241210210012.3586101-1-sashal@kernel.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 11 Dec 2024 09:27:42 +0100
Message-ID: <CAO-hwJL7HgrE0wTkG6U47N9k8LRiCR2AqZ4a0CmeX0Lip7uofA@mail.gmail.com>
Subject: Re: Patch "HID: bpf: Fix NKRO on Mistel MD770" has been added to the
 6.6-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, bentiss@kernel.org, 
	Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 10:00=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> This is a note to let you know that I've just added the patch titled
>
>     HID: bpf: Fix NKRO on Mistel MD770
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      hid-bpf-fix-nkro-on-mistel-md770.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.


Please drop this patch (and in all previous releases).

Again, it makes no sense to backport any files in
drivers/hid/bpf/progs on kernels before 6.11, and even then, it makes
very little value as they are also tracked in a different userspace
project (udev-hid-bpf).

Cheers,
Benjamin


>
>
>
>
> commit ad2a792488fb4d41b30190360837022bfca634cf
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


