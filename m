Return-Path: <stable+bounces-235428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBmoLNDD12mdSQgAu9opvQ
	(envelope-from <stable+bounces-235428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:20:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 045493CC89E
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E199230293FB
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F9B37F8A2;
	Thu,  9 Apr 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LZpz0Xab"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB013D3498
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747763; cv=none; b=tOUKagjG9Xb+tpHXlxlRRUiulTcqXmVm6r+t5DEGrgQ58xYYSB0dv4w47LXyRbM65rV0MFbL3EFbTIhXeyn13MRFAM1wd5dAer1XAbWo8GizXoBMFrjd5072EeNBvrZYXNp2RNLhHy9iVr2VM2e4mkJtzhJEEv7Dum5/2jq1ypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747763; c=relaxed/simple;
	bh=lPGV8AFmLuXxJZ6gD+bLN7/Il/AxPMIpR2Jc3CtNGME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdyQ95GadW8TIzLap0j60A3a/6Y454bqs5tYA4BphYgGwClJwLB/DQL4OgZjAVXe3V6Ub4/UE0FToLVTp2LaVuJ66eykQL53eEIOS8CO+ioXkzaxExa8qoyM0gUPv0KofqvTVwVzi4sAwYi2Za4Qs30TEBUmoPYVa52/BJydElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LZpz0Xab; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64eb84d1e37so815214d50.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775747761; x=1776352561; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hPQPBOBgtkvcgYqzt6x5wusYckTuQGEX69sblOJCEYc=;
        b=LZpz0XabV91fVUzyHR1SDVj1rFMbOlzdFmKE8y6NboHza3kYCGutR8Y8oMSvras3YG
         GkGgkeNuY90ChDeiWD9GIZSJkGg/7iv9K/r+Jrm3o7ttWwqpDUGijwuyLMXMwgw6AVSh
         ilTMnM/rrH3qEpZEF6FbT436ZDGur6BMfJLynCF+fEUebegfu38RZv4414ndahk8DqSb
         48UMG2C2vksL8dwd3cY9mS1v5yL18e9Vahmf0n5D5Bhde7CxLj9Cmiw1ctbDQ2c9+YEj
         RkzsEM392XkRgMtxM/hBWE/zD40uu8R+hbm9+iMSUS13dmC9husxaThRkAfx6WUUPs3i
         gfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775747761; x=1776352561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPQPBOBgtkvcgYqzt6x5wusYckTuQGEX69sblOJCEYc=;
        b=ExVVI9iOta13PDnaRf35dRSvI6uknz2F6uK39qbozYGYH08sKLbHyOZC0qaY9z5GSH
         n60bOr+3eaxrFBK/ZzOtSIi8iehZCZeC0n7LYc+ABnj2tnWZQxmmzKKiEHdvfmdPx/sV
         cPhm5EHTJ75rkaBnMGwzSNcWlH1zab4uoBAZ7CQsgth+wymn3umJZaF8ERJN0vzf4gzX
         pUv8BHsXdAbsIYoz1f1b0MtKj4Gf11qo2GPQPIVzWgEOhFDD34kRceh4lDthKxEalAaz
         8QCLKo5cwVwEGx7RF2jDy6xgJrqIFlIAifMCJ5xqIQBnK2iYGkW9kD8vIulWu3gbK3dm
         jm2g==
X-Forwarded-Encrypted: i=1; AJvYcCWLM4vEvrnuAG9NVWOwiGJteEq6A0ayJntIanE8sbo5h/PwieBiWel13D86wAllj3h1XdC8FIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymWeRUi1xWmDL+37jhzFpBQytEYhNYul0vStPW/IydqIbyaYCM
	GIXVd2OQi/ey7YviSghnalbMzGFPTSsuW5jdQYmPVXEEfxbg1/dFLlawHPmSYwKzqzw=
X-Gm-Gg: AeBDiesSGEof47osLhKBrfToiGLPaKZFHQ6fsg6WXIk4JLfCimJJyuWTJnT1aY8bfsh
	uPZsfJ89jfmjtGNclc+ZJb4+q7Zyy/3Uk3bHJ0Y7SNllqPQ1UwIDk7HwMKOtCTDwVlH51jXU1EF
	YP1UQZeAonKIoqSy8ibVdCJmzuCXUJTeCf3hRUNLJ7VRI4U+4jz4tUoDnxCrmmQyp57PCyxdQMa
	p9OpfQ4/Q1I3zsjtHmJZjMVdI2ghow8PayEo47/1w8AKxmOVpN4+lZSfcKP5re4o7n4lBi4ziKz
	poxOfYoxSRTfOIZWRXz/ORvoK0+QF7VmjABWwGtzYy7zshmUFMYKeBSYClAIcZAykABci52IfWA
	YYZBB/Oe2N5uOhS5GS65mh0MOktbs/ky/7aAQtUKYfNLGsWkjsk4d5B8h65sVmbqmWurkUGPax6
	+s+gCJgfhUQnJLibSZU/+daluU/i0kCyTLPHxUjRCo8C/NjKLQ1pLjcz/h3pDbi8uUnYpgQg==
X-Received: by 2002:a05:690e:43d1:b0:650:8c3:8df2 with SMTP id 956f58d0204a3-650488afacemr17793279d50.62.1775747760893;
        Thu, 09 Apr 2026 08:16:00 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8067c73sm1700572085a.24.2026.04.09.08.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:16:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wAr6t-00000008Ihi-0wvj;
	Thu, 09 Apr 2026 12:15:59 -0300
Date: Thu, 9 Apr 2026 12:15:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sina Hassani <sina@openai.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Aaron Wisner <awiz@openai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
Message-ID: <20260409151559.GR2551565@ziepe.ca>
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca>
 <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
 <20260407012726.GN2551565@ziepe.ca>
 <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-235428-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 045493CC89E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 06:40:05PM -0700, Sina Hassani wrote:
> On Mon, Apr 6, 2026 at 6:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Apr 06, 2026 at 06:17:24PM -0700, Sina Hassani wrote:
> > > On Mon, Apr 6, 2026 at 6:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
> > > >
> > > > > io_pagetable *iopt, unsigned long start,
> > > > >                 unmapped_bytes += area_last - area_first + 1;
> > > > >
> > > > >                 down_write(&iopt->iova_rwsem);
> > > > > +
> > > > > +               /* Do not reconsider things already unmapped in case of
> > > > > +                * concurrent allocation */
> > > > > +               start = area_last + 1;
> > > >
> > > > area_last can be ULONG_MAX so this literally overflows to 0. It is why
> > > > I formed the suggestion I gave as I did
> > > >
> > > Yes, in which case the  if (start < area_last) that follows will catch
> > > it. Are you suggesting I compare against ULONG_MAX instead?
> >
> > iommufd does not have any overflows to 0 and rely on it tricks like
> > this. You should just compare to the existing iteration last
> >
> Just to confirm that I understand correctly, like this?
> 
> +               if (area_last >= last) {
> +                       break;
> +.              } else {
> +.                      start = area_last + 1;
> +               }

Yeah that looks Ok

Jason

