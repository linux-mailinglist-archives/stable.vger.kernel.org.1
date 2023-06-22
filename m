Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC423739791
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFVGob (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 02:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFVGoa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 02:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7619B4
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 23:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687416228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+FfvD9upAX2n+TrRm5cI++/eo1KhuF1ydXwZijWEroU=;
        b=cca/o/6zXDTOUKqViWDxi7EPPIMPIm3p62elwrUHpV/7M+IiWatBN/dvko9WtZAAMXT/I0
        lhHqL8XQixbzcbhh+XrhLLWVO5jtQVvRgNssppg5TrM+qX9ta4DR0hmNv/KpyrFTHB9Kph
        QVsGgundmA4Aoe9GgToEzMXM6N9VJew=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-gkqZaWqEMWmiSv838GGZpQ-1; Thu, 22 Jun 2023 02:43:46 -0400
X-MC-Unique: gkqZaWqEMWmiSv838GGZpQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a356c74e0so394770766b.2
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 23:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687416225; x=1690008225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FfvD9upAX2n+TrRm5cI++/eo1KhuF1ydXwZijWEroU=;
        b=Z8RmpXbVZjJG2x1qtT27JLNZvcET0TiO5SMmnDRqCy3KEMOnt0SrnrfbzNPepxJ2z0
         6Phj9b2NP+jC6PmLY98ThyTu2CL5XjFboiy5nE+CUl+jKMK2Ideb5ZmvsL0UZv5Etwfn
         KbRLlzxC7rFNFHzRL6JfeWtjHYX4W0OTW72UBr3eUvrb0TIXKs/XE9JjSkOMqHS4LFNi
         QcRY1hrES+OFnr3adGz7+Ihkp6kkPa5PcDzlJzZzU89ZySQ+kTro+RBmwZtcpUOka3jS
         9z31pMrd6lIfOjJcgQOzJhDAIHApPDHMcupd7QVIuGVMl6dh5OpjX9HTPFSAWdxaqLbA
         47aw==
X-Gm-Message-State: AC+VfDzlue7UJSZfcuIApPwK/jQyhnCJRDh5OX04b7IVUGoM+M+xh8X5
        xdUhpXYYVl/WeGp7H6dO9X5IVXj7eOaU7uliTT89Gzz0xv66o2QSDbAlzvbZnF3wWkAmrLp/mYQ
        zffmUBw71qzij0DHyeHMd82m0
X-Received: by 2002:a17:907:60d4:b0:988:a986:b11c with SMTP id hv20-20020a17090760d400b00988a986b11cmr8693964ejc.29.1687416225525;
        Wed, 21 Jun 2023 23:43:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lKvji4EKKkqDgYQDspApRAIe/Y+qr6ALvGu9PKpdHmbRaR9DqLfQ3vj4SLDwIcZLYkf5EbA==
X-Received: by 2002:a17:907:60d4:b0:988:a986:b11c with SMTP id hv20-20020a17090760d400b00988a986b11cmr8693954ejc.29.1687416225211;
        Wed, 21 Jun 2023 23:43:45 -0700 (PDT)
Received: from redhat.com ([2.52.159.126])
        by smtp.gmail.com with ESMTPSA id qn15-20020a170907210f00b0098ce34f0bc5sm1698987ejb.59.2023.06.21.23.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 23:43:44 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:43:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
Subject: Re: [mst@redhat.com: [PATCH v2] Revert "virtio-blk: support
 completion batching for the IRQ path"]
Message-ID: <20230622024302-mutt-send-email-mst@kernel.org>
References: <20230622021540-mutt-send-email-mst@kernel.org>
 <2023062220-submarine-flagman-096a@gregkh>
 <20230622023907-mutt-send-email-mst@kernel.org>
 <2023062214-reprise-footrest-e8df@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062214-reprise-footrest-e8df@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 22, 2023 at 08:42:39AM +0200, Greg KH wrote:
> On Thu, Jun 22, 2023 at 02:39:15AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 22, 2023 at 08:37:36AM +0200, Greg KH wrote:
> > > On Thu, Jun 22, 2023 at 02:15:45AM -0400, Michael S. Tsirkin wrote:
> > > > ----- Forwarded message from "Michael S. Tsirkin" <mst@redhat.com> -----
> > > > 
> > > > From: "Michael S. Tsirkin" <mst@redhat.com>
> > > > Date: Fri, 9 Jun 2023 03:27:28 -0400
> > > > To: linux-kernel@vger.kernel.org
> > > > Cc: kernel test robot <lkp@intel.com>, Suwan Kim <suwan.kim027@gmail.com>, "Roberts, Martin" <martin.roberts@intel.com>, Jason Wang
> > > > 	<jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo
> > > > 	<xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org,
> > > > 	linux-block@vger.kernel.org
> > > > Subject: [PATCH v2] Revert "virtio-blk: support completion batching for the IRQ path"
> > > > Message-ID: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
> > > > 
> > > > This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.
> > > 
> > > What commit id is this in Linus's tree?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > afd384f0dbea2229fd11159efb86a5b41051c4a9
> 
> Great, and what tree(s) do you want it applied to, just 6.3.y?
> 
> thanks,
> 
> greg k-h


That's the only one that has the commit we revert so yes. Thanks!

