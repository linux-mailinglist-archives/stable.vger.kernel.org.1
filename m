Return-Path: <stable+bounces-241439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA9QOBDG72m4FwEAu9opvQ
	(envelope-from <stable+bounces-241439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:24:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 493A3479FCC
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DBC93006796
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171CA366DB4;
	Mon, 27 Apr 2026 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7eTLbkH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50C736605D
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321382; cv=pass; b=uhCkvuEDIgr/m1zUaPxNuYMuARoGNVE5FA5OpBTqJXceX8gweup6VF4DzsvSCCA6FsCosALhjF48lJRLsje02dNSxMAFEZm8zomLn108rXW3DnAss+FQQ+PyhW5N4SWDeyWjSzK86Bu0XoNBNOnoyrpd0dbSbC0DIISdpuQjUKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321382; c=relaxed/simple;
	bh=wLhzACwKAv9l7tovfBKzPDMF7NPXf/fRsDIOmkSEMsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4zeOhOX3xYzR2wAQ+nRal3Ea/QCEzUpda/T7zUxiN/b7ZFnI+eQZPvrCFeoVu/ie3PfHhPy+CVyxAfbI466DmY90T1DDqK2iH185h3oYEaHuKzWTOiCibqLqIwXlWxtpiXHzBXS1Q8OzKEzntWfRoOhB3XISXtfDR8T0/k47qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7eTLbkH; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82748257f5fso6105252b3a.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777321381; cv=none;
        d=google.com; s=arc-20240605;
        b=GkhyR6mesKwvjaSHKkVlHaV5mxq1V8SBbbVDH69g3R2ZT0+2FJdL06TmEpmadNqo4B
         DSTgbAr4DekUWYmisJHd+kgRyyEtzgRwkXSWg5c8qc4oPxo0bhHpj4DuUFezI+dVVG5l
         JbTAkKJts2KNmfAdCNOu7m4SQE8ET0AdA3gZM+N4u2PDM5YxIO6uHblJfLjw8aGFzOO6
         ZIo3DgTtzd8YsTKOiMSaEI1QNAh6aMKmUXe2+IlIt8zMdG/EzM22O+fo2CCQWZU5dZ5P
         e+5atlxlwbfSZq6UOCX5c4ZRh89ZaAZBevzByCqKjc7awl+hbG0yVP3FI8TqP85pbPoC
         p+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=glu0c7/GlCCLUBKIwdpH1OtAWRB3GEXQxIqPmsJa7NA=;
        fh=KHNEYBGUhbKBpOJrtVJ8qS0RSIB2miAM/5aSAkbVt2E=;
        b=eTOW/CpqpFQVTXClZyn3KFFMAmqJ18EqJ7OUcfFEJ3JIEhUc7gTOD6ZHLSe6L5RV/j
         gNZyzfI0hsnCLCDu/vcy9FJiwfoxvc5SPtFSN2JIugG1OrcCt7I1FzTiSkd1OW2TO7Ry
         mwIlEODH6Oa8aLaMxwavtucI+JKsOKw0cqETO70ZBslkhXXD/EPiUR/L6ACbeZM0csIJ
         J+LDLHwdu1FPhaF7dZo623GkrVVhHgqesBnQizeQXhLXgSs79vmbgB9d1GQxEpRDeWI9
         PuJG202gbD5LGKSdLkxbdjHlzJwVDq7M6KPtViGCfhfAuA8/7DfIQ/Rd6AVrTWwLPFCI
         x7aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777321381; x=1777926181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glu0c7/GlCCLUBKIwdpH1OtAWRB3GEXQxIqPmsJa7NA=;
        b=m7eTLbkH4rGKmV79xGg0Cxga+CN6wwsGkoaK8Z0KGimYbSSpay426vMVrkWE383Pri
         JMrv2+lLL/LwOAy+iGKBvWT1p1s86d9tW1M0oWoP2FBDXkXoMePKSfJ0HovlCmvHS+WU
         flHog7TbktVYHB4nbzLLTb/o//WS553AHUDUXFo9bV8cXi4EjWdCyLNql8GgOaeW6XwK
         x7bONS/eMvW1ddjnZe9JVPLH3zOxzTF1x00P6s9EtWz5fMM2Wm5+3dagD3F6IDC9wqEp
         Cb3ehM2+LSbyxby5Y/YivGTFOEfaRuHuP4RbfPRPw/1OflIacHJTIG7XNnxmC53WtR0l
         4HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777321381; x=1777926181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=glu0c7/GlCCLUBKIwdpH1OtAWRB3GEXQxIqPmsJa7NA=;
        b=gwBs8IJOXxh3GuLMJvRr9DZe9LrerAmfiw34PiV9W2Gny2LYWPRSykgIgufXm8/wCy
         /rrU29PZ8T7e1T4s4OqaFQinJUyhlIowjZChADCzhDRqg6WsWdImJ3TNjRwpKjI361RF
         iWg+5sDw/bViZ+4TgOJJRn6rQL0p8HdyPAblVshLGCyM6lS30CD+W58i/AKSbw8FfGHA
         iLkbHsozCf2H2Zs1LNX6X06NM/Qw3aM0+vHRRY4SjokMKVPZALnTrbFxfJW7xpRJqNry
         dbtyxd+w83ctzbiQK4ZTlt7cOxKKJyrH27uW7zw6BBYweg9Y1aVUNBcA9fljEivnuHL7
         TrQA==
X-Forwarded-Encrypted: i=1; AFNElJ9CNr+kXOCK5K7Eba2z+SEysEWcjhOSUNJwg3Z4vZk6pD7sqak4WPsrY01imzfDoyDSjWdK5GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvfWdRVcJY0uIk9Cpd4CPF0w0lcipFLVV/2QLNgAP9xiIefg4d
	QHLiv62dXL20lTq3g+mjfaq2kufQci8szEdvw5qHK/es6fXw1TRYHQn4Tq2IDVRVz2cUwFBkSsD
	nFokKqoaAqsExIWPIdx8vjUJS4HtnU3n7dVi79vle
X-Gm-Gg: AeBDievh3lD3VkxDlblP1zmR3MlqhmdFROL2cnwDqFad7cPWzp031r7pA7U6+P3Vyu8
	O3WWk6UzKtKDTg7lzjr81xU0zqu/Hnd5VSJnkXCEQtN8Xua3V50FebnGUhr1XppMSk0eMEoyiBw
	KkKP/oW65cx8XFc+krJ/nqL94ZEoJSoLIRMjnSrR6JpkaL4+2JnLxt7daEV9IiTW1KLFiZ+I7Rp
	CzgBpeg8SIQSo2orEZRQTSf1tC+tMzZAzBEy/1TTl9uXojxF6VwH2QRsoDNbWxFTW/AotFZjzbD
	0iXElF9aRGQpVwsVjRNMH5RBzoppQ2dXjFs5TOxZpSFq24MVt/7JkcKc3hc=
X-Received: by 2002:a05:6a20:4320:b0:399:831:cc29 with SMTP id
 adf61e73a8af0-3a39c6534c3mr136415637.23.1777321380345; Mon, 27 Apr 2026
 13:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425002450.163421-1-hramamurthy@google.com> <20260425002450.163421-2-hramamurthy@google.com>
In-Reply-To: <20260425002450.163421-2-hramamurthy@google.com>
From: Pin-yen Lin <treapking@google.com>
Date: Mon, 27 Apr 2026 13:22:48 -0700
X-Gm-Features: AVHnY4Jy3b7j4bR2l3wUV-1eR_7SbH4m6nNRJ84JfpDj5s9hqbp0D9BSMExwtxE
Message-ID: <CAHwYsiorqB9w3Js+yh+kkCOVEiGjMY=tLNjVc2MePbBWxyKg_Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/4] gve: Add NULL pointer checks for per-queue statistics
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Debarghya Kundu <debarghyak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 493A3479FCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241439-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Fri, Apr 24, 2026 at 5:24=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Debarghya Kundu <debarghyak@google.com>
>
> gve_get_[tx/rx]_queue_stats references the [tx/rx] null rings when the
> link is down. Add NULL pointer checks to guard this
>
> This was discovered by drivers/net/stats.py selftest.
>
> Cc: stable@vger.kernel.org
> Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
> Signed-off-by: Debarghya Kundu <debarghyak@google.com>
> Signed-off-by: Pin-yen Lin <treapking@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 424d973c97f2..ef00d9ca1643 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2746,9 +2746,13 @@ static void gve_get_rx_queue_stats(struct net_devi=
ce *dev, int idx,
>                                    struct netdev_queue_stats_rx *rx_stats=
)
>  {
>         struct gve_priv *priv =3D netdev_priv(dev);
> -       struct gve_rx_ring *rx =3D &priv->rx[idx];
> +       struct gve_rx_ring *rx;
>         unsigned int start;
>
> +       if (!priv->rx)
> +               return;

Sashiko says:

Does this NULL check safely prevent a use-after-free regression in lockless
paths?
Queue statistics can be accessed locklessly from the core network stack
(e.g., via ndo_get_stats64 under rcu_read_lock). If gve_close() is called
concurrently, gve_queues_mem_free() frees priv->rx and priv->tx using
kvfree() without an RCU grace period (e.g., synchronize_net()).
A concurrent reader could pass this NULL check, stall briefly, and then
dereference the freed array memory.

Sashiko also made a similar comment about the tx stats.

While this race between stats and gve_close() is a pre-existing issue,
we will address it in a separate patch in v3.

> +       rx =3D &priv->rx[idx];
> +
>         do {
>                 start =3D u64_stats_fetch_begin(&rx->statss);
>                 rx_stats->packets =3D rx->rpackets;
> @@ -2762,9 +2766,13 @@ static void gve_get_tx_queue_stats(struct net_devi=
ce *dev, int idx,
>                                    struct netdev_queue_stats_tx *tx_stats=
)
>  {
>         struct gve_priv *priv =3D netdev_priv(dev);
> -       struct gve_tx_ring *tx =3D &priv->tx[idx];
> +       struct gve_tx_ring *tx;
>         unsigned int start;
>
> +       if (!priv->tx)
> +               return;
> +       tx =3D &priv->tx[idx];
> +
>         do {
>                 start =3D u64_stats_fetch_begin(&tx->statss);
>                 tx_stats->packets =3D tx->pkt_done;
> --
> 2.54.0.545.g6539524ca2-goog
>

Regards,
Pin-yen

