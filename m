Return-Path: <stable+bounces-111732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4173CA23408
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 19:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CA01661E2
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF231BEF84;
	Thu, 30 Jan 2025 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="gI306yXd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DOuFYXW8"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F8143888;
	Thu, 30 Jan 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262895; cv=none; b=djzJybXwjNpqCd5zt+gyM92TpTKn9swZp1AR5QWwGELe1rov3ieE8bnEPXVbpi7htHT9GOJiihxNQmMGyF16RPc2IUol0BH93xhnfc3rrjcoZUb5q4wxUK+TJw/rciPEzqU1br9W8J4yh/rq9lVGSQ2pOAXQaf8+n23fMVOUqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262895; c=relaxed/simple;
	bh=tUWI336ClpVEiFRGPmJcZoA6T/3Im4XIUkl2jynGFKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBh30DgY3U9fo9XsWAlauFzi76B53sQ3C6R7OpuDV2iCpp2bbfairk47t3S9j5jB4oTQ84OYInTeQ/1hVucPZRJxQmLxevIKiSExNGWkUTi8vutjxubuEBINf54B6eoEFVxan9FDD5SgXM6RwkI7fU5jk6ifJ2d8+BN7yECTCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=gI306yXd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DOuFYXW8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BAF021380140;
	Thu, 30 Jan 2025 13:48:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jan 2025 13:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1738262891; x=1738349291; bh=raqyYngkkJXYRmg42JKQOnEvjolJ9Dxu
	iQG90yq2mFs=; b=gI306yXdN+ojtGUERMZQVClyi9asqZ7YWtTphMlVxEZwNVH/
	F8XzULPkKkXvAijTEobrvSL29o45iX4q44nHCGqzPd8q4vhwkav9HvJrnhIm7HIp
	G40A1S/i6OK0NYnLZ4gvLd5wjvP0k+uhdwa/jEmipn8nZ3qFNzxPMACPdqWOO6YU
	mpu8DU9R7gQgmT3Taj7raAiAxym4joLS9xR8T4XX+stgjeYDiz5gQgUwj79J0tSG
	rBrNCtgHGoL7vd7WPKvzAfuqdOhNQHc3FjR4KptyiN8Lg0/fxJTelmJr8EyfMim9
	PODwKTtuI2cVpdn1SHG4k3Cp1xtDvmZcbHpL4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738262891; x=
	1738349291; bh=raqyYngkkJXYRmg42JKQOnEvjolJ9DxuiQG90yq2mFs=; b=D
	OuFYXW8vffhlh6q9Pyq0ZyPq3c5YrrSExfRJNORef5VKqBNcHkW9eijRZS+1hpxV
	yUuMqC8cRO/GI9bEEihPMpML6OFsGB6Oucr3IEbr5SGlWpsU3yFWCcpB6UDtpvdT
	qwiyo+eW712LbB1m+cGOvngSqdCnsRtLLgMf3BlutItitCr1dvvD7gaa0jES4L4t
	rxgmG/hu8dXq4J6a+QljlNnTahyE7vW8DUXTetc5mgOzxDTAPKW8xDswK/+l86Yc
	TE0M9+Dw7iTd4UipRBsFAp+NQKA8aJlumj8kIL/kc47J3fh0aLFqvSyNymIYZo/V
	hRAGuXQefcsYHNcstdPmg==
X-ME-Sender: <xms:a8mbZ9lEUHgb6Fy4KA9xdVjGqh7Ll5sMjtDWuzfDZDXqyFag_hdX1g>
    <xme:a8mbZ41iCkaXsgy8d21He-MyVBZx1sFgJzzUwuex71R9Khig2u3nkqMSxzvqtes-T
    nwQfIzxpV2D1rKsU44>
X-ME-Received: <xmr:a8mbZzr8Uj4D5on0_yoU1Ph9QPFiJFVJhVIwglqPlzJdfv1mtdw6M2zd49SUYhJPRD7bww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiheekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:a8mbZ9nsTC6HAYS2YuAnKMpK3sxm3r6AhiFJFB856OoKGLpPhIfZtA>
    <xmx:a8mbZ72S25XKK1a52zVKFPwxTX-c1E-8dkl1NldV597Q3J9ducv_Qg>
    <xmx:a8mbZ8vkdcGcifYegJYSQibA2h9EcjmcKfaIBOtYYXCt6RRWpi2BpA>
    <xmx:a8mbZ_VdgrKO77dgOXOevT4_T1CsEV9uzZW5kRppM_GDMgJX6oprDQ>
    <xmx:a8mbZ8G3gEZQplbk-N2kTku55px82-L83iWZgUbUg88Z4MPoFJXv_G6E>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 13:48:06 -0500 (EST)
Date: Thu, 30 Jan 2025 20:48:02 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via
 tdx_safe_halt()
Message-ID: <wmdg54v56uizuifhaufllnjtecmvhllv35jyrvdilf4ty4pfs5@y4zppjm2sthr>
References: <20250129232525.3519586-1-vannapurve@google.com>
 <p6sbwtdmvwcbr55a4fmiirabkvp3f542nawdgxoyq22cdhnu33@ffbmyh2zuj2z>
 <CAGtprH8pJ3Zj_umygzxp8=4sJTdwY5v2bFDhoBdX=-3KQaDnCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH8pJ3Zj_umygzxp8=4sJTdwY5v2bFDhoBdX=-3KQaDnCw@mail.gmail.com>

On Thu, Jan 30, 2025 at 09:24:37AM -0800, Vishal Annapurve wrote:
> On Thu, Jan 30, 2025 at 1:28 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Wed, Jan 29, 2025 at 11:25:25PM +0000, Vishal Annapurve wrote:
> > > Direct HLT instruction execution causes #VEs for TDX VMs which is routed
> > > to hypervisor via tdvmcall. This process renders HLT instruction
> > > execution inatomic, so any preceding instructions like STI/MOV SS will
> > > end up enabling interrupts before the HLT instruction is routed to the
> > > hypervisor. This creates scenarios where interrupts could land during
> > > HLT instruction emulation without aborting halt operation leading to
> > > idefinite halt wait times.
> > >
> > > Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests") already
> > > upgraded x86_idle() to invoke tdvmcall to avoid such scenarios, but
> > > it didn't cover pv_native_safe_halt() which can be invoked using
> > > raw_safe_halt() from call sites like acpi_safe_halt().
> > >
> > > raw_safe_halt() also returns with interrupts enabled so upgrade
> > > tdx_safe_halt() to enable interrupts by default and ensure that paravirt
> > > safe_halt() executions invoke tdx_safe_halt(). Earlier x86_idle() is now
> > > handled via tdx_idle() which simply invokes tdvmcall while preserving
> > > irq state.
> > >
> > > To avoid future call sites which cause HLT instruction emulation with
> > > irqs enabled, add a warn and fail the HLT instruction emulation.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > > ---
> > > Changes since V1:
> > > 1) Addressed comments from Dave H
> > >    - Comment regarding adding a check for TDX VMs in halt path is not
> > >      resolved in v2, would like feedback around better place to do so,
> > >      maybe in pv_native_safe_halt (?).
> > > 2) Added a new version of tdx_safe_halt() that will enable interrupts.
> > > 3) Previous tdx_safe_halt() implementation is moved to newly introduced
> > > tdx_idle().
> > >
> > > V1: https://lore.kernel.org/lkml/Z5l6L3Hen9_Y3SGC@google.com/T/
> > >
> > >  arch/x86/coco/tdx/tdx.c    | 23 ++++++++++++++++++++++-
> > >  arch/x86/include/asm/tdx.h |  2 +-
> > >  arch/x86/kernel/process.c  |  2 +-
> > >  3 files changed, 24 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > > index 0d9b090b4880..cc2a637dca15 100644
> > > --- a/arch/x86/coco/tdx/tdx.c
> > > +++ b/arch/x86/coco/tdx/tdx.c
> > > @@ -14,6 +14,7 @@
> > >  #include <asm/ia32.h>
> > >  #include <asm/insn.h>
> > >  #include <asm/insn-eval.h>
> > > +#include <asm/paravirt_types.h>
> > >  #include <asm/pgtable.h>
> > >  #include <asm/set_memory.h>
> > >  #include <asm/traps.h>
> > > @@ -380,13 +381,18 @@ static int handle_halt(struct ve_info *ve)
> > >  {
> > >       const bool irq_disabled = irqs_disabled();
> > >
> > > +     if (!irq_disabled) {
> > > +             WARN_ONCE(1, "HLT instruction emulation unsafe with irqs enabled\n");
> > > +             return -EIO;
> > > +     }
> > > +
> >
> > I think it is worth to putting this into a separate patch and not
> > backport. The rest of the patch is bugfix and this doesn't belong.
> >
> > Otherwise, looks good to me:
> >
> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>@linux.intel.com>
> >
> > --
> >   Kiryl Shutsemau / Kirill A. Shutemov
> 
> Thanks Kirill for the review.
> 
> Thinking more about this fix, now I am wondering why the efforts [1]
> to move halt/safe_halt under CONFIG_PARAVIRT were abandoned. Currently
> proposed fix is incomplete as it would not handle scenarios where
> CONFIG_PARAVIRT_XXL is disabled. I am tilting towards reviving [1] and
> requiring CONFIG_PARAVIRT for TDX VMs. WDYT?
> 
> [1] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanarayanan.kuppuswamy@linux.intel.com/

Many people dislike paravirt callbacks. We tried to avoid relying on them
for core TDX enabling.

Can you explain the issue you see with CONFIG_PARAVIRT_XXL being disabled?
I don't think I follow.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

