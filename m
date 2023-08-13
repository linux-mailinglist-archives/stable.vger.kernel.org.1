Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0707B77A9F0
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 18:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjHMQ17 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjHMQ16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 12:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D44170A
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 09:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADB2360C28
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 16:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6D4C433C8;
        Sun, 13 Aug 2023 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691943985;
        bh=s5dT010UIn2FJfSNfbpZQ1GBn9UlLwHEftGd4vg+tIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dhu91dYEvIvHGT0iKN69McmHh4aWRUmmzbLmpvoJ0U/pyS6LG9nHStJLzAgoAwBoH
         bGmE8oPUBKHzWlfPelaa8CW5T8yL9AXTShR+9patEuTrLsb8CkeYPfJq/2Bg6R0EqU
         DhRmd1uxF5Hvcbc0fFPXCkPh8FPzScqquqsLL/fY=
Date:   Sun, 13 Aug 2023 18:26:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     stable@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5.15.y 5.10.y 5.4.y 1/2] nvme-tcp: fix potential
 unbalanced freeze & unfreeze
Message-ID: <2023081310-playback-thirstily-c79f@gregkh>
References: <20230813144510.15401-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813144510.15401-1-sagi@grimberg.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 13, 2023 at 05:45:09PM +0300, Sagi Grimberg wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Move start_freeze into nvme_tcp_configure_io_queues(), and there is
> at least two benefits:
> 
> 1) fix unbalanced freeze and unfreeze, since re-connection work may
> fail or be broken by removal
> 
> 2) IO during error recovery can be failfast quickly because nvme fabrics
> unquiesces queues after teardown.
> 
> One side-effect is that !mpath request may timeout during connecting
> because of queue topo change, but that looks not one big deal:
> 
> 1) same problem exists with current code base
> 
> 2) compared with !mpath, mpath use case is dominant
> 
> Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

All now queued up, thanks.

greg k-h
