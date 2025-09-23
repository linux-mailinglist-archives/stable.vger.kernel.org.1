Return-Path: <stable+bounces-181528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D63B96C64
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 18:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C11017AEE7
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C569313536;
	Tue, 23 Sep 2025 16:15:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277330E84A;
	Tue, 23 Sep 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644100; cv=none; b=Tnmpy3F5g4DI0aY4mwPSyFIydFN6b3D5K9o+DM+VVKq1L8kVcbQ1HNrcoEiv8m+XysF306c95XeSZZ/4c1tPbsb2tctKQ6zZbATM6C1XWragy+RNs69aHid/Y2Grly4fMFepTdq5XU/mWvkkSJQNciu2Xn4G3UfAiJfqBIpijX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644100; c=relaxed/simple;
	bh=GLX+Bs10++gMcM1RHPq8kj4gcq/8AhAuZIuYnjJmuGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcuHPIhKMzKaX8GtM7lqN3ijoKW4Sp9RJXhGdmKpZJP1ZVSHsqWqK9EQJvG4PgjQd75R6TeSR2/QiufeD96nD8k+UBwGPL/oAiwrorKbhyeAWfSCM6s7JYQ4bUMZsaKDRQ6zxDQ2jh2uhKk0YJcjZwfyg/2dpRzLqlE1Aa92g4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DEEC4CEF5;
	Tue, 23 Sep 2025 16:14:53 +0000 (UTC)
Date: Tue, 23 Sep 2025 17:14:51 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, usamaarif642@gmail.com,
	yuzhao@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	baohua@kernel.org, voidice@gmail.com, Liam.Howlett@oracle.com,
	cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
	kaleshsingh@google.com, npache@redhat.com, riel@surriel.com,
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
	dev.jain@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
	surenb@google.com, hughd@google.com, willy@infradead.org,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, qun-wei.lin@mediatek.com,
	Andrew.Yang@mediatek.com, casper.li@mediatek.com,
	chinwen.chang@mediatek.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
Message-ID: <aNLHexcNI53HQ46A@arm.com>
References: <20250922021458.68123-1-lance.yang@linux.dev>
 <aNGGUXLCn_bWlne5@arm.com>
 <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
 <aNKJ5glToE4hMhWA@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNKJ5glToE4hMhWA@arm.com>

On Tue, Sep 23, 2025 at 12:52:06PM +0100, Catalin Marinas wrote:
> I just realised that on arm64 with MTE we won't get any merging with the
> zero page even if the user page isn't mapped with PROT_MTE. In
> cpu_enable_mte() we zero the tags in the zero page and set
> PG_mte_tagged. The reason is that we want to use the zero page with
> PROT_MTE mappings (until tag setting causes CoW). Hmm, the arm64
> memcmp_pages() messed up KSM merging with the zero page even before this
> patch.
[...]
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index e5e773844889..72a1dfc54659 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -73,6 +73,8 @@ int memcmp_pages(struct page *page1, struct page *page2)
>  {
>  	char *addr1, *addr2;
>  	int ret;
> +	bool page1_tagged = page_mte_tagged(page1) && !is_zero_page(page1);
> +	bool page2_tagged = page_mte_tagged(page2) && !is_zero_page(page2);
>  
>  	addr1 = page_address(page1);
>  	addr2 = page_address(page2);
> @@ -83,11 +85,10 @@ int memcmp_pages(struct page *page1, struct page *page2)
>  
>  	/*
>  	 * If the page content is identical but at least one of the pages is
> -	 * tagged, return non-zero to avoid KSM merging. If only one of the
> -	 * pages is tagged, __set_ptes() may zero or change the tags of the
> -	 * other page via mte_sync_tags().
> +	 * tagged, return non-zero to avoid KSM merging. Ignore the zero page
> +	 * since it is always tagged with the tags cleared.
>  	 */
> -	if (page_mte_tagged(page1) || page_mte_tagged(page2))
> +	if (page1_tagged || page2_tagged)
>  		return addr1 != addr2;
>  
>  	return ret;

Unrelated to this discussion, I got an internal report that Linux hangs
during boot with CONFIG_DEFERRED_STRUCT_PAGE_INIT because
try_page_mte_tagging() locks up on uninitialised page flags.

Since we (always?) map the zero page as pte_special(), set_pte_at()
won't check if the tags have to be initialised, so we can skip the
PG_mte_tagged altogether. We actually had this code for some time until
we introduced the pte_special() check in set_pte_at().

So alternative patch that also fixes the deferred struct page init (on
the assumptions that the zero page is always mapped as pte_special():

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7b78c95a9017..e325ba34f45c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2419,17 +2419,21 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
 #ifdef CONFIG_ARM64_MTE
 static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 {
+	static bool cleared_zero_page = false;
+
 	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
 
 	mte_cpu_setup();
 
 	/*
 	 * Clear the tags in the zero page. This needs to be done via the
-	 * linear map which has the Tagged attribute.
+	 * linear map which has the Tagged attribute. Since this page is
+	 * always mapped as pte_special(), set_pte_at() will not attempt to
+	 * clear the tags or set PG_mte_tagged.
 	 */
-	if (try_page_mte_tagging(ZERO_PAGE(0))) {
+	if (!cleared_zero_page) {
+		cleared_zero_page = true;
 		mte_clear_page_tags(lm_alias(empty_zero_page));
-		set_page_mte_tagged(ZERO_PAGE(0));
 	}
 
 	kasan_init_hw_tags_cpu();

-- 
Catalin

