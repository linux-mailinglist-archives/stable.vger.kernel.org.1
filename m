Return-Path: <stable+bounces-230054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOfrCE8twml5ZwQAu9opvQ
	(envelope-from <stable+bounces-230054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:21:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C79302C19
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD9C31BE1D9
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 06:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509143AA4F7;
	Tue, 24 Mar 2026 06:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czwr3N4O"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5E3002BD
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332483; cv=pass; b=llarEQvPKvUNvN97PbWLGdAR/y/JCLGu7OGIsNaljzodzJHVyfyIy2nvHxi0pttPFKrjsF/ybmDE8VBZGurYydMfAcVS5gPBfh3hgINerSqffKZVT1xtGtIxKLgWR/n/9vyiSDeG4C9kBvu3P21FMQOqyiOjVx0ezit2LZ2hXqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332483; c=relaxed/simple;
	bh=mI7IXHOvVwfOeSEe+wG0QApSngBTg9jiiTJhWvTjxNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sskdiRl8e9ClWk2eXM7/n+deccsQ/Y6U8BGU9cUJcEeoCyMBirTPA6bCq+WGTWMf7lF33Sk6HBGoaLb2RKoQ/HMPquGQqeMI7SK9RAXjPIUVQvd7YhO1kTpVPwEn2h6Eezkppi+/kewj7l+grhVxW9tzma0PGspUm72okP4IBcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czwr3N4O; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so591752966b.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 23:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774332480; cv=none;
        d=google.com; s=arc-20240605;
        b=dbLj/bl7kC8frfEzTWDCg6FK5bA1SfH+ZRGpx3UfBqfKblcpJqWDPZXbDQxXaCch7O
         2bUQLN+n07iDfAWh3i996qsZyPpCezMlDg82qsop3Mooz1fetk6BmIJG2wBilWzV+HzI
         bsaxQiyPjStURPPTS4Q4tIkXACSc1uSC0MZ3YCA+ahvkVRAtq8yQ/TH2j+Mq+vKQdKaO
         gtbsDIPlxFuyOUJFStB6TE5tM3zWzdwjmT1yTR2oUqYEoMTXg9HMEPi/44/R8i2o794q
         uGTAEJHO5a1U0wXno6NOoqMDfHeAhXVs3ftEYSxylfvlM2/tAJbZNlRwZiPxpM2RLeDL
         ievQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B5zvAs0ntexVIDD9sucPNtVKRPH24qK9vYHSkiDVFPc=;
        fh=WgHW/+dXcjhzi7GHbCzGGWj68Al5WYyT5l577EjEtwc=;
        b=LmGwFOBNtlEG1GbjQD6QJ5XJJ2wpSSMH5gXgJIUFGI8kxE7FvLZrjseMJH73wIJINW
         VwLb24RkqQNSwFikp54HS0elinM93BqRvceXvm09lhzE1A1I6tL4eMZ2Y9GDf7RrJF5q
         KAlxr9nj2EgERlCg2KK9dB0D6+mnDGDQ/hoc3+T08TBl/bCXoX9UwPcVnYMatWn4nR6+
         qBR0MfAev/emN/gRW1Cb/rAO6kqflN3pG1i0TG2g/4qXGRizbVolsLL+msJAnxB7+yyM
         GEaqsfiMvZZuawjBG8oU9NvkWCKZxRaM3uc+xeVAmTFvT39BRpo14iLujYo7Rrd+Mx3E
         pULA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774332480; x=1774937280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5zvAs0ntexVIDD9sucPNtVKRPH24qK9vYHSkiDVFPc=;
        b=czwr3N4OzNJYD72GQtxe/dMQdazGlyXGbhN3w45SUsLiu5pBfrdqcdFn2k7KZcPGOY
         lEKEjKC6jlsEs9w3hIDXhMqqQ2kO2bguL5uKHEYsGaVQe5D4Y4KjsvBrwwo+NMJbijo7
         WUNLHAheDm6ZhyK6Y+V70T3mA9xBa6T3U+ntIeQhcowqONeCiRTMW4DQfOzystf9fU9S
         K1NK+tRt0WUe+zN5uHEEHuPwr4VeTsUspLNjL/AwG3qSwhaFns6iY32GWzDU+QspXwbU
         TPOAzOxlygMcY7Myu6FL16/Srd0BMuCyYELA45lfFlIcP6at+ekHiT+hFT0Fq5H2QP9R
         sz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774332480; x=1774937280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B5zvAs0ntexVIDD9sucPNtVKRPH24qK9vYHSkiDVFPc=;
        b=SU9Bh6E1S4JgnxrED2a90267v7UPNaLeMKJug/Zin8DMryTOZodo1zAxB0UQGk7GYu
         lnOtPaooA/AQn+VVwCnAZrcSdj6DemmLclpFsyugw+Xf9kJDwSOjf2H5tUQ1OOOBP6rM
         Ouic7TFBBXd4pOpHv/PnG2m7k5FIeg3Jnb087/J4Jva9zGhx72Oh6SKO2HXSsjR1wLn2
         zh5JzCxtnCeoW3M+dwAdcIc6dmKFuN9UDDEiHaa8Pr614JecE/iGb1IhIdwv1C9wzfNp
         mi3X5h0+Ri5x3otPaFiL2rFofyrwz1eb/DnI5X5UMHL1i/lXg/oiITozN3kbmGHLs5Pa
         UyxA==
X-Forwarded-Encrypted: i=1; AJvYcCVq8W/VUesrA7V4MYe+YUmG1YIndbUVVrpsJDNsOuxFVxKhtgMq40P/AuCBoZO1IMtnUZXVmmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBcdGwFqs2gGlGa1DjNh+pkxe4TSAoEn3u2vhPeIDOh8wOdqPO
	pr36ArFKo2rvCVeyNWnrKCCMO2UByBMMDd0s3rMgARWnpq+xXkYIibLnE8+gUb0u3cPUSb1W4aO
	nb1LSreMLoeRkfWwjH0gtVSjcF+h7zL0=
X-Gm-Gg: ATEYQzzT7v3WxJDSf2ENvHnz95wwgZ3F+t3QDfoO5gE5g53ix/1fv2H5o1+p+EbxJ3s
	7e/wzUIxu80Gmigt9boC2Z7xnK1Su1F+WS1vj924nlhaWbZIcnNdJheDwAfe55T2iTsZTUl9k01
	78BsdlFyVdx26nDjV2LmsubSmzJrWI1pOjUuakXc+P4C5w6xlpfxT2iPReKiF0AkVW/t+fXsTn9
	c3pyZFTnRE3OkDGcwhM/QMbiMmVa1TDZchOMoGO8TCBbo9XHkd1cSxIKvTNycFjD2cO2d6ai4wI
	2yL/Jjc=
X-Received: by 2002:a17:907:1c89:b0:b98:70fe:cd9a with SMTP id
 a640c23a62f3a-b9870feced9mr385081766b.57.1774332479655; Mon, 23 Mar 2026
 23:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321041058.901149-1-LivelyCarpet87@gmail.com> <20260323141822.GB69756@horms.kernel.org>
In-Reply-To: <20260323141822.GB69756@horms.kernel.org>
From: Tyllis Xu <livelycarpet87@gmail.com>
Date: Tue, 24 Mar 2026 01:07:47 -0500
X-Gm-Features: AQROBzC9ip5K_wNQFZvrDdtzllrm__8yUSGaMMq_v9fzmsTMIsGUbtrFjLi2bjE
Message-ID: <CAJsYhQJga9M1aqeOLu0ni4i5iRirTDTxP1c8qyWz4=-9pBpRtw@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: fix integer underflow in chain mode jumbo_frm
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk, 
	maxime.chevallier@bootlin.com, peppe.cavallaro@st.com, 
	rayagond@vayavyalabs.com, stable@vger.kernel.org, danisjiang@gmail.com, 
	ychen@northwestern.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230054-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com,st.com,vayavyalabs.com,gmail.com,northwestern.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76C79302C19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I will try to change the code to consolidate with the ring-mode
code, avoid whitespace diff, and resubmit the patch with a new
correct subject line. Thank you for your feedback!

On Mon, Mar 23, 2026 at 9:18=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Mar 20, 2026 at 11:10:58PM -0500, Tyllis Xu wrote:
> > The jumbo_frm() chain-mode implementation unconditionally computes
> >
> >     len =3D nopaged_len - bmax;
> >
> > where nopaged_len =3D skb_headlen(skb) (linear bytes only) and bmax is
> > BUF_SIZE_8KiB or BUF_SIZE_2KiB.  However, the caller stmmac_xmit()
> > decides to invoke jumbo_frm() based on skb->len (total length including
> > page fragments):
> >
> >     is_jumbo =3D stmmac_is_jumbo_frm(priv, skb->len, enh_desc);
> >
> > When a packet has a small linear portion (nopaged_len <=3D bmax) but a
> > large total length due to page fragments (skb->len > bmax), the
> > subtraction wraps as an unsigned integer, producing a huge len value
> > (~0xFFFFxxxx).  This causes the while (len !=3D 0) loop to execute
> > hundreds of thousands of iterations, passing skb->data + bmax * i
> > pointers far beyond the skb buffer to dma_map_single().  On IOMMU-less
> > SoCs (the typical deployment for stmmac), this maps arbitrary kernel
> > memory to the DMA engine, constituting a kernel memory disclosure and
> > potential memory corruption from hardware.
> >
> > The ring-mode counterpart already guards against this with:
> >
> >     if (nopaged_len > BUF_SIZE_8KiB) { ... use len ... }
> >     else { ... map nopaged_len directly ... }
> >
> > Apply the same pattern to chain mode: guard the chunked-DMA path with
> > if (nopaged_len > bmax), and add an else branch that maps the entire
> > linear portion as a single descriptor when it fits within bmax.  The
> > fragment loop in stmmac_xmit() handles page fragments afterward.
> >
> > Fixes: 286a83721720 ("stmmac: add CHAINED descriptor mode support (V4)"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
>
> As a fix for code present in net this patch should be targeted at the net
> tree like this:
>
> Subject: [PATCH net] net: stmmac: fix integer underflow in chain mode
>
> As is, our CI tries to apply this patch to the default tree, net-next.
> Which fails due to a conflict with commit 6b4286e05508 ("net: stmmac:
> rename STMMAC_GET_ENTRY() -> STMMAC_NEXT_ENTRY()"). So no CI tests were
> run.
>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/chain_mode.c | 71 ++++++++++++++--=
-------
> >  1 file changed, 44 insertions(+), 27 deletions(-)
>
> The bulk of this patch is whitespace change (indentation).
> So seems useful to examine this patch with whitespace changes ignored.
>
> git diff -w yeilds;
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/n=
et/ethernet/stmicro/stmmac/chain_mode.c
> index 120a009c9992..c8980482dea2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> @@ -31,6 +31,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, stru=
ct sk_buff *skb,
>         else
>                 bmax =3D BUF_SIZE_2KiB;
>
> +       if (nopaged_len > bmax) {
>                 len =3D nopaged_len - bmax;
>
>                 des2 =3D dma_map_single(priv->device, skb->data,
> @@ -77,6 +78,18 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, str=
uct sk_buff *skb,
>                                 len =3D 0;
>                         }
>                 }
> +       } else {
> +               des2 =3D dma_map_single(priv->device, skb->data,
> +                                     nopaged_len, DMA_TO_DEVICE);
> +               desc->des2 =3D cpu_to_le32(des2);
> +               if (dma_mapping_error(priv->device, des2))
> +                       return -1;
> +               tx_q->tx_skbuff_dma[entry].buf =3D des2;
> +               tx_q->tx_skbuff_dma[entry].len =3D nopaged_len;
> +               stmmac_prepare_tx_desc(priv, desc, 1, nopaged_len, csum,
> +                               STMMAC_CHAIN_MODE, 0, !skb_is_nonlinear(s=
kb),
> +                               skb->len);
> +       }
>
>         tx_q->cur_tx =3D entry;
>
> The code in the else arm of the new condition is quite similar to
> the (not visible in the diff above) code at the top of the non-else
> arm of the condition.
>
> I do see this is consistent with the ring-mode code.  So perhaps it is
> appropriate as a fix. But I do wonder if this could be consolidated - e.g=
.
> by setting up some local variables rather than moving the mapping logic
> into a condition.

