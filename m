Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2462878A0ED
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 20:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjH0SY6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 14:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjH0SY0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 14:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E291E123
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 11:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D11A612BF
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 18:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43141C433C8;
        Sun, 27 Aug 2023 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693160662;
        bh=JydO1Yrt87UT6n7e5bO781ZlxB8bLm2b7Kd6FlxAI24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dosXAKpHsfHdNSwgjlh2Vr9k+Y9PWf5Wn02pUMFogJ7iX/m6FE3HCUWG1TYYZAIXs
         68LrRWfSKa7g/qRuXiH2CCYiACl9g6Fq4TTh9tnud8rr3yDpbXb7nxdlVhveiSzsQJ
         KIhmVSktjVwwWTjzo0DfaZ7SKg3lbp9Wo39KPYSQ=
Date:   Sun, 27 Aug 2023 20:24:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Vishal Moola <vishal.moola@gmail.com>,
        Yang Shi <shy828301@gmail.com>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.4.12] madvise:madvise_cold_or_pageout_pte_range():
 don't use mapcount() against large folio for sharing check
Message-ID: <2023082709-universal-zipfile-f50c@gregkh>
References: <20230827135211.2115099-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827135211.2115099-1-fengwei.yin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 27, 2023 at 09:52:11PM +0800, Yin Fengwei wrote:
> Patch series "don't use mapcount() to check large folio sharing", v2.
> 
> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
> folio_mapcount() is used to check whether the folio is shared.  But it's
> not correct as folio_mapcount() returns total mapcount of large folio.

All backports now queued up, thanks!

greg k-h
