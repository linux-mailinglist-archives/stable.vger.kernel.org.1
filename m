Return-Path: <stable+bounces-230056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGNZN+Atwml5ZwQAu9opvQ
	(envelope-from <stable+bounces-230056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:23:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F447302CA7
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D205930576BA
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 06:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093CF3B0AD0;
	Tue, 24 Mar 2026 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5vBTiwh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74CE3AEF24
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333017; cv=pass; b=oS+i7y+0CC9zI6NCwqlk1l94qRJT5ZwG7XeQ1qhdFRsSynvfRTGNLX5C1WSbYl31pM1Ad1yrGEaqfygjLtJNvsAnKHfP6mXJSg+YaKGBMDysZla98MohFOuMIGw2VLafo0ufRqKUcPIM59/5MhRW98+KGhpi6RXt9Qd9AQjtLV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333017; c=relaxed/simple;
	bh=ZcbX+5mJfGFHcWFhOYfFiN8hHaXsM3DySpqgTEdyijc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG3kCJ7KZWBCeCmcM/P+NOqqQtsHunmbBLo+1V/DzWtpP2nduC5G7enKQfpePepDaRgtvOg+m7N+mm14GgIHUdiaGuNxkqSjjOvZ4jnjktAhorPWqAXFfHKVkM9Ft6iIvgMuRf2lgJt4CIv8R67aDp318NLuZiIiLmi3uKVsK1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5vBTiwh; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b982d56dac4so154030166b.3
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 23:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774333012; cv=none;
        d=google.com; s=arc-20240605;
        b=FmETFQ0xwqrPhF0R6xSO3TA9EZ8YKoj9U8QCkuL84eFj6KJCnvDhaQwlu/SALujnhl
         uT8+sUuV/ko4DttWnGTEA0K0IV2MW4JLe1saAoPOTQD6Y5mbyBHxUWQB7P8kb6sECCSn
         wOJ49TJpci/ui03qwQMOzJi09WqkVShev1OxW2mmbAx2tTLAOxHYxPi9kLuQnZa6NQZw
         rGwvsk8rxAn7zEmqd0+du9SUux8rbWOzgtomGr1hxRtA8nRj7o6UkCgpkKdSiYJHgDrc
         il0PnDcgYlFFPeZACIhtFnPVy+nKLpQZrFX6N3v2wB/fjHiuqWsVscWzeDCOK5E2PMhK
         ma2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+cvaC0YcLoRbJfn1y+y3/naIIgMA8OuvZpHsk5edtbU=;
        fh=jW22127lQZfeP+unbU7RpmxqMbfaxTPtoWgenQgChWc=;
        b=DOXr6vPs3GcOO7Q1s2X1YhrBE0u0x8hKgw+2FFf56EqYUVCET/40+LsYx0S6jc0jNo
         sNfZg3qzflTRgQTa0DaTxkum5RLxnSfmr4VSZdD6DTSZfH/Z2MCsXHxpeWv2ARkphX5k
         INOLn/ouBETRf3t01eGSjlYSCN2KrGn6Ejpq8p7kfmyAPqrQi4VF/Fn/g2B3S4yephst
         l0X98DTPhdNO9ZX9SegJ4Y/NBb9JcNqVuY7bhiuXR1CKgBRt6CFwZWAScbZtDXeg6JAP
         Bdwiy+s6INAllPosP7B+IcbJlSpUD+auvrArPDK3RKc6lH5FIn/o99fv+8VLAuQnwEiR
         6iVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774333012; x=1774937812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cvaC0YcLoRbJfn1y+y3/naIIgMA8OuvZpHsk5edtbU=;
        b=P5vBTiwhKr/mXWFR2ceG3bY4QU5IR7t2lhSZvd4/Ht3Wyv8U3yYpE/04EAqaWYRaWY
         ZKtm7GH/YM/3dkYcK8AimAcQI3hstMd2SB6P5+1pWhT0A0cb7qmV3R6kHIyp9yj3o/6v
         Z80i6vWnW08h+tOmeHlzA1iRncoEPvBz3B9jrxkepDWMYZb6Nf6ajyejmts8rWZJqXny
         A2JIYJ/r2llAyQsk6gwDN3KPLnuDK8ZrKijR7NahAPWhA9ZEPCWKyTqIlx9WjWMYocew
         IOIcwqRYkpIXCLgc8rd/IQjNzWW01MaCpmapXLTCTRLRpuhgF9QSLDpMV02qQsWQCxrv
         j7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774333012; x=1774937812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cvaC0YcLoRbJfn1y+y3/naIIgMA8OuvZpHsk5edtbU=;
        b=iGSxJV1LoJhta1ZlRfMcHZ4IJcyZwXBD3ABnRssrJ7FLA8cX25OsvHeAzlfQZ1w8+r
         tVX/1DxMBBU7ZBuxo4q6Uq2ZRcxXjrTg2lzbO1ewB4tSHAG7Ak8b4/+dfQK/PyMc//NK
         0QV5K/yAC8AmDI91K27Jb5oyiU4CBg56WmqyuqE4fVxn8xm46xd/SqtCkH9t7EitSo8+
         UySB/BlmlPwlPpuvS8P7lOTHZIasJOdQcDN5grigG8pG8TTmh3j4tFEO8K8cssaFz/00
         1jvFOwlX/nTh3kTNJDNTCnwjND8A0ZVwULD5bJogW6flPlftZqda5hQjlAWey+UiyCwQ
         6KYg==
X-Forwarded-Encrypted: i=1; AJvYcCX5HcJ4hEEfznu2E4tgvPeFY2hYWimBiUuD8avsHlJ5ll6AQ198ijN5im1DMCFN7I0u3MCilTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvafq8IMqFp7lxXZs8eIA0XML3emMpO0KkY0Ff45VwgmeOC1n0
	9xAFN798Zv5ikoGrqCZfB/6b2tGeOhxFZ0wj7CeL2sjlPMLRiZARA6s8JxdbVW5jXiY+EAaUuZW
	oCp+ueTqBy2pR7iHi8ErKJW9+s+ay/tY=
X-Gm-Gg: ATEYQzwze5bU8hyuYub4TeN/AATyQXnIebBIh9Jas1kRnjGng3VCFCR0FL4fCHvckTE
	yW5NNhwgIBFrawJsU4i9OK8Lr5klMVZBGxw1dEoF+eC1oVsi/8nnBWpb0Ou1K4RlfdmrYtoOWvv
	1xSWwpwa+VndduHLBIXVk5yX5iJcRWZ5RNJkMywVUi3zwkJ8uZ+oP2fgr4sRjEqdXxsdtMwaOLG
	8hIxR73A6lFrsBoOxNXn+gNDG3m0mKYdfUkkp/Lqg1f16umu+6Yz/i/joJusxocR31PwXsJr53B
	y7GXaic=
X-Received: by 2002:a17:907:da7:b0:b98:4c2a:d503 with SMTP id
 a640c23a62f3a-b984c2ada90mr763599666b.38.1774333011445; Mon, 23 Mar 2026
 23:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321035439.900644-1-LivelyCarpet87@gmail.com> <20260323144535.GB85922@horms.kernel.org>
In-Reply-To: <20260323144535.GB85922@horms.kernel.org>
From: Tyllis Xu <livelycarpet87@gmail.com>
Date: Tue, 24 Mar 2026 01:16:39 -0500
X-Gm-Features: AQROBzBBCv2w0ZOtVdMmuKvgHj7C9SgIeMjOabKYcsILKAH01H0D6sFogiiH00U
Message-ID: <CAJsYhQJm4mW1FHu2d=Pf8PfFyBWZA43QHpQ2esc0Cfuqqehh4w@mail.gmail.com>
Subject: Re: [PATCH] ibmvnic: fix OOB array access in ibmvnic_xmit on queue
 count reduction
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@linux.ibm.com, 
	nnac123@linux.ibm.com, sukadev@linux.ibm.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	danisjiang@gmail.com, ychen@northwestern.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230056-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,northwestern.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F447302CA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'll try out the suggested changes and use more
of the existing handling to create a new patch.
I'll also remove the unlikely(). Thank you for
your feedback!


On Mon, Mar 23, 2026 at 9:45=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Mar 20, 2026 at 10:54:39PM -0500, Tyllis Xu wrote:
> > When the number of TX queues is reduced (e.g., via ethtool -L), the
> > Qdisc layer retains previously enqueued skbs with queue mappings from
> > before the reduction. After the reset completes and tx_queues_active is
> > set to true, netif_tx_start_all_queues() drains these stale skbs throug=
h
> > ibmvnic_xmit(). The queue index from skb_get_queue_mapping() may exceed
> > the newly allocated array bounds, causing out-of-bounds reads on
> > tx_scrq[] and tx_pool[]/tso_pool[], and out-of-bounds writes on
> > tx_stats_buffers[] in the function's exit path.
> >
> > The existing tx_queues_active guard does not help here: it is set to
> > true by __ibmvnic_open() before netif_tx_start_all_queues() restarts
> > queue draining, so stale skbs pass the check with an invalid queue inde=
x.
> >
> > Add a bounds check against num_active_tx_scrqs immediately after the
> > tx_queues_active guard. Use a dedicated out_unlock label to skip the
> > per-queue stats updates (which also index tx_stats_buffers[queue_num])
> > when the queue index is invalid.
> >
> > Fixes: 4219196d1f66 ("ibmvnic: fix race between xmit and reset")
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
> > ---
> >  drivers/net/ethernet/ibm/ibmvnic.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/=
ibm/ibmvnic.c
> > index 5a510eed335e..c939391474cb 100644
> > --- a/drivers/net/ethernet/ibm/ibmvnic.c
> > +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> > @@ -2453,6 +2453,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *=
skb, struct net_device *netdev)
> >               goto out;
> >       }
> >
> > +     if (unlikely(queue_num >=3D adapter->num_active_tx_scrqs)) {
> > +             dev_kfree_skb_any(skb);
> > +             goto out_unlock;
> > +     }
> > +
>
> This doesn't seem quite right. Shouldn't it be as per other
> blocks in this function that drop packets. In which case
> it could re-use the existing handling in the conditional immediately abov=
e
> this hunk.
>
> Also, I don't think unlikely() seems in keeping with the existing
> implementation of this function.
>
> I'm suggesting something like (completely untested):
>
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ib=
m/ibmvnic.c
> index 5a510eed335e..67e1e62631e3 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -2457,7 +2457,8 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb=
, struct net_device *netdev)
>         txq =3D netdev_get_tx_queue(netdev, queue_num);
>         ind_bufp =3D &tx_scrq->ind_buf;
>
> -       if (ibmvnic_xmit_workarounds(skb, netdev)) {
> +       if (ibmvnic_xmit_workarounds(skb, netdev) ||
> +           queue_num >=3D adapter->num_active_tx_scrqs) {
>                 tx_dropped++;
>                 tx_send_failed++;
>                 ret =3D NETDEV_TX_OK;
>
> Where the next line is:
>
>                 goto out;
>
> ...
>
> > @@ -2672,6 +2677,9 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *s=
kb, struct net_device *netdev)
> >       adapter->tx_stats_buffers[queue_num].bytes +=3D tx_bytes;
> >       adapter->tx_stats_buffers[queue_num].dropped_packets +=3D tx_drop=
ped;
> >
> > +     return ret;
> > +out_unlock:
> > +     rcu_read_unlock();
> >       return ret;
> >  }
>
> My previous comment not, withstanding:
>
> The RCU read side critical section is already enormous.
> So perhaps making it slightly better doesn't make a difference.
>
> If so, can we go for this slightly flow here (completely untested).
>
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ib=
m/ibmvnic.c
> index 5a510eed335e..1e1cd8c11cf9 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -2664,14 +2664,14 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *s=
kb, struct net_device *netdev)
>                 netif_carrier_off(netdev);
>         }
>  out:
> -       rcu_read_unlock();
>         adapter->tx_send_failed +=3D tx_send_failed;
>         adapter->tx_map_failed +=3D tx_map_failed;
>         adapter->tx_stats_buffers[queue_num].batched_packets +=3D tx_bpac=
kets;
>         adapter->tx_stats_buffers[queue_num].direct_packets +=3D tx_dpack=
ets;
>         adapter->tx_stats_buffers[queue_num].bytes +=3D tx_bytes;
>         adapter->tx_stats_buffers[queue_num].dropped_packets +=3D tx_drop=
ped;
> -
> +out_unlock:
> +       rcu_read_unlock();
>         return ret;
>  }
>
>
> --
> pw-bot: changes-requested

