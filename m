Return-Path: <stable+bounces-112053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E449A2643F
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 21:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42EE67A3485
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090220CCDB;
	Mon,  3 Feb 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="PMaQtFAW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x0wFcjse"
X-Original-To: stable@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73420ADF8;
	Mon,  3 Feb 2025 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738613365; cv=none; b=RQUPDKaNOvTxgaPm0YMnPuaUdUP8lft1jiEMY2ujNNVNlLZ/IvrYCiSxGOe3ZCqkwBoVP/NYA8qjEQQFRDiwzOSjLlJ9fEUaN6K2Noy8/3YNHKSzHHI330fL3ySM+1F5AwF1WBkdMjii/oHXY+QH7x0iJcOK80eOOB7YMMTuJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738613365; c=relaxed/simple;
	bh=lmaID9/Fvvv+f7MT405cg+tBR28wbJJWtD8YtmMjc7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZoQUmog8CqovH3JnfwwVvndrjHT2rH2TM9l3ubDCHBJGifwJj51ygv5U+7rKWM/X2slC3s9PWvPnGTk/5UVgwg8fU/we/2dxSRkpcuB7KgrodMteYQF43OpwWO6j8qyn4CDLe6RefLrkAginuAwdtB/NrS+TjdkzLXyAhWjSdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=PMaQtFAW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x0wFcjse; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 3864713800F3;
	Mon,  3 Feb 2025 15:09:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 03 Feb 2025 15:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738613363; x=
	1738699763; bh=gdZjmY4mF8BniQw7ksJqZTxbvwf8Cbu7d2Zd5wNwyIk=; b=P
	MaQtFAWKwNju87h91YauYbDeVru3KayJT9D9intecqJ7RCKAb3vKXU/B+vesOdCj
	zsyZCmRZY5SmDEqwufUgyt2aD9PgEI7Z/6MpAOlBsIeNn+ZDDOSSmQaYEDoLqi84
	T0Gm4SOlHFc1v1b0hWcOAnD/xwqT9XmXKhqS1vseJZfys82fsyt/BIvpkAQlP7DY
	tHtDoRjth++UZqULKiIepqJ8eBXPMCpU3LCMx3PxNJtYn1Kp8vHnV7vOW8NjGIrQ
	0mOt2hCWqUloMSiqs2YsC0KgCvDUNCp4O1p/hrrpYT8w2/2bIEXT9n+CI5I+QCkd
	UMkIYm18U6G1CdxrRGFoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738613363; x=1738699763; bh=gdZjmY4mF8BniQw7ksJqZTxbvwf8Cbu7d2Z
	d5wNwyIk=; b=x0wFcjsexlZQrflKA/7uu/kEtEzD78r8fc5vDyqG5CWFbcoRUln
	u+eflI5oeV3SxkLVvlSxh17FzX1Ot90/rtyuF7dpEMRIBteD50b8KN088TDSKYZz
	rt9UF3OQhJ7+u5DCVjDVdV0yayashXHw8AraZOuecbI8AD9ZKicQCSB7uQLCIA87
	9AZp1BdzsOhJebTN4v4NVzEVn+xR/E1NMLFUy0xhZQtvti/Z0YcUCTXAKVUEcWe0
	dhOoL2hmOYf1Jo186yOYuyjAaiW/73t4GV1/r0fy3qXedoJbopLQlfDYsNBlmUMX
	1/J649R9eGBfOV7a718hlFE5oZGCmnz2JtA==
X-ME-Sender: <xms:ciKhZ9XzhbzENXEdN5FDp1zWX9OUZndqRbTS6mhWFpqqY4-wC8i1IQ>
    <xme:ciKhZ9lLbGQyj6GwhnzbqRRMouf4jdK9S3GUG4lVLD--VMzqHBp088ifVu4xy5uGY
    LJOOEOzqbtHUqUdfQo>
X-ME-Received: <xmr:ciKhZ5aZrR-6D-zx6ZclPpX9-KNalgR1-Stp_H5rVkJsifAERLx5cXInGrYMwhH3bqV_rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddv
    necuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllh
    esshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffh
    ffevlefhteefveevkeelveejudduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhho
    vhdrnhgrmhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepuggrvhgvrdhhrghnshgvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehv
    rghnnhgrphhurhhvvgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepgiekieeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehsvggrnhhjtgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghr
    uggvmhgrkhhtrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopegrtghkvghrlhgvhi
    htnhhgsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjgihgrghosehgohhoghhlvgdr
    tghomh
X-ME-Proxy: <xmx:ciKhZwWVEmRc2QziH0_hVt2TWvJ9R40htPOaWC3Ko_2Qgu3XNn4CkA>
    <xmx:ciKhZ3m1q0BuBgSRitiwFBwUkVMZIoOPEaJOj59VPjWh1rYuCd1O5w>
    <xmx:ciKhZ9eWmYjYBbz010Z6N0Q652Lx3XsZznakREDtbdZPTi9vPBMeyg>
    <xmx:ciKhZxH1uxkKW-eCHCBlbbYO6c_4CPO80yy_AlsFH2fIUgnjHWYk-w>
    <xmx:cyKhZ6p1eRi9uacVExNU2Q6un5HBDWkNDqF8Cbt2bBdLWaDpxp7Uijwb>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 15:09:17 -0500 (EST)
Date: Mon, 3 Feb 2025 22:09:13 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via
 tdx_safe_halt()
Message-ID: <qzl5vkhykj4anuvjrhfco5qoeuib3oskffnxnqbcszotttnnqa@up5b4xl5l55g>
References: <20250129232525.3519586-1-vannapurve@google.com>
 <p6sbwtdmvwcbr55a4fmiirabkvp3f542nawdgxoyq22cdhnu33@ffbmyh2zuj2z>
 <CAGtprH8pJ3Zj_umygzxp8=4sJTdwY5v2bFDhoBdX=-3KQaDnCw@mail.gmail.com>
 <wmdg54v56uizuifhaufllnjtecmvhllv35jyrvdilf4ty4pfs5@y4zppjm2sthr>
 <CAGtprH82OjizyORJ91d6f6VAn_E9LY7WptN-DsoxwLT4VwOccg@mail.gmail.com>
 <2wooixyr7ekw3ebi4oytuolk5wtyi2gqhsiveshfcfixlz3kuq@d5h6gniewqzk>
 <CAGtprH-n=cfH_BJAmiNMoRbqq0XdGCf3RE67TYW8z7RARnsCiQ@mail.gmail.com>
 <40418980-6e5b-48eb-bc35-7ffaf3221fd9@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40418980-6e5b-48eb-bc35-7ffaf3221fd9@intel.com>

On Mon, Feb 03, 2025 at 10:06:28AM -0800, Dave Hansen wrote:
> On 1/31/25 18:32, Vishal Annapurve wrote:
> ...
> > Are you hinting towards a model where TDX guest prohibits such call
> > sites from being configured? I am not sure if it's a sustainable model
> > if we just rely on the host not advertising these features as the
> > guest kernel can still add new paths that are not controlled by the
> > host that lead to *_safe_halt().
> 
> Let's say we required PARAVIRT_XXL for TDX guests and had TDX setup do:
> 
> static const typeof(pv_ops) tdx_irq_ops __initconst = {
>         .irq = {
> 		.safe_halt = tdx_safe_halt,
> 	},
> };
> 
> We could get rid of a _bit_ of what TDX is doing now, like:
> 
>         } else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
>                 pr_info("using TDX aware idle routine\n");
>                 static_call_update(x86_idle, tdx_safe_halt);
> 
> and it would also fix this issue. Right?
> 
> This commit:
> 
> 	bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> 
> Makes it seem totally possible:
> 
> >     Alternative choices like PV ops have been considered for adding
> >     safe_halt() support. But it was rejected because HLT paravirt calls
> >     only exist under PARAVIRT_XXL, and enabling it in TDX guest just for
> >     safe_halt() use case is not worth the cost.
> 
> and honestly it's seeming more "worth the cost" now since that partial
> approach has a bug and might have more bugs in the future.

If we want to go this path, I would rather move safe_halt out of
PARAVIRT_XXL. PARAVIRT_XXL is kitchen sink, no new code should touch it.

But Sean's proposal with HLT check before enabling interrupts looks better
to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

