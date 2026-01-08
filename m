Return-Path: <stable+bounces-206238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9BBD00818
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 01:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BED3020CD7
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 00:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA81E3DF2;
	Thu,  8 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/EIAGGA"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D41D5ADE
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833892; cv=none; b=PyENXVNHaUQ3u+H2ZQGQb4l83/qMsAwdT9dpmp9Z8ux+92+v6H6aChGl/eIgUme0qpE0K2hDPnCbm6lehEUvXyI6rGX8bkruNsuMzpxzJ2bHhGZAA/Zqf7oPpWfb/lPZS0FnTMLhHkSWqkyLgJM/ezVaF9m4P0HNdSo7qPT9A48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833892; c=relaxed/simple;
	bh=DOF/Tt4P+IDAmL5JEu3WdnhqLfRy4vGwq61c0MdHSwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdpbkFI67/6PbB/7N0iY+fS++wdoS14d572PVhF2gige2SAmHwGxWpc1ra8dtZEV6+T10jhdGBM9FmN65OeHJ0lMxo6qRU++VMiOD2r988x1wimBcPVji9Gijj2X1uRwMUBx/0LGU/e4/xDgkBAdBkcsprJiN6Q6THxnbgESmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/EIAGGA; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79045634f45so31419357b3.1
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767833890; x=1768438690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DOF/Tt4P+IDAmL5JEu3WdnhqLfRy4vGwq61c0MdHSwE=;
        b=g/EIAGGAEk6fpC9ZmBihYhvElvewZ2RDSHHZWjvo1bgrGkDAPx0SE181gFEQTZMmQt
         EdxRrqCm3VSZfUc9w2Z+9ksMYv0zOdIbQxNv5ndTu/HmoZKVlC+A+ET5hktr6KGmlVcT
         Ks2+mU34d3ZdIjiHkhIN9Op0/uqM775VFYsWuCVq3dSyYsCqm5s14Mmhdl+27oUVuXip
         sbYmDSoqVeuf+3QLvixNFUGlh/S9/opR/MOj+9y4BmEhFnCbv9laAMObypPMKBvDRWwd
         pelacNPqHZcHP6Wdr9v9Jiif3w5Rpg5WWflfBe/rA0Fx5ESfd7OVwT82FHdRlMcYFRCN
         J5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767833890; x=1768438690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOF/Tt4P+IDAmL5JEu3WdnhqLfRy4vGwq61c0MdHSwE=;
        b=AmB5IzY3RyzNy81eOpPacaR1Sf3roR7ykHGcCenicAebVqnz7JTAQpJixYzfOf66IE
         cVZl85rQ64I0uolF0rmwOHr5fKAu+4SSqzN2Y4CR29CrLRQhWq/hA7aiUGqPtzutzMC3
         3/JkACJRGChPKD+SDsyCL77HHDeTfKCrBW1y/PCwb74nOeI/vELzVzbDn/F7vYC7OuYW
         v8Ylw5Ol6QadNQ8IoClIVIt5l4mOlEBOMIkKmqtCCSA/TstMIKenfjgrH1WwtEm0KZzV
         grN7SkTWFTaikoyVT+pNaF3nc3c7GppvVgr3i+TnPzeEbSF7eK3fFC8QBygJeuF1BSiu
         qb+A==
X-Gm-Message-State: AOJu0Yz0VHEjCBVRzak6VPqBRbXKL0MMiqFEY601qMKeh9+t6c3FQsgv
	NDBITEzzwfnMsc2Q2eD6Slb7JPQKfWNspOMgVdw7n3FGJp2QCzjsYPoi9V53kMJ4AeTpqAjN6gT
	C7Wvxr+gEMJuu0Aq8rwFseKz3eW1/nJI9cZRN6Q==
X-Gm-Gg: AY/fxX7hk5OxXiveUfm6d88UP39dUhKet0vGsLvIxV3ZxJtnNUZXVMPIxEp7c09zp2s
	SZAur8R5567ooO8G4FotImfm9MC3JIjWRUopzlQWtzF3SoOAdO/3rzfz8xtIu8QQWHOwaWLO+4Y
	I5W8T8NOGcotZ3iqol5aD8N9Qaq9/bMPMZqEV4cjNMbb2oDbJgvjHOQsHheER1hL9MlVjwTycQz
	RArxT6Vmn9sbjh86UN4Oq8bO8Ls5EY6ozsfNhcFUBR7ySEwzu43duM2nNpjeLqADqCr4kOFBpsx
	ASFITw==
X-Google-Smtp-Source: AGHT+IHjO7Yt06Vwyr6K7B/OD1oALmlvcXG49eNIHZVxIZBbag9yyp3yIw/jAqCI9MTrtoDSdPzEo9JUZfRWr7wlfkw=
X-Received: by 2002:a05:690e:1404:b0:644:fc4b:6fad with SMTP id
 956f58d0204a3-64716c1979fmr4332222d50.58.1767833890005; Wed, 07 Jan 2026
 16:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH1aAjJkf0iDxNPwPqXBUN2Bj7+KaRXCFxUOYx9yrrt2DCeE_g@mail.gmail.com>
 <2025122303-widget-treachery-89d6@gregkh> <ME6PR01MB1055749AAAC6F2982C0718687AAB5A@ME6PR01MB10557.ausprd01.prod.outlook.com>
 <CAH1aAjJjxq-A2Oc_-7sQm6MzUDmBPcw5yycD1=8ey1gEr7YaxQ@mail.gmail.com>
 <2026010604-craftsman-uniformed-029c@gregkh> <CAH1aAj+myyuXniX9JAo5fQzHUyqtrGobhNPizc-Of8=OPgOAjw@mail.gmail.com>
 <2026010748-seventeen-daylight-2568@gregkh>
In-Reply-To: <2026010748-seventeen-daylight-2568@gregkh>
From: JP Dehollain <jpdehollain@gmail.com>
Date: Thu, 8 Jan 2026 11:57:58 +1100
X-Gm-Features: AQt7F2pKZawDn7HZct-AwFi3NL1M3BdQvriHW_smipJUrM_H64x5lhxGSn-ZgOc
Message-ID: <CAH1aAjK=GLKQvi6MaJsv2vANTc-f4FNX4ePUCk8AwLwGO7oPqQ@mail.gmail.com>
Subject: Re: Fwd: Request to add mainline merged patch to stable kernels
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks, I can do that, just note that these patches had already been
previously submitted and merged into mainline:

1/2 - [PATCH] misc: rtsx: Add support for RTS5264 Version B and
optimize init flow - Ricky Wu
Link: https://lore.kernel.org/all/20250620071325.1887017-1-ricky_wu@realtek.com/

2/2 - [PATCH] misc: rtsx_pci: Add separate CD/WP pin polarity reversal
support - Ricky Wu
Link: https://lore.kernel.org/all/20250812063521.2427696-1-ricky_wu@realtek.com/

The request is to also get them merged into all previous stable
versions. Apologies if I'm missing some trivial context, I'm just
learning about the kernel development process and I'm not across this
process of porting patches across kernel versions.

Cheers,
JP

On Wed, 7 Jan 2026 at 17:41, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 07, 2026 at 04:43:42PM +1100, JP Dehollain wrote:
> > Apologies greg, I just realised that there is a prior commit
> > 587d1c3c2550abd5592e1f0dc0030538c9ed9216 that needs to be merged
> > before the 807221d can pass the build.
>
> Great, please submit a patch series of this, that are properly tested,
> so we know exactly what to do here.
>
> thanks,
>
> greg k-h

