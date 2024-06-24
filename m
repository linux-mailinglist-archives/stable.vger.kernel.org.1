Return-Path: <stable+bounces-55030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191FE915135
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EC828684B
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B2192B67;
	Mon, 24 Jun 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a7RTbJYC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5F14264F
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241158; cv=none; b=iLV4U4mHku+BgcGmSOh5nM7LYMEMbrIF33WKN0ldtzFodfY5yM1ANG0kMbZXOiMADCopVVO2OaXtjbLZRHF3ciBJOgRzqJRD61BVS0sDHC9neishhWmNxAKOCyi2AhEN7v9VpPyDxfCiGxYYQLfZPurL9JNi6TFyFrNUT3kwyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241158; c=relaxed/simple;
	bh=VS/KUs1WrEa9BQfqVtNHXpqWtkbYN19nW17eOlEoBgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSHGLXH2mEkDoCuD7byPvDTxLIgDPAVrVJZ8Q4Qs6TCQfqqAtf2zXADLskKFkb/GAZEOYVIU/XS07U7mezPU82KDQrk9JKM0grkFQP4P9wJA6ahTiMpScRF6T14G87f+cu9k4asbT5t9QWyXiIdtrU5GT8cbPkMNYW01vdO79DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a7RTbJYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92546C2BBFC;
	Mon, 24 Jun 2024 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719241158;
	bh=VS/KUs1WrEa9BQfqVtNHXpqWtkbYN19nW17eOlEoBgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7RTbJYCDY7yAF9L29ONdqmZ82dbsudDGpN81YJXmfvv8+QIFSV8+pTWX/G8Fku07
	 b/AXkJk0PY3WFJKiMn/oZpRSRwFcH2h/yaxsfGd7zjSmfdFBHXV8bE82ErvXkr1owY
	 nXT0tVJDa5hR2OTWJnI5PLw6FljdRTDUdtzyLRUg=
Date: Mon, 24 Jun 2024 16:59:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.19.y] mm: fix race between __split_huge_pmd_locked()
 and GUP-fast
Message-ID: <2024062402-whiny-retreat-fbac@gregkh>
References: <2024061320-handcart-crook-0519@gregkh>
 <20240624092743.568016-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624092743.568016-1-ryan.roberts@arm.com>

On Mon, Jun 24, 2024 at 10:27:43AM +0100, Ryan Roberts wrote:
> __split_huge_pmd_locked() can be called for a present THP, devmap or
> (non-present) migration entry.  It calls pmdp_invalidate() unconditionally
> on the pmdp and only determines if it is present or not based on the
> returned old pmd.  This is a problem for the migration entry case because
> pmd_mkinvalid(), called by pmdp_invalidate() must only be called for a
> present pmd.
> 
> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any future
> call to pmd_present() will return true.  And therefore any lockless
> pgtable walker could see the migration entry pmd in this state and start
> interpretting the fields as if it were present, leading to BadThings (TM).
> GUP-fast appears to be one such lockless pgtable walker.
> 
> x86 does not suffer the above problem, but instead pmd_mkinvalid() will
> corrupt the offset field of the swap entry within the swap pte.  See link
> below for discussion of that problem.
> 
> Fix all of this by only calling pmdp_invalidate() for a present pmd.  And
> for good measure let's add a warning to all implementations of
> pmdp_invalidate[_ad]().  I've manually reviewed all other
> pmdp_invalidate[_ad]() call sites and believe all others to be conformant.
> 
> This is a theoretical bug found during code review.  I don't have any test
> case to trigger it in practice.
> 
> Link: https://lkml.kernel.org/r/20240501143310.1381675-1-ryan.roberts@arm.com
> Link: https://lore.kernel.org/all/0dd7827a-6334-439a-8fd0-43c98e6af22b@arm.com/
> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 3a5a8d343e1cf96eb9971b17cbd4b832ab19b8e7)
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

All now queued up, thanks.

greg k-h

