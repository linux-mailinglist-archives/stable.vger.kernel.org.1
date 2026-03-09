Return-Path: <stable+bounces-223645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFARGSXLrmnEIwIAu9opvQ
	(envelope-from <stable+bounces-223645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:29:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90969239BEB
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0F7D3064E9C
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19612C08D0;
	Mon,  9 Mar 2026 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDigyx66"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF7198A17
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062787; cv=pass; b=JXVENDoyn2dWn0SapagEJyDXvt9Zf+jqYlwjI0udWKTYnFeiJVK6EspYJZaAV8i/Dfq3OTo800eAkzuISKeg3UsPnlw/rcGOfa0AnouWtQZ2sPlKG6TU7t60DrstwvjYiTso3+/ai63eQvRwXCb4Nj4dFfL0KnHpZKEP92Vhtys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062787; c=relaxed/simple;
	bh=MLRnVrwHOe71gNd/E86u1+1nCOvXV/nTSTUR0emHFFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMIJS/t/8Jkx6+bN/j6HH+xdLnUjC6jHREsgGaD8KZijxjuxfEwqYbJzQS8HlejehVJsO4upwGhk5isnGDouqwWfpzwf/fM7N7ufb6TOhg375diLrGqP3pw3M4CetzJMDB99rBcpjkbrmFvLx+FLBM9O9u6jJFbbLNuhw6c6lWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDigyx66; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b96f02b4329so180567266b.2
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 06:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773062785; cv=none;
        d=google.com; s=arc-20240605;
        b=iNk0Z9NlaiC8jpPHo7FTm9ONbbFqGXA3qq/XK3quPqkOK+kSlhXVTCDOTRvOTT7WZd
         izCIUsVDHVVFM9mkGpcfEVdPZrbZT8WTbGG8dQZK5rz5NCg3L955nPaEqI6xgV2VX72d
         fRTLGbrUsCqIOyoXO3i+pmXgXn6cJ2m13KWanJPCTdfvtN9Z2V+Mm8eHvSLH5InT3yOd
         xQuRwguD3qw36AJfVh7P8yv0zTH8shqK6mGorYPuceEYJbnehHZMv0B3ZBHEpwCLZote
         6yFJtuRy8qa5DfVhUTbIw+yNR9TY4KjXv9uskEucWD2e2EfIH0Y5BIpWQgp3+Uxjm2Qh
         3WKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oixowz9hOqs1JRm0ycSIci6ewWqNYd16EH6MiYr71MA=;
        fh=M9HijMjz1gtMPGPD/7Ha0ThOU75tHZbx3+wRSfLf3eo=;
        b=YK1VUWNEsGZ4e+efeL1hxbTTJJIevQnrQOJkuTlMupL7ZzYj1Kr3QCdOXw3VJm0FfJ
         dV2ce5KigCPhn4x2KypTLwA2NaQFUONgDz0P6+LzAZ4n1rb1Z6Rtgqw5mkz1O3whOIpU
         tx/x6ckNQVjGb8y+qjq2V9HZzmXT67R7bXlC8p1WgTejD/Tn511RX6RTul5AuVonJItS
         NOmNMiqODrLxewb4OpL0R2cCbrIUKcHOhJNPi9zwV4yrBjRCldLuDi81GqxRCu2ww4Lp
         iaGcawVWFHC5xTXNXYGdLvNXGJj30PHTNDICQbkyiya7lv4imB8LmMxx6UKnBQpLZz41
         9M4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773062785; x=1773667585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oixowz9hOqs1JRm0ycSIci6ewWqNYd16EH6MiYr71MA=;
        b=sDigyx66ng1uU195DEql5KR7g+Om9+m8TWjXY0t/TwcFClYawa0mBVT9j3vYQ2FxKh
         2I3/a6fBrFSon3Ih0/ZwMyCK893M5q6kwLfbSOxjSriMOZEH7lm3+dbClBF04vA9rv6w
         Zm+5eeLGTygo9jLk7/GV2Vk4czbWCl1Ja5Doa+WPJw1vgu+YmrOtYG2bBuMPdM3oJNPB
         UYUdC4aRgYk1XKpvzlKJ4BEyITtzVk0g74eFidLcVO/G+uNlxigU3/haZBXVAx+mTY7D
         dzjRtMiTNisW0iyJ2pKc6VW93u0yMe1NnlY9Cflg4aiSZGjwiNaG0KEKZHpWpUtZxfAc
         qnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062785; x=1773667585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oixowz9hOqs1JRm0ycSIci6ewWqNYd16EH6MiYr71MA=;
        b=oNs1s6dUb/8vodo1PfnBRnd7XGO8x2BsA8iokf1j7IBjwY/C7/cpoobyikp/qeVdb0
         FV5flT//VB58RukZ/HyZUgLUAP8888jTxIBOJzfj0qo0H/vh67Lajmet8JSpYObDbd7k
         CamDrN2bLYYTlUTiBcCnGO3CP6CeyBlLwiSU6xESssaVJyc2duuGikRW7ZmgCkgtQYv4
         FqwTZtWxm7RmMhTSJIOHVfDXvmEC7vCY1upwfiq1jiD0HkRt4y1QamS0Bdgc67tzK7a+
         Pwie8T0kCYMbiYqTLjrZDJRXVAtvSfzq434MOc8gmcPFzIuy1eydqgKr3oSYUqfDPvE8
         k1EA==
X-Gm-Message-State: AOJu0YxQ3SkahyspTCjGGZ6RXj+qB+Gb8orIIBr8pOqxHiDHNdMExBqf
	oz6hhi6/UyT1W33Dyu6ezg11nw7rIwCgSOlThyjJD6xQ6MSPl6S1hdVQZ7bcvnz8d90qv9S/0uM
	A7zBT0NbTMsIY+0eEy4+K9Ri2FeL5uOIKrc2h1wcMM9Ln0vkswuTWO9vz
X-Gm-Gg: ATEYQzx2XdFmsJJFXfFWAnIcI5zorVZ/V4+vmygZfAmJ6pKtdX5zHOyFl+59PdfWjb/
	LO0Dujbu3+Dcrakj+rFvjkCeVIfUCVFKZ2uYsIj2LiZlAHbje9OMiam/z5M9xret1XwfOZBBGeQ
	5XNjR8A8StXaeyBl4fPDOgRMZHbDNLCfnSq587CTBi/mkAHYRnohn0EzYNupThxcCAI+5osS+K0
	bhjusVQm9oDbFj0m81XuiPYYt8AzijzYTR+RLCEifVgd8o+CYHa0LUZTC/TJ1xYF7zk6+Y9Wpfq
	azuNqHvRvO0pGZAJwPU0FZULMl3IhUcUgm3UXCo99b2IgDqf8PU=
X-Received: by 2002:a17:906:9f92:b0:b87:3740:dd87 with SMTP id
 a640c23a62f3a-b942dceb6d2mr667242166b.26.1773062784078; Mon, 09 Mar 2026
 06:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026030917-ferment-untamed-144d@gregkh> <20260309124750.861990-1-sashal@kernel.org>
In-Reply-To: <20260309124750.861990-1-sashal@kernel.org>
From: Ankit Garg <nktgrg@google.com>
Date: Mon, 9 Mar 2026 06:26:12 -0700
X-Gm-Features: AaiRm50BfqvRvATeFpmk2K6jyi4rq4qISvkD1pCXpyF5q3iDmeLdFuDTPZx9OnQ
Message-ID: <CAJcM6BGbszBUTo4zHbEsfiDZ+MY+9e9xRpc1EkbQv9XC2PoQsA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] gve: fix incorrect buffer cleanup in
 gve_tx_clean_pending_packets for QPL
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jordan Rhee <jordanrhee@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Joshua Washington <joshwash@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 90969239BEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223645-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nktgrg@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 5:47=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Ankit Garg <nktgrg@google.com>
>
> [ Upstream commit fb868db5f4bccd7a78219313ab2917429f715cea ]
>
> In DQ-QPL mode, gve_tx_clean_pending_packets() incorrectly uses the RDA
> buffer cleanup path. It iterates num_bufs times and attempts to unmap
> entries in the dma array.
>
> This leads to two issues:
> 1. The dma array shares storage with tx_qpl_buf_ids (union).
>  Interpreting buffer IDs as DMA addresses results in attempting to
>  unmap incorrect memory locations.
> 2. num_bufs in QPL mode (counting 2K chunks) can significantly exceed
>  the size of the dma array, causing out-of-bounds access warnings
> (trace below is how we noticed this issue).
>
> UBSAN: array-index-out-of-bounds in
> drivers/net/ethernet/drivers/net/ethernet/google/gve/gve_tx_dqo.c:178:5 i=
ndex 18 is out of
> range for type 'dma_addr_t[18]' (aka 'unsigned long long[18]')
> Workqueue: gve gve_service_task [gve]
> Call Trace:
> <TASK>
> dump_stack_lvl+0x33/0xa0
> __ubsan_handle_out_of_bounds+0xdc/0x110
> gve_tx_stop_ring_dqo+0x182/0x200 [gve]
> gve_close+0x1be/0x450 [gve]
> gve_reset+0x99/0x120 [gve]
> gve_service_task+0x61/0x100 [gve]
> process_scheduled_works+0x1e9/0x380
>
> Fix this by properly checking for QPL mode and delegating to
> gve_free_tx_qpl_bufs() to reclaim the buffers.
>
> Cc: stable@vger.kernel.org
> Fixes: a6fb8d5a8b69 ("gve: Tx path for DQO-QPL")
> Signed-off-by: Ankit Garg <nktgrg@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://patch.msgid.link/20260220215324.1631350-1-joshwash@google.c=
om
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ netmem_dma_unmap_page_attrs() =3D> dma_unmap_page() ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Reviewed-by: Ankit Garg <nktgrg@google.com>

Thank you very much!

> ---
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 54 +++++++++-----------
>  1 file changed, 24 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_tx_dqo.c
> index 26053cc85d1c5..62a6df009cda9 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -157,6 +157,24 @@ gve_free_pending_packet(struct gve_tx_ring *tx,
>         }
>  }
>
> +static void gve_unmap_packet(struct device *dev,
> +                            struct gve_tx_pending_packet_dqo *pkt)
> +{
> +       int i;
> +
> +       if (!pkt->num_bufs)
> +               return;
> +
> +       /* SKB linear portion is guaranteed to be mapped */
> +       dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
> +                        dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
> +       for (i =3D 1; i < pkt->num_bufs; i++) {
> +               dma_unmap_page(dev, dma_unmap_addr(pkt, dma[i]),
> +                              dma_unmap_len(pkt, len[i]), DMA_TO_DEVICE)=
;
> +       }
> +       pkt->num_bufs =3D 0;
> +}
> +
>  /* gve_tx_free_desc - Cleans up all pending tx requests and buffers.
>   */
>  static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
> @@ -166,21 +184,12 @@ static void gve_tx_clean_pending_packets(struct gve=
_tx_ring *tx)
>         for (i =3D 0; i < tx->dqo.num_pending_packets; i++) {
>                 struct gve_tx_pending_packet_dqo *cur_state =3D
>                         &tx->dqo.pending_packets[i];
> -               int j;
> -
> -               for (j =3D 0; j < cur_state->num_bufs; j++) {
> -                       if (j =3D=3D 0) {
> -                               dma_unmap_single(tx->dev,
> -                                       dma_unmap_addr(cur_state, dma[j])=
,
> -                                       dma_unmap_len(cur_state, len[j]),
> -                                       DMA_TO_DEVICE);
> -                       } else {
> -                               dma_unmap_page(tx->dev,
> -                                       dma_unmap_addr(cur_state, dma[j])=
,
> -                                       dma_unmap_len(cur_state, len[j]),
> -                                       DMA_TO_DEVICE);
> -                       }
> -               }
> +
> +               if (tx->dqo.qpl)
> +                       gve_free_tx_qpl_bufs(tx, cur_state);
> +               else
> +                       gve_unmap_packet(tx->dev, cur_state);
> +
>                 if (cur_state->skb) {
>                         dev_consume_skb_any(cur_state->skb);
>                         cur_state->skb =3D NULL;
> @@ -1039,21 +1048,6 @@ static void remove_from_list(struct gve_tx_ring *t=
x,
>         }
>  }
>
> -static void gve_unmap_packet(struct device *dev,
> -                            struct gve_tx_pending_packet_dqo *pkt)
> -{
> -       int i;
> -
> -       /* SKB linear portion is guaranteed to be mapped */
> -       dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
> -                        dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
> -       for (i =3D 1; i < pkt->num_bufs; i++) {
> -               dma_unmap_page(dev, dma_unmap_addr(pkt, dma[i]),
> -                              dma_unmap_len(pkt, len[i]), DMA_TO_DEVICE)=
;
> -       }
> -       pkt->num_bufs =3D 0;
> -}
> -
>  /* Completion types and expected behavior:
>   * No Miss compl + Packet compl =3D Packet completed normally.
>   * Miss compl + Re-inject compl =3D Packet completed normally.
> --
> 2.51.0
>

