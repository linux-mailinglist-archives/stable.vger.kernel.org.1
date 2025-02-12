Return-Path: <stable+bounces-115049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFAAA32651
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 13:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FE13A6350
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECD820CCED;
	Wed, 12 Feb 2025 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="UFpZapta";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NkdljSwn"
X-Original-To: stable@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A98271824;
	Wed, 12 Feb 2025 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364871; cv=none; b=fuxAWhMlNA+79ReFLliHJcuYXRKN5GFq4O/U77LXy5wRle0IIJMlnCqxxrOGAIZ84A1u+QfdHBdW69SFOkLvVZybwnH2oQWl9pKc9a6NjHfX4Ggsv+86behb1CFO5JFmIRaDa7rKVBjgHWbRlibz+1T/nQ5NFTPrtcafRjpwjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364871; c=relaxed/simple;
	bh=dUzLri7HLBnLUNXHtV56R2oFbTGzCCUoFmmjbezeFMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMQiumxD1mheP4k37IGqq/rFT4b6gzkYHM8bysOFaHdzC0Ng06OJkaeV+yUBnmc21Xf+WQRJG2KAoiFh5xiyU3Cn0X5ucGHsb1VTUmygPb0ya091/8NGwDKIKJuFLO4v3lWOnc3BZWR39VzdS30cjrvp4OV2AhgYkEoQPq1LySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=UFpZapta; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NkdljSwn; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 467641380830;
	Wed, 12 Feb 2025 07:54:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 12 Feb 2025 07:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1739364867; x=
	1739451267; bh=B8CxILEVEpjQ5H2ChvReMTw8ajG4/Nhh8qC+Fiy/HAc=; b=U
	FpZaptaQZTevoe0cySA3pPZRz7aLIwl0WmrLjfHqB5tQKE4T1hXWY1nfrPGtXVZd
	nM5lLH9iiI11DEabnPWSkd5Vs9oa6zUx2CnOyRXkGwqWHZznsEgGnLlqI7V3eQK/
	92eGQ5bolSmIVQ5OOSHkDhKnBQCQ/JYrBZ4eU9zxW/mRgdPCZB9a1aQhzP7lC/CF
	1J8Y3qi2C4TpX12jOgMcISUeStbUwGVkwC/dLpabhdrBkwf3gGe6oNzQuXGXUMz9
	ZavnZXt36Z7JT5aiokfllnBR42ou1+B9ioqH9gKPEVGrFxfa7w1i/SDGN4oFgvPG
	I0dNq7tYlMzkKpiugcA6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739364867; x=1739451267; bh=B8CxILEVEpjQ5H2ChvReMTw8ajG4/Nhh8qC
	+Fiy/HAc=; b=NkdljSwnPaOcgW0ruMTJgTYj+egMstPs93iS9lb/cdE0Zf++1zC
	Q+2n1uxqsnfWOuSB41UoLA9cpjKHlEQ+NRU+10neTM1BL+MPlynKh4vQFdCAaMmY
	aE8UGymw7SLeSOYBkYdO2E9Uf/PsFx+hSiS0ah9lcW2Uv6pZZkke2x0TZyNJ5Rn+
	wYvRB2KT2FAC4+o6AY7kuJxQI4XBmhdv8sKLUX98W1jUkL/EcEeCYAUlHMl/zvKl
	Wh9s2WjmjviEOujM17XdT+BAukcYMPnAYI8+tA04oqi9Fd3G/RW4cWjETkNQ+Q1l
	EXQwDS1pNfG/DVi8YT6zisA6egalr6mPa1w==
X-ME-Sender: <xms:A5qsZwFfftWnxLKO6VEGGYykTExInmqUGCVHfIm60tKHBomTukzBiQ>
    <xme:A5qsZ5V1Cysan1OEF7T3q8C0u--XYOveiBFa9runYPz5BvJ2Htzjc3mJgMqRIsqq2
    i6WOwIOup1XZzhpT9Q>
X-ME-Received: <xmr:A5qsZ6JGQTKbTQppU40zBoPJBB60aFrO9Ht9NjM3pmtmEV_7A2P9bhECg0f-lTaizoXXmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddv
    necuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllh
    esshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffh
    ffevlefhteefveevkeelveejudduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhho
    vhdrnhgrmhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepvhgrnhhnrghpuhhrvhgvsehgohhoghhlvgdrtghomhdprhgtphhtthhopeig
    keeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpsghonhiiihhnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepshgvrghnjhgtsehgohhoghhlvgdrtghomhdprhgtph
    htthhopegvrhguvghmrghkthgrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprggt
    khgvrhhlvgihthhnghesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhigghgrohesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepshgrghhishesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:A5qsZyELfOkik5Aw0VjABfX6_-CkUI8hrvVUaWqAyH0abqxsoBUVqg>
    <xmx:A5qsZ2UngPg7AvIvi-g81a65Nlso9hxbl5MDri9HYTV_rk8wgxKGOA>
    <xmx:A5qsZ1Mg-FmwM8dJGVhQ9avw3ohaazEB9jZul-D0tirmGmPdLHKTpg>
    <xmx:A5qsZ93m0XRzGOMaqXzjhdDAiyogMy9f1YhtwXpRA_DM3bmvILZcyA>
    <xmx:A5qsZ0ayS2upXBHUmye1FPk7dK90iimRTe2aHt76QKeRyBesncV9rvoA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 07:54:21 -0500 (EST)
Date: Wed, 12 Feb 2025 14:54:17 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH V4 2/4] x86/tdx: Route safe halt execution via
 tdx_safe_halt()
Message-ID: <ljdzupgyl2am4qgvirwpdonwuzwjaysemu43icrzxjt5olr3yx@dldbi5tqwhjh>
References: <20250212000747.3403836-1-vannapurve@google.com>
 <20250212000747.3403836-3-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212000747.3403836-3-vannapurve@google.com>

On Wed, Feb 12, 2025 at 12:07:45AM +0000, Vishal Annapurve wrote:
> Direct HLT instruction execution causes #VEs for TDX VMs which is routed
> to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
> so IRQs need to remain disabled until the TDCALL to ensure that pending
> IRQs are correctly treated as wake events. So "sti;hlt" sequence needs to
> be replaced with "TDCALL; raw_local_irq_enable()" for TDX VMs.

The last sentence is somewhat confusing.

Maybe drop it and add explanation that #VE handler doesn't have info about
STI shadow, enables interrupts before TDCALL which can lead to missed
wakeup events.

> @@ -409,6 +410,12 @@ void __cpuidle tdx_safe_halt(void)
>  		WARN_ONCE(1, "HLT instruction emulation failed\n");
>  }
>  
> +static void __cpuidle tdx_safe_halt(void)
> +{
> +	tdx_halt();
> +	raw_local_irq_enable();

What is justification for raw_? Why local_irq_enable() is not enough?

To very least, it has to be explained.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

