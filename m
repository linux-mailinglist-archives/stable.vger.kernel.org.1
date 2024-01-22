Return-Path: <stable+bounces-12358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E58361A8
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 12:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594A11F24B9C
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF753B785;
	Mon, 22 Jan 2024 11:16:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A33A8C6
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922180; cv=none; b=cCC3FzNc50KYJ4Ag+weql00ll0daK/zwFgvkIavLW26IaJq5R+CD7MDhKSuZzEgVyDTvfj44dCWag6nlVoVN9g0aJrnhGDnt2byFvseFNrXImn6bAeuIT+iXfrnwqWIBUXdQrOFDr1V3bfr40ZGqN1O6gzaVI5pxxgACVbUb6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922180; c=relaxed/simple;
	bh=Z46VKqKZ0FPff1sCru/gK9s4P3X0W2Nu7ly7V5AunKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsoXNahrOSqXhc3V2AsK2EiPsUAVA/g7LvW5pVxBNoCXpdSTuoo9s3LvHYRbcvkHdo4cWHuIwRuPSuDF5EizX1gZ8vRflpX6EHu2iuPz/NV7yGpH80GRIHFsIR5nRdSyZqf0DD9p+exVuAQD+FiW7zCEKeUl7Nc43ga6gU8GP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1490E2F4;
	Mon, 22 Jan 2024 03:17:03 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.47.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A46F3F5A1;
	Mon, 22 Jan 2024 03:16:15 -0800 (PST)
Date: Mon, 22 Jan 2024 11:16:10 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	james.morse@arm.com, stable@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH 1/2] arm64: entry: fix
 ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
Message-ID: <Za5OekA_bYooPXxz@FVFF77S0Q05N>
References: <20240116110221.420467-1-mark.rutland@arm.com>
 <20240116110221.420467-2-mark.rutland@arm.com>
 <CAL_JsqJGWHj_adgvX_XwRuh+xvQGw2p-e9ZxxJ_qd19nWZ_daQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJGWHj_adgvX_XwRuh+xvQGw2p-e9ZxxJ_qd19nWZ_daQ@mail.gmail.com>

Hi Rob,

Sorry for the confusion here; I should have synced up with you before sending
this out.

On Fri, Jan 19, 2024 at 09:11:33AM -0600, Rob Herring wrote:
> On Tue, Jan 16, 2024 at 5:02 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Currently the ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD workaround isn't
> > quite right, as it is supposed to be applied after the last explicit
> > memory access, but is immediately followed by an LDR.
> 
> This isn't necessary. The LDR in question is an unprivileged load from
> the EL0 stack. The erratum write-up is not really clear in that
> regard.

I see from internal notes that the rationale is that the LDR in question only
loads data that EL0 already has in its registers, and hence it doesn't matter
if that data is leaked to EL0. That's reasonable, but we didn't note that
anywhere (i.e. neither in the commit message nor in any comments).

To avoid confusion, the LDR in question *is* a privileged load (whereas an LDTR
at EL1 would be an unprivileged load); for memory accesses the architecture
uses the terms privileged and unprivileged to distinguish the way those are
handled by the MMU.

I agree that given the rationale above this patch isn't strictly necessary, but
I would prefer result of these two patches as it's less likely that we'll add
loads of sensitive information in future as this code is changed.

> It's the same as the KPTI case. After switching the page tables, there
> are unprivileged loads from the EL0 stack.

I'm not sure what you mean here; maybe I'm missing something?

AFAICT we don't do any loads within the kernel after switching the translation
tables. In tramp_exit we follow tramp_unmap_kernel with:

	MRS; ERET; SB

... and in __sdei_asm_exit_trampoline we follow tramp_unmap_kernel with

	CMP; B.NE; {HVC,SMC}; B .

... so there are no explicit loads at EL1 before the ERET to EL0. In the SDEI
case any loads at a higher EL don't matter because they're in a different
translation regime.

Thanks,
Mark.

