Return-Path: <stable+bounces-112052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86622A26434
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 21:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1B41885952
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 20:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045AC1E98EC;
	Mon,  3 Feb 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="KwX7SJGz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJyjEfJ4"
X-Original-To: stable@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B551339A1;
	Mon,  3 Feb 2025 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738613186; cv=none; b=LtmF/8A3gQuAjQx6ywCq2IhKSgGShl+uJg2o1MT+1PYndk5Crzh7MXHhNitpjC0eYVniHDrbNTXJRujM9az4DXey/O4powc6fHFoUReOKNFLGHi67ZsdmADTcJcUBUR5+SQSZLCOM4K6s3a02R9b+RH++guaJLI9YuKkcCHRK50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738613186; c=relaxed/simple;
	bh=SutM7TpXAtw9+sBUhKOyPpuiD0yU5oLKZvaFEhKhudM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTW1bRAqEBnm8W8AxMEPBSO4hM9JQjH+x66yidEWgOK0bNCfEdD4uv0fSpXYVQIewpelRjKVDJMSlaNlH0SMrkW/e5sggir1k0xrtRmjQnqClP8u2MET03yzZcyJRdFKu+G+Q5ZiaJpMdGdAr8x5JNGjT/zr9xwpHm9OyO/NxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=KwX7SJGz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJyjEfJ4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 863A913801E6;
	Mon,  3 Feb 2025 15:06:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 03 Feb 2025 15:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1738613183; x=1738699583; bh=CfVg5HvIt5jV2onLmlvDPrpx5sF0Oynr
	lrxmWaMF1zE=; b=KwX7SJGzVrwG6QVtgB4kRLvIQKqnqWh7By8UIzAuWJvuuDZq
	FNM+ESvPfCkzg+ntfGk5B/7ir19bJ6gEoQHS4xElGRvi+Jg9bWbs/zA3J5C+jAVc
	8TxGcYAwoWxJCacXyoJ78kXGDNBMBaT032F8V/7hiGCyZSjQQAusYkRsMpIxs95p
	LM/jhzfJiNWUF7DtVwpHZ+dHsrWInjPdj8o17dr5URPhqlwVHX9Pd3FHPAMLRI3/
	UBurESUBskfnmoNXpZ8n9RS/p6bs2rz3jLxn+b8/yrSwptesxgBNUvWdFHesj+oa
	OZHXeoGO1xKwXloBdOcb2DdGAF/++bJLPPKWvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738613183; x=
	1738699583; bh=CfVg5HvIt5jV2onLmlvDPrpx5sF0OynrlrxmWaMF1zE=; b=d
	JyjEfJ4U/2NSX+irXHtodFgZ2E4ELijoCwm0GtSaJtD2AAZaR/UN8FKcHtZlRWd+
	kDqqU+LL/fFWh/k3pV8tUyDte3FfGZXa0sGpT4vtUzpH7lx+AurBeE1c1uxhx4ri
	YDViBv33rCsxYcFz1UcOlD9yu+qaJqr+nzSIg19nrfftz+hJr5Gh3/WIPFWHs2yw
	UrURqTmSmqVDFADJvQKY/yyQYs4A9jG1Fn38M5mDlnPOzv8FW5I3ozWJsWPI5IO7
	MztDJt3vAEcUCipNjL0NA09cY0avR4ulZNK/tYYnMin9H2K5/O97LBqNlGBg/68s
	sOKDzlzQIWGA0uASfyhrw==
X-ME-Sender: <xms:viGhZ5AvMKQHVYeAXnFCOvol0aBR0u7apuWBxUjE_Ce0c9IFflMAhQ>
    <xme:viGhZ3i89TNqzlOKA3hGXqudFMBzQfuS2FPL7RUS96tZxCjBt2xj9Gh9cJqnEq5s0
    T7DTcfUzzsRU7zhjtQ>
X-ME-Received: <xmr:viGhZ0ln9ayMuDgRYbCmBxMtAm1us9_8XsMlqXuz7vgD8AvEjQGSZDC5sRjmJKwxQ8HXBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:viGhZzz8d-kbqIvAkTfvnQmo5YaEJ52dJaH7onpuQ0pJxmMbaihzKQ>
    <xmx:viGhZ-QRSAD7i9rza_AFtRXPBzXmWzDlegkOKDYjFGR37PR579VSnQ>
    <xmx:viGhZ2YS2ZW3kr-ja63igcXbqzPYrCbbvjQE8dLFLbox8kA_P7I8bA>
    <xmx:viGhZ_QKmrDxsIDIn3yxKSXOgY7lLGIW88wZirzPWlFnkTePWtOjOA>
    <xmx:vyGhZ3Av6fx4jy055CM7y_ttBjui7Mr7ze0MQpiC04WLHUo3mwAB0Dgv>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 15:06:17 -0500 (EST)
Date: Mon, 3 Feb 2025 22:06:13 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via
 tdx_safe_halt()
Message-ID: <4brtmv5h2ymvcqhvtiavzogm253t6du3pn6gtpfrga6ll7nvf2@wbcz7noqvutp>
References: <20250129232525.3519586-1-vannapurve@google.com>
 <p6sbwtdmvwcbr55a4fmiirabkvp3f542nawdgxoyq22cdhnu33@ffbmyh2zuj2z>
 <CAGtprH8pJ3Zj_umygzxp8=4sJTdwY5v2bFDhoBdX=-3KQaDnCw@mail.gmail.com>
 <wmdg54v56uizuifhaufllnjtecmvhllv35jyrvdilf4ty4pfs5@y4zppjm2sthr>
 <CAGtprH82OjizyORJ91d6f6VAn_E9LY7WptN-DsoxwLT4VwOccg@mail.gmail.com>
 <2wooixyr7ekw3ebi4oytuolk5wtyi2gqhsiveshfcfixlz3kuq@d5h6gniewqzk>
 <CAGtprH-n=cfH_BJAmiNMoRbqq0XdGCf3RE67TYW8z7RARnsCiQ@mail.gmail.com>
 <baiv6tl2lkr25i2ry2q2jaylu5y6hhioqfwhc4yafk2uwqbgf5@sqxlpg2r6kcc>
 <CAGtprH-5bL44c7ZQHKsDuOQNNd4dsBd-uR8GT9OyqffEXW963Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH-5bL44c7ZQHKsDuOQNNd4dsBd-uR8GT9OyqffEXW963Q@mail.gmail.com>

On Mon, Feb 03, 2025 at 09:01:41AM -0800, Vishal Annapurve wrote:
> On Mon, Feb 3, 2025 at 8:00 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > ...
> > >
> > > Are you hinting towards a model where TDX guest prohibits such call
> > > sites from being configured? I am not sure if it's a sustainable model
> > > if we just rely on the host not advertising these features as the
> > > guest kernel can still add new paths that are not controlled by the
> > > host that lead to *_safe_halt().
> >
> > I've asked TDX module folks to provide additional information in ve_info
> > to help handle STI shadow correctly. They will implement it, but it will
> > take some time.
> 
> What will the final solution look like?

VMX has GUEST_INTERRUPTIBILITY_INFO. This info is going to passed via
ve_info. Details are TBD.

With the info at hands, we can check if we are in STI shadow (regardless
of instruction) and skip interrupt enabling in that case.
 
> >
> > So we need some kind of stopgap until we have it.
> 
> Does it make sense to carry the patch suggested by Sean [1] as a
> stopgap for now?
> 
> [1] https://lore.kernel.org/lkml/Z5l6L3Hen9_Y3SGC@google.com/

I like it more than paravirt calls. And in the future, HLT check can be
replaced with STI shadow check if the info is available.

> >
> > I am reluctant to commit to paravirt calls for this workaround. They will
> > likely stick forever. It is possible, I would like to avoid them. If not,
> > oh well.
> >
> > > > > 2) acpi_safe_halt() -> safe_halt() -> raw_safe_halt() -> arch_safe_halt()
> > > >
> > > > Have you checked why you get there? I don't see a reason for TDX guest to
> > > > get into ACPI idle stuff. We don't have C-states to manage.
> > >
> > > Apparently userspace VMM is advertising pblock_address through SSDT
> > > tables in my configuration which causes guests to enable ACPI cpuidle
> > > drivers. Do you know if future generations of TDX hardware will not
> > > support different c-states for TDX VMs?
> >
> > I have very limited understanding of power management, but I don't see how
> > C-states can be meaningfully supported by any virtualized environment.
> > To me, C-states only make sense for baremetal.
> 
> One possibility is that host can convey guests about using "mwait" as
> cstate entry mechanism as an alternative to halt if supported.

You don't need cpuidle for that. If MWAIT is supported, just enumerate
MWAIT to the guest and select_idle_routine() will pick it over
TDX-specific one.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

