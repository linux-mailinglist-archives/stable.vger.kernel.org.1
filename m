Return-Path: <stable+bounces-233453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MKvOREx1GmUsAcAu9opvQ
	(envelope-from <stable+bounces-233453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:17:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 626FE3A7CEC
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 097963018764
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62D339DBE7;
	Mon,  6 Apr 2026 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n4Z6d8H8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701539DBC2
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775513867; cv=none; b=Ft6yjHZCg1+mer2uJliCWC1f4U84sGLHkNMFlt5b65cvOI4jX11urlXDyC2xgCD3Se4bwAJaBdjyv+vcH1mF3sEBYbacqoqqx8LhymIhPByreWt9npjNLMzEMDUwLJaiBDRdHc7WeryvFK5LG3YCynitor+G9belHujjhHn6J2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775513867; c=relaxed/simple;
	bh=IrkSAajzxzj+cznXEX1SlF25o+WZMkFvFr/eXU7uev4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE4JuSsPMJss28SdfvQkmb8p0Lg4r0/iIKgEGv2UTHKxZh/UbZK8JcmZn1ktw3lIjgUtRjuyDcxrkWYONXgUyGhLJ8t+J6GbLEhpW6GXrb5QMZhiNoC9m/i4Ydh/0c2zObZKaKra1Zwb/T4GvMnU22BAr2K6ysx7t1KMtzToLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n4Z6d8H8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfd44fa075so573558785a.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 15:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775513865; x=1776118665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qX7VE6datnkTCa6fo3UBv/A39y5LOoYpU+f0cCPRo80=;
        b=n4Z6d8H8hrBISQEg/8bx0fSjgyN9sGvgq3cfxuhmAMwzMV00tjADaUF4DhkbDkilRW
         5WXJE5SM5gj8em5li6MZVMiNLEpzmk22piVg49syqsqI4dmEtHf9hi4u1nEB2Zq31RC/
         G+Uz1KatvBpA3j8OySE2pP5IwaBaDzLrMMhhpOPVvKcYghxAqKIXNaQXUPyP5awwN0s4
         fZgdOuRRLsdIMq/jjATSD43EgKfoSMW/AyXflFSTngdVSiMew/dqFAImtF6L/TFi9YYy
         sL+WERRm7nSwJIYeAnFQu+aMU+AWJvVENbN2QD5z4eX7FYzuaOGd5Pgy6D2gvTqsv+3o
         Zg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775513865; x=1776118665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qX7VE6datnkTCa6fo3UBv/A39y5LOoYpU+f0cCPRo80=;
        b=e9NZohWTKbruZtS8q7yXUnyiKX5pXgUUh8jseGWX7LsQlnhTV1EFsjylUsrOFJBsR6
         No2RCoXIZjoudeCWUrBsSMwfyCfEoDsdMgad57SOmeHqinlLjNv0yNTlO6yqaHoG7pKP
         Z+zcVuCSLHlHIQPdt6gDYStOo+YWYD9ZAieay//V4U8ytqHb+y4mSqkwvxeu+08wsF/4
         r9XSkgUDquT8YqDA0TknmcK5UQAH6eLMSNEoi5wbdejnBWyuyIh0QEw1xzN8x6755tLJ
         PstLpErSgQfLZyXYSzJoXcfrLMoUwtcytuYvB36ws8r89Arj4Z9RRePLXU6vm3tNLFLT
         7B+g==
X-Forwarded-Encrypted: i=1; AJvYcCX/WQ1KRWzVrSQ4r6V7YrmoOv0KeVIXB/XNCJ3ayWhy9DE1ygsvoCW06m5NjDE8RvJMTX+R37A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qNbZ3C11Uh/ce2jjrcrScqnfR3Kb7DAldp7Vgg63OMk3BN2G
	bw65umsFOH7xgWu+nUgRcpAggbnvbJRAwrkGhasslMEFkuNpqNl3FCFq0JWe1raXR2M=
X-Gm-Gg: AeBDiesnvBQ7qn7wQZKkktfxQw6xFGQnjk8xFhf11KgGKmiocE4H1SBNmgNnBu2rpj/
	/hPtoJZNSVIO1+pfR1H/2H0Yjt1TZLevilCpqoQQhUzr7+IVX33Vfhaq+OxdGxXoQROiQI1YOCh
	k75hOP9K4jhFk2rHMxTmP1qQ1UK1CSBbfjXDWLG9DDwoyGwP7BBdvTyU+8hbxTapVC1z1Yq7E2o
	l47edYM+oIHpz4MJKpt5YtZv9QeR/vtyaid1otQoGHDmId6uElcwowALcE8gFw4YA/q0mEOoKk2
	sEVOM/VJjZJFOk4/PFIHPhhP1BOlrUTLx4pA5sstE3JZc+Do4ZuFOvgOFhxU1lVlT7/la5iAAQ8
	Y5kW6I8RlUM6bDITJ8917bmq7Am67+Mpbq/Glg5pcoV3/2F3fF4dwd5rfNCUetl+93xw9SdDbIZ
	EhPHME9mRwi6h/703XjAxn8lJEVWMgN+JSoMvx99m5nHeGiH2BRQ9mkKNYqHtb4QOIo2PEoA==
X-Received: by 2002:a05:620a:1a11:b0:8cf:d565:fca4 with SMTP id af79cd13be357-8d41b8df4ecmr2084176985a.3.1775513865190;
        Mon, 06 Apr 2026 15:17:45 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8648c17sm1169709885a.33.2026.04.06.15.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:17:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9sGN-0000000E50y-3Hgv;
	Mon, 06 Apr 2026 19:17:43 -0300
Date: Mon, 6 Apr 2026 19:17:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sina Hassani <sina@openai.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Aaron Wisner <awiz@openai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] Fixes a race in iopt_unmap_iova_range
Message-ID: <20260406221743.GI2551565@ziepe.ca>
References: <CAAJpGJTzJZ0OgEU8NhyJ3dR1Y1V5x6CwbBjLW_kYLu+FTt9woQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJpGJTzJZ0OgEU8NhyJ3dR1Y1V5x6CwbBjLW_kYLu+FTt9woQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	TAGGED_FROM(0.00)[bounces-233453-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 626FE3A7CEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 03:00:36PM -0700, Sina Hassani wrote:
> Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the loop
> body when getting to the more expensive unmap operations. This is fine on
> its own except the loop condition is based on the first area that matches
> the unmap address range. If a concurrent call to map picks an area that was
> unmapped in the previous iterations, this loop will try to mistakenly unmap
> them.

Does this mean you are also using the automatic IOVA allocator?

It is certainly an error for userspace to be mapping to IOVA that is
under concurrent unmap.

> io_pagetable *iopt, unsigned long start,
>                 iopt_put_pages(pages);
> 
>                 unmapped_bytes += area_last - area_first + 1;
> +               start = area_last + 1;

This seems like a reasonable solution, but area_last + 1 can overflow
and that needs to be delt with too.

/* Do not reconsider things already unmapped in case of concurrent allocation */
if (area_last != last)
   start = area_last + 1;

?

Jason

