Return-Path: <stable+bounces-112039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E395A25F61
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 17:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A4E3A40C9
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E87720A5EF;
	Mon,  3 Feb 2025 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="A5eBwkvy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iQTBmrkA"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D520A5FA;
	Mon,  3 Feb 2025 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738598411; cv=none; b=gyL3If6d/pCQsOexR7NdgREzykoy41X60pHRcKcaqv2IgBLE1bbIfpI1Z9S37MPPUFDK8Cu0y6eYmz9bQ0ir1m4Zo0hubZ///WphW8LcD0ect+EBHb9RH1hwbmviuZtbKe0EWZtUTCRHM/1T8KoQUKVCkXDxy8weHS/ilVoXy6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738598411; c=relaxed/simple;
	bh=HHpIuLxVdDey+3rQYAd0ieQOJFjAUhHlZWuznmLX3Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HR7vpnxwpJyNc+Sn9Sa0GJmQonzbrGsQPxmmL34lwEZI6l0FkQqwrnCvLB/zzcivnswizdMc4T8GKHxAXlCQB7NxKXGe2MFbOigSvpZwoToUGJWGU+K2T9yLiZnns0SDjnITnVmVXZwDi0uNJZl87WaoyGwOqiYwvCdULLf7LMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=A5eBwkvy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iQTBmrkA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70428254015B;
	Mon,  3 Feb 2025 11:00:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 11:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1738598407; x=1738684807; bh=b1TGdaW+/VY1wKwJa980bXl/HdO+YGMF
	E8U9uk/NliE=; b=A5eBwkvyvWUsSlVFAYoPx6DgEZiIP3e7d+S0GIU8y+f7xooq
	o4f963CuwgcCFtmGkvIx54I0pr2HZaG+D5dIbt5M7357f+n1OtNhfX9iakbSfQWf
	tf+6CNPSE0o2DTJOJrExlQi1o7lMIJlzPICUHwt+a/5ocuo/kxxd1KPYHEypCX6S
	c38JwU3KgKwPtCyIOwXX1qkDO8NwlN58ILGl5t9RvWdDOzfjLq6VLttdiELj0W9s
	Q9hZwXaQMDeDpjyWOGElfjxw/4ziNS6dl7kYjPtv/T2ubywYK3oJM+AoX4JIPDSR
	PRebLKQx1kCxH5q432/jd21k7VussLfGPPVasw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738598407; x=
	1738684807; bh=b1TGdaW+/VY1wKwJa980bXl/HdO+YGMFE8U9uk/NliE=; b=i
	QTBmrkAdBpVRMMtn+QbbB+Cy+Px3uDvcO9FHdcluRiA4gl0ZmMh0/U5Wv+Nuumh7
	yuNi6LkMvOshe3N/F5hJ7ag9tNL9vx3fGD8YHOS5zHnjQWb0a2d//HKpbXJd/0rK
	AtG+tXehXtxHrmvmzYPMvA+LppRDBI8sh08yrzQhr8hBLqiJrimDRj16UTZr9cNx
	798tKv5BFCt6jAzkyx3S7Bxz39G6PFQcSzC5eg3J3KhBGomiAvrXdBU+VPeQ55/q
	JSQB9n/nuKeYRCmmLnGQrlaYD1l5/bqfmvNKtwOK2J5SAnu6wckMFndQ/E3y2aVO
	tHnmXqD2p3tOdbyD1cNow==
X-ME-Sender: <xms:BuigZ7PhnrwzScCOT8JHUEm38ytNppzjnVa-IgaPTNjCz-AXlkV7iA>
    <xme:BuigZ18HZ6HYyA28FvGY_4cER1vFxiERbEO1b-biWgRxFjznIwHOXQ-DMahJ5ECtf
    8MSFoxyBG-5TbBnW2w>
X-ME-Received: <xmr:BuigZ6TVcW5LCsgu6plJckSlhamVVKDvhTyJAVjQrkQBRlCO568Bsa4FUXLPV35NIR58jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdttddt
    jeenucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilh
    hlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtvdefueetheei
    gefgkedtheetjeduvddvtdfhteelgeektdevvedttddvhfdtfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtth
    hopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhgrnhhnrghpuhhrvhgv
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsh
    gvrghnjhgtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvrhguvghmrghkthgrshes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtoheprggtkhgvrhhlvgihthhnghesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepjhigghgrohesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepshgrghhishesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:B-igZ_u6fLyRvAx_v06d0HwyF4Oe7G0hAz3blzcs4E2-WJ-meyWFEQ>
    <xmx:B-igZzfjwJa__g6T9LIZ65-CI_kK-swUWRT9Q_HtGZBaEynqBmYeJw>
    <xmx:B-igZ73E3iXifhgNQ6_nTSWK4y6RDdYsY9evYR5x5PX1TrrZofZN_A>
    <xmx:B-igZ_8jdfs5LhXu56Y85qnw4m5ACbziSKIVDHSWxMKmf1ECFpluEw>
    <xmx:B-igZ-sSziHMoXbaR-6MO7PjFs--OxKfDqVpQJYVZYBu1qnqerdDvq5k>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 11:00:01 -0500 (EST)
Date: Mon, 3 Feb 2025 17:59:57 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via
 tdx_safe_halt()
Message-ID: <baiv6tl2lkr25i2ry2q2jaylu5y6hhioqfwhc4yafk2uwqbgf5@sqxlpg2r6kcc>
References: <20250129232525.3519586-1-vannapurve@google.com>
 <p6sbwtdmvwcbr55a4fmiirabkvp3f542nawdgxoyq22cdhnu33@ffbmyh2zuj2z>
 <CAGtprH8pJ3Zj_umygzxp8=4sJTdwY5v2bFDhoBdX=-3KQaDnCw@mail.gmail.com>
 <wmdg54v56uizuifhaufllnjtecmvhllv35jyrvdilf4ty4pfs5@y4zppjm2sthr>
 <CAGtprH82OjizyORJ91d6f6VAn_E9LY7WptN-DsoxwLT4VwOccg@mail.gmail.com>
 <2wooixyr7ekw3ebi4oytuolk5wtyi2gqhsiveshfcfixlz3kuq@d5h6gniewqzk>
 <CAGtprH-n=cfH_BJAmiNMoRbqq0XdGCf3RE67TYW8z7RARnsCiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH-n=cfH_BJAmiNMoRbqq0XdGCf3RE67TYW8z7RARnsCiQ@mail.gmail.com>

On Fri, Jan 31, 2025 at 06:32:04PM -0800, Vishal Annapurve wrote:
> On Fri, Jan 31, 2025 at 12:13 AM Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> >
> > On Thu, Jan 30, 2025 at 11:45:01AM -0800, Vishal Annapurve wrote:
> > > On Thu, Jan 30, 2025 at 10:48 AM Kirill A. Shutemov
> > > <kirill@shutemov.name> wrote:
> > > > ...
> > > > > >
> > > > > > I think it is worth to putting this into a separate patch and not
> > > > > > backport. The rest of the patch is bugfix and this doesn't belong.
> > > > > >
> > > > > > Otherwise, looks good to me:
> > > > > >
> > > > > > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>@linux.intel.com>
> > > > > >
> > > > > > --
> > > > > >   Kiryl Shutsemau / Kirill A. Shutemov
> > > > >
> > > > > Thanks Kirill for the review.
> > > > >
> > > > > Thinking more about this fix, now I am wondering why the efforts [1]
> > > > > to move halt/safe_halt under CONFIG_PARAVIRT were abandoned. Currently
> > > > > proposed fix is incomplete as it would not handle scenarios where
> > > > > CONFIG_PARAVIRT_XXL is disabled. I am tilting towards reviving [1] and
> > > > > requiring CONFIG_PARAVIRT for TDX VMs. WDYT?
> > > > >
> > > > > [1] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanarayanan.kuppuswamy@linux.intel.com/
> > > >
> > > > Many people dislike paravirt callbacks. We tried to avoid relying on them
> > > > for core TDX enabling.
> > > >
> > > > Can you explain the issue you see with CONFIG_PARAVIRT_XXL being disabled?
> > > > I don't think I follow.
> > >
> > > Relevant callers of *_safe_halt() are:
> > > 1) kvm_wait() -> safe_halt() -> raw_safe_halt() -> arch_safe_halt()
> >
> > Okay, I didn't realized that CONFIG_PARAVIRT_SPINLOCKS doesn't depend on
> > CONFIG_PARAVIRT_XXL.
> >
> > It would be interesting to check if paravirtualized spinlocks make sense
> > for TDX given the cost of TD exit.
> >
> > Maybe we should avoid advertising KVM_FEATURE_PV_UNHALT to the TDX guests?
> >
> 
> Are you hinting towards a model where TDX guest prohibits such call
> sites from being configured? I am not sure if it's a sustainable model
> if we just rely on the host not advertising these features as the
> guest kernel can still add new paths that are not controlled by the
> host that lead to *_safe_halt().

I've asked TDX module folks to provide additional information in ve_info
to help handle STI shadow correctly. They will implement it, but it will
take some time.

So we need some kind of stopgap until we have it.

I am reluctant to commit to paravirt calls for this workaround. They will
likely stick forever. It is possible, I would like to avoid them. If not,
oh well.

> > > 2) acpi_safe_halt() -> safe_halt() -> raw_safe_halt() -> arch_safe_halt()
> >
> > Have you checked why you get there? I don't see a reason for TDX guest to
> > get into ACPI idle stuff. We don't have C-states to manage.
> 
> Apparently userspace VMM is advertising pblock_address through SSDT
> tables in my configuration which causes guests to enable ACPI cpuidle
> drivers. Do you know if future generations of TDX hardware will not
> support different c-states for TDX VMs?

I have very limited understanding of power management, but I don't see how
C-states can be meaningfully supported by any virtualized environment.
To me, C-states only make sense for baremetal.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

