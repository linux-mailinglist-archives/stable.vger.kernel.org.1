Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF62A74CA23
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 05:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGJDD3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 23:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGJDD2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 23:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA6FF4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 20:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688958158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZdypXFkBjoBC9AdVCThdk80K7RU0xQwH/gJH94hZBE=;
        b=DoFZilPyREQEYSWHzVg6V6t+xf+VQpDP6sDbGpTn5W+qzfBG2Ield7FMhWjj9+Ue0uzz47
        4xneGs71f9JfcBnvXXtlAxAV0IIHYwVWgTRnLse5aaj+onbnyBIWRSFu8xIrVJV1tw0drl
        QYnyjNS0a/ULZPvHuQn2ULNNq2+oy/w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-Gq7u1Sm_NBKNVRcYvxzP4g-1; Sun, 09 Jul 2023 23:02:35 -0400
X-MC-Unique: Gq7u1Sm_NBKNVRcYvxzP4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB8F21C07243;
        Mon, 10 Jul 2023 03:02:34 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B605C200A7CA;
        Mon, 10 Jul 2023 03:02:30 +0000 (UTC)
Date:   Mon, 10 Jul 2023 11:02:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Message-ID: <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 09, 2023 at 10:38:29AM +0300, Sagi Grimberg wrote:
> 
> > > namespace's request queue is frozen and quiesced during error recovering,
> > > writeback IO is blocked in bio_queue_enter(), so fsync_bdev() <-
> > > del_gendisk()
> > > can't move on, and causes IO hang. Removal could be from sysfs, hard
> > > unplug or error handling.
> > > 
> > > Fix this kind of issue by marking controller as DEAD if removal breaks
> > > error recovery.
> > > 
> > > This ways is reasonable too, because controller can't be recovered any
> > > more after being removed.
> > 
> > This looks fine to me Ming,
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > 
> > 
> > I still want your patches for tcp/rdma that move the freeze.
> > If you are not planning to send them, I swear I will :)
> 
> Ming, can you please send the tcp/rdma patches that move the
> freeze? As I said before, it addresses an existing issue with
> requests unnecessarily blocked on a frozen queue instead of
> failing over.

Any chance to fix the current issue in one easy(backportable) way[1] first?

All previous discussions on delay freeze[2] are generic, which apply on all
nvme drivers, not mention this error handling difference causes extra maintain
burden. I still suggest to convert all drivers in same way, and will work
along the approach[1] aiming for v6.6.


[1] https://lore.kernel.org/linux-nvme/20230629064818.2070586-1-ming.lei@redhat.com/
[2] https://lore.kernel.org/linux-block/5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me/T/#mfc96266b63eec3e4154f6843be72e5186a4055dc

Thanks,
Ming

