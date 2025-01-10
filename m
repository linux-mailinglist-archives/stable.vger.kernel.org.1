Return-Path: <stable+bounces-108162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CDCA0854A
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 03:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 051347A25DC
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 02:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB21E22F0;
	Fri, 10 Jan 2025 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="IPeJV9BP"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A41E1C01
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736475854; cv=none; b=VHAvV20eZZ2WulGBMBf8Ez+RzpUS6Un/9RI4ClxgkOSsH/hxR9RRcTURuDm2UQroI0SAFhByLv7WyDmtDzmCkBrDNvfK3f/8+tst/K5Rfqz9QlqcDaDlKxdU7NCYqImwZO6TVn+nO4yXI89WrHQiUyQEvp+uc3/PZPgKbovDXGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736475854; c=relaxed/simple;
	bh=HPbJTAOZCcEw1vPjoee7BGtZeeHn6BbIBbKmaAl3eug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d32snllyuhKDn5/zIwiMtLgach3rTXQ8V1bO5dSrAhvO0rhxd83LBMDLl1OXAsTn7rXb0epdTm9gk10fOdS9CbbdECaib6j4qg68nAVPBysj/VPC8eCPlAoz41QRRsuZdoFyqr5SCD4buk/vtmqA4hyrs6JiDR/m524l6ObxyRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=IPeJV9BP; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=IPeJV9BP;
	dkim-atps=neutral
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 19B244C6
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 11:24:06 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216728b170cso30173725ad.2
        for <stable@vger.kernel.org>; Thu, 09 Jan 2025 18:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1736475845; x=1737080645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RT99AIOWKsdh3kIu1d1CPLSjddf8N740x5d+oosRGww=;
        b=IPeJV9BPZQ/lG+6wb2/QcsfPW+WgvnIq3OAA3mQo9kUxWG9tMrsyK9mVZJuZze4wUp
         FSMvhly+wj91vilcA4QF0QbDu4v0ERxSfSHUYLVlnmtH4PFGE8NDnUdPelj4awWVgd93
         sxDjjNyS6FQ1b4zDBMMbIdGeEV6V7ZXs0pbAX9er5ledThZ6au5ziF62uwVQn1tHirYp
         vc2VQ5jj2dLYnECENzk6aKUaEKAaEOylMFrOhTawAiKKUxpWB0XTpRhUUIGkAW/VDyFm
         azF/qOIVubX0rQkD3OmANQdAmF8ub84GLr0TUGiTu6sfXrOckrqAgq6CtQLOOGelSOzr
         DT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736475845; x=1737080645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT99AIOWKsdh3kIu1d1CPLSjddf8N740x5d+oosRGww=;
        b=EQnGWjB4AbIJ3z1tKyV2swyZa4k1uGTEPdQq9jq1g62Llc5MF1tp5GrYMiyr9O9PVz
         5mpuezQyIL/nwhZb4Ozeq9yrfwleRMpqfqYc0vTiJgJz3HjiJUdDmow19suAlHRGLv1L
         WC6Xu+ttCna/XBkv/g1dFx1zCF3cJb5ULzOovdbgOAXIsJv7bvb6OQgBVwFoKf9S1Zqy
         ytjRsWBKkzrcLzgD4nRtYhIVMf5/s+g25fwd4ZcRXHzGd6L3YFiWPhud+P7ubADPV5yN
         /jGB8FIqtlsBom0h9ay6rtc4YhPUNY7h/PwSkLyQ2dOguAGF3yP6uoeEJojnVKhs1nEb
         LC5g==
X-Gm-Message-State: AOJu0Yy9Ig0gG5Fgm+M8mn/lSyF+HQ5RqmsfUU0/Ux5U3G9r2yYpQ7s8
	lQhbNBP+NCi7MC2FvM/9GEHYHprabUaFx/at6jUVgcGZSc0kmrVS4RYuNq6s6fBuHSlyBwPcRmH
	hdaCtmnw1E+6LBUaAB+XcB6vag+VY0qS4LBfJfQ16KIUwJJsmllXf4RQ=
X-Gm-Gg: ASbGncu+DIupBoDlPb4X9iWWghImRiT4qd6O89ubxjk30mqMlgxUxjR4zoWWjFJu85p
	DLrFfJcZWB9esobomC7vrE7CNgJQPPKtzXkmp11psssEgWc/5pNdHVYQHrUiLPg++sloT/4Ecyr
	fJaIj+xpHfA148Jy7dp8WJeVUeH6onqq3Sm5C+xrfmvG0s67W/BcvG3j8YGyWMFnOKEpCdgbgh7
	vNAnWwjtxMVDdcpHMd/b6e35LI1wMQC4VyKmXp5L+DjiIc45P+AxIux5vGRAgHvw5S0Cv5BaiiE
	PULBCANwyuEnPW1qEd7XidSWjkoMykUGKhJotM5M
X-Received: by 2002:a17:902:d491:b0:215:54a1:8584 with SMTP id d9443c01a7336-21a83f4c070mr132141955ad.17.1736475845066;
        Thu, 09 Jan 2025 18:24:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7zOCxWxdSOPki70L4ZSLPi+nEkzbIqt3vmIoV52QigSXWXfd5vnC+IeYGVUSlUiO0mwxYaw==
X-Received: by 2002:a17:902:d491:b0:215:54a1:8584 with SMTP id d9443c01a7336-21a83f4c070mr132141685ad.17.1736475844693;
        Thu, 09 Jan 2025 18:24:04 -0800 (PST)
Received: from localhost (145.82.198.104.bc.googleusercontent.com. [104.198.82.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f2199ebsm4453335ad.143.2025.01.09.18.24.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2025 18:24:04 -0800 (PST)
Date: Fri, 10 Jan 2025 11:23:51 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	Desheng Wu <deshengwu@tencent.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 5.15 6.1] zram: check comp is non-NULL before
 calling comp_destroy
Message-ID: <Z4CEt5k3DWz4J9SK@atmark-techno.com>
References: <Z3ytcILx4S1v_ueJ@codewreck.org>
 <20250107071604.190497-1-dominique.martinet@atmark-techno.com>
 <2025010929-nutmeg-lustiness-f433@gregkh>
 <2025010916-janitor-matching-0136@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025010916-janitor-matching-0136@gregkh>

Greg Kroah-Hartman wrote on Thu, Jan 09, 2025 at 11:09:38AM +0100:
> On Thu, Jan 09, 2025 at 11:09:02AM +0100, Greg Kroah-Hartman wrote:
> > > Before 74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing
> > > device") that was indeed not a problem so I confirm this is a
> > > regression, even if it is unlikely.
> > > It doesn't look exploitable by unprivileged users anyway so I don't have
> > > any opinion on whether the patches should be held until upstream picks
> > > this latest fix up as well either.
> > 
> > Looks like Sasha just dropped the offending commit from the 5.10 and
> > 5.15 queues (but forgot to drop some dep-of patches, I'll go fix that
> > up), so I'll also drop the patch from the 6.1.y queue as well to keep
> > things in sync.
> > 
> > If you all want this change to be in 6.1.y (or any other tree), can you
> > provide a working backport, with this patch merged into it?
> 
> Oops, nope, this was already in a 6.1.y release, so I'll go apply this
> patch there now.  Sorry for the noise...

Thank you! I hadn't even noticed the patch had made it to 6.1.122
earlier, good catch.

So to recap:
- 6.1 is now covered;
- for 5.15/5.10, you suggested squashing this prereq directly into the
74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing
device") backport ; given the patch got merged to 6.1 as is does it
still make sense?
I can resend both patches together as a set if it's become more
preferable.
(... Perhaps adding a tag like [ v6.1 tree commit xyz123 ] even if I
doubt it's standard)
- (for completeness I checked 5.4, 74363ec674cb doesn't apply so I won't
bother)
- I don't think there's any rush for the latest fix[1], so it'll get
picked up through the Fixes tag when it does and I won't wait for it to
resend whichever version.
[1] https://lore.kernel.org/all/20250107065446.86928-1-ryncsn@gmail.com/

Thanks!
-- 
Dominique


