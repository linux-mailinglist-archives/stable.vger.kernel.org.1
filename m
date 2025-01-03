Return-Path: <stable+bounces-106738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F264AA01004
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 22:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C0518842CF
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 21:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628481BD9DD;
	Fri,  3 Jan 2025 21:55:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857FF188904;
	Fri,  3 Jan 2025 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735941355; cv=none; b=XMFjMFwfPRZICSLhoI1T/vZQVIPzZ4HqgmAoK/6/KQyOCdbH+XBjtHgl7dku0IrZO9WDZbeqrd8csHiBQeghyjZsjLsqLyUpr/nsWFRmjlUSaVKDJtjoI7Twzt5pMLtmkMOAaaV6AieT1VCI6XiJfwbypnDt/0yKGMyJPTk4C/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735941355; c=relaxed/simple;
	bh=IqZiuTEbTAnA6K842ongX8Ep9TFhUNCbj9Z48YOQhvc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1MduTY9aXCnAbj2r3vUiBOaf9BpoNDADY5F5MZLR91CHIcBYyRNK4Y7scuZuEV/fLSrEVGJJhkSLUM2DGMEb7WgfENCRwsxjEEkba6R510fnQ+JOc+uMdUz7FJe5vPb6uatG3KYvAKT7hAssqFSxxBMj9CJZhw8Hslcr0EqLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tTpde-000000006ej-0fBu;
	Fri, 03 Jan 2025 16:55:26 -0500
Message-ID: <a1fff596435121b01766bed27e401e8a27bf8f92.camel@surriel.com>
Subject: Re: [PATCH] x86/mm: Fix flush_tlb_range() when used for zapping
 normal PMDs
From: Rik van Riel <riel@surriel.com>
To: Jann Horn <jannh@google.com>, Dave Hansen <dave.hansen@linux.intel.com>,
  Andy Lutomirski	 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 03 Jan 2025 16:55:25 -0500
In-Reply-To: <20250103-x86-collapse-flush-fix-v1-1-3c521856cfa6@google.com>
References: <20250103-x86-collapse-flush-fix-v1-1-3c521856cfa6@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Fri, 2025-01-03 at 19:39 +0100, Jann Horn wrote:
> 02fc2aa06e9e0ecdba3fe948cafe5892b72e86c0..3da645139748538daac70166618d
> 8ad95116eb74 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -242,7 +242,7 @@ void flush_tlb_multi(const struct cpumask
> *cpumask,
> =C2=A0	flush_tlb_mm_range((vma)->vm_mm, start,
> end,			\
> =C2=A0			=C2=A0=C2=A0 ((vma)->vm_flags &
> VM_HUGETLB)		\
> =C2=A0				?
> huge_page_shift(hstate_vma(vma))	\
> -				: PAGE_SHIFT, false)
> +				: PAGE_SHIFT, true)
> =C2=A0
>=20

The code looks good, but should this macro get
a comment indicating that code that only frees
pages, but not page tables, should be calling
flush_tlb() instead?

--=20
All Rights Reversed.

