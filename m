Return-Path: <stable+bounces-69624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DD99573DC
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 20:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099EC1F24240
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 18:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D39181B9A;
	Mon, 19 Aug 2024 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gam7KhGo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C4026AD3;
	Mon, 19 Aug 2024 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093163; cv=none; b=gkrdc27kMokjiPSPGsUJ62d5Wu+Z4hv584aUonfBAA7/GBGwsum6iQeIFci5Bf/7hE2cW1IsCY05tOpHp0wGbv8AksCMtqW2Vvqk2OqTfTewAZOj9gOc5pf5vTQxCwX1LJ+UI51g2zyRn/suxMzNVzVXCyz3M5iIfr6kI0/gpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093163; c=relaxed/simple;
	bh=HdIJY01lHoLxaZGedoCASwrrmQVvme3IbQCYk3XtDxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPy/naceQg+wB3AoE5j276zAEz22HRZgMiXZ70bsyigeEQswLmxRGO8Hb9IqroF82a97u1Ied1db6Fvnx9AeFLcPHsU8Ej+zB9LBNMJLB02wSUeUgUTmaMaY3gBpYHSTx+zvcvLTOW+tR1v7SwQpftB6xuuG7BLwxsB/m38N//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gam7KhGo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso36697855e9.0;
        Mon, 19 Aug 2024 11:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724093160; x=1724697960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83RS5Bq76bBQeFMijiRLgaOeMKTh/8Mb3G8iVoR5aBw=;
        b=gam7KhGofNpYIjdvZsILa8FkqXRX9YwEHV+ltLdr7DGsFzmM/ELFyxA7T4v1GVBOC2
         tiIWrV5275yfwe6RWTWia/9nHeBPGqjNo4wn3Utgx5ZoOh1yjELrq+mHczOGNVDRjvTS
         gzULpOp2X82wQE6DpZKM1gPk9mu90m83/ZSo0zNAdnh+eDrsvbsp+bE/SltUO7K56dtw
         sja+W5hbj/L3VKwHOwnIEXZCbaXvGL9P73w7TcHINVwtOFj8iw9DwUOIyO3ONlZ05WHH
         aiN69aCuwS+XRP1gUv8GrIFmWPnmqCH2/2i8YvlxmVol7wwmgXmbUFJdvU14tLhI1cS1
         7mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724093160; x=1724697960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83RS5Bq76bBQeFMijiRLgaOeMKTh/8Mb3G8iVoR5aBw=;
        b=PRndKsuF58qFN48U7ZcwsT8qLYwDzNWPMXsS/Pi7RhqFxyxvy6KKjPb/EQEQ4562W0
         dd02oMb+MGTsEXrGbsE+wl+QSgT1iZZUM5+REgQvTOCuQAQ/HK5mUjZRGF7V1BwE54c7
         61fQECReCGJjyp+bK/IAYwKewsACyQxPK9xIHeGjEGXpLtGPDP7VKWfW4LgvxdQ5/nLp
         L+9UnmTMBEGfPOpmgM3qwMnph/UMxXdGoqTEd2oJSg6CspQdzV9MolmXlbTZJw+OZcqj
         D2zVw5+s7LPbNcA5HDTCECrTaej0ajh1UmcsQS7xIlSRTZvfSZqUyyDbcv5E5lLnzeB8
         BpYA==
X-Forwarded-Encrypted: i=1; AJvYcCUs/Xn4lDCP8Hiax3kreL1K1qFOQPqE8s3FZJw/s2NzP7IbpBVwnyygskF52BZ32CHEO3IXYTZiuTOraHEq@vger.kernel.org, AJvYcCViwoxg+fLtAFTQrhxka4qCRWmPJpOrJiPGX7HAIPJs4RF2XHE8E0x/JUDa7tjzRilPGiO5nR0i@vger.kernel.org, AJvYcCVwMvt8nGRdQJzC4nhMvGI4Tm2q30ymZdr/pLwsWhQbRjdqoTP86JKNxVP0eOqAMvDdxvJjjtSf0hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqnYtqVrnWqV4qzsTcaXaul2ToIQorX8R0gj9Nqcz+q2tqEwW
	UIraZs5IWJn/hNvcXm0BcgF51bjQXNWwmVEJpIXAG6ZIx3jn9fbHzmLD7nB/
X-Google-Smtp-Source: AGHT+IHgkMerOvxIAQnbhWE5dSxXyVexmF7ZW1KYRom0PSEE9yi2Aci3kgKxAUs6+3AAUS3kSUNC/g==
X-Received: by 2002:a05:600c:a45:b0:426:627e:37af with SMTP id 5b1f17b1804b1-429ed77d75amr72399195e9.3.1724093159268;
        Mon, 19 Aug 2024 11:45:59 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429eea70115sm113922805e9.36.2024.08.19.11.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:45:57 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 61A00BE2EE7; Mon, 19 Aug 2024 20:45:56 +0200 (CEST)
Date: Mon, 19 Aug 2024 20:45:56 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Christian Heusel <christian@heusel.eu>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>, linux-ide@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED][STABLE] hdparm errors since 28ab9769117c
Message-ID: <ZsOS5DmRnS3ab_9W@eldamar.lan>
References: <0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu>
 <45cdf1c2-9056-4ac2-8e4d-4f07996a9267@kernel.org>
 <ZrPw5m9LwMH5NQYy@x1-carbon.lan>
 <1376f541-bc8a-4162-a814-a9146ebaf4eb@kernel.org>
 <df43ed14-9762-4193-990a-daec1a320288@heusel.eu>
 <e206181e-d9d7-421b-af14-2a70a7f83006@heusel.eu>
 <d224b165-14dd-4131-b923-1ef5bdf3fb7f@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d224b165-14dd-4131-b923-1ef5bdf3fb7f@leemhuis.info>

Hi,

On Mon, Aug 12, 2024 at 11:26:53AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 09.08.24 22:13, Christian Heusel wrote:
> > On 24/08/09 08:42PM, Christian Heusel wrote:
> >> On 24/08/09 08:34AM, Damien Le Moal wrote:
> >>> On 2024/08/07 15:10, Niklas Cassel wrote:
> >>>> On Wed, Aug 07, 2024 at 11:26:46AM -0700, Damien Le Moal wrote:
> >>>>> On 2024/08/07 10:23, Christian Heusel wrote:
> >>>>>>
> >>>>>> on my NAS I am encountering the following issue since v6.6.44 (LTS),
> >>>>>> when executing the hdparm command for my WD-WCC7K4NLX884 drives to get
> >>>>>> the active or standby state:
> >>> [...]
> >>> Yes, indeed. I do not want to revert any of these recent patches, because as you
> >>> rightly summarize here, these fix something that has been broken for a long
> >>> time. We were just lucky that we did not see more application failures until
> >>> now, or rather unlucky that we did not as that would have revealed these
> >>> problems earlier.
> >>
> >> It seems like this does not only break hdparm but also hddtemp, which
> >> does not use hdparm as dep as far as I can tell:
> > 
> > As someone on the same thread has pointed out, this also seems to affect
> > udiskd:
> > 
> > https://github.com/storaged-project/udisks/issues/732
> 
> For the record, three more people reported similar symptoms in the past
> few days:
> 
> https://lore.kernel.org/all/e620f887-a674-f007-c17b-dc16f9a0a588@web.de/
> https://bugzilla.kernel.org/show_bug.cgi?id=219144
> 
> Ciao, Thorsten
> 
> P.S.: I for the tracking for now assume those are indeed the same problem:
> 
> #regzbot dup:
> https://lore.kernel.org/all/e620f887-a674-f007-c17b-dc16f9a0a588@web.de/
> #regzbot dup: https://bugzilla.kernel.org/show_bug.cgi?id=219144

AFAICS, this has now been reverted upstream with fa0db8e56878 ("Revert
"ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error"")
in 6.11-rc4 and the revert was as well backported to stable releases
(5.15.165, 6.1.106, 6.6.47 and 6.10.6)

Regards,
Salvatore

