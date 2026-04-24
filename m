Return-Path: <stable+bounces-240546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMmIIy7G6mkXDgAAu9opvQ
	(envelope-from <stable+bounces-240546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 03:23:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDF3458B43
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 03:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CBC730125E6
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 01:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7246246BCD;
	Fri, 24 Apr 2026 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZs77KMI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B119C556
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776993809; cv=pass; b=JXaT0Chur7h53bO1vHfxevslVMdvz0oTL4uVCiPr/MXB06DyNwD/cnv5N6ILdP4sOSEaschDR2FsJY20395iBx+Qx9uczaO7cX0P9NWERppL77vwRoMrc3mF0bmOox9+cGNDDXGcKRJGWOI9pnwp3acDc6hzY049NC9DPge9m+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776993809; c=relaxed/simple;
	bh=LZxQiuYx4ox4RBl4n5ZTdHsqwDGgf72MBgrWCsmpZ1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUqM4m5RDMQWSQxCRYr5xr7a5OmX7iurVvk4rvsdYyFzMslgStGT/qjBzRMXzl87Km0+1Ee/nP8E3WV6he4ilScPm0ovRDpBshRXxpYSloeg/a4KAF7VQe++pfA3DD90gTs8gmieM9uIK7Oa559G8+WA0MH6fTtX0y9P3NYStM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZs77KMI; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b24fede2acso48306215ad.3
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 18:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776993807; cv=none;
        d=google.com; s=arc-20240605;
        b=WrHvuVq2a7TkyzxhTwZnh4Rwqu9Vh4wgkc8LRtPUKq9T+A3WB1h0t6G2CIAQByGx6q
         aNduTpNssI67GMHIuTesAHFX/l283vtgzzNvKD5LdomkZ2WAjF2ZMKwyWsv+0eVaS8wf
         ozS0+fFYf62WfEZNguuvBOAdzm/X8GL7Xl5ocaSDgHwFIzy8Q6dmFOC2kjwnulDbI6zJ
         ev3RvNZBBbocJ9j9/yjFBcs5joCxCr9ETkJo8GmSfOIpKk3rb4PShcJqOsfx+VhpFz2Y
         A9iJDny2edNTgLQ2BhPRHICuDsRbjUcDoIR30cIz6JZY7ThqryIcBfbMdOpTg/BZK+Dy
         veXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/DGB0p6PEQGZngruRS3yAoXwqjvYFLn1cZjKZe/H0Wg=;
        fh=5nTS/oI6mcTGE9EHcuHqDwHbgE00hEfzMK2AHK9iweA=;
        b=bQ3/2CndCBAVVo+KFmeIdW4KSWv6DiyH91wvQ/76/7LCHT0d0XDMlAx6dmrMwsiesM
         1i6aZj6MGHJDVQhLrn3/LkH/IIzuj3bbMATLaSm+2chsq8VgRvrwqVgdmnT3UTg87rKL
         TyKnWk6toRo+gs3A5tTfI08gAO+LiHZsEomVcDkE4xwxmcVxI5YnqDQ+TkBP7whrDalt
         g2GwJGWupnCVBP+s1oTSWFoQeIW/v4XRPOR5YRDhgxZ4SAWKpjXDjZQ4qmqYnHle/NgP
         2YCiH9fonndco2EYGjoymmjUzpjGmHCDXI3IAKqhdPSCZYwVQiyBQOPldwZIsZIicJ4w
         1KZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776993807; x=1777598607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DGB0p6PEQGZngruRS3yAoXwqjvYFLn1cZjKZe/H0Wg=;
        b=RZs77KMI145HgJ+BiXtX909VDMni6Kq/0y4Zj1DvhLNg3ZMnoSMJwU0F8xeKSS8UMj
         k4HXK+R5IcAgQitlLrpGm9qzNN7mTnR0mp4TXAJdRpc+4YtJEsJ/vFrjw3K4H7Nrw3Qg
         RRCamprtqU+oKTaJE97VGJFZmX6EpYNfPz9WyVA/x/oHkH6ww+ElmbQQjT/opY5EoMB4
         x5edxHXdV3ysrgTi6ARbHxEl+FFfGnBSF5PJv+c2iXdCmwbG3qcjIT9mjt2Nfq0RZhrz
         ej8DfQoWURbe+NP+mV7iAXUfJo+9YJE4YXyLDrKH4ynto0/fDlCnLZSjGG2gWiebxs2M
         fxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776993807; x=1777598607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/DGB0p6PEQGZngruRS3yAoXwqjvYFLn1cZjKZe/H0Wg=;
        b=TL+UNstBxzu++BmvHf8rsTBdW/BSpGXRK+pwzZVbhcLCCQH0Lpc4yxHbZH7wrhfdi1
         6827Q7/8DQ8Swkvqcdg/QPsIjtC5bRLLS7vgy5xFA6fbpFHaEsp4ehlLimpotYeP5/Ea
         5I023UXc2fw3gun0r/o3o1ARhfnwwKc7i2H0PXnSmYABvalV6E7+0QXVsnFwek4m7I1P
         Xi5zKI2NUZGxMOWJ+tuMXpyHrLYGryyX5DTx4Yj9x3xr1xRVXj2RgUtOVnLY7WTM5Qt5
         2+TmCBDPkTjvECxTChqgfII0wywBPgJWrATBPAKFvtuzFecu6m+ry4VYDQFWj9mt4Rln
         sJQw==
X-Forwarded-Encrypted: i=1; AFNElJ/IW/PlZLucpUA6URei70IBd2o4A3C2HOAAMyrz/zsbDNTkipDKqHjeOcr0450+zzXetEosCbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx74+IP7HqJ3B4yi29+CnIQueE3MKjcfQ1qR1zr2ODVm9jiZupT
	4wand7aMoo3Co0/x2NZloN2KEy85FsCiSfPT34LeW8LY61L5VtoBXXjl+TCBIkRPPXRNU2+4ioF
	YFcUf1xUK6CTsHlbPPaRphh1hMDjwr+wOI0E5CqMx
X-Gm-Gg: AeBDievlMf32CGY2mwOHV044duIJy8q418Of2HZtO4ORBUS4XhUuSawFpWxMqmhcrfV
	Q2uoJfzsi1WQ8eipHfYOp25QZqzsIVIRCoSo3QmH7K8YSSszBfnb2s5OYSlD+nQW1bCDMn/xm8Y
	FkkQqzoDA3v20izrLFAiIwRPbro6ayycfu5Q6xd5dp8y2hPGXIlxj4n00OyyTyiv62BHRTzQUbe
	4a8j9eMHS2Xaxatgkew/q0YOwvYrZ3jKo/BzSs4aDI/c7NKrA24v6AACu0a+5TBi+MDPdvSIuUL
	0ir+NwRl3SNDz9wxeOEoUFjawS57YvdOU72vVqt0X8sAM7Tx8rgzV0+H9g==
X-Received: by 2002:a17:902:b40e:b0:2b2:5203:acd3 with SMTP id
 d9443c01a7336-2b5f9f3d36bmr245167045ad.26.1776993806167; Thu, 23 Apr 2026
 18:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
 <20260420171837.455487-5-hramamurthy@google.com> <d0981984-b55f-495e-848b-6e9611f0c2ff@redhat.com>
In-Reply-To: <d0981984-b55f-495e-848b-6e9611f0c2ff@redhat.com>
From: Pin-yen Lin <treapking@google.com>
Date: Thu, 23 Apr 2026 18:23:13 -0700
X-Gm-Features: AQROBzAGcS2PjTs5swOOoaKfbZg2p-wqysByjPRmX2HYW5vKVn4V0GsCwsuCX18
Message-ID: <CAHwYsioVLVsHpUWbokBrzcbQ6BEYTWP9B+TYqZVbU04-EHqtgQ@mail.gmail.com>
Subject: Re: [PATCH net 4/4] gve: Make ethtool config changes synchronous
To: Paolo Abeni <pabeni@redhat.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, maolson@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, shailend@google.com, jordanrhee@google.com, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2BDF3458B43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240546-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,mail.gmail.com:mid]

Hi Paolo,

On Thu, Apr 23, 2026 at 6:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/20/26 7:18 PM, Harshitha Ramamurthy wrote:
> > From: Pin-yen Lin <treapking@google.com>
> >
> > When modifying device features via ethtool, the driver queues the
> > carrier status update to its workqueue (gve_wq). This leads to a
> > short link-down state after running the ethtool command.
> >
> > Use `gve_turnup_and_check_status()` instead of `gve_turnup()` in
> > `gve_queues_start()` to update the carrier status before returning to
> > the userspace.
> >
> > This was discovered by drivers/net/ping.py selftest. The test calls
> > ping command right after an ethtool configuration, but the interface
> > could be down without this fix.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 5f08cd3d6423 ("gve: Alloc before freeing when adjusting queues")
> > Reviewed-by: Joshua Washington <joshwash@google.com>
> > Signed-off-by: Pin-yen Lin <treapking@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_main.c | 56 +++++++++++-----------
> >  1 file changed, 28 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 8617782791e0..d3b4bec38de5 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -1374,6 +1374,33 @@ static void gve_queues_mem_remove(struct gve_pri=
v *priv)
> >       priv->rx =3D NULL;
> >  }
> >
> > +static void gve_handle_link_status(struct gve_priv *priv, bool link_st=
atus)
> > +{
> > +     if (!gve_get_napi_enabled(priv))
> > +             return;
> > +
> > +     if (link_status =3D=3D netif_carrier_ok(priv->dev))
> > +             return;
> > +
> > +     if (link_status) {
> > +             netdev_info(priv->dev, "Device link is up.\n");
> > +             netif_carrier_on(priv->dev);
> > +     } else {
> > +             netdev_info(priv->dev, "Device link is down.\n");
> > +             netif_carrier_off(priv->dev);
> > +     }
> > +}
> > +
> > +static void gve_turnup_and_check_status(struct gve_priv *priv)
> > +{
> > +     u32 status;
> > +
> > +     gve_turnup(priv);
> > +     status =3D ioread32be(&priv->reg_bar0->device_status);
> > +     gve_handle_link_status(priv,
> > +                            GVE_DEVICE_STATUS_LINK_STATUS_MASK & statu=
s);
> > +}
> > +
> >  /* The passed-in queue memory is stored into priv and the queues are m=
ade live.
> >   * No memory is allocated. Passed-in memory is freed on errors.
> >   */
> > @@ -1434,8 +1461,7 @@ static int gve_queues_start(struct gve_priv *priv=
,
> >                         round_jiffies(jiffies +
> >                               msecs_to_jiffies(priv->stats_report_timer=
_period)));
> >
> > -     gve_turnup(priv);
> > -     queue_work(priv->gve_wq, &priv->service_task);
> > +     gve_turnup_and_check_status(priv);
>
> Sashiko says:
>
> Since gve_handle_link_status() can now be called from process context
> via gve_turnup_and_check_status(), while also being concurrently
> executed by gve_service_task() on the workqueue, could this create a
> time-of-check to time-of-use race?
> If the physical link toggles rapidly, could the workqueue thread sample
> the later hardware state (e.g. OFF) but see the software state is
> already OFF and return early, while the process context thread sampled
> the earlier state (e.g. ON), evaluated netif_carrier_ok() as OFF, and
> proceeded to call netif_carrier_on()?
> This might leave the software carrier state stuck ON when the most
> recent hardware state is OFF, because the condition check and update are
> no longer serialized by the workqueue.
>

This is a legitimate concern, but it is not introduced by this series.

gve_turnup_and_check_status() is an existing function. And, given that
there is no locking around gve_service_task(), there could be
concurrency issues on gve_handle_link_status().

We will upload a separate patch to fix this.

> Notes that there more comments:
>
> https://sashiko.dev/#/patchset/20260420171837.455487-1-hramamurthy%40goog=
le.com
>
> but I'm not sure if they are actual regressions introduced by this series=
.

Thanks for the pointers. I'll reply to all the Sashiko comments on the
mailing list.
>
> /P
>

Regards,
Pin-yen

