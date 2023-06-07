Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9A7268EB
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 20:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjFGSgH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 14:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjFGSfp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 14:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B792137
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 11:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1CC26429C
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 18:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD23BC43444;
        Wed,  7 Jun 2023 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686162932;
        bh=Tg/8x5siubYCdUQ5RHPMDYTycT7rPEjqanvfpG9byDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g5aaDr8glFTr9UudXKVbc4T0UECQ9IU+OTSHmMV7lenh0xe1pqKEkd+vlGDvKruc8
         Yh56mI6rI0v6UyWIa9LsMj8uzGTdDD+YPB/j5VMQGxbHh/VjojP0mZPyMYu+Rs57mP
         L17hImSLunh66D8IfKmTQIFkq4HV+VfenVAbu1UY=
Date:   Wed, 7 Jun 2023 20:35:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Mendoza-Jonas <samjonas@amazon.com>
Cc:     stable@vger.kernel.org, benh@amazon.com,
        Al Viro <viro@zeniv.linux.org.uk>, stable@kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 4.14] Fix double fget() in vhost_net_set_backend()
Message-ID: <2023060713-scoreless-gratitude-2177@gregkh>
References: <20230606182831.639358-1-samjonas@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606182831.639358-1-samjonas@amazon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 06, 2023 at 11:28:31AM -0700, Samuel Mendoza-Jonas wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> commit fb4554c2232e44d595920f4d5c66cf8f7d13f9bc upstream.
> 
> Descriptor table is a shared resource; two fget() on the same descriptor
> may return different struct file references.  get_tap_ptr_ring() is
> called after we'd found (and pinned) the socket we'll be using and it
> tries to find the private tun/tap data structures associated with it.
> Redoing the lookup by the same file descriptor we'd used to get the
> socket is racy - we need to same struct file.
> 
> Thanks to Jason for spotting a braino in the original variant of patch -
> I'd missed the use of fd == -1 for disabling backend, and in that case
> we can end up with sock == NULL and sock != oldsock.
> 
> Cc: stable@kernel.org
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I did not sign off on this patch, where did that come from?

Please be more careful.

thanks,

greg k-h
