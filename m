Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4E6FC5EE
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 14:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbjEIMJj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 08:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjEIMJe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 08:09:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BD4B35A7
        for <stable@vger.kernel.org>; Tue,  9 May 2023 05:09:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F2E8FEC;
        Tue,  9 May 2023 05:10:16 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACA393F67D;
        Tue,  9 May 2023 05:09:30 -0700 (PDT)
Date:   Tue, 9 May 2023 13:09:27 +0100
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        vincenzo.frascino@arm.com, will@kernel.org, eugenis@google.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64: mte: Do not set PG_mte_tagged if tags were not
 initialized
Message-ID: <ZFo39y0hv0np8vTj@monolith.localdoman>
References: <20230420214327.2357985-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420214327.2357985-1-pcc@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Peter,

Regardless of the nitpick below, the patch looks correct to me:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

On Thu, Apr 20, 2023 at 02:43:27PM -0700, Peter Collingbourne wrote:
> The mte_sync_page_tags() function sets PG_mte_tagged if it initializes
> page tags. Then we return to mte_sync_tags(), which sets PG_mte_tagged
> again. At best, this is redundant. However, it is possible for
> mte_sync_page_tags() to return without having initialized tags for the
> page, i.e. in the case where check_swap is true (non-compound page),
> is_swap_pte(old_pte) is false and pte_is_tagged is false. So at worst,
> we set PG_mte_tagged on a page with uninitialized tags. This can happen
> if, for example, page migration causes a PTE for an untagged page to
> be replaced. If the userspace program subsequently uses mprotect() to
> enable PROT_MTE for that page, the uninitialized tags will be exposed
> to userspace.
> 
> Fix it by removing the redundant call to set_page_mte_tagged().
> 
> Fixes: e059853d14ca ("arm64: mte: Fix/clarify the PG_mte_tagged semantics")
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Cc: <stable@vger.kernel.org> # 6.1
> Link: https://linux-review.googlesource.com/id/Ib02d004d435b2ed87603b858ef7480f7b1463052
> ---
>  arch/arm64/kernel/mte.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index f5bcb0dc6267..7e89968bd282 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -66,13 +66,10 @@ void mte_sync_tags(pte_t old_pte, pte_t pte)
>  		return;
>  
>  	/* if PG_mte_tagged is set, tags have already been initialised */
> -	for (i = 0; i < nr_pages; i++, page++) {
> -		if (!page_mte_tagged(page)) {

Both braces could have been kept (they define multiline blocks), and as a
bonus the diff becomes only one line removed. Not sure that's worth a
respin.

Thanks,
Alex

> +	for (i = 0; i < nr_pages; i++, page++)

> +		if (!page_mte_tagged(page))
>  			mte_sync_page_tags(page, old_pte, check_swap,
>  					   pte_is_tagged);
> -			set_page_mte_tagged(page);
> -		}
> -	}
>  
>  	/* ensure the tags are visible before the PTE is set */
>  	smp_wmb();
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
