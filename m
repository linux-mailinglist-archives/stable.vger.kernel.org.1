Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C146D7AFA67
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 07:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjI0FxY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 01:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjI0Fwt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 01:52:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514BC1B6
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 22:51:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AE0C433C7;
        Wed, 27 Sep 2023 05:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695793893;
        bh=iSvRaoQsvHcID1e7FqP/42c2VfE0oDMv4a1u0al4HRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMBkQUo6bI9y/v66lscpD/mJL6taRxZetEj8yut0jY+XbK+RnRwPU1ewS9YrHKJcV
         xt58K+uMH/iDmHUSvfd2w/S33qAZczL19om/ymZThHpunQBqKC96HOk8eFEaHjR3yd
         vVRAE5XmaKLtmS2FVkIsAgkDdacnLdxRPX7ZnRVceTq67EH8J2hQ8oHZd7qUPYEA5+
         kzaTOO70aECdC5S/0zzb+yW3D+6cWmYEKsO6cWIAMEr2bSwzDvr640VjhgD9Squ0s2
         U37OpSW4iMoQ1JvZZpzpYxyip6LNSK17FhuVusbDM9ZlZlOA1lDBXcKUwk4rRZWG6n
         VVqULe07KPZlA==
Date:   Wed, 27 Sep 2023 07:51:26 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jordan Rife <jrife@google.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        netdev@vger.kernel.org, dborkman@kernel.org, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
        ast@kernel.org, rdna@fb.com, stable@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v5 3/3] net: prevent address rewrite in kernel_bind()
Message-ID: <20230927055126.GD224399@kernel.org>
References: <20230921234642.1111903-1-jrife@google.com>
 <20230921234642.1111903-3-jrife@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921234642.1111903-3-jrife@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 21, 2023 at 06:46:42PM -0500, Jordan Rife wrote:
> Similar to the change in commit 0bdf399342c5("net: Avoid address
> overwrite in kernel_connect"), BPF hooks run on bind may rewrite the
> address passed to kernel_bind(). This change
> 
> 1) Makes a copy of the bind address in kernel_bind() to insulate
>    callers.
> 2) Replaces direct calls to sock->ops->bind() in net with kernel_bind()
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> Cc: stable@vger.kernel.org
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jordan Rife <jrife@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

