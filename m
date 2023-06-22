Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F28073978C
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 08:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjFVGmx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 02:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjFVGmu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 02:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79841BDF
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 23:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6380E6176A
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DFBC433C9;
        Thu, 22 Jun 2023 06:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687416162;
        bh=gz1qDAZ2PRiK54x4lANzhoT/1QcdXwSty+3cR/Tb4Rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHvFe5FQc8RUkTRrJalE/emk3Io15vzjeHgnCJz4P+N+eOrHOKd0bHKyepCiuAzty
         86ZyQTaY59QD/+S195Nozam11Lbh4MwCA2rtKcoV36nB/NDdSktEmkEIbmWpN3uchE
         4yxz2ygwCeQHIB/V7DMfZItLXwrKdyCZiyysAkDc=
Date:   Thu, 22 Jun 2023 08:42:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     stable@vger.kernel.org
Subject: Re: [mst@redhat.com: [PATCH v2] Revert "virtio-blk: support
 completion batching for the IRQ path"]
Message-ID: <2023062214-reprise-footrest-e8df@gregkh>
References: <20230622021540-mutt-send-email-mst@kernel.org>
 <2023062220-submarine-flagman-096a@gregkh>
 <20230622023907-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622023907-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 22, 2023 at 02:39:15AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 22, 2023 at 08:37:36AM +0200, Greg KH wrote:
> > On Thu, Jun 22, 2023 at 02:15:45AM -0400, Michael S. Tsirkin wrote:
> > > ----- Forwarded message from "Michael S. Tsirkin" <mst@redhat.com> -----
> > > 
> > > From: "Michael S. Tsirkin" <mst@redhat.com>
> > > Date: Fri, 9 Jun 2023 03:27:28 -0400
> > > To: linux-kernel@vger.kernel.org
> > > Cc: kernel test robot <lkp@intel.com>, Suwan Kim <suwan.kim027@gmail.com>, "Roberts, Martin" <martin.roberts@intel.com>, Jason Wang
> > > 	<jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo
> > > 	<xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org,
> > > 	linux-block@vger.kernel.org
> > > Subject: [PATCH v2] Revert "virtio-blk: support completion batching for the IRQ path"
> > > Message-ID: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
> > > 
> > > This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.
> > 
> > What commit id is this in Linus's tree?
> > 
> > thanks,
> > 
> > greg k-h
> 
> afd384f0dbea2229fd11159efb86a5b41051c4a9

Great, and what tree(s) do you want it applied to, just 6.3.y?

thanks,

greg k-h
