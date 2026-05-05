Return-Path: <stable+bounces-244016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHu9GAav+Wky+wIAu9opvQ
	(envelope-from <stable+bounces-244016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:49:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BF44C8DF2
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1E063021AD1
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE323D1CC0;
	Tue,  5 May 2026 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlNEydxc"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCCB30DECE
	for <stable@vger.kernel.org>; Tue,  5 May 2026 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970919; cv=pass; b=fCwLudUVtqMEZdQeU+BI548BgLEvtNR7dxyYjN/DrkXajEsC/o4a2tVankJLKRj4JSxvH6H47TKU75N6eDddURgKKpwkxEQumDWsmuZm16qeGKkbG4aNCndD7TlCAWnp7jCMo/vDU/QngX1nsPhOsZ7iBqRy23PwqG/giGi8+8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970919; c=relaxed/simple;
	bh=oXP7Q9PEWRCYGqRxo/nb7s27Xpd4sVylWQvYZRpHUjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRXiGEOn5QqN3dy8Owy2OJxXYdqKBfZRjP2p8bAMIGUOYR2GG60bjYaaTjYh6vonEOyj/4O8bg/X9h54HFqHXEXMCHuPnamjS34wBbfeJFugHG9Q/goqL9j1fzhi4LNS20+RdldXWlX+TIIEQP51bUp+TonuvEbXr5JNhJGx3/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlNEydxc; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-656d749109cso2718151d50.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 01:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777970916; cv=none;
        d=google.com; s=arc-20240605;
        b=hEmSlovd649Oibci/qo+UzJvJ/07skTMAL2lUPc+WbC8Bp5cbYApgiE7HwxHAI96HX
         V2VQ2cHu8XTmN+nSWz0uOxkoHZNXATuPSJx01aanRBQ0dys8diPxKDHy6wdWEWtdtbFa
         fZfZ6jHEH4rhB83igvfWiLUCqbPS0oLk1cMVerVUuOfTOmYNPpkKpLbvbWIuIEGURPFm
         r1gcg/BrRtcm3wpvZVKD+EKuPscGNZqCZ9h66kVviBtNvstNuyd9DIckWq6SRoPiiOCG
         ulkucRcFgza6qR+J/h07i3IbADlj+TwHbEuPBVvvnmPmTur7ZsjiMs6FqUeBsIxLjr91
         2LDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lHInEywuR/eLrZtnZ1V4BvhNMaJvbKOVJaYJJABdPSo=;
        fh=RsFw3TXh1ERApCj+GBb0e95Mh5fvtj5gFMShlZbcmLw=;
        b=MVtmpp0n9cK7n/amBb+pdvQhkxnbSupynCb1uhX+ZJaw1kMksWRyS/aFOiaeORffpa
         6huJ+J2nuGRP7ABoJwLX/BiMYjyQcJxkP0dms7H2Vx3C3xCyMYeC/+Ax25yEvRiMNF7j
         gi3+4CR0vde/NtxL30DugRZ0CIE/f4cJh47ncg7pwA6j1CDmlE6OMELsfELQLAjkPZz0
         38caakJb4xWHvk0Otj+O6W+4EIHpCHuDIerqVACqGPoPviaQaB2EIIEeqeSBrH8X12dv
         gC577njUSRF7ARuuFUn3OUM8zWfSj/Prf7iTYrQWL4FuEMmPcbfyz0Er8J2uhLN8Wyux
         8Kuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777970916; x=1778575716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lHInEywuR/eLrZtnZ1V4BvhNMaJvbKOVJaYJJABdPSo=;
        b=OlNEydxcU49cGCKseH4IPWP5mOMa0ycowAjPeY2YCKYyw6AgruWhmk2j0VjzGAoVg+
         mPqUAWwOKsENSOXYMvbHiDNmiON3FeoupRvfPGQqps1tmVsUWHyPQ0z2IcK1G2x9JJnf
         Q38QEwy15X2MYkB7ppnm7zd+v/R7OM2dlams0aSYcAvDQllcNiLz0f1S7sLht0/f8qAM
         2Bh0YmlKe7khkptAswqOv7spDe3Qf2TzAMigeQ89amy2xhzlS//nX1gPq5yPZaBSXgho
         tGmyGx77CwPb07ZIDgmGwK6YuTa2/vf1BeMYdaSPRtAdsSSbGBGurmCjHeM70JERBddg
         uWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777970916; x=1778575716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHInEywuR/eLrZtnZ1V4BvhNMaJvbKOVJaYJJABdPSo=;
        b=BqOwUuOjXV3d0Mo9uWn09INHhMtg2PSpILo2eGijCaLxt07nMb3EUGC/0wI7YM6kwa
         vEwqhpd4CIU2MifTOnNwAiQ5cckrK1E3Gl8FN5WNhsqj5nbksMyQSMwcQA/8wwKCdRgJ
         TgoYk62fCzSPqMm9B/X4ZUWwjca01h9cbHd0Wxj2SwVpWVbEtPI+FXQg29ziq6ZK+UhP
         7YsbcjRuEQofKcIG8gxyQIkn4jpiYTQwHcg9QQ9SRhOH8kF5h4iBb+pUbr7VIE69bnqq
         AXrvrYwgCm8Bx09Tl9F/9wDEdDplSLTIrSazJoV3xF+ezPj1S0+AqruOb6pfdkmi7Uyd
         w3Ag==
X-Forwarded-Encrypted: i=1; AFNElJ83e+ojeFOxnrk7EvC5Xyt71pdByDQgubtC8MYSCYk8XARxLjIAINf90nHoz9l4g8Xj4pDZvB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUzrqHFvls5bgDbzAu5F2alSthfLocllky6UZfLLdJ1jnXoekx
	+X9ynZ8jDjgcqLe8x8JHiLxWG6lGUmea22lvGX40tjIqRpEzGp3AR48c9cSiE8cdJtM4yI7jIYw
	uFs/wr5fbwlUaHM2iXdiQ1IrJRLqYaTQ=
X-Gm-Gg: AeBDieuLOnzwyyk+OYmfs7vbsZ9IMeYIW6sgLjNmlvcUxv2y56N3952xWZQjOxse/Lq
	7jzPXrpcgTeTsc/kE+5onKu9NGgYHNvXDgjbiOYIBQWhQ6MG6suu0D2DBRrqZFu3Ri84sf4p2HN
	BgiC4NXSa3BCOdvqQ3//b/tZHR84k4JDtE4JbqrE91UxSsAxWzqmmbVRbhgQ58ppVcvxrmytiql
	dPxCOj/ymURkx/Vn8+FpDvNkuHh/N2+pQppFUewZ6GSCDn9bQL6TtO100lb3N95Kvz7/DktM+BK
	TjREym69//3U+wogRrI=
X-Received: by 2002:a05:690e:4809:b0:652:ddea:11f1 with SMTP id
 956f58d0204a3-65c69eb364dmr1678595d50.30.1777970916424; Tue, 05 May 2026
 01:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418070220.64542-1-lgs201920130244@gmail.com> <DIA4URMZOEAU.1146WQ3M1DO7M@kernel.org>
In-Reply-To: <DIA4URMZOEAU.1146WQ3M1DO7M@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 5 May 2026 16:48:27 +0800
X-Gm-Features: AVHnY4LgTxvDOB1Qfaw_1_n5aA1mALltyh-tHiADgVTMx9kA3PBfqRebAzQUh14
Message-ID: <CANUHTR8XCO=KUvGzpNHD0zCmnZkhNuqAH3XZWz9ka5iUPw3Khg@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: fix device reference leak in firmware_upload_register()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tianfei zhang <tianfei.zhang@intel.com>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 25BF44C8DF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244016-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi Danilo, Russ,

Thanks for your reviewing.

On Tue, 5 May 2026 at 03:18, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Sat Apr 18, 2026 at 9:02 AM CEST, Guangshuo Li wrote:
> > diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> > index f59a7856934c..a6dab34b22d8 100644
> > --- a/drivers/base/firmware_loader/sysfs_upload.c
> > +++ b/drivers/base/firmware_loader/sysfs_upload.c
> > @@ -351,7 +351,8 @@ firmware_upload_register(struct module *module, struct device *parent,
> >       if (ret != 0) {
> >               if (ret > 0)
> >                       ret = -EINVAL;
> > -             goto free_fw_sysfs;
> > +             put_device(fw_dev);
> > +             goto exit_module_put;
> >       }
> >       fw_priv->is_paged_buf = true;
> >       fw_sysfs->fw_priv = fw_priv;
>
> I think this assignment comes too late, by calling put_device() we eventually
> end up in fw_upload_free() which expects this to be assigned already.
>
> I didn't think it through entirely, but can we just move the
>
>         fw_sysfs->fw_upload_priv = fw_upload_priv;
>
> assignment to after alloc_lookup_fw_priv(), so fw_dev_release() does not enter
> this path in the first place?

After manual re-review, I confirmed that the issue Danilo pointed out
does exist. In the current v2 patch, fw_sysfs->fw_upload_priv has
already been assigned before alloc_lookup_fw_priv() succeeds, while
fw_sysfs->fw_priv has not been assigned yet. Therefore, calling
put_device() on this failure path may eventually enter
fw_upload_free(), which expects fw_sysfs->fw_priv to be valid.

I will address this in a v3 patch.

Thanks,
Guangshuo

