Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADE777A9D0
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 18:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjHMQWX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 12:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjHMQV7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 12:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8827635A6;
        Sun, 13 Aug 2023 09:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B27E6261F;
        Sun, 13 Aug 2023 16:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283B6C433C7;
        Sun, 13 Aug 2023 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691943624;
        bh=dJ7XBmGnv2/PcRCYhHJN7W1RC4U/fGPA1xnxq7FEMpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQXwkPCJzTWOg5dgbc3v4v4FKLwf+oFiM73pm6cy34jb9hC5EP826hxkb4MtzFmcC
         kMPwYb46ml/8zt/z8n/bw5kOAqiCHpN9uI9VTnpxPo5sEKP/1FJ1aYJ1LRTQzxcpq9
         uGWJgsyDKdg1eVq/nH/WzHwdvR9fHmPdZ4o9YcK8=
Date:   Sun, 13 Aug 2023 18:20:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     stable@vger.kernel.org, kuba@kernel.org, vladbu@nvidia.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "vlan: Fix VLAN 0 memory leak" has been added to the
 6.4-stable tree
Message-ID: <2023081310-flame-pushup-a252@gregkh>
References: <2023081245-ebony-gladly-b428@gregkh>
 <ZNiK6AVGEZX6Y04c@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNiK6AVGEZX6Y04c@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 13, 2023 at 10:48:56AM +0300, Ido Schimmel wrote:
> + stable
> 
> On Sat, Aug 12, 2023 at 08:02:46PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     vlan: Fix VLAN 0 memory leak
> > 
> > to the 6.4-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      vlan-fix-vlan-0-memory-leak.patch
> > and it can be found in the queue-6.4 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please do not add the patch to the stable tree. A problem was found and
> a revert was posted:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230811154523.1877590-1-vladbu@nvidia.com/
> 
> In addition to 6.4, please do not apply to: 6.1, 5.15, 5.10, 5.4, 4.19,
> 4.14

Now dropped from everywhere, thanks.

greg k-h
