Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B9712CEA
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 20:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbjEZS5I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjEZS5H (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 14:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7303119C
        for <stable@vger.kernel.org>; Fri, 26 May 2023 11:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCBC9652AD
        for <stable@vger.kernel.org>; Fri, 26 May 2023 18:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DF5C433EF;
        Fri, 26 May 2023 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685127425;
        bh=+rQvkn5iRsdHWAdZbU00GY1LB9Xzt7Og6SadcX3f6p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lflKBLA7whKvQTkGmBddQ7tbFMQgbBFxxxk5/UJHkO+qxrd5+ivFdhemMZedslSqQ
         +ea0VL5CB3xUSmc1Mk4H3Sm8uGIlDK8AvzIGKsjRII8jaX45IzXGELck55ZGcwScF4
         /I08uOXIT2bJKEedQXOBB6XwltCCrBtWxGWfzfCo=
Date:   Fri, 26 May 2023 19:57:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6.1.y] arm64: Also reset KASAN tag if page is not
 PG_mte_tagged
Message-ID: <2023052650-juncture-smudgy-7407@gregkh>
References: <2023052235-cut-gulp-ad69@gregkh>
 <20230522192245.661455-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522192245.661455-1-pcc@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 22, 2023 at 12:22:45PM -0700, Peter Collingbourne wrote:
> Consider the following sequence of events:
> 
> 1) A page in a PROT_READ|PROT_WRITE VMA is faulted.
> 2) Page migration allocates a page with the KASAN allocator,
>    causing it to receive a non-match-all tag, and uses it
>    to replace the page faulted in 1.
> 3) The program uses mprotect() to enable PROT_MTE on the page faulted in 1.
> 
> As a result of step 3, we are left with a non-match-all tag for a page
> with tags accessible to userspace, which can lead to the same kind of
> tag check faults that commit e74a68468062 ("arm64: Reset KASAN tag in
> copy_highpage with HW tags only") intended to fix.
> 
> The general invariant that we have for pages in a VMA with VM_MTE_ALLOWED
> is that they cannot have a non-match-all tag. As a result of step 2, the
> invariant is broken. This means that the fix in the referenced commit
> was incomplete and we also need to reset the tag for pages without
> PG_mte_tagged.
> 
> Fixes: e5b8d9218951 ("arm64: mte: reset the page tag in page->flags")
> Cc: <stable@vger.kernel.org> # 5.15
> Link: https://linux-review.googlesource.com/id/I7409cdd41acbcb215c2a7417c1e50d37b875beff
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Link: https://lore.kernel.org/r/20230420210945.2313627-1-pcc@google.com
> Signed-off-by: Will Deacon <will@kernel.org>
> (cherry picked from commit 2efbafb91e12ff5a16cbafb0085e4c10c3fca493)
> ---
>  arch/arm64/mm/copypage.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Both backports now queued up, thanks.

greg k-h
