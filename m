Return-Path: <stable+bounces-185876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA28BE1740
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 06:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64B5D4E477E
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 04:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CCD215F42;
	Thu, 16 Oct 2025 04:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k9W2Roms"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DD1E5B72
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 04:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590481; cv=none; b=cpYV4Z6Ydgz+JTls5b32VQpKtfe6rOAhciATYPJcVHZ1AEYzfx8Obyt62JOl99JUyBorqsutb3A0aJqObO4Nly7FUs+Put0LAwL3aHDhC6V9+DVGRUPbWstYh8dIElDuZVj+Y/l66lmURyIi+WgoY2pZgfQGHMTFiIsYR4EwexE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590481; c=relaxed/simple;
	bh=/Q6NfJWghWGNobhXEDBhXrQWhlfTOUPEdyfRJMrQ5PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgexEMv/wllP9yvo3CBKXCTkmbJlxHHGzFuXyO3F3He1Stu35WcOHZpuJN82J/2wK76807+qBXgbItfybzfY3mNPeSYJTC/TgqmLmeewQ4guDfHUGNPpimf4kSEsiz4aU8Jp/B/+nPcU5yz5k718NBoKcsd6RhleF82enjCUYMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k9W2Roms; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27eec33b737so4933875ad.1
        for <stable@vger.kernel.org>; Wed, 15 Oct 2025 21:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760590480; x=1761195280; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jdHglGpSN3KxDuAvr8dPMfQT8EEnf8fGwUS/E78rcH8=;
        b=k9W2Roms1z9Oth+D9VFUQ6ksuw/aqLt9bxMeo95+5mUJmAjf8V6qXHLv6KY/tfRoqD
         bkEYogIJyzNZmemLP9Fr5KGzcTt6HOhv8Otv6oFeMQDJT8wFIxJw0cE5Iv2waqnCAUR3
         sMtrObkC81MALTZGI/Bc7p8Vjvkz+bDOLWoaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760590480; x=1761195280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdHglGpSN3KxDuAvr8dPMfQT8EEnf8fGwUS/E78rcH8=;
        b=jvPN3ljwj25i/zZ8T+Dc7P99J78lUM+WfqeBXYxIVFAA0+1wQyINt/bDCXSYnnjjcL
         qNCSvPpxzyZmDjAsP/J2wbGz4ItvFvuCEGWeyqF6nm5Bt0hfP2T2LMHlay464uoKyLmx
         WRnjqN6/nMroTVfLPPs/yir8meZ6RRaNm6qvj+/WjhjbMZS8hieRg2A+3QYwd4XmFs5B
         tb9LbeYCYqBBX4MEZUX6TfV95DBJVGIbgoOhu9+GcjXIIb+zPrlyLtR5nz0Hzuojyaie
         fD1o36y1zTyehnC1slElT5mx/1UeSVUaWfvn9aTJimB1HUU3lTkN9NpmOYm8rDWIaqyy
         WTvA==
X-Forwarded-Encrypted: i=1; AJvYcCVRxXaIqp44c1rzwEHU7euOjRaazBTtSkXDD4MBvDZfFawX+00UpzeJeQYVuFEVAR4l14GjRhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNz9G6vyZdkhk4AaNIJJlj16qD3tA1L6bByClyecEhPg4jzbkZ
	b+YHt1vrX/Qr4y+mJANTMRcqQKZfl8MX2a1/cLQVujHD3fOIRQPRy57Rx0cqnKh8oA==
X-Gm-Gg: ASbGncvBlYORgH9BjLlH8ODClLNnJ4CVL1iZZIylZePQgP8DAF2m4l+22hh5S9VcCkZ
	yS6tseQ7WOT8/SQH2Cy9/IIISxEudbVOkWMc/qq8VWX9ZKVmgGC/3fYMJ0PPHbKp1FndlnoCWeT
	Dvaym+1t9cwKw7hxvNS5EybUB+1wzbFLyIgRK/CjcKY8u6f7Y3S9ddUxoWT1EjQhZrsJ/2i8Cn7
	MPldW/1JsqABZU1qGSP7853OxLI3DXk9gKh29O2duni6r/Ff5IC9OfdL2OWqpOGXd9Aqnqm9RBr
	nVDb0kgPWmqPebn9+nKWkPaWTKs4y2rsbnf9zAIinUkaCNhtj1GA1RopGNa9veY1jnDwLcK7vlm
	QABq4obXJ/2f5YBWFB6oLrYrceU6gDiNylhKf1XKRmd9DS0z0Onzxt3yOLNFM5P5MgtwlsHg6gK
	pkLD0=
X-Google-Smtp-Source: AGHT+IE0ih/CjX4ELruc5guQe7p/S9Ic1AWEutevogqpYPhg2145lGm3u6x2XmjWR3oPrwyHajo9KA==
X-Received: by 2002:a17:903:1510:b0:267:776b:a31a with SMTP id d9443c01a7336-290272c188dmr388977865ad.29.1760590479719;
        Wed, 15 Oct 2025 21:54:39 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:18d7:f088:3b2a:6563])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afbdb5sm14082495ad.104.2025.10.15.21.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 21:54:39 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:54:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
	stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <ry5gjxocyzo6waonjyc7hgvo7bc6riqpmy6l3f2au7dm4j5dtd@shma7ngcqjuk>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
 <ns2dglxkdqiidj445xal2w4onk56njkzllgoads377oaix7wuh@afvq7yinhpl7>
 <a9857ceb-bf3e-4229-9c2f-ecab6eb2e1b0@arm.com>
 <CAJZ5v0iF0NE07KcK4J2_Pko-1p2wuQXjLSD7iOTBr4QcDCX4vA@mail.gmail.com>
 <wd3rjb7lfwmi2cnx3up3wkfiv4tamoz66vgtv756rfaqmwaiwf@7wapktjpctsj>
 <CAJZ5v0g=HNDEbD=nTGNKtSex1E2m2PJmvz1V4HoEFDbdZ7mN3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g=HNDEbD=nTGNKtSex1E2m2PJmvz1V4HoEFDbdZ7mN3g@mail.gmail.com>

On (25/10/15 15:08), Rafael J. Wysocki wrote:
> On Wed, Oct 15, 2025 at 3:56 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (25/10/14 16:02), Rafael J. Wysocki wrote:
> > > > >> Would it be possible to check if the mainline has this issue?  That
> > > > >> is, compare the benchmark results on unmodified 6.17 (say) and on 6.17
> > > > >> with commit 85975daeaa4 reverted?
> > > > >
> > > > > I don't think mainline kernel can run on those devices (due to
> > > > > a bunch of downstream patches).  Best bet is 6.12, I guess.
> > > >
> > > > Depending on what Rafael is expecting here you might just get
> > > > away with copying menu.c from mainline, the interactions to other
> > > > subsystems are limited fortunately.
> > >
> > > Yeah, that'd be sufficiently close.
> >
> > Test results for menu.c from linux-next are within regressed range: 78.5
> 
> So please check if the attached patch makes any difference.

From what I can tell the patch fixes it!

