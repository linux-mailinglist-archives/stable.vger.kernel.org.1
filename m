Return-Path: <stable+bounces-212646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFRvMhRFemn34wEAu9opvQ
	(envelope-from <stable+bounces-212646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:19:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49161A6B6E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 003A3300AEDE
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DDC32E733;
	Wed, 28 Jan 2026 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emgAG8BD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80BA225390
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620753; cv=pass; b=I4rNMrgO0+qwEWHEgZDKRUpMcMDUB2GHVT21uz2KUOo+mRcPdUTrr40GUlC6MVn8ttWKaMsaJAdbLErNh/0am2Z0QWoWewNjr1H9m627S6Ds2uDpFSza/OzOkfDjFR2dA+FFvdlU8QOGwnUCMWmmE+cE5748VEPcyHzoWKfPDH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620753; c=relaxed/simple;
	bh=HU+2qV9g/s9S77R3j/OFeZGFjqpC0FxcFKPAXfJCMbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XW2yq+uskJeF91bexEyRAv92+JPLC7WerZvkkQ3EYTWcQ9/SsrDcDYkEUhDcUva2/oM3OYplrqE1Ck0zum2BDjMRlrrjbyWG/legyeH61vmSo8PVlfeT5SbOb1ZiM6OtYkFLmU+qe0J3fUuvxD68WH1z+dmf1HXzBIjx/ZryXJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=emgAG8BD; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b883787268fso12669366b.3
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 09:19:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769620750; cv=none;
        d=google.com; s=arc-20240605;
        b=bSc8GH1BwmUdVZcMezyrDME6iGaYkdvZOz5HbPK7HfYhb6RvN2xOZLzCr/elz4+E2S
         UWHwTwC1klCZLBo3t7RJyyMNahPi+elhS8g9c1SWt/IHUC4xmu4AyWUecIGKYdUpIVfs
         tI1qKsxuEYCB4pg+CpRTIDNDK65Axx/saWIrOtGw3opb6IM5xsHdTR6EjlQbPqqDCr+Z
         stPJSjxUSXGXFShC/PQC+W6G4dkRLa9LsyIt8EYjoTdpJFWDFJVJrlU4FMUNm/2OlASk
         JrUktqhJum7LTvjresWlcqKanGOg2ZSFS2rwSwtX5OwhsAcJn8AoX8mabEcp25WOve8s
         lynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c6U2T5XiBkgtqqoIWwFJ9MeumwoEccaKOI8Bpx3K3Oc=;
        fh=r8WhPeDhMJJ4CopUPEABrtLM4SFu2zupmcLHMAFzrGs=;
        b=hXLZia+I4utYK6POKNcsfKeLZzJVTFqPVSv6SHWdqGxgj2ZAs4FF4PEsm7uVEewLcs
         Fep0XBFFjHyEf3UqEAj5Q5SxIH9rgvARc2/8ug/UiYvP/TewaE5ss6Ownq6cWkR1AYP/
         3tgrUlslprYEPw90HBfEh77ewxRYZQGtI9fBoSqiWDbIXKy9ZjTZIpNt7EGt+GhCu0zp
         ZzBd/X2RsCqOouZDxxSk2fiCb4fz90LIhHm/E8QwD7/db3dcDP5ato6539jhyTJPg14d
         KdyO+TRntjcmhhJKcIBQIwXJleY7mizEECGwCJhmmRo8xShWPPKlTXMosBuPYZ7HaaeA
         OzcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769620750; x=1770225550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c6U2T5XiBkgtqqoIWwFJ9MeumwoEccaKOI8Bpx3K3Oc=;
        b=emgAG8BDJNaaUSG6V2gc6gDgLN24ig8B6gi29iRk1HErKeMq7bNUz6wF+HwKH8vOUy
         S7yhjYSIlvLC/i5YXF7GXCGH59a500vVt9q6rkDXmhbhLHCPpkg3mJRqYerOMeIdeteW
         vfaerpeK6WOWqnQGR4+4g/0LH4WTkYAVCmLVcE7+rk0aVY8HDeK8IFW68cHpaAJuN8ZY
         IH7d481Q9bPFQosJF75J3SWi9bw8U7S1xyfT7/VH5SaPJWg3EvbmFuQJvh/LmhtRmI09
         LQV68BkwZ9PpUzGNZvOiPhjjBjMbfIy5CWUvXweorWlGLo6MNSlbBX7cMg7tYpDgz+5Q
         f05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769620750; x=1770225550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6U2T5XiBkgtqqoIWwFJ9MeumwoEccaKOI8Bpx3K3Oc=;
        b=RDkdtBjXA19W6GNr1i+rdaN4MOoG6qJ7t5OEjPQF2uwEIo0vke39KD2GG8YDPJ/VHL
         3LUlgzVY3tTkHQAB9T0L/McqYLnfJ4CfE7IWEpxD+fOyYKv8KBncBAQSfIiR/Fds1a18
         5P7vlHfX7ki3BCQqto5nKZk0wG1oTG7LNmo4i3RVKh7xU2HooQlM+hVzobq8J7w2w8Pp
         wKelplowAwx5wmQbUgiVPXUZTno2xE3wRSsEvO7t3OpPwkAlyG3wI0sm0m7pJvkgvXO7
         mgHOTz0E4vC4pcV+tABEKtxU3pqjMEyzJzlzYZ91WYmRWj2C6DFG49+2lwbQBAn4LNE0
         GJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCWpa7Wzgza87KJ5x0ACIYjLyadKXykuq0kH6cIvixdvmpEulha26VKcw8upke+VrgMmjhQI2R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnxJlleHCYaeGkXSqxnQHDH0/jo2qhDaKfzebGrzAcMOUlNIw
	/kxdKKrJkAuVCQGIQeul+HA4Amr9gs9W6IqgjbGCcj+zuahrRTRjcAT6cdlJ+f1X+2h2MksxGCT
	FL/CAKt0XDpnWE+FXS8AHLkqQ6lqOQOwC8OFb4zzhag==
X-Gm-Gg: AZuq6aJ9Dno5BMObh3Mx/rvb0L//owNzsMCdzNhmdf6zGh7p8zNyx3StZNmVm3lm5sK
	hzfacSwJs+dgyKIh5Uzbqa/UzlRPYI27fpLlZBfLZVRRKfWuv9CBHWrsuipADDbYlwXEYu4qywO
	gzNAhHCg1xwtPumB88iMaC9RM1DpS9ue0TOieb5ENZ5h7E3YxqNhTERlAcP1uwVq69k5nzF7aU0
	5G3jTOFDURAtPHMzt56XHE5DpNpA42aY1SRXkSi2LrX+ccFI3RxPg56HzFFBr62hDdK1uCQ6LtN
	u06hGStKhWAzllv7m8gP2hzhgTBd1w==
X-Received: by 2002:a17:907:9620:b0:b6d:73f8:3168 with SMTP id
 a640c23a62f3a-b8dab15be8bmr411653466b.3.1769620750053; Wed, 28 Jan 2026
 09:19:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-imx-rproc-fix-v2-1-7288fcf74385@nxp.com>
 <CANLsYkznMVh240wMUZGayJHRzsUV-NNTiU+ezpLt3rjcwSn5Wg@mail.gmail.com> <PAXPR04MB845923F8485ABF7DAEA390CB8891A@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB845923F8485ABF7DAEA390CB8891A@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 28 Jan 2026 10:18:58 -0700
X-Gm-Features: AZwV_Qi18JCueG1u3J70NR_1Vvtj-phyG744RAEAtU4_AnPA_NPI-ZDjNCfkuhc
Message-ID: <CANLsYkyrz+A1iEabGZ6rFybFo4=mM+TPVDRSckFB2YUS_7aKow@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: imx_rproc: Not report loaded resource
 table when none
To: Peng Fan <peng.fan@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Iuliana Prodan <iuliana.prodan@nxp.com>, 
	Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212646-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.poirier@linaro.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:url]
X-Rspamd-Queue-Id: 49161A6B6E
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 at 20:22, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH v2] remoteproc: imx_rproc: Not report loaded
> > resource table when none
> >
> > On Mon, 26 Jan 2026 at 23:51, Peng Fan (OSS)
> > <peng.fan@oss.nxp.com> wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > priv->rsc_table is not NULL if the DT has a "rsc-table" entry,
> > > priv->indicating
> > > that _if_ there is a resource table in memory, that's where it should
> > be.
> > > Function imx_rproc_elf_find_loaded_rsc_table() is buggy so the
> > > narrative about a previously running FW with a valid resource table
> > can be dropped.
> > >
> >
> > (sigh)
> >
> > You apparently did not understand my last comment.
>
> Sorry about this. Does this looks good?
>
> Daniel, Iuliana, would you please help review?
>
> remoteproc: imx: Fix invalid loaded resource table detection
>
> imx_rproc_elf_find_loaded_rsc_table() may incorrectly report a loaded
> resource table even when the current firmware does not provide one.
>
> When the device tree contains a "rsc-table" entry, priv->rsc_table is
> non-NULL and denotes where a resource table would be located if one is
> present in memory. However, when the current firmware has no resource table,
> rproc->table_ptr is NULL. The function still returns priv->rsc_table, and the
> remoteproc core interprets this as a valid loaded resource table.
> .
> Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
> there is no resource table for the current firmware (i.e. when
> rproc->table_ptr is NULL). This aligns the function's semantics with the
> remoteproc core: a loaded resource table is only reported when a valid
> table_ptr exists.
>
> With this change, starting firmware without a resource table no longer
> triggers a crash.
>

Yes, this will be fine.

> Thanks,
> Peng.
>
> >
> > > In this case rproc->table_ptr is NULL because the current firmware
> > > does not contain a resource table, but the remoteproc core still
> > > interprets the non-NULL return value as a loaded resource table and
> > > attempts to memcpy() from rproc->cached_table, leading to a NULL
> > > pointer dereference and kernel panic.
> > >
> > > Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table()
> > > when there is no cached resource table for the current firmware. This
> > > ensures that a loaded resource table is only reported when a valid
> > > table_ptr exists, which matches the remoteproc core expectations.
> > >
> > > This issue can be reproduced by:
> > >   1) start a firmware with a resource table
> > >   2) stop the remote processor
> > >   3) start a firmware without a resource table
> > >
> >
> > Another sign you did not understand my last comment.
> >
> > I had hopes of merging this patch but the changelog is too garbled to
> > be salvageable.  I suggest you ask Daniel or Iuliana for help.
> >
> > > With this change, starting a firmware without a resource table no
> > > longer causes kernel dump.
> > >
> > > Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook
> > for
> > > find_loaded_rsc_table")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > > Changes in v2:
> > > - Per Mathieu, Check rproc->table_ptr, update commit log
> > > - Include R-b from Frank
> > > - Link to v1:
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > lore
> > > .kernel.org%2Fr%2F20260122-imx-rproc-fix-v1-1-
> > 36cc64369a40%40nxp.com&d
> > >
> > ata=05%7C02%7Cpeng.fan%40nxp.com%7C781fb4227e024211e71c08
> > de5dbb609e%7C
> > >
> > 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C639051256532
> > 530786%7CUnknow
> > >
> > n%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> > MCIsIlAiOiJXaW
> > >
> > 4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=0
> > 3sG8la72ysD
> > > ivP9SMmA9Ry2YaiMvCjsHWAWaGFOVQw%3D&reserved=0
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index
> > >
> > 375de79168a1c8d11b87ac1bd63774a3feac106d..f5f916d679051936
> > 0f446f063e09
> > > d018c5654953 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct
> > rproc
> > > *rproc, const struct firmware *  {
> > >         struct imx_rproc *priv = rproc->priv;
> > >
> > > +       /* No resource table in the firmware */
> > > +       if (!rproc->table_ptr)
> > > +               return NULL;
> > > +
> > >         if (priv->rsc_table)
> > >                 return (struct resource_table *)priv->rsc_table;
> > >
> > >
> > > ---
> > > base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
> > > change-id: 20260122-imx-rproc-fix-e206f8e6e477
> > >
> > > Best regards,
> > > --
> > > Peng Fan <peng.fan@nxp.com>
> > >

