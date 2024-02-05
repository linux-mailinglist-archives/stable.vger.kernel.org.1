Return-Path: <stable+bounces-18858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB4C84A6F9
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 22:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573631F29B1B
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 21:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5059A5CDD3;
	Mon,  5 Feb 2024 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMXKVwYD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564625CDC4
	for <stable@vger.kernel.org>; Mon,  5 Feb 2024 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161613; cv=none; b=uBG9W0bE9FSzT8zUMZnyk38TYQyN5nEWgHnPcraLwe2SQl+D4RraGb/xRHySiiagkVqGZIFh9SLr09qCm3ORRWgPU4yp96S4lFBLPzumR7inEm5B2WrnbOccD2hnEyRJFR0LuEer7j7tiKMTjxtA7UKVfanG3TY18ERoC8USd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161613; c=relaxed/simple;
	bh=S8VBDrPY3rWixgeirT65Bi+aQAfk/nawdnTwZWCHHu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaMeMmlHRu1FSwKE+S0cXwr+uMXmsay0X8pdL1a5hn4hocCbG6UoWO0Dcd82SZwW2T+IyNNV4GNpNBiMmXYVFCJ4oklD+TTMrDsfOlN8BM7ugkMNuL5ETE1kEsoyzj6JE/tgPG9R1ZmL5VxLn28BWGv2Es0SK5O5SYlpKE2zGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMXKVwYD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56012eeb755so3874a12.0
        for <stable@vger.kernel.org>; Mon, 05 Feb 2024 11:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707161609; x=1707766409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDn/H+533WiSQe64x85tBjr0VQMs7P8+fBEaYS85mkI=;
        b=HMXKVwYD/vSIYBdvMOzx2mxitL9WuA11qEfuvzgK2Rt6d3druHuRF6lCC/23e3sM90
         Xm0LSBh8xrfJyPc9zNBbhPgfgWhWhh6NHbJrvIHBY14tmTG4u/dHNCLKdcldyyT6CyKg
         YcN8ogbGEAgKvbs3a8kXYM+8eW0zf9ac/imFcj/2Rg0KLiHPmyDwHKgtB8AibWzyZvFM
         fjttwOjZOJAnQMJ2+cJIRSFSEDHkvjH2sDF+L6ShxtRMwMFaqSc05OnPvAuqrO/q30/O
         THHVz0NuGzfmnwA6tnddVTZ+ZIiCiHq60gIszUAbB8DjMaU6FoIlejXPZSDy73h0l2Af
         VC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707161609; x=1707766409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDn/H+533WiSQe64x85tBjr0VQMs7P8+fBEaYS85mkI=;
        b=PukLGPEuLNHJ4OSKIFnt67UPLg8s06dKrSHHOpcVAECr6FmQg3Y77rbz0sGSsvUwPq
         7VrA+WzrOivqXseKBMHHHybuu0JwKi2VHyXSPDcjCaK/jRsQ2NU7L/Inh/SzLWcRjpcZ
         S/vaBOS4F+yV8FMXuFOdLsrEFCckg7Q3C52zaLxPC/AtFF2YZKquiFuZGraY3sv+t9TI
         +x4Daasn3m4EWJTbOxKFbPcxTkwIDAXWEluZcXV7tMou8v5FfGChdj5cdro6fHSYeg9Y
         Uqj2CtVyr/XG7ZNmkLw72bsoit6OOCv5bFtbl25fsKPIaAL7YnTeAkm/fPv3ktJv2mTe
         TmUg==
X-Gm-Message-State: AOJu0YxbeqoUHvtIDNdiWivoyB54x4gD9tShyY3pwCLcNbQ7zdzWOHUt
	T0UAhH+cog5Epz1wXKAZ21ig9hiov9k22v3n0Y6pcxmpGstY0vdgQrbY2AIcRD0ErWwol7fLeRt
	0Qrav+Zhu6fYfnpkGSgUUuHkJgic6/Y41bIsd
X-Google-Smtp-Source: AGHT+IHEGjV78FtJAEihZiE0A9oWspyKqUrE08qAc1XqO4kCnpOelvHEIhfvLcTK7R01qyEvPDeyc73g6wrzG++eUag=
X-Received: by 2002:a50:f60b:0:b0:55f:9918:dadd with SMTP id
 c11-20020a50f60b000000b0055f9918daddmr44292edn.2.1707161608933; Mon, 05 Feb
 2024 11:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205074650.200304-1-quic_kriskura@quicinc.com>
In-Reply-To: <20240205074650.200304-1-quic_kriskura@quicinc.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 5 Feb 2024 11:33:17 -0800
Message-ID: <CANP3RGdfxgDaMMjrFD6w4JkTDr0vHbv6sji-KKDqnKHKv=hCiA@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hardik Gajjar <hgajjar@de.adit-jv.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_wcheng@quicinc.com, quic_jackp@quicinc.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 11:47=E2=80=AFPM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> It is observed sometimes when tethering is used over NCM with Windows 11
> as host, at some instances, the gadget_giveback has one byte appended at
> the end of a proper NTB. When the NTB is parsed, unwrap call looks for
> any leftover bytes in SKB provided by u_ether and if there are any pendin=
g
> bytes, it treats them as a separate NTB and parses it. But in case the
> second NTB (as per unwrap call) is faulty/corrupt, all the datagrams that
> were parsed properly in the first NTB and saved in rx_list are dropped.
>
> Adding a few custom traces showed the following:
> [002] d..1  7828.532866: dwc3_gadget_giveback: ep1out:
> req 000000003868811a length 1025/16384 zsI =3D=3D> 0
> [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb toprocess: 102=
5
> [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 175199934=
2
> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb seq: 0xce67
> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x400
> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb ndp_len: 0x10
> [002] d..1  7828.532869: ncm_unwrap_ntb: K: Parsed NTB with 1 frames
>
> In this case, the giveback is of 1025 bytes and block length is 1024.
> The rest 1 byte (which is 0x00) won't be parsed resulting in drop of
> all datagrams in rx_list.
>
> Same is case with packets of size 2048:
> [002] d..1  7828.557948: dwc3_gadget_giveback: ep1out:
> req 0000000011dfd96e length 2049/16384 zsI =3D=3D> 0
> [002] d..1  7828.557949: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 175199934=
2
> [002] d..1  7828.557950: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x800
>
> Lecroy shows one byte coming in extra confirming that the byte is coming
> in from PC:
>
> Transfer 2959 - Bytes Transferred(1025)  Timestamp((18.524 843 590)
> - Transaction 8391 - Data(1025 bytes) Timestamp(18.524 843 590)
> --- Packet 4063861
>       Data(1024 bytes)
>       Duration(2.117us) Idle(14.700ns) Timestamp(18.524 843 590)
> --- Packet 4063863
>       Data(1 byte)
>       Duration(66.160ns) Time(282.000ns) Timestamp(18.524 845 722)
>
> According to Windows driver, no ZLP is needed if wBlockLength is non-zero=
,
> because the non-zero wBlockLength has already told the function side the
> size of transfer to be expected. However, there are in-market NCM devices
> that rely on ZLP as long as the wBlockLength is multiple of wMaxPacketSiz=
e.
> To deal with such devices, it pads an extra 0 at end so the transfer is n=
o
> longer multiple of wMaxPacketSize.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 9f6ce4240a2b ("usb: gadget: f_ncm.c added")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Link to v2:
> https://lore.kernel.org/all/20240131150332.1326523-1-quic_kriskura@quicin=
c.com/
>
> Changes in v2:
> Added check to see if the padded byte is 0x00.
>
> Changes in v3:
> Removed wMaxPacketSize check from v2.
>
>  drivers/usb/gadget/function/f_ncm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/fun=
ction/f_ncm.c
> index ca5d5f564998..e2a059cfda2c 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -1338,7 +1338,15 @@ static int ncm_unwrap_ntb(struct gether *port,
>              "Parsed NTB with %d frames\n", dgram_counter);
>
>         to_process -=3D block_len;
> -       if (to_process !=3D 0) {
> +
> +       /*
> +        * Windows NCM driver avoids USB ZLPs by adding a 1-byte
> +        * zero pad as needed.
> +        */
> +       if (to_process =3D=3D 1 &&
> +           (*(unsigned char *)(ntb_ptr + block_len) =3D=3D 0x00)) {
> +               to_process--;
> +       } else if (to_process > 0) {
>                 ntb_ptr =3D (unsigned char *)(ntb_ptr + block_len);
>                 goto parse_ntb;
>         }
> --
> 2.34.1
>

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

Let's get this fix out.

Greg, there's further code cleanups (here and elsewhere) I'll send
once this is merged.
I don't want to annoy Krishna further ;-)

