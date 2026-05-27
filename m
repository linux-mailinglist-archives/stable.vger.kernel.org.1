Return-Path: <stable+bounces-254509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NmJJByqFmofoQcAu9opvQ
	(envelope-from <stable+bounces-254509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:23:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AA25E107E
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9A1D300BD50
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E341C3DB636;
	Wed, 27 May 2026 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vR3ffAAI"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C7D3DBD4E
	for <stable@vger.kernel.org>; Wed, 27 May 2026 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870230; cv=none; b=eRb5CiFLuNSKGC5A+ZDM5IutNmjJ387RB2qmSjiLGCJtMBRcAJFTs8GMMZuTuUeY+ebDm+TklsSy6f34QEqMjP/Nxe/QPfp50lBpczkxLUu0zZ668qPk1qlrmAxAHzzM11ZGEoouGxQ+ZIaLYpLx36xsE2qDck68jMyEGyfmm50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870230; c=relaxed/simple;
	bh=3hu/YKjn9OtDC0cI7qvIUKCxRZyA3eenzUS1dFC/GRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fofjLlxOnkzz1/DH3LNYOj9V1EZerIG8XhHJUSka+ys19B90kLUa2X0+qAAgloRfXBMUUb+0tUw2hPCozD4ezWlKhxClRqsE6Gwb1PfAgsBT/FWDr8eM2mwefjdWg7k9zMHTD0uL/0V5CqFUiMiLXHJidZ/bUqJyMat1hhIhqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vR3ffAAI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CDF12880;
	Wed, 27 May 2026 01:23:36 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C7213F7D8;
	Wed, 27 May 2026 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779870221; bh=3hu/YKjn9OtDC0cI7qvIUKCxRZyA3eenzUS1dFC/GRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vR3ffAAIofGswU0aEO1HQv8A28uYu+aJT6U0d2GpJ+/xPQYHHPWyhNF31EC3qag1P
	 riOb7MLnlcaxqzsjeWfosTnSb7YT0JIBcmglfcugHYJaB95DQ7CXq1VXuMs5mRmDoQ
	 8IKF2XJBtC479anGlIeXq28E4qe4yhtvoQmwgT00=
Date: Wed, 27 May 2026 09:23:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Xiangyu Chen <xiangyu.chen@windriver.com>
Cc: will@kernel.org, stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 6.12 1/1] arm64: io: correct user memory type in
 ioremap_prot()
Message-ID: <ahaqCb1gGdUjyCN_@arm.com>
References: <20260520091337.3799553-1-xiangyu.chen@windriver.com>
 <20260520091337.3799553-2-xiangyu.chen@windriver.com>
 <ag3o-RbDTQWWazwF@arm.com>
 <3f1485f0-905b-4c5a-bd66-fb03aa9ea0cb@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f1485f0-905b-4c5a-bd66-fb03aa9ea0cb@windriver.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254509-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm.com:mid,arm.com:dkim]
X-Rspamd-Queue-Id: 93AA25E107E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 11:01:04AM +0800, Xiangyu Chen wrote:
> On 5/21/26 01:01, Catalin Marinas wrote:
> > On Wed, May 20, 2026 at 05:13:37PM +0800, Xiangyu Chen wrote:
> > > generic_access_phys() passes a 'pgprot_t' value determined from the
> > > user mapping of the target 'pfn' being accessed by the kernel.
> > > On arm64, this 'pgprot_t' contains all non-address bits from the pte,
> > > including user permission controls (PTE_USER).
> > > 
> > > When a process attempts to read the target memory via cross-process
> > > subsystems (such as reading /proc/<pid>/mem or via ptrace), the kernel
> > > re-maps this memory using ioremap_prot(). Since the PTE_USER bit is
> > > incorrectly preserved in the temporary kernel-space mapping, it triggers
> > > a level 3 permission fault on systems with PAN (Privileged Access Never)
> > > enabled, resulting in an immediate kernel panic.
> > > 
> > > Upstream already fixed this issue in
> > > commit: 8f098037139b ("arm64: io: Extract user memory type in ioremap_prot()")
> > > 
> > > Directly porting the upstream patch's macro changes inside <asm/io.h>
> > > creates circular build dependencies due to the architecture-specific
> > > GENERIC_IOREMAP refactoring introduced in the stable kernel lifecycle.
> > > 
> > > To bypass header dependency traps safely, this backport confines the fix
> > > entirely inside the implementation layer of arch/arm64/mm/ioremap.c:
> > > 1. It uses pgprot_val() to safely unpack page properties into a pteval_t mask.
> > > 2. It introduces a targeted safety check (if (prot_val & PTE_USER)) to
> > >     selectively strip away volatile user permission parameters.
> > > 3. It maps the memory through pure kernel attributes, leaving standard
> > >     peripheral device drivers completely unaffected.
> > > 
> > > Tested-by: QEMU ARM64 (Cortex-A55, CONFIG_ARM64_PAN=y, /proc/<pid>/mem read)
> > > Fixes: 893dea9ccd08 ("arm64: Add HAVE_IOREMAP_PROT support")
> > > Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> >
> > Instead of re-implementing this, could we cherry-pick the prior commit
> > renaming ioremap_prot() to __ioremap_prot() throughout arm64? It's not a
> > straightforward cherry-pick since we changed the prot arg from unsigned
> > long to pgprot_t (across multiple architectures), but with some minor
> > tweaks we can get the patch below. After this, 8f098037139b should apply
> > (hopefully unmodified). Please give it a try:
> 
> Thanks for your suggestion.
> 
> After reviewing the code, it appears we cannot directly backport commit
> f6bf47ab32e0 ("arm64: io: Rename ioremap_prot() to __ioremap_prot()") to
> older stable kernels. This is because commit f6bf47ab32e0 depends on commit
> 86758b504864 ("mm/ioremap: pass pgprot_t to ioremap_prot() instead of
> unsigned long").

My proposed backport of f6bf47ab32e0 took care of using unsigned long
instead of pgprot_t since the dependencies get too complicated. Could
you try my backport of f6bf47ab32e0 together with cherry-picking
8f098037139b. The latter may need some adjustment of pgprot_t as well
but at least the final form will look fairly similar to upstream.

-- 
Catalin

