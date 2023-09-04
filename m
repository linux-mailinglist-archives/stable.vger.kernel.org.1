Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C06E7911AC
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 08:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjIDGzY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 02:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIDGzY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 02:55:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240A102
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 23:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A0D1B80CD9
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 06:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81EAC433C8;
        Mon,  4 Sep 2023 06:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693810518;
        bh=kvTQYf0BK5dKW+HH6QT31yMMnR2i1voF9u+hSyxEsOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fy/uFPUKROO1easEjy9D3PTeu1RCgMOPtnxH58Re8ZrezSZklv8Kt/nKtotFq7fQ5
         19/ZkTRii92d7qSGydp1v0EjyuOpo33prnjOOcucYAHx0CcH91tLF1xtpvy4JuqdBD
         uj20M7H1zEfmdKRI17IT9RY6P8VgUkGjrlZdIs1A=
Date:   Mon, 4 Sep 2023 07:55:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     stable@vger.kernel.org, sashal@kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH for 5.4, 5.10, 5.15] cifs: Remove duplicated include in
 cifsglob.h
Message-ID: <2023090445-circling-enhance-4e81@gregkh>
References: <20230904020529.343589-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904020529.343589-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 04, 2023 at 11:05:29AM +0900, Nobuhiro Iwamatsu wrote:
> From: Yang Li <yang.lee@linux.alibaba.com>
> 
> commit d74f4a3f6d88a2416564bc6bf937e423a4ae8f8e upstream.
> 
> ./fs/cifs/cifsglob.h: linux/scatterlist.h is included more than once.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3459
> Fixes: f7f291e14dde ("cifs: fix oops during encryption")
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  fs/cifs/cifsglob.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 92a7628560ccb0..80b570026c2c0d 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -29,7 +29,6 @@
>  #include "cifs_fs_sb.h"
>  #include "cifsacl.h"
>  #include <crypto/internal/hash.h>
> -#include <linux/scatterlist.h>

This is not an issue that needs to be added to the stable trees as it
doesn't actually do anything.

thanks,

greg k-h
