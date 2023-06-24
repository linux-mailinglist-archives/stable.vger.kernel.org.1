Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E253573CB3E
	for <lists+stable@lfdr.de>; Sat, 24 Jun 2023 16:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjFXOJE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 24 Jun 2023 10:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjFXOJD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Jun 2023 10:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF3C1BC2
        for <stable@vger.kernel.org>; Sat, 24 Jun 2023 07:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9743B60302
        for <stable@vger.kernel.org>; Sat, 24 Jun 2023 14:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A213AC433C0;
        Sat, 24 Jun 2023 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687615742;
        bh=W2/jOBewhTmU4X8k/Qjg0yQqTZ43GTlMlbmNNm0Jvds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWt2MlxKYKWND39whxXZmgyzvKgBT7V6RgnSXKITr8osL4BywqaUBf8mlcBGoSSoc
         kuBYWFwD02a/MD8ry9UwAaW372SmChBMRsM4PggYa25IAjXYjOFTVmKimIFf+zqB5C
         eCObJHK86LDDroIC02xFtUIloc/3fFqVeU9Vton0=
Date:   Sat, 24 Jun 2023 16:08:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.14 4.19 5.4 5.10 5.15 6.1] nilfs2: prevent general
 protection fault in nilfs_clear_dirty_page()
Message-ID: <2023062452-drank-strife-99ad@gregkh>
References: <2023062316-swooned-scurvy-040f@gregkh>
 <20230624041802.4195-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624041802.4195-1-konishi.ryusuke@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jun 24, 2023 at 01:18:02PM +0900, Ryusuke Konishi wrote:
> commit 782e53d0c14420858dbf0f8f797973c150d3b6d7 upstream.
> 
> In a syzbot stress test that deliberately causes file system errors on
> nilfs2 with a corrupted disk image, it has been reported that
> nilfs_clear_dirty_page() called from nilfs_clear_dirty_pages() can cause a
> general protection fault.
> 
> In nilfs_clear_dirty_pages(), when looking up dirty pages from the page
> cache and calling nilfs_clear_dirty_page() for each dirty page/folio
> retrieved, the back reference from the argument page to "mapping" may have
> been changed to NULL (and possibly others).  It is necessary to check this
> after locking the page/folio.
> 
> So, fix this issue by not calling nilfs_clear_dirty_page() on a page/folio
> after locking it in nilfs_clear_dirty_pages() if the back reference
> "mapping" from the page/folio is different from the "mapping" that held
> the page/folio just before.
> 
> Link: https://lkml.kernel.org/r/20230612021456.3682-1-konishi.ryusuke@gmail.com
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Reported-by: syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com
> Closes: https://lkml.kernel.org/r/000000000000da4f6b05eb9bf593@google.com
> Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> ---
> Please apply this patch to the above stable trees instead of the patch
> that could not be applied to them.  This patch resolves the conflict
> caused by the recent page to folio conversion applied in
> nilfs_clear_dirty_pages().  The general protection fault reported by
> syzbot reproduces on these stable kernels before the page/folio
> conversion is applied.  This fixes it.
> 
> With this tweak, this patch is applicable from v3.10 to v6.2.  Also,
> this patch has been tested against the -stable trees of each version in
> the subject prefix.

Now queued up, thanks.

greg k-h
