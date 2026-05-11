Return-Path: <stable+bounces-245267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKe/BGz8AWomnAEAu9opvQ
	(envelope-from <stable+bounces-245267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:57:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EC8511AC2
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BD4F301AA63
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1542189F;
	Mon, 11 May 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RigRaoIm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D32441B37B
	for <stable@vger.kernel.org>; Mon, 11 May 2026 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514994; cv=none; b=P1PEmMKEZYSbe6P+AWA/AEiF+nPKv6je1gPMGAGuSkRtTzzbnKp7PwwxTAjFQ6W08WfTSjQW5cvxapu40ZpnqrCamDEaHKHd1HNi9wqoEdIwrD5VdhqLWVYmp2BrWq89hPgC8TGtbRa7E6LE2RpGOVO65PsPFW3dcwjdQzK5J/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514994; c=relaxed/simple;
	bh=26Z5zACiBEmeh57u1zpWGmh+HK9C+rNPbX7cWfwXieY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbR5l+vqwsuww0Hq3PaKiRjXIadhEXzDD6GsAjBWeq+zdULvU+dRxp5uOl9U1Q6aZEW7wbxYiyuVd0ymvetMfXEi9Whysj++wT2vEio6uEOE9RuezjMVHdLT8iCZoXDXHPbh7aA4aOE8JBqJ83K6LTar/40Po14yzO2orKtz654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RigRaoIm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd2087858c4so53603566b.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778514990; x=1779119790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V8N1U/Qyj3QR7QkqyWRXyEthKrpdzgJBz+nYOsIhbBo=;
        b=RigRaoImfQ5O2gRXLnVh4KcIG080HL5/ulm/Y+1ntMLB68D8tHP+R1erC7OaOMVl5V
         mBOWJjgTlvATEGyf3qS/hLvFzQ3OELAiGczGS+z1Ke0QRRHk3SOgLtPOSao1oz+HdlWz
         QdWdNCBkuh5BxC1sWs6DagcCao9S/OpqKQkoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514990; x=1779119790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8N1U/Qyj3QR7QkqyWRXyEthKrpdzgJBz+nYOsIhbBo=;
        b=QSW8IpelAVBNH0TddhD7NCh5urSPeK2lsV+EBipfcePWbdwhj7DX7vwblYKaC9h8U6
         liNeAZY4MrJP3gGyUlFw6GZbXkkcQaaAsqNNcDAgb8IUEqx4HqG1a480BJPuHgL58aU4
         rn/s9TQWJ4PvE/TXzDf8rEVQbaBU5jc7hXyqLRrLh/aHjtd/cZhVaI+nH1KeL8ISh0cw
         bxWp40rBIz8JBvDFDl+LbT3WUMcxB19icL/OCD7Vduwd0wff77Sk5JVMsbvIZ5iWg154
         87aneo7he27T7MZcjNluzKI4iAL5r2fdJlgKP7yOouND7X/gUxUoQgbJDRnpx6GBLtwx
         lGnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+70cVlgkwh8O86N4QwHOndI/cov+04EJsfaPXyZaFftRhdOqSar6AyAgZU+Ya3HVUIyq1c0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YweFY4jUM/cG9McOKAHXLgfGytkk/DNy/3tELNxI5hLx6KPaJzE
	xbvvVX3IO9jU/fmUAYB7i6Uam16VBdv7dNg4b/XAMfvDO6MqpVd4reOEkbo1tMeb6EhYQ6kuobb
	cdOM=
X-Gm-Gg: Acq92OHah0SDLoJIF6323N7w8qsAlTMLg/HnNqqTA3P9StbVYXuMa081t5Twx+Hqr/1
	fV44mX22uLJdoL9tL3mMFabDh4VGFT6AiYZSOu22IzNezzyQ4Sqn1746JzO+jC9YukA3xJGBtXI
	AOzYo5JYqd0NsdImArid8MUtXxobmAAooaCTQ8lNb4lV8yBUt79FwSZMgsahQJrEe5rOELUhyXo
	NliNuzRD7FnG9Cw8kKnu7sxgnjOFOKZS28QBKEvuLF3GHE84f7eyUni3UGApXmTqeT7b7GF/6vX
	UDKcZuJY02I1zAo60MVSOvsPFwyevJYkIBPQ3a8cgUGf5JChgSnnhpsWGMQJPj5TmZCfkHeFY9w
	1lwyTbyLM77ZJgsJiwrqQR8uyH18azXj/9kMEthsJGY53WJP6+rFghiuar4SRH7TK+TJ4ueSdnq
	vJ4wj5nZzgnBNaLvQNRFdv0UFbfkq2csUPRsMatrr1XRlm4kSuW4MwqFTOPmcr
X-Received: by 2002:a17:907:1ca7:b0:bce:2050:a0c2 with SMTP id a640c23a62f3a-bce2050bba9mr384404166b.0.1778514990136;
        Mon, 11 May 2026 08:56:30 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfac35c47asm186277066b.1.2026.05.11.08.56.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 08:56:29 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd2087858c4so53596966b.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 08:56:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ++SjS1J9Bj822D8Dk4pTWDPF2/NtTHlSM1RyvuxLLvZV5yM+++YQU3CgsIKhh49tZKGciDqO4=@vger.kernel.org
X-Received: by 2002:a17:906:7946:b0:bc6:14b3:e835 with SMTP id
 a640c23a62f3a-bcaac454f5amr778837666b.32.1778514988144; Mon, 11 May 2026
 08:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
 <20260323-uvc-hwtimestamp-v1-1-aa42e3865204@chromium.org> <20260511154629.GB3043805@killaraus.ideasonboard.com>
In-Reply-To: <20260511154629.GB3043805@killaraus.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 11 May 2026 17:56:14 +0200
X-Gmail-Original-Message-ID: <CANiDSCuhk-xdFcXBfsXMtjDERmj_A4TGDLMBKiQZyVuaQCtbgg@mail.gmail.com>
X-Gm-Features: AVHnY4J56rIMhLc06nCkSPl4V0Q1aa58PkNztLW1yCu0dHF_rEy9aAbm3MLbfKk
Message-ID: <CANiDSCuhk-xdFcXBfsXMtjDERmj_A4TGDLMBKiQZyVuaQCtbgg@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: uvcvideo: Fix dev_sof filtering in hw timestamp
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A4EC8511AC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245267-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,chromium.org:email,chromium.org:dkim]
X-Rspamd-Action: no action

On Mon, 11 May 2026 at 17:46, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Mon, Mar 23, 2026 at 01:10:28PM +0000, Ricardo Ribalda wrote:
> > To avoid filling the clock circular buffer with duplicated data we only
> > add it if the new value sof is different than the last added sof.
> >
> > The issue is that we compare the unprocess sof with the processed sof.
> > If there is a sof_offset, or UVC_QUIRK_INVALID_DEVICE_SOF is enabled,
> > the comparison will not work as expected.
> >
> > This patch moves the comparison to the right place.
> >
> > Fixes: 141270bd95d4 ("media: uvcvideo: Refactor clock circular buffer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index 40c76c051da2..6786ca38fe5e 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -583,16 +583,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> >       if (!has_scr)
> >               return;
> >
> > -     /*
> > -      * To limit the amount of data, drop SCRs with an SOF identical to the
> > -      * previous one. This filtering is also needed to support UVC 1.5, where
> > -      * all the data packets of the same frame contains the same SOF. In that
> > -      * case only the first one will match the host_sof.
> > -      */
> >       sample.dev_sof = get_unaligned_le16(&data[header_size - 2]);
> > -     if (sample.dev_sof == stream->clock.last_sof)
> > -             return;
> > -
> >       sample.dev_stc = get_unaligned_le32(&data[header_size - 6]);
> >
> >       /*
> > @@ -664,6 +655,16 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> >       }
> >
> >       sample.dev_sof = (sample.dev_sof + stream->clock.sof_offset) & 2047;
> > +
> > +     /*
> > +      * To limit the amount of data, drop SCRs with an SOF identical to the
> > +      * previous one. This filtering is also needed to support UVC 1.5, where
> > +      * all the data packets of the same frame contains the same SOF. In that
> > +      * case only the first one will match the host_sof.
> > +      */
> > +     if (sample.dev_sof == stream->clock.last_sof)
> > +             return;
> > +
>
> We will now uncondtionally call some potentially more expensive
> operations, in particular usb_get_current_frame_number(). Wouldn't it be
> better to store the unprocessed SOF in the sample in addition to the
> processed SOF, to allow early comparison ?

Works for me. But I'd rather do it as an optimization 5/5

I would like to have an early equality comparison against the
unprocessed_sof. And then a similarity check as in 4/5 with the
processed_sof
>
> >       uvc_video_clock_add_sample(&stream->clock, &sample);
> >       stream->clock.last_sof = sample.dev_sof;
> >  }
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

