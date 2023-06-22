Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03737739786
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 08:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjFVGkK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 02:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjFVGkJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 02:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034E132
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 23:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687415962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/wlESUVvNTZ3DwM0kXAZ8osGBx3zgkTpeY6oIhsl2k=;
        b=DABXwrc2cMXx7fRW2TvPxFbWe0D6r1cQFqMLvBhKb1D8I0FFgKijDbwFeoMm/Etehznbin
        spDLKSgJNmSJHUG9I988B3IHE8uJvow1STea10qd9SMQFkHUDXFEL4zvdiDqY76Y/xTRhn
        15UWs4YrHc7sAXTRkP4hUUBNCHx3nYY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-k8ZGRt-GOz6ExwFZ0Y4iYg-1; Thu, 22 Jun 2023 02:39:20 -0400
X-MC-Unique: k8ZGRt-GOz6ExwFZ0Y4iYg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9892f7b022eso35081366b.1
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 23:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687415959; x=1690007959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/wlESUVvNTZ3DwM0kXAZ8osGBx3zgkTpeY6oIhsl2k=;
        b=HUwBbLHB/V35ONymeY5mIfsqvxkgfJqA+j+wPbZ3qaYgoY6vSDkNWob8tsf+SxyJpD
         SAHYxdrW9H5bE6cHvEV4Ghs3BV3xb0Foy6ksZdukDRXzsumWh+oX89IfbOhsKrz4HgRk
         2B31zY2dMK/VArRR71/g/zI92v2t6Up3NoOWo8/s2lUaQ11QfJp0vVVSbof6p/yRmV3V
         Zy3+43biWarbeMHVhurib6vObxgKwKU7FP29JfzRM9j290N3kg8Tq4VLwz58Gb5Jpy5e
         Mf9vq1tu2eyJunwKX0Kk6OMuJbX91Amwq26jNaCeCFcpMDiVQ3vqXe3HrgEO1BXxcXMB
         B18Q==
X-Gm-Message-State: AC+VfDxFWzI6lV8hFy+xydttXsP1/bJ2XDVY7n5Iu2I+E0+t0hPSFRBa
        3cV6RFdoS98y9PUIodykWUNShtfcyIcQ2YKwmpxkoDzcnEw+b00927VXl0p/Q7DHFSsT8xfC6I2
        FQanmEo5RPDFb99C6z5JZde0H
X-Received: by 2002:a17:907:2d87:b0:989:3068:2dba with SMTP id gt7-20020a1709072d8700b0098930682dbamr6877672ejc.16.1687415959384;
        Wed, 21 Jun 2023 23:39:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DZEEtUBMKivkDvQLzo9+0sWPB//8tv+cJl5aV9ucs2EG+Crp4y1CT6bMmYzOJ2nU4CHBnSg==
X-Received: by 2002:a17:907:2d87:b0:989:3068:2dba with SMTP id gt7-20020a1709072d8700b0098930682dbamr6877665ejc.16.1687415959174;
        Wed, 21 Jun 2023 23:39:19 -0700 (PDT)
Received: from redhat.com ([2.52.159.126])
        by smtp.gmail.com with ESMTPSA id la18-20020a170906ad9200b009888f0bbd38sm4120308ejb.169.2023.06.21.23.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 23:39:18 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:39:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
Subject: Re: [mst@redhat.com: [PATCH v2] Revert "virtio-blk: support
 completion batching for the IRQ path"]
Message-ID: <20230622023907-mutt-send-email-mst@kernel.org>
References: <20230622021540-mutt-send-email-mst@kernel.org>
 <2023062220-submarine-flagman-096a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062220-submarine-flagman-096a@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,TRACKER_ID,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 22, 2023 at 08:37:36AM +0200, Greg KH wrote:
> On Thu, Jun 22, 2023 at 02:15:45AM -0400, Michael S. Tsirkin wrote:
> > ----- Forwarded message from "Michael S. Tsirkin" <mst@redhat.com> -----
> > 
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> > Date: Fri, 9 Jun 2023 03:27:28 -0400
> > To: linux-kernel@vger.kernel.org
> > Cc: kernel test robot <lkp@intel.com>, Suwan Kim <suwan.kim027@gmail.com>, "Roberts, Martin" <martin.roberts@intel.com>, Jason Wang
> > 	<jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo
> > 	<xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org,
> > 	linux-block@vger.kernel.org
> > Subject: [PATCH v2] Revert "virtio-blk: support completion batching for the IRQ path"
> > Message-ID: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
> > 
> > This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.
> 
> What commit id is this in Linus's tree?
> 
> thanks,
> 
> greg k-h

afd384f0dbea2229fd11159efb86a5b41051c4a9

-- 
MST

