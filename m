Return-Path: <stable+bounces-246826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qObHK51mBGpVIAIAu9opvQ
	(envelope-from <stable+bounces-246826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:55:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 161025329D4
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F5A230E07C9
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359823FF887;
	Wed, 13 May 2026 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXqWasW8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25303FF8A6
	for <stable@vger.kernel.org>; Wed, 13 May 2026 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673081; cv=none; b=f4kYOBWRX0qOtu+A1x8K0lACki8v2MI45odHAZXqYZEJLkBevZaMwate3fUA1JdJcnuJri9UnOaUOrsDh2QxXWC0Lm11Te2LqPbhJy7lCg6XFywQVft4Z5c66zjNeTSvej4JDwdrPkMtrgbfiBeLWtdG5/A8JeNyR7qVZXRlYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673081; c=relaxed/simple;
	bh=75TUQIZkypLwoR8DRfvoyh1YFztZQAcIa1BmTtogMjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dn0wzFcoQA7qmFKHM5c9bXN0qsyijrBA77h30b7rOjZaXjuPR2+Wfij4a9Rj6tjuybSY7RMbUvoC7RSY4NQ7wLK1wB/fu5nwOmIPHN4VYcGWQJd9i9n4h18an0C3naZ+QlyL16+rV9raddkoomr23vZpGcTfhtxJ5J53o/MniWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nXqWasW8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bce386d5b85so635292166b.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778673078; x=1779277878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y32yEFiYyRsO7dPNCj0L6p2gfndeIIlW5kAPWaEhJ1w=;
        b=nXqWasW8IO0HADrr2p/tx9h+NY+7l3O/OqulBJw2SBvCSSmQkatp/5DJfmu6Q+X2YK
         lUCV32TXBiIvTlK2tsEjn7d//6MEFvwkVdKK9kp4ZkURZkYvbQub/7//8KvH/udkQnca
         XY92U9gOLKR6a0pGzRXrzUDL0aLKG5PrlUQ+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778673078; x=1779277878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y32yEFiYyRsO7dPNCj0L6p2gfndeIIlW5kAPWaEhJ1w=;
        b=bG846jTC/hGJogTsKs8pm4kX8IIilWNjOfd+/6kAtyHrbyTF/LiJ+TwXtM7rtS4RJR
         ssdRJweoHJZ5v3sKTv8ywK/6LkGAPyHUdt8wo1W+3YjNWyX/0tLxcf8aNiI8PpopQYpa
         l8xSyM/yARJJsXjH757A1WQhDnZOhLdotU/F3JTpvq82hgJSFZfVBYlAWZUQpXLN17m/
         qTFeMhRzgNFHLZi+lgW1ctd2jYczwYe5+RN9SMqbexeSmD7rxaN692j6Bemmi4rUGJo0
         9vNOYz9aV3pkoYBIvPPoTrarjkQVdmdowbRE3hh3ArdOWCYVpM44j7TgvAbLuSzGVoyy
         hu/g==
X-Forwarded-Encrypted: i=1; AFNElJ9R7zrc+JJAvo3wlnlvrG0u8jsXMQCAbcORdk8Ek6pDLRQbI6ZaDcLzST2d70fXAvEgWhWc89s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPSfFpnDOqlJbAYbo34oVdpRPYmRGkF5ky4bzWY3BKnNcHHbV
	Coj3+/SaYc6a+jbuGYq3iXwds72EABs8JW+5fe7kjtuwno+TdPlf7+U3PPzu36WT/N49Nk3m+Ph
	OFwe4ZUqq
X-Gm-Gg: Acq92OGhWS+BzkLgn9aYjjMydpYmqLcbrpZZhlHytTvjPU8slFen88EJmqZXik3xqXQ
	JXhX1BLnrmqtHuK9/5HaiTbR3LUL44puiMZyqvkFr3cZypde0ytJFLvCeQe7uWTCznAViSUO3ab
	ylXJM2W1ObSF19El7v40kDcIuv8umjWVtlHmTSWMW5qk7fhj6TiDQKd/+UsX38IWPumzyXJ1NGg
	Fen8Q1Mbhp5Vupibfkqgf5DfMVOof/ePAS24+8MPGY0jUe7dXYCB/wTCr85FAL/OHWv8KVLrlPS
	6lvhHQLPISqnzar9fS3zc/He33PZ7yg/alZsQV3J9NAUboBuVLgMlSd/EKacEd4a1ANsFtD3BWS
	ibCIsBIikJGZae8/Gd6PPvQYsHwJOGAUa7NbjdBkjul98Q/EOzmdWyb4fvse3Z3hoNsIB8GWCf3
	KDmoTQCUMsr6wZFANJ5eoXVxITzlNYskHXSjkpgaQh81PmnnvpN/DGeMQ10KzBtpIhyyRGm98=
X-Received: by 2002:a17:907:9689:b0:bb8:e150:d353 with SMTP id a640c23a62f3a-bd3df4899c8mr144624266b.4.1778673077945;
        Wed, 13 May 2026 04:51:17 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfb7b17d1fsm479790166b.41.2026.05.13.04.51.16
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 04:51:16 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9d9971d059so975789066b.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 04:51:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9QuW3erJK3qT5ET9o4FcXXgKcUT2Gzf4aAX1a/xImEUr+JOcWnBi3Im/ZPp6kdeHJOALvikog=@vger.kernel.org
X-Received: by 2002:a17:907:97c2:b0:b9d:6d06:b78a with SMTP id
 a640c23a62f3a-bd3e025e2fcmr150312066b.17.1778673075122; Wed, 13 May 2026
 04:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-uvc-hwtimestamp-v3-0-7a64838b0b02@chromium.org> <20260513-uvc-hwtimestamp-v3-4-7a64838b0b02@chromium.org>
In-Reply-To: <20260513-uvc-hwtimestamp-v3-4-7a64838b0b02@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 13 May 2026 13:51:02 +0200
X-Gmail-Original-Message-ID: <CANiDSCu4fjMpgwbdEq+_Uw=nRGya3Fu6aM0A9N14JLsJauk9fQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lgx11bR8Or1Dxd2VZsKqsoBhl7G-pzaH-gTXE-qB6RaCPEhsNcduKIk6U
Message-ID: <CANiDSCu4fjMpgwbdEq+_Uw=nRGya3Fu6aM0A9N14JLsJauk9fQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] media: uvcvideo: Do not add clock samples with
 small sof delta
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 161025329D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246826-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,chromium.org:email,chromium.org:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Hans

On Wed, 13 May 2026 at 13:49, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Some UVC 1.1 cameras running in fast isochronous mode tend to spam the
> USB host with a lot of empty packets. These packets contain clock
> information and are added to the clock buffer but do not add any
> accuracy to the calculation. In fact, it is quite the opposite, in our
> calculations, only the first and the last timestamp is used, and we only
> have 32 slots.
>
> Ignore the samples that will produce less than MIN_HW_TIMESTAMP_DIFF
> data.
>
> Fixes: 141270bd95d4 ("media: uvcvideo: Refactor clock circular buffer")
> Cc: stable@vger.kernel.org
> Tested-by: Yunke Cao <yunkec@google.com>
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 355b9bfb799e..63850b779e24 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -544,6 +544,15 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
>         spin_unlock_irqrestore(&clock->lock, flags);
>  }
>
> +static inline u16 sof_diff(u16 a, u16 b)
> +{
> +       /*
> +        * Because the result is modulo 2048 (via & 2047), we do not need a
> +        * special case for a < b.
> +        */
> +       return (a - b) & 2047;
> +}
I have modified this function but kept your R-b. Hope that it is fine.

Thanks!


> +
>  static void
>  uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>                        const u8 *data, int len)
> @@ -664,12 +673,13 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>         sample.dev_sof = (sample.dev_sof + stream->clock.sof_offset) & 2047;
>
>         /*
> -        * To limit the amount of data, drop SCRs with an SOF identical to the
> +        * To limit the amount of data, drop SCRs with an SOF similar to the
>          * previous one. This filtering is also needed to support UVC 1.5, where
>          * all the data packets of the same frame contains the same SOF. In that
>          * case only the first one will match the host_sof.
>          */
> -       if (sample.dev_sof == stream->clock.last_sof)
> +       if (sof_diff(sample.dev_sof, stream->clock.last_sof) <=
> +           (UVC_MIN_HW_TIMESTAMP_DIFF / stream->clock.size))
>                 return;
>
>         uvc_video_clock_add_sample(&stream->clock, &sample);
>
> --
> 2.54.0.563.g4f69b47b94-goog
>


-- 
Ricardo Ribalda

