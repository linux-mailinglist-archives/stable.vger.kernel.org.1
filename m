Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95434782A68
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 15:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjHUNY1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 09:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjHUNY1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 09:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD1B1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 06:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51B64636EA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F4BC433C7;
        Mon, 21 Aug 2023 13:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692624264;
        bh=jtLHX+xPs/K9eiy9Uwrg3BPsJSd48m9KoPuilR8SXfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmgrF1UKvKjJBVEisI4Pk+XMyoZXGfDOASy9xYSue6QJZnSPZS9JvQ9wfoADxa6nH
         kVPTyYE1xt5b9rsvqYmZCkoCYGnP6PGuSIXLOmXhbM4+c1/kXYV0wQ8MtP74b/4KI8
         VaZnAR1OZ4CyVBaPtBIyLVSK9BgmTSjj6Tc4fnEY=
Date:   Mon, 21 Aug 2023 15:24:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vladislav Efanov <VEfanov@ispras.ru>
Cc:     stable@vger.kernel.org, Jan Kara <jack@suse.com>,
        lvc-project@linuxtesting.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 5.10 1/1] udf: Check consistency of Space Bitmap
 Descriptor
Message-ID: <2023082118-hundredth-thinly-9dd2@gregkh>
References: <20230815075939.2205503-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815075939.2205503-1-VEfanov@ispras.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 15, 2023 at 10:59:39AM +0300, Vladislav Efanov wrote:
> From: Vladislav Efanov <VEfanov@ispras.ru>
> 
> commit 1e0d4adf17e7ef03281d7b16555e7c1508c8ed2d upstream
> 
> Bits, which are related to Bitmap Descriptor logical blocks,
> are not reset when buffer headers are allocated for them. As the
> result, these logical blocks can be treated as free and
> be used for other blocks.This can cause usage of one buffer header
> for several types of data. UDF issues WARNING in this situation:
> 
> WARNING: CPU: 0 PID: 2703 at fs/udf/inode.c:2014
>   __udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014
> 
> RIP: 0010:__udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014
> Call Trace:
>  udf_setup_indirect_aext+0x573/0x880 fs/udf/inode.c:1980
>  udf_add_aext+0x208/0x2e0 fs/udf/inode.c:2067
>  udf_insert_aext fs/udf/inode.c:2233 [inline]
>  udf_update_extents fs/udf/inode.c:1181 [inline]
>  inode_getblk+0x1981/0x3b70 fs/udf/inode.c:885
> 
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> 
> [JK: Somewhat cleaned up the boundary checks]
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> Syzkaller reports this problem in 5.10 stable release. The problem has
> been fixed by the following patch which can be cleanly applied to the
> 5.10 branch.

We can not, for obvious reasons, take this only into the 5.10.y branch
(same for the other udf patch you sent.)  Please send patches for all
applicable branches (5.10 and newer) so that we can apply these to the
5.10.y tree at that time.

I've dropped both of these from my review queue now, thanks.

greg k-h

