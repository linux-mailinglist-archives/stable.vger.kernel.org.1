Return-Path: <stable+bounces-111264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE78A22A50
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 10:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B4E188584B
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 09:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473531B425F;
	Thu, 30 Jan 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="c4I4Q9fg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cg4zjQBj"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA7B1AB53A;
	Thu, 30 Jan 2025 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738229290; cv=none; b=fkrNIbYZZaB/x9pvRvfFNVotGfOHzDXmVZMdg3hBOT1GAgRwyglLhUIbLobmHcePZYO3UOdCdpx6R3AMzPUVX/8Ep/VTTxcRlg+uy4OCfw/sYNkR/Nc3o5+716DLve4fivDedod9RkqkciG5PwEFK5i5mKEU9v+OTW1UhtEUHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738229290; c=relaxed/simple;
	bh=6QEEVxeXCV/Eryqb4+2vYLsdLa+714Q+GrQSfN0elNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRUr1nfvzxa49pEi1H1eozzgShCNQb+4Bq5YTqhEGctwuRP2Xzq8/Imela06DcHS5yCQipR1uCPWTQgiLDuHalyuIcPTcIDQ4D19Znz6p6/JzFR6crPtoMGqO4Z6lPmRSbTWwtVyGBfoklhFFfOYl0OwfosSMRNfYETPWw4f7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=c4I4Q9fg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cg4zjQBj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A35B72540115;
	Thu, 30 Jan 2025 04:28:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 30 Jan 2025 04:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738229285; x=
	1738315685; bh=t3O8u0KUNKcJVT+PdNptZvz5j4ncE2iGZc2jtKHEpZA=; b=c
	4I4Q9fgmE9PKfoX+evVrmj/SMTQjIa0xDK/Dt4eW/gefmrOirVBpzaswWpwJudWq
	HmlyaV+6d26O9ugiRXB23gZRIP/cBZYxEvkJeFMN1Vy+i+ONivAQjKemHk8Z7PVJ
	2bKJCZXuCm68SfiZkU87gt+zBUiVL+jmGKAWmCrZBu8QoFAyb+tJjbrBuvmtfXps
	T6yGO0dIZ5POEEUkVuBC7e7lWJ+yZslUu2j3VAYBTbJX9GPCoRJmRYN1G9iP/aas
	aeDzWvMq+4KUbvCA351BTi5xyvbSYdoUkP4I7m2uzncPGyRfl7/XVf7tcrHkTSGq
	nJz7SxlDyL7HWj58zGHnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738229285; x=1738315685; bh=t3O8u0KUNKcJVT+PdNptZvz5j4ncE2iGZc2
	jtKHEpZA=; b=cg4zjQBjrjLB6KNZKNo80Wh+HchynueFbqaBIr+CYP2vyZgB6BR
	bhsKXyHHjdWR1KNlbG0kszwEl66Z4w5h+XLW1/saKsJciGM9V/zeAHpOBfo51ZG+
	NnjSOkOlGPFNEOmFiyjI3Z9DyAIUYWpOZF/sYuWzX3dIJHU7tvRiIo5ryh2sVmUX
	+oPaDgu3yJOGjQ1GO60b9lodMEfPMCzl9N8Ko4maVnC/dVBs0mMgeJ5BdhojuWuU
	TkykP9qQAViOzbP7IiyKhFYZFZI5g7taNRNaJ9V8WoSkTj3Juji0lWiuHrv1eBkM
	4uKdq0K9S5jUe76aEE/A8Hbi5FYJoyv2xAQ==
X-ME-Sender: <xms:JUabZ7waI2wxTDSPmwYRBaPSiT8e3YCzVmQpFa71ZcgYljSy4EniOQ>
    <xme:JUabZzRmPYq9hclZHzr4147DsLIR02AMYM0awGBWUGan9kl4f9eQK3e4yu9fCTw4B
    _3TvGS-2hVcZQc2Blg>
X-ME-Received: <xmr:JUabZ1WUR03_1zi0b_ZSuQiJAbcnAj6QpNs6w4dtRVGzxRVRXq9RjGpy8wts8mpyBg6wqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehgeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeltedugedtgfehuddu
    hfetleeiuedvtdehieejjedufeejfeegteetuddtgefgudenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhope
    duiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhgrnhhnrghpuhhrvhgvsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshgvrg
    hnjhgtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvrhguvghmrghkthgrshesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheprggtkhgvrhhlvgihthhnghesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepjhigghgrohesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    shgrghhishesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:JUabZ1jy_e-IpxT5ZSFHKe9Bzu0Wt_Lg0hBLoEjWCdiltsATEx-_Aw>
    <xmx:JUabZ9ADP0yPihoeZby56FGMKuJGEjPwpaur_dt3Dr9QggsybmVB9Q>
    <xmx:JUabZ-Ib6HiCGN62p--HuxIq4y986zMLxAVrZDDQ3Dc9q3XLHJq4kg>
    <xmx:JUabZ8B81ibLoEibSBLpIu3AFhijdAWoVaLyXz_KA9zgX8RVDSRCsw>
    <xmx:JUabZ_wsvb8L6c7pN6I7c9hH0SPP9A7BbUhKPR1g40OOjcMxMQsipjif>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 04:28:00 -0500 (EST)
Date: Thu, 30 Jan 2025 11:27:56 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via
 tdx_safe_halt()
Message-ID: <p6sbwtdmvwcbr55a4fmiirabkvp3f542nawdgxoyq22cdhnu33@ffbmyh2zuj2z>
References: <20250129232525.3519586-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129232525.3519586-1-vannapurve@google.com>

On Wed, Jan 29, 2025 at 11:25:25PM +0000, Vishal Annapurve wrote:
> Direct HLT instruction execution causes #VEs for TDX VMs which is routed
> to hypervisor via tdvmcall. This process renders HLT instruction
> execution inatomic, so any preceding instructions like STI/MOV SS will
> end up enabling interrupts before the HLT instruction is routed to the
> hypervisor. This creates scenarios where interrupts could land during
> HLT instruction emulation without aborting halt operation leading to
> idefinite halt wait times.
> 
> Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests") already
> upgraded x86_idle() to invoke tdvmcall to avoid such scenarios, but
> it didn't cover pv_native_safe_halt() which can be invoked using
> raw_safe_halt() from call sites like acpi_safe_halt().
> 
> raw_safe_halt() also returns with interrupts enabled so upgrade
> tdx_safe_halt() to enable interrupts by default and ensure that paravirt
> safe_halt() executions invoke tdx_safe_halt(). Earlier x86_idle() is now
> handled via tdx_idle() which simply invokes tdvmcall while preserving
> irq state.
> 
> To avoid future call sites which cause HLT instruction emulation with
> irqs enabled, add a warn and fail the HLT instruction emulation.
> 
> Cc: stable@vger.kernel.org
> Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
> Changes since V1:
> 1) Addressed comments from Dave H
>    - Comment regarding adding a check for TDX VMs in halt path is not
>      resolved in v2, would like feedback around better place to do so,
>      maybe in pv_native_safe_halt (?).
> 2) Added a new version of tdx_safe_halt() that will enable interrupts.
> 3) Previous tdx_safe_halt() implementation is moved to newly introduced
> tdx_idle().
> 
> V1: https://lore.kernel.org/lkml/Z5l6L3Hen9_Y3SGC@google.com/T/
> 
>  arch/x86/coco/tdx/tdx.c    | 23 ++++++++++++++++++++++-
>  arch/x86/include/asm/tdx.h |  2 +-
>  arch/x86/kernel/process.c  |  2 +-
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 0d9b090b4880..cc2a637dca15 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -14,6 +14,7 @@
>  #include <asm/ia32.h>
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
> +#include <asm/paravirt_types.h>
>  #include <asm/pgtable.h>
>  #include <asm/set_memory.h>
>  #include <asm/traps.h>
> @@ -380,13 +381,18 @@ static int handle_halt(struct ve_info *ve)
>  {
>  	const bool irq_disabled = irqs_disabled();
>  
> +	if (!irq_disabled) {
> +		WARN_ONCE(1, "HLT instruction emulation unsafe with irqs enabled\n");
> +		return -EIO;
> +	}
> +

I think it is worth to putting this into a separate patch and not
backport. The rest of the patch is bugfix and this doesn't belong.

Otherwise, looks good to me:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

