Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78377748E73
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 21:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjGETzz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 15:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjGETzn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 15:55:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F9FE3
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 12:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA7E616D1
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 19:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A290DC433C8;
        Wed,  5 Jul 2023 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688586941;
        bh=WqIQUie4XS3G+oRTAfFPbKmQXMnQH3WSjRl725fkDnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gp8rSObgSxmhVtQJbrQrMwjo6+yDlcMfwBCJ9wY3mud/7/8spsaoHUodr75KprzfP
         wUK89elrcCXufvCG2wZ6RXj/BvNkUPHhVlA9EC8koyW8rJQtKbqDw5xjzR0ZEN1ALz
         XM9mTSca362h/7lkELqe/S4go9fHDk8k6d5YROJk=
Date:   Wed, 5 Jul 2023 20:55:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] nubus: Partially revert proc_create_single_data()
 conversion
Message-ID: <2023070527-mystify-scrubber-8098@gregkh>
References: <2023070300-copious-unhidden-592f@gregkh>
 <9bb320e617f10d0b99fed211fbaf5543.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bb320e617f10d0b99fed211fbaf5543.fthain@linux-m68k.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 04, 2023 at 11:09:21AM +1000, Finn Thain wrote:
> The conversion to proc_create_single_data() introduced a regression
> whereby reading a file in /proc/bus/nubus results in a seg fault:
> 
>     # grep -r . /proc/bus/nubus/e/
>     Data read fault at 0x00000020 in Super Data (pc=0x1074c2)
>     BAD KERNEL BUSERR
>     Oops: 00000000
>     Modules linked in:
>     PC: [<001074c2>] PDE_DATA+0xc/0x16
>     SR: 2010  SP: 38284958  a2: 01152370
>     d0: 00000001    d1: 01013000    d2: 01002790    d3: 00000000
>     d4: 00000001    d5: 0008ce2e    a0: 00000000    a1: 00222a40
>     Process grep (pid: 45, task=142f8727)
>     Frame format=B ssw=074d isc=2008 isb=4e5e daddr=00000020 dobuf=01199e70
>     baddr=001074c8 dibuf=ffffffff ver=f
>     Stack from 01199e48:
> 	    01199e70 00222a58 01002790 00000000 011a3000 01199eb0 015000c0 00000000
> 	    00000000 01199ec0 01199ec0 000d551a 011a3000 00000001 00000000 00018000
> 	    d003f000 00000003 00000001 0002800d 01052840 01199fa8 c01f8000 00000000
> 	    00000029 0b532b80 00000000 00000000 00000029 0b532b80 01199ee4 00103640
> 	    011198c0 d003f000 00018000 01199fa8 00000000 011198c0 00000000 01199f4c
> 	    000b3344 011198c0 d003f000 00018000 01199fa8 00000000 00018000 011198c0
>     Call Trace: [<00222a58>] nubus_proc_rsrc_show+0x18/0xa0
>      [<000d551a>] seq_read+0xc4/0x510
>      [<00018000>] fp_fcos+0x2/0x82
>      [<0002800d>] __sys_setreuid+0x115/0x1c6
>      [<00103640>] proc_reg_read+0x5c/0xb0
>      [<00018000>] fp_fcos+0x2/0x82
>      [<000b3344>] __vfs_read+0x2c/0x13c
>      [<00018000>] fp_fcos+0x2/0x82
>      [<00018000>] fp_fcos+0x2/0x82
>      [<000b8aa2>] sys_statx+0x60/0x7e
>      [<000b34b6>] vfs_read+0x62/0x12a
>      [<00018000>] fp_fcos+0x2/0x82
>      [<00018000>] fp_fcos+0x2/0x82
>      [<000b39c2>] ksys_read+0x48/0xbe
>      [<00018000>] fp_fcos+0x2/0x82
>      [<000b3a4e>] sys_read+0x16/0x1a
>      [<00018000>] fp_fcos+0x2/0x82
>      [<00002b84>] syscall+0x8/0xc
>      [<00018000>] fp_fcos+0x2/0x82
>      [<0000c016>] not_ext+0xa/0x18
>     Code: 4e5e 4e75 4e56 0000 206e 0008 2068 ffe8 <2068> 0020 2008 4e5e 4e75 4e56 0000 2f0b 206e 0008 2068 0004 2668 0020 206b ffe8
>     Disabling lock debugging due to kernel taint
> 
>     Segmentation fault
> 
> The proc_create_single_data() conversion does not work because
> single_open(file, nubus_proc_rsrc_show, PDE_DATA(inode)) is not
> equivalent to the original code.
> 
> Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org # 5.6+
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/r/d4e2a586e793cc8d9442595684ab8a077c0fe726.1678783919.git.fthain@linux-m68k.org
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> (cherry picked from commit 0e96647cff9224db564a1cee6efccb13dbe11ee2)
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>  drivers/nubus/proc.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 

Now queued up, thanks.

greg k-h
