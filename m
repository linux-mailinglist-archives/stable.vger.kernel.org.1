Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BE7779D80
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 08:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjHLGHy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 02:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjHLGHy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 02:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785A30DC
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 23:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71601643CB
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82808C433C7;
        Sat, 12 Aug 2023 06:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691820472;
        bh=8ADH81whV3g7GhKdHG2jMlrC6l5YPoMozdDyjrBjRcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1aooKYvjWgyeOlCDebeWNb+p5Ua5grzQHFsw9cJuHYya0ObHo0LvQuKExNfHaV1Y
         eDIFHfNogHyxk3u9huD2YAl+PtR2kzqe+bgplLttJE0/OJaVEU65wJLU4FQwx+TH6g
         DDMAdwqiYWXJLBT2pBLmcYiJo7szBgJprAMNbRGM=
Date:   Sat, 12 Aug 2023 08:07:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     stable@vger.kernel.org, RAJESH DASARI <raajeshdasari@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5.4,5.10] x86/pkeys: Revert a5eff7259790 ("x86/pkeys: Add
 PKRU value to init_fpstate")
Message-ID: <2023081241-simmering-compacted-20eb@gregkh>
References: <20230810153106.172292-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810153106.172292-1-cascardo@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 10, 2023 at 12:31:06PM -0300, Thadeu Lima de Souza Cascardo wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Commit b3607269ff57fd3c9690cb25962c5e4b91a0fd3b upstream.
> 
> This cannot work and it's unclear how that ever made a difference.
> 
> init_fpstate.xsave.header.xfeatures is always 0 so get_xsave_addr() will
> always return a NULL pointer, which will prevent storing the default PKRU
> value in init_fpstate.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/20210623121451.451391598@linutronix.de
> Reported-by: RAJESH DASARI <raajeshdasari@gmail.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
> 
> This has been reported to cause a WARNing since the backport of b81fac906a8f
> ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()").
> 
> a5eff7259790 was part of 5.2 and no older LTS kernels carry it, so not
> necessary on 4.19 or 4.14.

Now queued up, thanks.

greg k-h
