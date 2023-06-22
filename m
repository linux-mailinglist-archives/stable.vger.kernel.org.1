Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A672739783
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 08:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjFVGhm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 02:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVGhl (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 02:37:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9359132
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 23:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB8861772
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E32C433C8;
        Thu, 22 Jun 2023 06:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687415859;
        bh=0+KP5+9JfkIls6sPbMY5kzZY2RUh9etqor33XKCnnOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyKuD/UgEd40r68RS7l8Cxp3zz3mF/tsgNrgPmXrniGHXrshBzBJhegHpnj98lK5n
         kJeOi/VJf+VAWqOko4wB3yKStLleQrO4BsEFbalZ6Ag3r1WX3YGPZMpL6f0LUnl98q
         lgjiJ+NSVx61/SG15AQ1pmpzQEcxjGYPILP4Aadk=
Date:   Thu, 22 Jun 2023 08:37:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     stable@vger.kernel.org
Subject: Re: [mst@redhat.com: [PATCH v2] Revert "virtio-blk: support
 completion batching for the IRQ path"]
Message-ID: <2023062220-submarine-flagman-096a@gregkh>
References: <20230622021540-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622021540-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 22, 2023 at 02:15:45AM -0400, Michael S. Tsirkin wrote:
> ----- Forwarded message from "Michael S. Tsirkin" <mst@redhat.com> -----
> 
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Fri, 9 Jun 2023 03:27:28 -0400
> To: linux-kernel@vger.kernel.org
> Cc: kernel test robot <lkp@intel.com>, Suwan Kim <suwan.kim027@gmail.com>, "Roberts, Martin" <martin.roberts@intel.com>, Jason Wang
> 	<jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo
> 	<xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org,
> 	linux-block@vger.kernel.org
> Subject: [PATCH v2] Revert "virtio-blk: support completion batching for the IRQ path"
> Message-ID: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
> 
> This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.

What commit id is this in Linus's tree?

thanks,

greg k-h
