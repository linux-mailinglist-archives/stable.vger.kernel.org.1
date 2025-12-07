Return-Path: <stable+bounces-200302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56754CABAEB
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 00:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA2C3012DE9
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 23:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E062F0685;
	Sun,  7 Dec 2025 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gORCP0hA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8528F2E8B7E
	for <stable@vger.kernel.org>; Sun,  7 Dec 2025 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765150391; cv=none; b=MEBEkYAFmqgnjcWhEX+DtJZsFp6+Yo6Gs3DXaDNdwu+Ka1ewQC6yan0jhsohLDcVI2JhLupsJDjBLmxX2FwKmTLYzglFYBHvdxO5ev+K6cuT6KlXkX8jMafy2rCA/VDlFjzwhdxfG3ybM1wzE3ndSGGcru/+eSw7k/hORmj9Yb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765150391; c=relaxed/simple;
	bh=IUBnPdBepuQxqsyw6VOLxWUVxW1uVa8REohoNzbmBWo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfsV6R3JT1S6Wf44UJO0RIr+utrlRTEAWHsZxUkxIqNpL2jZjpLBKvr6acCTxiNuWt/vabwvSg8SHtpV7WY9eL5xciRY/do5AtyQkXBrjRkljkLrvc/B+pkqRHRoYtcugHVKGxiBl4BskucBPe2XSRnbDZpjN4GFRFNMsz9TgD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gORCP0hA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47796a837c7so33609655e9.0
        for <stable@vger.kernel.org>; Sun, 07 Dec 2025 15:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765150387; x=1765755187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/1QB5AMwL5JyG53A9J+/NYEsONb+MuJ9XPqo/Mr2oxg=;
        b=gORCP0hAz6Va25M9MkwcviQejiNn/y4H7ldALaHZMeANruMpSVvJLpz/0cDdTml9HC
         FitQJ6tfE/K6cLfvJBF8ZtqXfeZ/0DVWUfvGs5tasOhb0JXIi2A3kSESZM8pxp+hXgMV
         psy8K/NHtHmlIxR02Td1KsQDmCwO8oB3LiTKRytDyOdLkgFoSzQTpO1k+yDCTk1C1SH5
         vBblJ1zXnirxVfWhTJi4vjyIvnAIDoZiogcTV2yNPGjRP4GW9rzcBDeBiI+T/03aYDuj
         IlXuSJWaalSV8QFUQ/jcMGUYz9MIymPcgLXvvKCVuEruhHB97hXU2CK+LUsiKbCNPWGr
         y8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765150387; x=1765755187;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1QB5AMwL5JyG53A9J+/NYEsONb+MuJ9XPqo/Mr2oxg=;
        b=FyHSk97zukBJDcwZx3QyJL+KUpQ0Ir8TgjDkxD/C3MFc+ybF5G8uH3ICynq8zbZfO9
         1FUHTgEz0RLOyO6v9N2FmcGPoWCEoPMdvsgTv0WMosYa0ntXbGHl/xvXgaYTnBM9urN9
         q5VJos1T12DZTHxh9jIfqKMaaPozzD45QAZeCMWvF7thccgh703PAlzUDnOQc6n0SHpR
         /fcdQ5v5nmMPcyhr+dWSpPz4NL+jJcjfQCxkVxb/bQRc8iz7379GTfC2Yu2aFmgN6or6
         y5lIwDRur0inazdzfdFAxReQnB/LK4ZiUTQxDRocGFNeZ7sMoVYgXHJq9wmXlIUrgHKQ
         zj+w==
X-Forwarded-Encrypted: i=1; AJvYcCWHdgBuv6vYEUayIHQO3i+7qVdNb4ydP+XLZD/1wQSvA2kSKn1t538HruS31bmTjTSbYwu5brQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNUyRDs8qeq/MJOKt+9meZRYECEPUaT5jTM961N5mTSkTQMEd
	P8toTn9Vu0kW1Fmsjt+JIQLQb0ihSIih/svCS/PseN7QOUZyfeVPfUDL
X-Gm-Gg: ASbGncutGm9/SF3hk765idretTwxaRyrZ4u/aMnpu3NE31Tb5CMrrrLuRPZygXT3g0L
	5NYMXagk3U8ETeJVHn8ne26PPVyzrgX+0gzNXPz86EklZ9uovvVk4IExES9yh4rlW+lq24a2Vt6
	3pYX7oEgFMZ23VzlbJk/Ouf5xzZAdz7+wdXqot3fqw9c98Dri/o7sX9lskIumZotpG4irtIwl/2
	XkvbU5OtLwlehL6g/KFuedyUgc2Tewx9lcvw2ozya5NHQwoW263DK7h7xbmqqaMy3vjwmy2duvk
	z0X96dnnWZruk6MkZu/T6rZxASE9XyfQ7/bDHxb6wu1qIz7j5D2ii47f5t5qH0rXWgbauFi8U8B
	JBNthsdKxgNrr7pAeprOi9vrCUzDmpx5mksrHtotJqzeiUD83x1mDZYIb3pV17Bq0WCqez9UdGJ
	9orgnK0FrDnf6MTplV2u+o7gmp7/CqzY3/eYvA/6NYCWvBs75coA==
X-Google-Smtp-Source: AGHT+IGLUNEk+nz4eZd0cxsG7HFG7mM99SnnzoeXPdxW5LC2ztuNSH2YjTiMmtNxdHU5VMl4lTRNzw==
X-Received: by 2002:a05:600c:3508:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-47939dfcb2amr75354295e9.14.1765150386730;
        Sun, 07 Dec 2025 15:33:06 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930c90e67sm209800585e9.12.2025.12.07.15.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 15:33:06 -0800 (PST)
Message-ID: <69360eb2.050a0220.2b0cf3.b5a8@mx.google.com>
X-Google-Original-Message-ID: <aTYOr2-OnqcRaubu@Ansuel-XPS.>
Date: Mon, 8 Dec 2025 00:33:03 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Magnus Damm <damm@igel.co.jp>, linux-kernel@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] resource: handle wrong resource_size value on zero
 start/end resource
References: <20251207215359.28895-1-ansuelsmth@gmail.com>
 <aTYJw9lNfHxQI_Ag@smile.fi.intel.com>
 <aTYMeY1AsprPwC_9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTYMeY1AsprPwC_9@smile.fi.intel.com>

On Mon, Dec 08, 2025 at 01:23:37AM +0200, Andy Shevchenko wrote:
> On Mon, Dec 08, 2025 at 01:12:08AM +0200, Andy Shevchenko wrote:
> > On Sun, Dec 07, 2025 at 10:53:48PM +0100, Christian Marangi wrote:
> > > Commit 900730dc4705 ("wifi: ath: Use
> > > of_reserved_mem_region_to_resource() for "memory-region"") uncovered a
> > > massive problem with the usage of resource_size() helper.
> > > 
> > > The reported commit caused a regression with ath11k WiFi firmware
> > > loading and the change was just a simple replacement of duplicate code
> > > with a new helper of_reserved_mem_region_to_resource().
> > > 
> > > On reworking this, in the commit also a check for the presence of the
> > > node was replaced with resource_size(&res). This was done following the
> > > logic that if the node wasn't present then it's expected that also the
> > > resource_size is zero, mimicking the same if-else logic.
> > > 
> > > This was also the reason the regression was mostly hard to catch at
> > > first sight as the rework is correctly done given the assumption on the
> > > used helpers.
> > > 
> > > BUT this is actually not the case. On further inspection on
> > > resource_size() it was found that it NEVER actually returns 0.
> 
> Actually this not true. Obviously if the end == start - 1, it will return 0.
> So, you really need _carefully_ check users one-by-one and see how resource
> is filled, before judging the test. It might or might not be broken. Each
> case is individual, but the observation you made is quite valuable, thanks!
>

Yes sure there are case where it can return zero but are there real
world scenario like that in the context of resource_size for PCI or
resouce for MMIO?

Again the idea of this patch was to start searching for error instead of
simply fixing ath11k, I'm pretty sure there are other case that are
currently working by luck.

Another idea might be to introduce a new helper and add all kind of
checks to understand if the resource we are testing is all zero.

Something like resource_is_zero() that checks if start end and flags are
all zero? (and fix all the case where the helper might be used in a
wrong way?)

Or maybe we can change the condition of this to:

if (!res.flags && !res.start && !res.end)
	return 0;

Just putting some ideas on what would be the proper solution to the
problem without having to analyze all the 990 case where the helper is
used ehehehhe

> > > Even if the resource value of start and end are 0, the return value of
> > > resource_size() will ALWAYS be 1, resulting in the broken if-else
> > > condition ALWAYS going in the first if condition.
> > > 
> > > This was simply confirmed by reading the resource_size() logic:
> > > 
> > > 	return res->end - res->start + 1;
> > > 
> > > Given the confusion, also other case of such usage were searched in the
> > > kernel and with great suprise it seems LOTS of place assume
> > > resource_size() should return zero in the context of the resource start
> > > and end set to 0.
> > > 
> > > Quoting for example comments in drivers/vfio/pci/vfio_pci_core.c:
> > > 
> > > 		/*
> > > 		 * The PCI core shouldn't set up a resource with a
> > > 		 * type but zero size. But there may be bugs that
> > > 		 * cause us to do that.
> > > 		 */
> > > 		if (!resource_size(res))
> > > 			goto no_mmap;
> > > 
> > > It really seems resource_size() was tought with the assumption that
> > > resource struct was always correctly initialized before calling it and
> > > never set to zero.
> > > 
> > > But across the year this got lost and now there are lots of driver that
> > > assume resource_size() returns 0 if start and end are also 0.
> > > 
> > > To better handle this and make resource_size() returns correct value in
> > > such case, add a simple check and return 0 if both resource start and
> > > resource end are zero.
> > 
> > Good catch!
> > 
> > Now, let's unveil which drivers rely on "broken" behaviour...
> > 
> > ...
> > 
> > >  static inline resource_size_t resource_size(const struct resource *res)
> > >  {
> > > +	if (!res->start && !res->end)
> > > +		return 0;
> > 
> > I think this breaks or might brake some of the drivers that rely on the proper
> > calculation. If you supply the start and end for the same (if it's not 0), you
> > will get 1 and it's _correct_ result (surprise surprise). One of the thing that
> > may be directly affected (and regress) is the amount of IRQs calculation (which
> > on some platforms may start from 0). However, in practice I think it's none
> > nowadays in the upstream kernel.
> > 
> > >  	return res->end - res->start + 1;
> > >  }
> > 
> > That said, unfortunately, I think, you want to fix drivers one-by-one and this
> > patch is incorrect as it brings inconsistency to the logic (1 occupied address
> > whatever unit it has may still be valid resource).
> > 
> > Also a good start is to add test cases and add/update documentation.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
	Ansuel

