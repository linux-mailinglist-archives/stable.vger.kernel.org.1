Return-Path: <stable+bounces-237791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LeJLKwd3mk1ngkAu9opvQ
	(envelope-from <stable+bounces-237791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:57:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0404E3F903D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE29630115B3
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB1D26A0A7;
	Tue, 14 Apr 2026 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tceiYj4t"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB13939D3
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164016; cv=pass; b=jqQrBLHOQLBPmyHTSC/z2zpFrAkcy4nK42PwhVt3kbLBCoCv/IOvYIJN3JdqVH/zk+ddzigdkMP8wcZRP/9Edn1MvTKjECi6ptRCe+LwO/0FMrqCZBHSlyfo51uvlEpHfpdTExMtLaJna/x0ZKQeg0zEHo2ncmupcvuDn51g2pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164016; c=relaxed/simple;
	bh=3Mq7kU0ij9LNAekgyk28BMaUIZSuE1bTDnMCbACGw2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+R/9SbQgyUo60vbEMVv6TaNwlE5+ve8MPaIOm7yDBCemwfnnVPzNr3HBKUjwrZBbjWnQEhODitr/ZO06Nwtb0nONWuTFHR0mZfmXmnhYPheca05tnvyRoeSP+lEpRlypHGob2TmVfoz051j8GQA3ZXWlf5W8bK3wJxFFW8/Hw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tceiYj4t; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a2beae348eso5904027e87.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 03:53:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776164012; cv=none;
        d=google.com; s=arc-20240605;
        b=cGk434nJ5iSmDUoyFK28VX7wptH7cmyVjKZoBvq4x30JgVU87EmPA6kcUQKuJ7VSnH
         gXSacArA0ScZnkza4Oi5KVPRhUdp3znApi8pmaIFyRzZPUrA1TYxqIGi5bac+C6IdkGz
         nWxSCxSh/C7/xRXOnWBNaUPwARHnsRkcWY6BrvtB5jEpgTdY8mLa3TstAieognyRw1RK
         FkMmTUXJi7sdYJwPlSbUEjSMxyPur96N2CiZand3TYXgdUfh9P1vUUwqDqkkWSYuWftf
         fJa6FPxXzKXmDuA6GEHIYJfnDSs8veXM/Pze13EZA4qORMVyM9sJ+kpu8DtHWKMruYnb
         VnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E41YxX1sAguGiwh6zEbSng5G2cnuAQxPK/F52SLRHFc=;
        fh=IIGo1vzLuUNCutvYdy6xDNKYp81nDcrYC8YtPWW/b2c=;
        b=PnqzLUtEHuaxW60Fwti00Z8taHW4Cy7yWttALBk4dzCXfjbWw2kGneUQu1XaeYVfA0
         JoOj4EOG6+Dm2tXWteGRlwlig+5EBbif0FKEAucu26V6UME/BRFaVtokDLyjaNV3nvcu
         CUouKTOOoqG4bYgZ+FyreHDEjHKXg7uwfck4DraRjlq4OkHt1lprXT2QuzlTTFuH1IeD
         PgbUxEN5TBYCPmKZuCkBTHnGeuO4rcDs9CalRuNYS1bfVbKH5tTBviaqV5JXQLOtj/3e
         EoINOdRBcD7Hlvxh+wJkPyrAHeCPwd0dz7rRCKAthfvg2INzIonEfTt2bYHe5uGImYyr
         2sjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776164012; x=1776768812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E41YxX1sAguGiwh6zEbSng5G2cnuAQxPK/F52SLRHFc=;
        b=tceiYj4t1zQ6azuPwkobKSFa26BGx30DAH/t1bF0tabJKYVVuRZbBN7Jn304ihyRWY
         zDhHcWLTtrckcaxKGqVLa8snywySNfr1IJ5/IvlVNf3jUZhSluqQaiSbBDooNquTIuZB
         Z7MDZmtwYa4ANUau7nzCNI45LDQJUdXp/gHlxq8UyKYcQ03Wn5wjjpj8anxO+IzHt8LN
         lcNBiICOVBGNQXG6iF3Sj5eCVfMogMtbopykz5I9avvqbTX8iJMdUZ4jQlXLWEfbMbjO
         h2vXMCvwKHf2/rZzK7hJ+y08+cwPw62tcxUR3cnVRLUI+WuUuFIwqYhG8XGMCLUk0LAE
         +0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776164012; x=1776768812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E41YxX1sAguGiwh6zEbSng5G2cnuAQxPK/F52SLRHFc=;
        b=BL/2Ayg7DqX65xHct/VtXGCjiTkZpCe78Ih1WQYsIXa5Ik5c5k5K5MrhoBiMuG0wAx
         CQpSkoWpGK2CA7iokWrAt7RV36JbcKGsbcVBdLBd5qHEcAUSz2PteT7bRFMBjEYfw7Ga
         xOTXtYlozGUSfXANesfAwdyW16gVVM2wPLZm5FPU9WCWQxiGR+64mmy6/tYRUNMqJ7Gc
         vBhB7B66Ntk9QHNqF6qcG5/XgooAi7OslZNZrt+XhHWad8UAUokQMJlonkPLshQbNHSO
         3Wn0lnRDxBK5Uu8A5+m96LBu/WcE0Q1cUY02OqnciPDgC/gp7Et3rp5M2RRsl5JzGiUW
         MJSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ga5HyAaxzYI/VdtbswznJH77UhdKxgts2d83SrLqZDEieAy2+Smh1eqPvwFTFVVtsCZ/QWq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOg1gQSNkG2iyBqzwo/4/IlP/9QN19l0od7xISXpUkD+bitf3s
	u09SU0uzB8HOjqBME+ksUusKR118FABg63mukC5/yFWgEbV/uDEXUqC/ICrQDHp58WlxO1WE3kl
	Fjc/bjJ2rITeXFrGbsMjdRXsGquNRRXfNLenPcAkcAKT5jlH6GgLE
X-Gm-Gg: AeBDieu97gmOm5SiG1h5VEqiXjPU0E6YlbCoUhZC9Jq6tZocEKrLJutKQFHE1lZJrUI
	ACmTs3FG+uoyoQUTgtshQXIWlcHurRbseQDZuco7wG5VTH9T4r/Vd7ejKCtfC5SCHIagWJi+L+2
	7ZZlovmzaagXuDb3jbM2T0oFJCSVbYqT7wVK2CMBi9CoudeynGaJQvVDuDI7C9uJD8uxSvpRRfX
	dLifZjWyszPZtZNQoMhwQPlsVoibf8ZZwP65S2DSY8Lpn1FEMrpInBaPjmeFZ65KKouZX4zR6TP
	sK+7cMCL
X-Received: by 2002:a05:6512:39c6:b0:5a3:cc81:efdb with SMTP id
 2adb3069b0e04-5a3efb8ba02mr5334362e87.21.1776164012025; Tue, 14 Apr 2026
 03:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413155819.042779211@linuxfoundation.org> <20260413155836.794775290@linuxfoundation.org>
 <65cd5a0b7c68af467b8b13b4fbce51cc2febb5ad.camel@decadent.org.uk>
In-Reply-To: <65cd5a0b7c68af467b8b13b4fbce51cc2febb5ad.camel@decadent.org.uk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 14 Apr 2026 12:52:56 +0200
X-Gm-Features: AQROBzB8UduscqLXoj3HY1wGSVAb7et8WKMiE9PyT9lKdB3KXH6kPAKVBpwdnvk
Message-ID: <CAPDyKFo1DWRbidKrMg+DkwOxsdzDrfF5+YVhjjzGZzkAC7=Yfg@mail.gmail.com>
Subject: Re: [PATCH 5.10 474/491] mmc: core: Drop superfluous validations in mmc_hw|sw_reset()
To: Ben Hutchings <ben@decadent.org.uk>
Cc: patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>, 
	Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237791-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,decadent.org.uk:email]
X-Rspamd-Queue-Id: 0404E3F903D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 at 23:10, Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Mon, 2026-04-13 at 18:01 +0200, Greg Kroah-Hartman wrote:
> > 5.10-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > [ Upstream commit fefdd3c91e0a7b3cbb3f25925d93a57c45cb0f31 ]
> >
> > The mmc_hw|sw_reset() APIs are designed to be called solely from upper
> > layers, which means drivers that operates on top of the struct mmc_card,
> > like the mmc block device driver and an SDIO functional driver.
> >
> > Additionally, as long as the struct mmc_host has a valid pointer to a
> > struct mmc_card, the corresponding host->bus_ops pointer stays valid and
> > assigned.
> >
> > For these reasons, let's drop the superfluous reference counting and the
> > redundant validations in mmc_hw|sw_reset().
>
> Is this reasoning still correct for older branches such as 5.10?

Yes, I think it should be fine.

>
> And if so, do they also need commit 406e14808ee6 ("mmc: block: Remove
> error check of hw_reset on reset"), which claims to fix this one?  I
> don't really follow the explanation in its commit message.

Yes, good point, this commit is needed as well!

Kind regards
Uffe

>
> Ben.
>
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > Link: https://lore.kernel.org/r/20210212131532.236775-1-ulf.hansson@linaro.org
> > Stable-dep-of: 901084c51a0a ("mmc: core: Avoid bitfield RMW for claim/retune flags")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/mmc/core/block.c |    2 +-
> >  drivers/mmc/core/core.c  |   21 +--------------------
> >  2 files changed, 2 insertions(+), 21 deletions(-)
> >
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -987,7 +987,7 @@ static int mmc_blk_reset(struct mmc_blk_
> >       md->reset_done |= type;
> >       err = mmc_hw_reset(host);
> >       /* Ensure we switch back to the correct partition */
> > -     if (err != -EOPNOTSUPP) {
> > +     if (err) {
> >               struct mmc_blk_data *main_md =
> >                       dev_get_drvdata(&host->card->dev);
> >               int part_err;
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2096,18 +2096,7 @@ int mmc_hw_reset(struct mmc_host *host)
> >  {
> >       int ret;
> >
> > -     if (!host->card)
> > -             return -EINVAL;
> > -
> > -     mmc_bus_get(host);
> > -     if (!host->bus_ops || host->bus_dead || !host->bus_ops->hw_reset) {
> > -             mmc_bus_put(host);
> > -             return -EOPNOTSUPP;
> > -     }
> > -
> >       ret = host->bus_ops->hw_reset(host);
> > -     mmc_bus_put(host);
> > -
> >       if (ret < 0)
> >               pr_warn("%s: tried to HW reset card, got error %d\n",
> >                       mmc_hostname(host), ret);
> > @@ -2120,18 +2109,10 @@ int mmc_sw_reset(struct mmc_host *host)
> >  {
> >       int ret;
> >
> > -     if (!host->card)
> > -             return -EINVAL;
> > -
> > -     mmc_bus_get(host);
> > -     if (!host->bus_ops || host->bus_dead || !host->bus_ops->sw_reset) {
> > -             mmc_bus_put(host);
> > +     if (!host->bus_ops->sw_reset)
> >               return -EOPNOTSUPP;
> > -     }
> >
> >       ret = host->bus_ops->sw_reset(host);
> > -     mmc_bus_put(host);
> > -
> >       if (ret)
> >               pr_warn("%s: tried to SW reset card, got error %d\n",
> >                       mmc_hostname(host), ret);
> >
> >
>
> --
> Ben Hutchings
> When in doubt, use brute force. - Ken Thompson

