Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F189790C16
	for <lists+stable@lfdr.de>; Sun,  3 Sep 2023 15:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbjICNMn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 3 Sep 2023 09:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbjICNMl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 3 Sep 2023 09:12:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B505123
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 06:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E5F4ECE0AC6
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 13:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A1BC433B6;
        Sun,  3 Sep 2023 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693746753;
        bh=3T/Vq+P7C37rdn8gay3+642xll2VcZkRZrcmNXNNxlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cU0Ufg6DIAFn75VLGTeV4Mv3CQXD9j2croA09xi/62RaiLNnwRsW5v9ztq8/Ie4qP
         sIngNYN+H8JFW3lF27DafIH7S8rQfYmrca5Qz5o7yMNyPLh+S04vH+PTd8MGZa93Gh
         Ru9ONQstDXGafzRpIYdi/jrEurIpyxiWX9m1X/TE=
Date:   Sun, 3 Sep 2023 14:50:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.19 5.4 5.10 5.15 6.1] nilfs2: fix general protection
 fault in nilfs_lookup_dirty_data_buffers()
Message-ID: <2023090333-crouch-caucus-fb22@gregkh>
References: <20230902151000.3817-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902151000.3817-1-konishi.ryusuke@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Sep 03, 2023 at 12:10:00AM +0900, Ryusuke Konishi wrote:
> commit f83913f8c5b882a312e72b7669762f8a5c9385e4 upstream.
> 
> A syzbot stress test reported that create_empty_buffers() called from
> nilfs_lookup_dirty_data_buffers() can cause a general protection fault.
> 
> Analysis using its reproducer revealed that the back reference "mapping"
> from a page/folio has been changed to NULL after dirty page/folio gang
> lookup in nilfs_lookup_dirty_data_buffers().
> 
> Fix this issue by excluding pages/folios from being collected if, after
> acquiring a lock on each page/folio, its back reference "mapping" differs
> from the pointer to the address space struct that held the page/folio.
> 
> Link: https://lkml.kernel.org/r/20230805132038.6435-1-konishi.ryusuke@gmail.com
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Reported-by: syzbot+0ad741797f4565e7e2d2@syzkaller.appspotmail.com
> Closes: https://lkml.kernel.org/r/0000000000002930a705fc32b231@google.com
> Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> ---
> Please apply this patch to the above stable trees instead of the patch
> that could not be applied to them.  This patch resolves the conflict
> caused by the recent page to folio conversion applied in
> nilfs_lookup_dirty_data_buffers().  The general protection fault reported
> by syzbot reproduces on these stable kernels before the page/folio
> conversion is applied.  This fixes it.
> 
> With this tweak, this patch is applicable from v4.15 to v6.2.  Also,
> this patch has been tested against the -stable trees of each version in
> the subject prefix.

Now queued up, thanks.

greg k-h
