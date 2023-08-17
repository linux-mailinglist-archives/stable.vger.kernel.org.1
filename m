Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA777F97A
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 16:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348072AbjHQOoC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 10:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352216AbjHQOnv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 10:43:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8121735A3
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 07:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B86D163999
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 14:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DB1C433C8;
        Thu, 17 Aug 2023 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692283407;
        bh=552zwm0rSE79MslE79G1b9DNNYCZLRTWyefdf1Js+Gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v2J5o4BGRBzHTw5Tsu0Vwdj3to/MtCl0PViq0ayjQUXofnAaww8BPu6sjo/ZQ/Ege
         947YNvQWWFUZOwN0WjzmzAcR8u1nY7FBrv2K4lcdNzhOgThM78/3707zCiLSzccdYE
         o+0xgOeLwrPiRk9iEjSADQX3/6DJ0EjFQs+ZvxBE=
Date:   Thu, 17 Aug 2023 16:43:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     t.martitz@avm.de
Cc:     stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: proc_lseek backport request
Message-ID: <2023081752-giddily-anytime-237e@gregkh>
References: <OF964B0E9A.174E142D-ONC1258A0E.0032FEAA-C1258A0E.00337FA7@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF964B0E9A.174E142D-ONC1258A0E.0032FEAA-C1258A0E.00337FA7@avm.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 17, 2023 at 11:22:30AM +0200, t.martitz@avm.de wrote:
> Dear stable team,
> 
> I'm asking that 
> 
> commit 3f61631d47f1 ("take care to handle NULL ->proc_lseek()")
> 
> gets backported to the stable and LTS kernels down to 5.10.
> 
> Background:
> We are in the process of upgrading our kernels. One target kernel
> is based on 5.15 LTS.
> 
> Here we found that, if proc file drivers do not implement proc_lseek,
> user space crashes easily, because various library routines internally
> perform lseek(2). The crash happens in proc_reg_llseek, where it
> wants to jump to a NULL pointer.
> 
> We could, arguably, fix these drivers to use ".proc_lseek = no_llseek".
> But this doesn't seem like a worthwhile path forward, considering that
> latest Linux kernels (including 6.1 LTS) allow proc_lseek == NULL again 
> and *remove* no_lseek. Essentially, on HEAD, it's best practice to leave 
> proc_lseek == NULL.
> Therefore, I ask that the above procfs fix gets backported so that our
> drivers can work across all kernel versions, including latest 6.x.

For obvious technical, and legal reasons, we can not take kernel changes
only for out-of-tree kernel modules, you know this :)

So sorry, no, we should not backport this change because as-is, all
in-tree code works just fine, right?

Attempting to keep kernel code outside of the kernel tree is, on
purpose, very expensive in time and resources.  The very simple way to
solve this is to get your drivers merged properly into the mainline
kernel tree.

Have you submitted your drivers and had them rejected?

Have you taken advantage of the projects that are willing to take
out-of-tree drivers and get them merged upstream properly for free?

Is there anything else preventing your code from being accepted into the
upstream kernel tree that we can help with?

thanks,

greg k-h



> 
> I checked that this commit applies and works as expected on a board that
> runs Linux 5.15, and the observed crash goes away.
> 
> Furthermore, I investigated that the fix applies to older LTS kernels, down
> to 5.10. The lseek(2) path uses vfs_llseek() which checks for FMODE_LSEEK. This
> has been like that forever since the initial git import. However, 5.4 LTS and 
> older kernels do not have "struct proc_ops".
> 
> Thank you in advance.
> 
> Best regards,
> Thomas Martitz
