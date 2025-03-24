Return-Path: <stable+bounces-125836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF3DA6D340
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 04:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4612188FB0E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 03:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C833158520;
	Mon, 24 Mar 2025 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMmt5A+3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36314386D;
	Mon, 24 Mar 2025 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742785971; cv=none; b=KmA8Jayn2wcZcs9lqD21G13n6Gv0dQuomGHekPl81Uru0A0TjUk9+I5AeMsOjtfF4v5urJV22BrVBHi7xyohM4zj6h5c+5yehuBBsyi8qaF2WEwELONkL66cAsD7+4b8JGZkPjogO6F1u7psftzx950RVxmqxp3qjSdF3P3RIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742785971; c=relaxed/simple;
	bh=J+hMmHqyIo6zEGpGHB+QTEiRNpKQC9RZPUd7hFpsiV0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ahstNuGpJhs6DkkqcCPy7/e4kVkhQxkD2J3GkUm/MEHAzC2D5uG8mxhwSqyT7fPIq9RxHUViuY0n7rVc+9IhkYwV76CqlIpJ59p9WVockrzKuQGFWeKjOPeZVIufmniZyvj/gxHobklUKGBWlS4c+57tMFN/n4y3C8VBhCYB9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMmt5A+3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso6966115a91.2;
        Sun, 23 Mar 2025 20:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742785969; x=1743390769; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tea/ozfNH1Ujz9+Pt/AIl/58j38z2XpiNMnZ79tiKCM=;
        b=cMmt5A+3g6rNGydQIA1kdKrhnXhi0vfxq7g8x+U11evrPAy0OkyVcF/vElv02BdeaH
         OV6pMU3zKcEthxxqtpVSshKQ2IlUsjAA3WRuGgBJLNl6/8M0FbfJ8GrY1MaZqKeeJk9A
         x8UDlAo37pTjy3/XODcION9VN6q06FudPSm9KlGgvNOpkEWUvktfkwQkMyXKGVrM84uS
         h0PnGQgOOGFOWXoCdc/9QGFvJM6Tg/U1FQ2GroozIZ393T+w3EUfU0LJX3fLteyB07Kk
         XsZdFLpAmDjv7Ph/dOgYBB0QZwjwv1geX20FLXyA+YtLR01htHxE4A0m2bG03GZNa7+C
         73/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742785969; x=1743390769;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tea/ozfNH1Ujz9+Pt/AIl/58j38z2XpiNMnZ79tiKCM=;
        b=em5rufelqzY3QZ8+eUGjJ8fxx+kKgzWWdew45rAhbi0MJfyVK2RBX8tPNHnvF80Jnq
         HkbRZVcTetaSTlaLX920/m9GUCIVbmaQ0izljXQJMcFYWaqqtmvQEaGNJZX2wrAdrQnh
         NP5ySgzjd5hf7VlWf60oWXwp99glwTL89TNJ7zAWtuPFr3ZmnbOUFCtq9F/RUP7JFK7D
         caLHq47/bSgDgH7S8U6jhl+dZ1b9FpXnWFNTANZ+mNqNA7J3uGWWJz5l7CtGcICdm3iI
         5iF1t7PU/92RVbymHxZCT0pY4FsMdSZ1x+noFO/fbrL1/tn+nRC1m1Fkb+MbldvaYSRP
         4UAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCZ+eIpBoKSa11qLQjWav5KiXIwFTM6su5vDZWLHwxziaT/XaE5IRwCirNocW7Z+4L//1z2jHCKCvJxWg=@vger.kernel.org, AJvYcCVZpxphfEWYhIvu3vIsYbZPVydbnLv7KHTPECCfyTTUoAVJpAF0bNO4cqDd96tdaWLF21t334Ek@vger.kernel.org, AJvYcCXnBNMikGzy2rPR7qSgjsY+csMzWmZHAAbuzXInnj16grp16MaUqHZVKncoZjH6xuqG+k7L/eOYmudfy23YCs7+0y2Gow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRs1xcTdpqSRk6Kh9rOApGB6w6cFDW536TU12HixkfwVBJALD
	+8eZxgvm7mZy09GW/VHFYUyCBKwii1CIUr+QZoW1747YzjLJf23A
X-Gm-Gg: ASbGncuaWQceKv/bzUYJIucOSPtfbidqgQuscRXHR6njzJJPX++nqmXIbAGy5C75+QW
	krsB7EBf0xcyTkSSFk72wXOn6JehHU8a0uBeqEMFYQ//01JMHVTw0a2/MFLdxUV2D0iOqZJ0bGy
	MKpnUdmD9BAVz4XZ9rZPmtzbE8FFxDRXMp4XAkO+FdFspSMZK8DHM5eWZX3XlW9d7jKBE0zVx/t
	HKImT+jyCOMmGbofCj5leay9JwJGhd8TD4SwYRTG5DbcOqi0UPNdUqm9vZ5RjwITlkQ/uP1K2iO
	9WMS477jDEVWlxpM1FiMYEMCwJ9UqxASmO+ddQ==
X-Google-Smtp-Source: AGHT+IEn+9qYJQnWY98h1MLFYD024IQB4Y4D/jzquQCHfmfgDvDvH40NQfXJETuT2lCsQp1RzMQlpQ==
X-Received: by 2002:a17:90b:53d0:b0:2ee:90a1:5d42 with SMTP id 98e67ed59e1d1-3030fd4b078mr22842917a91.0.1742785968650;
        Sun, 23 Mar 2025 20:12:48 -0700 (PDT)
Received: from localhost ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf58b343sm10873298a91.15.2025.03.23.20.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 20:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Mar 2025 00:12:44 -0300
Message-Id: <D8O62BJFWT7P.23HRFHB8PX7JN@gmail.com>
Cc: <ibm-acpi-devel@lists.sourceforge.net>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Seyediman Seyedarab" <ImanDevel@gmail.com>, <stable@vger.kernel.org>,
 "Vlastimil Holer" <vlastimil.holer@gmail.com>, "crok" <crok.bic@gmail.com>,
 "Alireza Elikahi" <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>, "Eduard Christian
 Dumitrescu" <eduard.c.dumitrescu@gmail.com>
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: disable ACPI fan access
 for T495* and E560
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Seyediman Seyedarab" <imandevel@gmail.com>, <hmh@hmh.eng.br>,
 <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250324012911.68343-1-ImanDevel@gmail.com>
In-Reply-To: <20250324012911.68343-1-ImanDevel@gmail.com>

On Sun Mar 23, 2025 at 10:29 PM -03, Seyediman Seyedarab wrote:
> From: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
>
> The bug was introduced in commit 57d0557dfa49 ("platform/x86:
> thinkpad_acpi: Add Thinkpad Edge E531 fan support") which adds a new
> fan control method via the FANG and FANW ACPI methods.
>
> T945, T495s, and E560 laptops have the FANG+FANW ACPI methods (therefore
> fang_handle and fanw_handle are not NULL) but they do not actually work,
> which results in the dreaded "No such device or address" error. Fan acces=
s
> and control is restored after forcing the legacy non-ACPI fan control
> method by setting both fang_handle and fanw_handle to NULL.
>
> The DSDT table code for the FANG+FANW methods doesn't seem to do anything
> special regarding the fan being secondary.
>
> This patch adds a quirk for T495, T495s, and E560 to make them avoid the
> FANG/FANW methods.

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

>
> Cc: stable@vger.kernel.org
> Fixes: 57d0557dfa49 ("platform/x86: thinkpad_acpi: Add Thinkpad Edge E531=
 fan support")
> Reported-by: Vlastimil Holer <vlastimil.holer@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219643
> Tested-by: crok <crok.bic@gmail.com>
> Tested-by: Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>
> Signed-off-by: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com=
>
> Co-developed-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> ---
> Changes in v2:
> - Added the From: tag for the original author
> - Replaced the Co-authored-by tag with Co-developed-by
> - Cc'd stable@vger.kernel.org
> - Removed the extra space inside the comment
> - Dropped nullification of sfan/gfan_handle, as it's unrelated to
>   the current fix
>
> Kindest Regards,
> Seyediman
>
>  drivers/platform/x86/thinkpad_acpi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index d8df1405edfa..27fd67a2f2d1 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8793,6 +8793,7 @@ static const struct attribute_group fan_driver_attr=
_group =3D {
>  #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addr=
esses */
>  #define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as =
decimal */
>  #define TPACPI_FAN_TPR		0x0040		/* Fan speed is in Ticks Per Revolution =
*/
> +#define TPACPI_FAN_NOACPI	0x0080		/* Don't use ACPI methods even if dete=
cted */
> =20
>  static const struct tpacpi_quirk fan_quirk_table[] __initconst =3D {
>  	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
> @@ -8823,6 +8824,9 @@ static const struct tpacpi_quirk fan_quirk_table[] =
__initconst =3D {
>  	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) =
*/
>  	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
>  	TPACPI_Q_LNV('8', 'F', TPACPI_FAN_TPR),		/* ThinkPad x120e */
> +	TPACPI_Q_LNV3('R', '0', '0', TPACPI_FAN_NOACPI),/* E560 */
> +	TPACPI_Q_LNV3('R', '1', '2', TPACPI_FAN_NOACPI),/* T495 */
> +	TPACPI_Q_LNV3('R', '1', '3', TPACPI_FAN_NOACPI),/* T495s */
>  };
> =20
>  static int __init fan_init(struct ibm_init_struct *iibm)
> @@ -8874,6 +8878,13 @@ static int __init fan_init(struct ibm_init_struct =
*iibm)
>  		tp_features.fan_ctrl_status_undef =3D 1;
>  	}
> =20
> +	if (quirks & TPACPI_FAN_NOACPI) {
> +		/* E560, T495, T495s */
> +		pr_info("Ignoring buggy ACPI fan access method\n");
> +		fang_handle =3D NULL;
> +		fanw_handle =3D NULL;
> +	}
> +
>  	if (gfan_handle) {
>  		/* 570, 600e/x, 770e, 770x */
>  		fan_status_access_mode =3D TPACPI_FAN_RD_ACPI_GFAN;


