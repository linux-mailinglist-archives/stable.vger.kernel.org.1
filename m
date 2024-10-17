Return-Path: <stable+bounces-86588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE49A1DEE
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 11:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A431C21C23
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42FA1D88BE;
	Thu, 17 Oct 2024 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/oIpQMK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6241D8DF6
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156438; cv=none; b=gBfY5fdlpz37fQpTmcoovLizKcG8CfZJzRxcdNjKP9QhTxah62MjhBX/dbSbKqz26SQWGjqX/4u6rWZLEn0Dt5M/CRUSfBiBlUqJWLtPRUKS2PG0RixhNcu0dggGzGZgU0vVfwkeStU4Y44gzTmCcYyN/9jJ8RWu/BkcOvHqZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156438; c=relaxed/simple;
	bh=E/EX2nXPIh11iJuOLzPIXcFFLY7/ooLBLNxV1EXXXBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fahO+9kTpfArxGApNG79QvE0R+p27pTid841WLNVp/vHNW7439cAZQTxAp43xcWGJwIR5eKeZ3ib+JD8PgPovII08JMwZse46A6ditl0dQKQogp5DSUiW7lpELJ8klcDr1UB/jwZvn1uOTP7q089RDsympaQk/ppye/8dexmRsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/oIpQMK; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2918664a3fso632535276.0
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729156434; x=1729761234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LQTXgfd5CIC42gxjBiNXn1kbj+3FKhiZetQm59o+9L4=;
        b=q/oIpQMKqDMKgP+eGipRSWgwOSwu/HFMMmB813u9oVT4QbnzNkCIHjzu7ZhVbWvQHX
         xjKQcaPtzTFNI1Rcyr2rF2eAC7RgBE3vVI/1FFZS+SYNyVP40mk36ui0gLlgug9OVI/X
         OERjo3oZ8FcAAYHnXWLv4FgsuCwHTwyS0AgaSz1H5JmRaQrLqvaJzyNYW0l2dYQk1H5n
         mefMtsd05EaKTCtMndwa2XG8xPg09PCISajVLkI1lYNwSPM2xi9rkTpcPHOeW7lt6giL
         0TqYKmkF4Mfbqxoei6TJvcJMnvcz6oso4Sq5UjnkRJnAXNiNxkpQC6iwSvvr2nZK4w+R
         wFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729156434; x=1729761234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQTXgfd5CIC42gxjBiNXn1kbj+3FKhiZetQm59o+9L4=;
        b=xRxcGwWNkS81g9stMU4OcfuJheyEsrN/oQHS86TMClCsSOtYm+rH3nQ0j+gg9gPiGV
         4nnA3bPg8VzE0oWwV5lXPAiDqGslkEvO+DTcqEh7Wg2vfBlBV5am0HGmpl4WvHgTiJ9b
         9SizCd829q+g3hv+c2OtYBVmy+DEsYGX6jPhDpMXOJvLA4HZPMwSjosaJ5RUZV3sk78d
         d/XWNUJJHDLLgBMAgiwDxKgI3xwB08z9x7ixHEBrB6MOfcypmTX065sdTwwIRNQnKu6p
         Bcykj6Y5S90DaSwgE38D7IuHmKETHZLs75ErgTyOsngdrjUdV/aEKBerOV2N9uLb19Lz
         86pA==
X-Forwarded-Encrypted: i=1; AJvYcCW83gSN0K2iFL14AYQ1PyEgMW9RRLM6PUwnHv21yXrG8vRk3bQVW2DAgz2MwY8SetPUJ+ZEOLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHVvlj+lYGfqLeGHymuL8NcjMDoG/6KWGx9ojjDFZs0LpCo8d
	cFl2C0JeOfVErJrl2LHgtEPovNj1n9J9WqaSxyQb0VIYQA8bXcuh6LI84M1nw1OcmyPE2k103jA
	yGDwzWvEUkub4G06d4sz7GHWn/l0va5YHuco+sQ==
X-Google-Smtp-Source: AGHT+IEbp8eABRktb1aC4fWMaK7REcsntuOUjtNgrXb0K6kIzZKbpfLWxRHUTtkYPxgKePE5lMpKwVSKCeDzOlLz5aE=
X-Received: by 2002:a05:6902:e90:b0:e29:27db:a1ac with SMTP id
 3f1490d57ef6-e2b9cfb1dd3mr2151179276.17.1729156434494; Thu, 17 Oct 2024
 02:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014114458.360538-1-avri.altman@wdc.com> <18e66783-0fc7-4c55-8087-dc4212e851b4@intel.com>
 <CAPDyKFoXsgXNevDoCGTKSTwz-PfavfEHG5feyzEbeynRq3bDGw@mail.gmail.com> <DM6PR04MB65750E8C697235F8E0B42CA8FC462@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65750E8C697235F8E0B42CA8FC462@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 17 Oct 2024 11:13:17 +0200
Message-ID: <CAPDyKFqb_gJ74sddXRreZ49D8mM0yseSwg=L-M4Q8MvrtacXGQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Use GFP_NOIO in ACMD22
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Oct 2024 at 17:21, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > On Tue, 15 Oct 2024 at 11:44, Adrian Hunter <adrian.hunter@intel.com>
> > wrote:
> > >
> > > On 14/10/24 14:44, Avri Altman wrote:
> > > > While reviewing the SDUC series, Adrian made a comment concerning
> > > > the memory allocation code in mmc_sd_num_wr_blocks() - see [1].
> > > > Prevent memory allocations from triggering I/O operations while
> > > > ACMD22 is in progress.
> > > >
> > > > [1] https://www.spinics.net/lists/linux-mmc/msg82199.html
> > > >
> > > > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > > > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  drivers/mmc/core/block.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > > index 04f3165cf9ae..042b0147d47e 100644
> > > > --- a/drivers/mmc/core/block.c
> > > > +++ b/drivers/mmc/core/block.c
> > > > @@ -995,6 +995,8 @@ static int mmc_sd_num_wr_blocks(struct
> > mmc_card *card, u32 *written_blocks)
> > > >       u32 result;
> > > >       __be32 *blocks;
> > > >       u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
> > > > +     unsigned int noio_flag;
> > > > +
> > > >       struct mmc_request mrq = {};
> > > >       struct mmc_command cmd = {};
> > > >       struct mmc_data data = {};
> > > > @@ -1018,9 +1020,13 @@ static int mmc_sd_num_wr_blocks(struct
> > mmc_card *card, u32 *written_blocks)
> > > >       mrq.cmd = &cmd;
> > > >       mrq.data = &data;
> > > >
> > > > +     noio_flag = memalloc_noio_save();
> > > > +
> > > >       blocks = kmalloc(resp_sz, GFP_KERNEL);
> > >
> > > Could have memalloc_noio_restore() here:
> > >
> > >         memalloc_noio_restore(noio_flag);
> > >
> > > but I feel maybe adding something like:
> > >
> > >         u64 __aligned(8)        tiny_io_buf;
> > >
> > > to either struct mmc_card or struct mmc_host is better?
> > > Ulf, any thoughts?
> > >
> >
> > I have no strong opinion.
> Then I would vote to stay with Adrian's original NOIO suggestion, because:
> 1) My testing shows that mmc_sd_num_wr_blocks() is hardly being hit, and
> 2) that allocation is within the write timeout anyway
>
> So unless you want it otherwise, will remove the redundant macro call and re-spin.

Sounds good to me!

[...]

Kind regards
Uffe

