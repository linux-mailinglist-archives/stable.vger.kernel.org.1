Return-Path: <stable+bounces-223646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDzaLTTLrmnEIwIAu9opvQ
	(envelope-from <stable+bounces-223646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:29:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF97239BF2
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5612D3021EB2
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90383A4F50;
	Mon,  9 Mar 2026 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXJEPO1V"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E0198A17
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062811; cv=pass; b=n3yi/mThXNJVRitkm+cOO/YzEdkdjFh3sGUH7DnQBrt/ulm8p+/wlYkmUIbARvVKBB7ayngCmj158h3945O3Z91YhIk6TjQu1L3UlqILowT4LIRwmYQOMEFWMkw27sR4lPHOPqNmZMzjYjnFu6NlzutIpb88Gir+5a1cwogd8V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062811; c=relaxed/simple;
	bh=h1QPed/3IFJzeiuQSsWQNCJ6OK9m0ZCjUgEEmCo+gh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7d/uhwQ/J050zR6tGQ9MqB6TfBliGuD6VAR+zzoOHOU4Zx+JiXtB/XNmtZAS5Go5T+3i9PTyjB296XBjbVDLzaxDpXAmOXgdliSRzZGzbM2DWDWGWHpEwNiu3kFdvyMUZPzhemGYUUxd28r+jS6h1b/LwEYw4YMvjSVuOJFd5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXJEPO1V; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b96d784828bso231108966b.3
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 06:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773062808; cv=none;
        d=google.com; s=arc-20240605;
        b=FImtggGLUiXPSTv0En8l4cdUJr+GKgGNtN/CwJ578JWH0VgR/DFzRPXGrE1NhXPjrW
         sJpsvb2TAQVfVDG/qq1CMmNEt6FtiyvifGOwizHZv3hrRdSz2ytwrIFkEGHuJUCU6exU
         f3DoK5HsxSev5BhCiyE9Q1/fJk0EWruk1KiRQONRai1d9uWf2wSK9tECHoGe3aCg7so+
         rAqnHC4AgrzlNHxtiB9wNSPAX+3yAF1GZh+QcD62V4tNTzRNWeNOCCQUuOrchkIPK2hB
         9e826pBhI/jg9Igeoz3Pmgg8bbptgw7+0zmtz+LoMThMfd4j6vqTkhWcP+oWjMLRTtRt
         FxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lSfhpPu6NTHshTQVfO73M/2bhDH4PhFQCW3eSDL+fXo=;
        fh=M9HijMjz1gtMPGPD/7Ha0ThOU75tHZbx3+wRSfLf3eo=;
        b=Dttq9moaTqaYC0e7n/TbOZ0n7WyDM60WrPmOCpusdZa+oc8cakQdwp8BTnzsiVso4J
         3EAvD9XTAKMuOL835CEqgr8OfDy2eUDB2uTk2U84B4X5gi5lCC7Obgv1oWB2rZFSqe7L
         fOQRI5m64mT4Mwta7xeKZc+67gbapW8a+m3qiQFnTx/lXI1Q42GpWiWhiZRHwXfHoDU9
         UsItAUgctSnk2L2NnewT53LVs0k5hLNIjuRUYEKmv7/4ZSzlZhVEg5x59iRs1GBmecwS
         cIAc6Cpweor5Gv+0XINuVFMei1mqhodBew8Ap/gyPMIgIF8iYRU5AtoEihSSOUknIkPh
         CsGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773062808; x=1773667608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSfhpPu6NTHshTQVfO73M/2bhDH4PhFQCW3eSDL+fXo=;
        b=DXJEPO1Vp4HGVXeAK1B8BVbz4hWqMpRjL68GeZP84UAvtalMwc3mmeRjrrQX/fnYrv
         nE6suok2+r2FJPpWboGtn2oUJaYtp9aqoxV9xvoUhpFs+qhYVyQc4/oUyMP2l3UDqcup
         J9QDX8GdxfETEHEYEftH1rTgbMRMDo6XrA75VZ5Wbi/H/k5YWExISK2EvfLbEK3GNOGG
         otH031K4kL+3ZRxvUTIG8muxtOda/pqYJxGET1m4PE2bVwbiZP9xXQ1mBTOaj93eR8AC
         9wPmBEHE55slJEZIrV470VfHfZjDc2k5RACjwjIHilvPes7yhpKogeZ4niwg0o8SvRdz
         2vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062808; x=1773667608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lSfhpPu6NTHshTQVfO73M/2bhDH4PhFQCW3eSDL+fXo=;
        b=BMWqJSE+aKLXJ0Axb3hzaRkRNsmNgyCbG3J3mQ6gvO1zKrATWBhm/PJfq1uaVJgVjm
         ADObFjab+x+nTOjq2ljSdQKuKe/xB/C/Bv1vtrFCs9NDHl90a8EPCqdgBYA0H5MzjPbV
         RSUSUzU/GCRlmHGLBWQAXwKY/zKpQUtzmZxvirqqk0IJCuZhjHxSLy1kxRrvj3soMrla
         eHCBvXlj+UDb/hB+a0L6Ord4plNk/eF45gNzXVuJV0sdjRiuJ1rGA+CfQmyHy1mbiZIX
         u1zOxlP64xp6UALcPpxAhJ4zaqzFwgQOVa8tr1nMTooPF0SUDI4L8sPW8S+8FxNSaZx/
         VONQ==
X-Gm-Message-State: AOJu0YydnnOHeDu6gRL5DixILr6nQ0ZTN5bJQOUHnVJjpvAWfvlwKIqv
	m252pOh5vAkdRnOXA/r87yII5jXDKAa2KPb27BXliJUZ1PQafjtFS01HJOeIRLn6tzKQbOruZvG
	tHvqX+EJQgIkUw6sWeh0acbS365hrf2iZLTYsoGmK
X-Gm-Gg: ATEYQzwa+W/sR6WMcUdEYLwxdT77aukvLhYZWYwZXsfRdgv0c+I0psRk7OeVKDM9DV1
	B9zTjI4EdURgX2LWMy2lIMaNJ0Ce80uG22y3bX8kZZbqYr5kj/lEjByPrxeTMwzKpiBMTC/uaMc
	CXy7Ju/Nl9FVXids8fFk3b7RFJtASMtsAparW4kHQgkk1uF3Ph4IbJow+Hxjg9Bp5sj8AG8GMdb
	yGLLHckgwDvowFD/gECAqdAQnYBRhVktZU0TP+k/MD/vNdrFzAGZ5jgM621S38Dp34yteZjtT6O
	tnSEMuDJdEGxgIBUgqlBv9oxnmLh24zBlDuTv/z8e+658BwrsrruttUtODYAtg==
X-Received: by 2002:a17:907:a42:b0:b8a:f61a:edf2 with SMTP id
 a640c23a62f3a-b942e02031amr574834366b.50.1773062807781; Mon, 09 Mar 2026
 06:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026030918-unflawed-unmasking-3b8d@gregkh> <20260309130029.867834-1-sashal@kernel.org>
In-Reply-To: <20260309130029.867834-1-sashal@kernel.org>
From: Ankit Garg <nktgrg@google.com>
Date: Mon, 9 Mar 2026 06:26:36 -0700
X-Gm-Features: AaiRm51qMBZ2tbM-4JARQfMnRc096H8dJ0VihaurS1MSzE4VISSlWGPRcAGA450
Message-ID: <CAJcM6BGWUiamF-pX_etJqaoYMhzBT_exB94gam=N538y6bxkXg@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] gve: fix incorrect buffer cleanup in
 gve_tx_clean_pending_packets for QPL
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jordan Rhee <jordanrhee@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Joshua Washington <joshwash@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1BF97239BF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223646-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nktgrg@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 6:00=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
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
> index 857749fef37cf..e3c46f791abdc 100644
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
> @@ -992,21 +1001,6 @@ static void remove_from_list(struct gve_tx_ring *tx=
,
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

