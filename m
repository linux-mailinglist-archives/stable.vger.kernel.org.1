Return-Path: <stable+bounces-136674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2CBA9C2AC
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 11:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE9B4C04CE
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184AB230278;
	Fri, 25 Apr 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BkTyS+WD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F622367A5
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571585; cv=none; b=mVv8nIMzW5IiIS4DBd9e8RZdhx5H6vykVyTe0wFJtK9wL2wQeL4u1XA1XHkRZIdPObrDHMv0irAygBxIe3Gmopv66gdQJC73Onuwrn9KuAuZtI7gir8WoH4YkhwnbgUT7qGP42Pmk/JQVOWbulMluPDzfWx6Y0KGZUrphsIqvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571585; c=relaxed/simple;
	bh=FG52vSSqSb62eyVyg6iMFqQqyE0YYjpj12eVjme1v30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnmJuyLT+Rf3b5txCEl0xrt8nE1zVqHzY1cIsYiVG5R+jeyT+Nvxpl5JxIl90VdrRtoQsa62TF056lM7Wlz95IA7JDAOep6uQMZwK4tw0yD5KnrvfX7ptEho/EoJ61ofMejL3kTJzT8ROvLZW1i55soUe+GNx7G9GXsbDy78u4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BkTyS+WD; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so3151957a12.3
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745571582; x=1746176382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlnA5ZbFrS4WV28dU38D6tfu/eMxlTmqrBqiOY5tPo8=;
        b=BkTyS+WDQQ/4TL3wFlBwTXxq6N4U1s1rm2zEUEtmrVVaUMjK6vdex4MGFATBY4RMkK
         SVfUx2Pnd2SVMBHgvxaKAgv/bbvIVFYXoltsFw5YNEGhPPkNv3BytsUd3YDlqayP0NVW
         21WlJ/BluluSKU6oSBOVgy12dn4mqK733klJnPt70R2ngbE62sE2eGiOIqlQx9rZ3hgt
         H9rMRo4DXxsaY7up9nyRsDITvmiyTFSJuTuVbMORqr6R1b5fJTWSRVa4ZUEecZaRhfbX
         ET1gvzEIcY3dD+wTQXAKpNAZE1WZJdVHPoKU4MmHSFnK70sZriBlyw522okgb4pFS/WS
         xqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745571582; x=1746176382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlnA5ZbFrS4WV28dU38D6tfu/eMxlTmqrBqiOY5tPo8=;
        b=KwPwImm6lXSNW17tfc1WcI8E5waqT9ZCnmV3N9fVCPwiT8nWa87WwMHrok/2a5ZzMb
         9CKs0EtXRJWB/7+d8wWLFkgyfa/zH9vJoPhWSXXC5dsRpY4jgkUY8S79evQK3DRwOa9y
         McTc5pVSwNkpipoazuvoOMvUyHw85UGSH8l2O3fV9xCXgtcl4S0Ipd5iMHI6mKm63qp5
         oqGVUkM0B+LHBONmBxsfglIImR0NIcINWPy16Yao4SFXcCV1uA23RHLqTgsP/Et0ghTW
         SKGYNzq3Fo4MezmDMep7Oont1PlVP+Zk3CJQil3Cy8IndAPzaa8zbTjXOmgBpXuj07qN
         OJdw==
X-Gm-Message-State: AOJu0Yw+VnKamm7pMRObjkXzhH/HP0sIl4+cdwPRUJ7IMv/EIQ6Ig65p
	YYDew9LFAdVBtwwULhrBcSyYEmLi9yTdMjOxlSgbNSXrYU/XHEJ2Gd7XHsw4BZM=
X-Gm-Gg: ASbGncsN37K09eUwHghqnXCl+BSn1Amdh1sIklc8IzTSVbPQS9ybmBOTUqTNEL/Sxxd
	tT7M8gWDcTfhmSRz1YGfrB59DFq+6kdvWwCiregCHl70r/CklftUaVO6wac/fru/sFvwN+YLIzB
	BTOduJyA37USxQyUpxgPq/nSoCrcIYnzGrByJUxhHAEe14DankuBh0vZFurkw2cOWyMCDgPxbx0
	vZRgMHTI19hi4CL9gJFxrbd7a7qY2QG+u7wiYX0xv0yg7DSl8IPjZCos8bWfArBRao3WBHg/ifN
	+xrLb66qSr3syac2h5XgpHzS34tlr5p8sPSkY0uNPwITJyMeJNKF9CE+OWbKcOk=
X-Google-Smtp-Source: AGHT+IEzawCcMf3Tx52ifJ8XqWa5OjCWgNLAL+Kos2ww4BTacpKQFiBW++4NKbWBT10u1GU4SXtO2g==
X-Received: by 2002:a17:907:3cc3:b0:acb:34b1:4442 with SMTP id a640c23a62f3a-ace7139ce4emr145003866b.48.1745571581822;
        Fri, 25 Apr 2025 01:59:41 -0700 (PDT)
Received: from u94a (114-140-90-28.adsl.fetnet.net. [114.140.90.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf7866sm99255466b.116.2025.04.25.01.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:59:41 -0700 (PDT)
Date: Fri, 25 Apr 2025 16:59:33 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH stable 6.12 6.14 1/1] selftests/bpf: Mitigate
 sockmap_ktls disconnect_after_delete failure
Message-ID: <apmmx7mdgfznnzc3k2wqxpds7vpq2vy3emkuulql7u4c6uvrfm@ui7jkyfopcxh>
References: <20250425055702.48973-1-shung-hsi.yu@suse.com>
 <aok6og6gyokth2rap7qdhtmc4saljzg43qbrvtbeopjuuq6275@hptib2h2wpac>
 <2025042523-uncheck-hazy-17a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042523-uncheck-hazy-17a9@gregkh>

On Fri, Apr 25, 2025 at 09:17:13AM +0200, Greg KH wrote:
> On Fri, Apr 25, 2025 at 02:35:59PM +0800, Shung-Hsi Yu wrote:
> > On Fri, Apr 25, 2025 at 01:57:01PM +0800, Shung-Hsi Yu wrote:
> > > From: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > 
> > > commit 5071a1e606b30c0c11278d3c6620cd6a24724cf6 upstream.
> > > 
> > > "sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
> > > after recent merges from netdev:
> > > * https://github.com/kernel-patches/bpf/actions/runs/14458537639
> > > * https://github.com/kernel-patches/bpf/actions/runs/14457178732
> > > 
> > > It happens because disconnect has been disabled for TLS [1], and it
> > > renders the test case invalid.
> > > 
> > > Removing all the test code creates a conflict between bpf and
> > > bpf-next, so for now only remove the offending assert [2].
> > > 
> > > The test will be removed later on bpf-next.
> > > 
> > > [1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.org/
> > > [2] https://lore.kernel.org/bpf/cfc371285323e1a3f3b006bfcf74e6cf7ad65258@linux.dev/
> > > 
> > > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > > Link: https://lore.kernel.org/bpf/20250416170246.2438524-1-ihor.solodrai@linux.dev
> > > [ shung-hsi.yu: needed because upstream commit 5071a1e606b3 ("net: tls:
> > > explicitly disallow disconnect") is backported ]
> > > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > 
> > I missed that 5071a1e606b3 was added to 6.1 and 6.6, too. Please apply
> > this one for 6.14, 6.12, 6.6, and 6.1.
> 
> It's already queued up for the next 6.6.y, 6.1.y, 5.15.y and 5.10.y
> releases, and is already in the 6.14.3 and 6.12.24 releases.
> 
> Did I miss anywhere else that it needs to go?

My bad, the patches I sent and I want to have backported is
82303a059aab, the first line in the patch

  commit 5071a1e606b30c0c11278d3c6620cd6a24724cf6 upstream.

is wrong.

I'll send v2. Hopefully that will be easier for you.

Shung-Hsi

