Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4BD75EB86
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 08:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGXGcH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 02:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGXGcH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 02:32:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC8AA9
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 23:32:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F032C60F0C
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 06:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5B1C433C8;
        Mon, 24 Jul 2023 06:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690180325;
        bh=p/FDcNNNzaClwjq3zES6+z9MdhDyNQQNxmhUDuwp7Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjL6l0la0PfE3Y0BIoNZJ/8vwuDceOkeJWU+T1/dPOoPfsMFZ2ieZVgQuL6zTA4ku
         2V9M7yTcNRmXv22EKCUuK84Ku4KZzo3M7RCbivWEhyl7tB7z5QjAjT/RvuIpHrmFmS
         rMpDIjyY8eqnAa8xGtyXFk13b6DZzrrVlfMk9KI8=
Date:   Mon, 24 Jul 2023 08:32:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     rostedt@goodmis.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.10 0/2] re: FAILED: patch "[PATCH] ftrace: Fix possible
Message-ID: <2023072456-stillness-duvet-4d1f@gregkh>
References: <2023072114-giblet-unzip-f1db@gregkh>
 <20230724022924.3478612-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724022924.3478612-1-zhengyejian1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 24, 2023 at 10:29:22AM +0800, Zheng Yejian wrote:
> Resolve backport failed due to lack of dependency commit
> db42523b4f3e ("ftrace: Store the order of pages allocated in ftrace_page")
> 
> Linus Torvalds (1):
>   ftrace: Store the order of pages allocated in ftrace_page
> 
> Zheng Yejian (1):
>   ftrace: Fix possible warning on checking all pages used in
>     ftrace_process_locs()
> 
>  kernel/trace/ftrace.c | 72 ++++++++++++++++++++++++++-----------------
>  1 file changed, 44 insertions(+), 28 deletions(-)
> 
> -- 
> 2.25.1
> 

Both now queued up, thanks.

greg k-h
