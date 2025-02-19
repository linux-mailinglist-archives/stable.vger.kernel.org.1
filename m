Return-Path: <stable+bounces-118327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 790D6A3C835
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 20:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1310C189617B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 19:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F3F2135A5;
	Wed, 19 Feb 2025 19:04:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B11C3F02;
	Wed, 19 Feb 2025 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991855; cv=none; b=rUnHHKb0JA0n5ed1sRcepoS9WQ15X9XHsLMELtyvNsuVp2P+wlrmNPkuwORcW5CQMs2e9Fa32F5R7fcz6kYAohxS/oQyQHXfRJobbyQnghCfhKmRA5YGtOgAWq4oAbVc2wAkC6450kYVu913bpqdaphKQ17VB62iUva9OEdCE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991855; c=relaxed/simple;
	bh=TR4fWPqzQadJ/W0eppkMviJUDNSORR6geJs++8Vt76A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izLrmBiT0k4b1ehXflRFk0EYFUGOo64TrznSJTgHFGvbEfkEf42lVZqPAI1V45HIyUcaCAA8ffVpiTZibws+bR1rNNkB+bqrNIxzLG6gFfQ35uv+YRyXvF1Lk1HhwzWYl62PGYqJ7A6Ya3wtGJhSTTgoQlRPbXIkPZ/+1im90RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9C8C4CED1;
	Wed, 19 Feb 2025 19:04:08 +0000 (UTC)
Date: Wed, 19 Feb 2025 19:04:06 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Dev Jain <dev.jain@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: hugetlb: Fix flush_hugetlb_tlb_range()
 invalidation level
Message-ID: <Z7YrJqRPaqcd2au7@arm.com>
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-4-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217140419.1702389-4-ryan.roberts@arm.com>

On Mon, Feb 17, 2025 at 02:04:16PM +0000, Ryan Roberts wrote:
> commit c910f2b65518 ("arm64/mm: Update tlb invalidation routines for
> FEAT_LPA2") changed the "invalidation level unknown" hint from 0 to
> TLBI_TTL_UNKNOWN (INT_MAX). But the fallback "unknown level" path in
> flush_hugetlb_tlb_range() was not updated. So as it stands, when trying
> to invalidate CONT_PMD_SIZE or CONT_PTE_SIZE hugetlb mappings, we will
> spuriously try to invalidate at level 0 on LPA2-enabled systems.
> 
> Fix this so that the fallback passes TLBI_TTL_UNKNOWN, and while we are
> at it, explicitly use the correct stride and level for CONT_PMD_SIZE and
> CONT_PTE_SIZE, which should provide a minor optimization.
> 
> Cc: stable@vger.kernel.org
> Fixes: c910f2b65518 ("arm64/mm: Update tlb invalidation routines for FEAT_LPA2")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

