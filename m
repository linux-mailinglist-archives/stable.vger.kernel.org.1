Return-Path: <stable+bounces-119661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91EA45DC3
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E09162DDC
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA2217655;
	Wed, 26 Feb 2025 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Y+3lYlte";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="34ZhmKcj"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D89216E19;
	Wed, 26 Feb 2025 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570588; cv=none; b=DQ4KezbwnYoDOpYEWRlcK7N9Uk3YfJYM3dYpMtAtwN4Er8CHcZIHaWfSs7T41UrrT3XDYRMeiE2agX/PBpqg/O12Nk7ETmf9kkygC8de9bk0X4+yGEuAt2d6BJCMTSLK/NPuTp/eVfTTLB6oFi56u2gTH1WSQqWQPr1MQTeMDzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570588; c=relaxed/simple;
	bh=VpmMUY7wY/BS7Pk+f5B3auP2ZypMNupjv4juq8FsjbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6xPQqH4BENk0jkBp2aS6mP5oUd8DfFCpak9yT7DPmyyiQgJH6SLhUMUKPmpJkM0puS/YWvndMdR5oCljm3OggHgMQEsO9iJ4BusZTZe9E0c70VA5Oj3ElHq9SpU6z8WKer7cPh406BGq1eNWiPRcjIKpy+vnWR7CCk8G61r6QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Y+3lYlte; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=34ZhmKcj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A77011401BD;
	Wed, 26 Feb 2025 06:49:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 26 Feb 2025 06:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1740570585; x=
	1740656985; bh=NUV6XQ7b1xL3JnX+3WnfxkiyKE8c72Tyb0qS0broJwE=; b=Y
	+3lYlte5EmJcJWEt2f+7MS4Os164ocN+bPsGNY/MYlMGWulxvxPfJdtvl2fDv9ik
	bTXyQScCciCHsr1LCCauwhbpedXl5l03/ApwRcwr/HP6sphRpH2K25aPLn0Qyqzy
	VHaGthhvGNNbq84N/Sgo92KE45v7ywb1MFpm2n6CMvNmo0bLxVbQ9kAM7MpqRyj1
	9HpUYZLFqQDqeQTcFuKPcHIxNUWxEq0GN/c2yxkP6aVVaKVz6fwr7f7gWOvAtcim
	U+6MkxWj1bAxCgRaEh04GJfBOIx2P3Q1h5rEfFBHTATBapXynS8DeZMlC151RjhU
	P7/QqIHw5MW9dO/+6R5Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740570585; x=1740656985; bh=NUV6XQ7b1xL3JnX+3WnfxkiyKE8c72Tyb0q
	S0broJwE=; b=34ZhmKcjT4ByBDZWw2nHG1CfFp0CXR9QQuD2S5LS7RiK1aRryuk
	U9nq1PdX8Ng6nAo4KydzMu4ExzgBvxfxV+6uu6N4R5jbpSc9Awe7/X/9MT7bn+G0
	inT4pSBexS4Dtnj/nvWpdx69Tv29q93HvCx8scG0MH9L1m7oA6sL9jlcmlKW/fYE
	bvjcQW9QrsQhD2crdRf1+uzjFdlwArmRBPWJFLU82CJKHWii3WOGP+t2WdW1cR3g
	/4/uf80M4/9+rwc+XQRljMCINZAHIidlqP/rXr/jWHb2pEHYOVACOjDG1h4cmQgr
	r3MO3u+lSJfRghYCESD7zHbrzwT91VJ1FKw==
X-ME-Sender: <xms:2P--Z0xjIADr4gf4kqZzE6XbVlHMc9jNVZdNJA85a7RR6x3I6qzHYg>
    <xme:2P--Z4SrBuFVusf8FOAmIWtrw9nGZmL4KRzW-cPAzeVzAohRQu5-Izo0J3QFqxjLs
    9Ls09odPimvYmbv5oY>
X-ME-Received: <xmr:2P--Z2X3_1pSDndN3W4CcUAt6CG4kHsSzNyVcHPeaNNpTblmw2lW3vE5HQ1-ZlMm39uZrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddv
    necuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllh
    esshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffh
    ffevlefhteefveevkeelveejudduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhho
    vhdrnhgrmhgvpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepvhgrnhhnrghpuhhrvhgvsehgohhoghhlvgdrtghomhdprhgtphhtthhopegu
    rghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepkh
    hirhhilhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphht
    thhopehjghhrohhsshesshhushgvrdgtohhmpdhrtghpthhtoheprghjrgihrdhkrghhvg
    hrsegsrhhorggutghomhdrtghomhdprhgtphhtthhopegrkheslhhinhhugidrihhnthgv
    lhdrtghomhdprhgtphhtthhopehtohhnhidrlhhutghksehinhhtvghlrdgtohhmpdhrtg
    hpthhtohepthhhohhmrghsrdhlvghnuggrtghkhiesrghmugdrtghomhdprhgtphhtthho
    pehtghhlgieslhhinhhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:2P--ZyiAQKOFRnxyOzpeqCouZL8yXR5O0Z1uAGDl2AzgePchztVPLA>
    <xmx:2P--Z2BFvoasHzlVzsB6ZwmpavJNmNunVnf_ozZVmCxuQcwxCQ7a7g>
    <xmx:2P--ZzJmvgbpt5_9r6nXFhFSK3m76UBuDJRveiN9f9YKuSIEO60fsg>
    <xmx:2P--Z9AAmPPQje4t-8vfSh04lk6sCU__6b4u3BnCegBa-MQ6XPC8TQ>
    <xmx:2f--Z-a27CiKqq2ElAYuuRFNsyxas3XqkH1PFWDhpzTloP3iA4ZefGzk>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 06:49:34 -0500 (EST)
Date: Wed, 26 Feb 2025 13:49:31 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Vishal Annapurve <vannapurve@google.com>
Cc: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, tony.luck@intel.com, 
	thomas.lendacky@amd.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, pbonzini@redhat.com, seanjc@google.com, kai.huang@intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, afranji@google.com, kees@kernel.org, jikos@kernel.org, 
	peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	bcm-kernel-feedback-list@broadcom.com, stable@vger.kernel.org
Subject: Re: [PATCH v6 2/3] x86/tdx: Fix arch_safe_halt() execution for TDX
 VMs
Message-ID: <pvbwlmkknw7cwln4onmi5mujpykyaxisb73khlriq7pzqhgno2@nvu3cbchp4am>
References: <20250225004704.603652-1-vannapurve@google.com>
 <20250225004704.603652-3-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225004704.603652-3-vannapurve@google.com>

On Tue, Feb 25, 2025 at 12:47:03AM +0000, Vishal Annapurve wrote:
> Direct HLT instruction execution causes #VEs for TDX VMs which is routed
> to hypervisor via TDCALL. If HLT is executed in STI-shadow, resulting #VE
> handler will enable interrupts before TDCALL is routed to hypervisor
> leading to missed wakeup events.
> 
> Current TDX spec doesn't expose interruptibility state information to
> allow #VE handler to selectively enable interrupts. To bypass this
> issue, TDX VMs need to replace "sti;hlt" execution with direct TDCALL
> followed by explicit interrupt flag update.
> 
> Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> prevented the idle routines from executing HLT instruction in STI-shadow.
> But it missed the paravirt routine which can be reached like this as an
> example:
>         acpi_safe_halt() =>
>         raw_safe_halt()  =>
>         arch_safe_halt() =>
>         irq.safe_halt()  =>
>         pv_native_safe_halt()

I would rather use paravirt spinlock example. It is less controversial.
I still see no point in ACPI cpuidle be a thing in TDX guests.

> 
> To reliably handle arch_safe_halt() for TDX VMs, introduce explicit
> dependency on CONFIG_PARAVIRT and override paravirt halt()/safe_halt()
> routines with TDX-safe versions that execute direct TDCALL and needed
> interrupt flag updates. Executing direct TDCALL brings in additional
> benefit of avoiding HLT related #VEs altogether.
> 
> Cc: stable@vger.kernel.org
> Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

