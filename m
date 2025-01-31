Return-Path: <stable+bounces-111773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D01CA23A7F
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 09:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A007F1886493
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBC9158874;
	Fri, 31 Jan 2025 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="fbnskUI8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dmE1psfQ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7DC1531C2;
	Fri, 31 Jan 2025 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738311216; cv=none; b=cQW/nT1fmL3J3lU+ni1H48qyD/YJnj/Fn2pLCHXB5e9kyobAPr/QcIZTkDcJ9tpYHgeBfKwAq9zc5WmTSAdkagm6nvzM7AqOHUy4WLW1oxvhdXpsmQnBMrsScmF1q/dUj/lY9orsGkvoheeADxnCJdY1P1s2BLjGxrPxoueWxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738311216; c=relaxed/simple;
	bh=SNxN+ZGOBw0Qz1nYWxe6v5L2vLBX9SJQRv5wkaYcHkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLeVcEQXgcwuIMGFpUim445PqU4D3s8JGi2H2unLZWY7B3LmJeM7GL+O3TBPrMMFMILi+58/uVhw4pymgykhXUpRwiPHaIcvvPR5y3g9wrzgAE8wYhZAA0nkpRPsxIK/gYWqlBb7fzCsqyVg2lXDlV+vEY09pVhdHAHCVyZ1mX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=fbnskUI8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dmE1psfQ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C13651140154;
	Fri, 31 Jan 2025 03:13:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 31 Jan 2025 03:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1738311213; x=1738397613; bh=4jNxJH8MCi0+Pv9zAGCRWJW5yDuSYCSC
	uGhsFDemDZI=; b=fbnskUI897W5qqJl4oqk3ijAZn4iw9tZUFV31cpfWiTEKGRe
	EjreOQwww9Wn59r29EKDr2uO+cyUVRwGs5CoAhg4c+XSwNrgCtTIIVLn+N2kLo43
	79xvU0zZ03ouatHrrM0UMi0ilcAOOITIHzUvFGQgDdvyOj6EEsVdke/E11KuPI59
	/72XYeSy4DbQleuSWujVh8QIKBZQYbUkx74GpCvZTFC6gWWSCU2cSjdAPXNU1Ha/
	B/MBV3noCccvuZ9AhAAKOO3YCjsbxHHh6mVmctY9V4+7WUu7qbX+0XexGss61XRx
	dX07/uJgWJZyc3B/M1Sl9l6x+MpwgzkX8PJzLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738311213; x=
	1738397613; bh=4jNxJH8MCi0+Pv9zAGCRWJW5yDuSYCSCuGhsFDemDZI=; b=d
	mE1psfQezO2/GUpwkW5PXjaMkbLz3VSSnz0u0fzetszkR+z1bX48ZzXfXgJM1tzg
	+FI6baLBXX66EjBXikXQmwMZpBYQjUbvloTwi9qzlIHuBQnu6ZvABHaFeaLR5e1A
	kenZAUNg7CzKEPFsffcUP+XHTSRKt+RfvR/FPH8K5jEfnjmbu+aEvbVxtl2nEiUl
	Jly3+qVeV4XPPqe1wlQ/KaKGBRyNKNYLtqt1xC+iukFJob7C84nGMniC5qctdYUl
	PLkNMfCcNkbt31jOkFtboVTvYJa2//dbwNRyxxLvIkRYPnWQBi8zquvsSWS8eO8M
	tSRD1s0bX0br8NKFzD3+A==
X-ME-Sender: <xms:LYacZxWbNp1TYZ70UjM-69i0828YayL09ffr2cBQbfZY_sHxzsFWWw>
    <xme:LYacZxkC53T7BE3vuYLhDrpuGi-5ubIHTTdIqK_J48wSpfiPej5ZHW9zn7e2b74IE
    0jIf40p5jnIky64G0A>
X-ME-Received: <xmr:LYacZ9ayqubIikc5Gq1BwrPHAnOcO5-jdG97CqPvSWflCbH1JaHDZ1PWeXFtsXD1Jk6yvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdej
    necuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllh
    esshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnheptddvfeeuteehieeg
    gfektdehteejuddvvddthfetleegkedtveevtddtvdfhtdefnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtoh
    epudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvrghnnhgrphhurhhvvges
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehsvg
    grnhhjtgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghruggvmhgrkhhtrghssehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopegrtghkvghrlhgvhihtnhhgsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehjgihgrghosehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehsrghgihhssehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:LYacZ0XVhUl1FBqTTuhvlmOaZKw5xdH5IGZPqcaSZCmmixl0MP3FWg>
    <xmx:LYacZ7mQdzn3R2OV3G93scW6NdOPLtNNqWHB23vA27NggaNdNZczyw>
    <xmx:LYacZxdxYT3eRfe54QuxldJhEIMtP1Cmu1ymry0gUZcihVnlu3BEcA>
    <xmx:LYacZ1Fi6VOx6afjfZ6R84vJafhVoby0Pl1SX__sj9deycZtTmz96A>
    <xmx:LYacZ93krT3wfHYvxZxUGWTSVDmFYO--AgshRT8yLBFUqLjTvqGrKfJZ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 03:13:27 -0500 (EST)
Date: Fri, 31 Jan 2025 10:13:24 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via
 tdx_safe_halt()
Message-ID: <2wooixyr7ekw3ebi4oytuolk5wtyi2gqhsiveshfcfixlz3kuq@d5h6gniewqzk>
References: <20250129232525.3519586-1-vannapurve@google.com>
 <p6sbwtdmvwcbr55a4fmiirabkvp3f542nawdgxoyq22cdhnu33@ffbmyh2zuj2z>
 <CAGtprH8pJ3Zj_umygzxp8=4sJTdwY5v2bFDhoBdX=-3KQaDnCw@mail.gmail.com>
 <wmdg54v56uizuifhaufllnjtecmvhllv35jyrvdilf4ty4pfs5@y4zppjm2sthr>
 <CAGtprH82OjizyORJ91d6f6VAn_E9LY7WptN-DsoxwLT4VwOccg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH82OjizyORJ91d6f6VAn_E9LY7WptN-DsoxwLT4VwOccg@mail.gmail.com>

On Thu, Jan 30, 2025 at 11:45:01AM -0800, Vishal Annapurve wrote:
> On Thu, Jan 30, 2025 at 10:48 AM Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> > ...
> > > >
> > > > I think it is worth to putting this into a separate patch and not
> > > > backport. The rest of the patch is bugfix and this doesn't belong.
> > > >
> > > > Otherwise, looks good to me:
> > > >
> > > > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>@linux.intel.com>
> > > >
> > > > --
> > > >   Kiryl Shutsemau / Kirill A. Shutemov
> > >
> > > Thanks Kirill for the review.
> > >
> > > Thinking more about this fix, now I am wondering why the efforts [1]
> > > to move halt/safe_halt under CONFIG_PARAVIRT were abandoned. Currently
> > > proposed fix is incomplete as it would not handle scenarios where
> > > CONFIG_PARAVIRT_XXL is disabled. I am tilting towards reviving [1] and
> > > requiring CONFIG_PARAVIRT for TDX VMs. WDYT?
> > >
> > > [1] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanarayanan.kuppuswamy@linux.intel.com/
> >
> > Many people dislike paravirt callbacks. We tried to avoid relying on them
> > for core TDX enabling.
> >
> > Can you explain the issue you see with CONFIG_PARAVIRT_XXL being disabled?
> > I don't think I follow.
> 
> Relevant callers of *_safe_halt() are:
> 1) kvm_wait() -> safe_halt() -> raw_safe_halt() -> arch_safe_halt()

Okay, I didn't realized that CONFIG_PARAVIRT_SPINLOCKS doesn't depend on
CONFIG_PARAVIRT_XXL.

It would be interesting to check if paravirtualized spinlocks make sense
for TDX given the cost of TD exit.

Maybe we should avoid advertising KVM_FEATURE_PV_UNHALT to the TDX guests?

> 2) acpi_safe_halt() -> safe_halt() -> raw_safe_halt() -> arch_safe_halt()

Have you checked why you get there? I don't see a reason for TDX guest to
get into ACPI idle stuff. We don't have C-states to manage.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

