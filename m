Return-Path: <stable+bounces-25359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F9886AF66
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 13:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DBD1C22E74
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6F973501;
	Wed, 28 Feb 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utFjLF2Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D804145B3E
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124504; cv=none; b=OGOcGv65RaUC9T4+OUqLHQqYiF+21hl6ChEb/4qfXq/yzL8MCEgKHlH9tFJD4Mj3k5bNVpQ62kJoNzBPxzYYdAzWTCJTOxB0czpGaUmHk61rkb4dNlQ6I4ql4lBwAZKw+T/n4UiXpU8XVTzhCF1Q1mgPPRoVRAAoYG0587qMPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124504; c=relaxed/simple;
	bh=NBpzmRY60q2PWTykuATZrxsoFHMaBNlISPhqKCTWTk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKHvcT7BkCP5glIC1sNMDyaKLyxITtjgjvFfaYMQQzaDUR3jcBEW4C7iuHG395RnnlbzlHv2/LQqiM8P2XfbNNZJ8hJPMia/wVV7taO3ikNDQDu94naVLH9CDjHAeCzRxTWNXHywMFiICnHOcjwJp9IVtL1PzM9GNvBeVgrJUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utFjLF2Q; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5664623c311so9638a12.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 04:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709124501; x=1709729301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz8PDV6l9PzFmMf7h7g56ZTBB1hyILoO9PInbhnCtyg=;
        b=utFjLF2Q+kqNmcCjGnkbKP2aC6ZjJ3t0JG7gqq/oSFpA4KlJRqGSTbdSwd4cvoXlfa
         JBvy4WpB9wBjmw25JEk7jf9AqrnqfHN/S9FtjEC6x+9g5fsjlskr2tRbfyDf0bGjLFYm
         WG5qUIDA695NE45hkDWi3BTqVJVfSYonorH7Dtwz66zGRGHcmohBrDTf6qzc3jPZcoQz
         Ai2FcgQ0usBnjsJqAKL9oCvWWju0XpbXL6+/OUdSqpVuNgHiYNQQE2/H/P7YjK3NmuST
         5spskBDQ/4Sz71AvW8fIrO6OaeNL0pf7xuod94bixJIDlkN+vWKzB4u2IwlUrMXY/fOB
         622g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709124501; x=1709729301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lz8PDV6l9PzFmMf7h7g56ZTBB1hyILoO9PInbhnCtyg=;
        b=VXvBe+lmZailZcZaJabUAgDnawZn9VnNocgTbdcBdqSG10hkgoKLYjsuJLWM2MRRrv
         Sc+bKFEXBuz09zHU9LmNUbrIwbH4B14+cHW7vIQ+jIwl+8Hm73xA9Q82AAtMZLB2pQy8
         W0SnCjp4bswlnH6x/CiqRWtznuez0g/Qx2rwJP7St8DxJxcLKzqMkcApc8DfLNLsdw8S
         gErZ/xHzSWcRkhy3SBMyIlAl9ud/sMliiapz3Dwrmd7WsIA1rOWVH+9f0qUZL05Ynwno
         +GXokOjYqnKAwEP5mK/fAfC0rgvCU5c8LfwP9T78ZyJM16GywLeKIg+MyrYw6K3Rhb8H
         I86Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJQLpas+1KkNSzmuSqvbJRgxA7ezNhaY8eWWAE1hBn35XGImv8IcLSpD8JPbN6oUrWDDEBuLGUk9CXGk6l7TMeJSnwbJ2n
X-Gm-Message-State: AOJu0YzwnesmUn0CCFcFzim1B5DQCubtUN/24nm0VDsK9BrsDBVy6YeE
	cmTPtUftcq5iKFknwHEw1ywPkyZOD4Glt+g3kU7Du7EzbeR5996gyTcmjKcx0QP1GbO+Ly+YQnh
	0UZWZPGylndaD8/F0pCwyT5qjZZSvkSP8AMA1
X-Google-Smtp-Source: AGHT+IGvw5oWQcyaO7T3w4443RMPtvSrvIlBRtVQqFuSUAyc6ioFMSLcLtJTOeYhedzngZAOWYGKM0PKlUm2H+h4oz8=
X-Received: by 2002:a50:baae:0:b0:560:1a1:eb8d with SMTP id
 x43-20020a50baae000000b0056001a1eb8dmr17869ede.7.1709124501285; Wed, 28 Feb
 2024 04:48:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228115441.2105585-1-quic_kriskura@quicinc.com>
In-Reply-To: <20240228115441.2105585-1-quic_kriskura@quicinc.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 28 Feb 2024 04:48:05 -0800
Message-ID: <CANP3RGcj0e8ugWhy8mmNZS_HnxGaUQk=_H8d3rbZZm5SkggNLg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: ncm: Fix handling of zero block length packets
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_wcheng@quicinc.com, quic_jackp@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:54=E2=80=AFAM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> While connecting to a Linux host with CDC_NCM_NTB_DEF_SIZE_TX
> set to 65536, it has been observed that we receive short packets,
> which come at interval of 5-10 seconds sometimes and have block
> length zero but still contain 1-2 valid datagrams present.
>
> According to the NCM spec:
>
> "If wBlockLength =3D 0x0000, the block is terminated by a
> short packet. In this case, the USB transfer must still
> be shorter than dwNtbInMaxSize or dwNtbOutMaxSize. If
> exactly dwNtbInMaxSize or dwNtbOutMaxSize bytes are sent,
> and the size is a multiple of wMaxPacketSize for the
> given pipe, then no ZLP shall be sent.
>
> wBlockLength=3D 0x0000 must be used with extreme care, because
> of the possibility that the host and device may get out of
> sync, and because of test issues.
>
> wBlockLength =3D 0x0000 allows the sender to reduce latency by
> starting to send a very large NTB, and then shortening it when
> the sender discovers that there=E2=80=99s not sufficient data to justify
> sending a large NTB"
>
> However, there is a potential issue with the current implementation,
> as it checks for the occurrence of multiple NTBs in a single
> giveback by verifying if the leftover bytes to be processed is zero
> or not. If the block length reads zero, we would process the same
> NTB infintely because the leftover bytes is never zero and it leads
> to a crash. Fix this by bailing out if block length reads zero.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NTB's=
 in unwrap call")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Changes in v2:
> Removed goto label
>
> Link to v1:
> https://lore.kernel.org/all/20240226112815.2616719-1-quic_kriskura@quicin=
c.com/
>
>  drivers/usb/gadget/function/f_ncm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/fun=
ction/f_ncm.c
> index e2a059cfda2c..28f4e6552e84 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -1346,7 +1346,7 @@ static int ncm_unwrap_ntb(struct gether *port,
>         if (to_process =3D=3D 1 &&
>             (*(unsigned char *)(ntb_ptr + block_len) =3D=3D 0x00)) {
>                 to_process--;
> -       } else if (to_process > 0) {
> +       } else if ((to_process > 0) && (block_len !=3D 0)) {
>                 ntb_ptr =3D (unsigned char *)(ntb_ptr + block_len);
>                 goto parse_ntb;
>         }
> --
> 2.34.1

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

