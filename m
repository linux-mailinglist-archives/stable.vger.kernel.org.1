Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959607C750E
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 19:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344213AbjJLRtM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbjJLRtL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 13:49:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8CBB8
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 10:49:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA9FC433C7;
        Thu, 12 Oct 2023 17:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697132950;
        bh=kTHOSUwJptg5t9TkK4dC3pyRNB5fZRaRJGxtqI8IMgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5WCl6IN0PuxPZ8tlSjYYlkgsrM+4++KSnQoBPPREjM1FsIO48BG21MhBB51+XND1
         6hvCGZJxhu5e3R84c6xbI3wWH8LhGsbhjgrBwske3LTooTxBSGfsp0adEz8COQtQkS
         Lg/fWDQsCz0x79zccU2hc3VcMXTcz6db9MI25wuo=
Date:   Thu, 12 Oct 2023 19:49:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     poester <poester@internetbrands.com>
Cc:     stable@vger.kernel.org, Phil O <kernel@linuxace.com>
Subject: Re: Linux 6.1.56
Message-ID: <2023101229-sash-kilogram-9a46@gregkh>
References: <2023100635-pushchair-predator-9ae3@gregkh>
 <20231012165439.137237-2-kernel@linuxace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012165439.137237-2-kernel@linuxace.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 12, 2023 at 09:54:40AM -0700, poester wrote:
> Since rolling out 6.1.56 we have been experiencing file corruption
> over NFSv3.  We bisected it down to
> 
>  f16fd0b11f0f NFS: Fix error handling for O_DIRECT write scheduling
> 
> But that doesn't cleanly revert so we ended up reverting all NFS
> changes from 6.1.56 and the corruption no longer occurs.  Namely:
> 
>  edd1f0614510 NFS: More fixes for nfs_direct_write_reschedule_io()
>  d4729af1c73c NFS: Use the correct commit info in nfs_join_page_group()
>  1f49386d6779 NFS: More O_DIRECT accounting fixes for error paths
>  4d98038e5bd9 NFS: Fix O_DIRECT locking issues
>  f16fd0b11f0f NFS: Fix error handling for O_DIRECT write scheduling
> 
> The test case is fairly easily reproduced for us:
> 
>  dd if=testfile of=testfile2 oflag=direct; md5sum testfile*
> 
> shows a different md5sum between the two files on 6.1.56+ kernels.
> Interestingly, on 6.5.7 this problem does not occur even though it
> contains the same O_DIRECT patch as f16fd0b11f0f.
> 
> We opened a bugzilla on this:
> 
>  https://bugzilla.kernel.org/show_bug.cgi?id=217999
> 
> But this seems like a critical issue to us which should likely be
> addressed in 6.1.58.

I don't touch bugzilla, but I'll go revert these now and push out a -rc
release with the reverts as you aren't the only one who has reported
this and it would be good to get it resolved.

thanks!

greg k-h
