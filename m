Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648507E2012
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 12:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFLdo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 06:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKFLdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 06:33:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E268F1
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 03:33:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C3DC433C7;
        Mon,  6 Nov 2023 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699270420;
        bh=AH4qQxadXZXOKGPQ2nTyOsPcGN/2gTOTeWU4NA/fM9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjGEOi3M1zJD8ZLOo3wY3j4BNPedhyXB3efd80NXyIOrji0qGA2kaAn/d7s9W6H8z
         g7pMWISXsjI/04u7uE77AzuM6fONL1fO8kn2s3rAnennF2DW+B8ka8O01JBA6Lz/Lc
         zWCnkxYc9jy20ry6H1A4PQihXlVL5E6K3KvDg3z8=
Date:   Mon, 6 Nov 2023 12:33:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.5.y] mmap: fix error paths with dup_anon_vma()
Message-ID: <2023110624-bodacious-matchbook-654e@gregkh>
References: <2023102742-carnation-spinach-79d8@gregkh>
 <20231101144138.3513378-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101144138.3513378-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 01, 2023 at 10:41:38AM -0400, Liam R. Howlett wrote:
> commit 824135c46b00df7fb369ec7f1f8607427bbebeb0 upstream
> 
> When the calling function fails after the dup_anon_vma(), the
> duplication of the anon_vma is not being undone.  Add the necessary
> unlink_anon_vma() call to the error paths that are missing them.
> 
> This issue showed up during inspection of the error path in vma_merge()
> for an unrelated vma iterator issue.
> 
> Users may experience increased memory usage, which may be problematic as
> the failure would likely be caused by a low memory situation.
> 
> Link: https://lkml.kernel.org/r/20230929183041.2835469-3-Liam.Howlett@oracle.com
> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)

All backports now queued up, thanks.

greg k-h
