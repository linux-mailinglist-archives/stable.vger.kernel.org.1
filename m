Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63AF75BC10
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 03:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGUB7y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 21:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGUB7w (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 21:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFBC2718
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 18:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689904750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3G0CnLasAwk7QEzGMF4ayHtEf2TKT8SrgGzAZhiKurE=;
        b=ErknKCME8q3pvu9HIvgNtSqkXzTFR7f5LKRoIGkL8QjBmmnCSDlnGMJxJHy/A0pi3MiK1z
        NhO00hgEPBrgYpNy+U6uHoRBwORTHRpiU010iIa1j8ILSFLMBX3mq086rDG2GyzBkJJiN9
        oL8+mNgLZOVP6FvB6zcyWq5N7VqmO58=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-wKmodO90O9yihXhnAFJSCA-1; Thu, 20 Jul 2023 21:59:09 -0400
X-MC-Unique: wKmodO90O9yihXhnAFJSCA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-262d8993033so743062a91.0
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 18:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689904747; x=1690509547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G0CnLasAwk7QEzGMF4ayHtEf2TKT8SrgGzAZhiKurE=;
        b=SQuDE/oJUcCe6QKjxVhkFPwoZ60PfRY5XmX//jY6yk+ZDUDdqfMnNkiIz/GGhq2Z9D
         XwKIDVMTP0jMuFSVfu1PNrnrLzAbUWAFtEEhiZWP2VGyQksP+T0zl4M2qNWQvLWiot0T
         KqHaRQAQvfizVIi1l6CzcuG529aj7rOHVsYdrzudxRK4KG+3NpcEuuJbSJQyxzdWxoUb
         YZcLgnnmRF/ldIpQ6QGJcQ3s1lFbJ9i5nf09KQl9Qx0k8CrFPskkfz/Zv+7TZXgLym98
         YxxumIBD5hWR05ZOXwRTqW8Mnh9oy0lFQ0RZZDKlEiW1Z+slEugX4ZdhaFrL4pPt+bP8
         15Dg==
X-Gm-Message-State: ABy/qLbgbC7K98Qq5A0MatsAhA2V/EwOMumbQ2KF09cYqDAjjSH7urbX
        xjAV8NdFtPG6PFhwYaXBTnQKfUCEwtCKDvESQMmyAvuwIj7I4Pduj8pFgzyKCyxCi2fd/Tbj+ar
        3wRteUg0oIaldNtn7/0ATqofuZYJcMg9evhgfmeRx1STBwwjr
X-Received: by 2002:a17:90a:4597:b0:25e:ad19:5f46 with SMTP id v23-20020a17090a459700b0025ead195f46mr326444pjg.12.1689904747489;
        Thu, 20 Jul 2023 18:59:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEud+0AU+n3F2XLQgfcj5dE+dH08i4sIC20b0RGeYemcSKy+k5eiagsibx9Wbbii3KAP1rxkdjXtTclLPSGX6M=
X-Received: by 2002:a17:90a:4597:b0:25e:ad19:5f46 with SMTP id
 v23-20020a17090a459700b0025ead195f46mr326436pjg.12.1689904747219; Thu, 20 Jul
 2023 18:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230711094041.1819102-1-ming.lei@redhat.com> <20230711094041.1819102-4-ming.lei@redhat.com>
In-Reply-To: <20230711094041.1819102-4-ming.lei@redhat.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 21 Jul 2023 09:58:55 +0800
Message-ID: <CAHj4cs_XNfe3zfErc0B+tUG-_TOPb93pnicfHM=ViLbEbXZH-g@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] nvme-rdma: fix potential unbalanced freeze & unfreeze
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Verified it with the nvme/rdma scenario, Thanks Ming
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Tue, Jul 11, 2023 at 5:41=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Move start_freeze into nvme_rdma_configure_io_queues(), and there is
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
> Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/rdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index d433b2ec07a6..337a624a537c 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -883,6 +883,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_=
rdma_ctrl *ctrl, bool new)
>                 goto out_cleanup_tagset;
>
>         if (!new) {
> +               nvme_start_freeze(&ctrl->ctrl);
>                 nvme_unquiesce_io_queues(&ctrl->ctrl);
>                 if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOU=
T)) {
>                         /*
> @@ -891,6 +892,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_=
rdma_ctrl *ctrl, bool new)
>                          * to be safe.
>                          */
>                         ret =3D -ENODEV;
> +                       nvme_unfreeze(&ctrl->ctrl);
>                         goto out_wait_freeze_timed_out;
>                 }
>                 blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
> @@ -940,7 +942,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_=
rdma_ctrl *ctrl,
>                 bool remove)
>  {
>         if (ctrl->ctrl.queue_count > 1) {
> -               nvme_start_freeze(&ctrl->ctrl);
>                 nvme_quiesce_io_queues(&ctrl->ctrl);
>                 nvme_sync_io_queues(&ctrl->ctrl);
>                 nvme_rdma_stop_io_queues(ctrl);
> --
> 2.40.1
>


--=20
Best Regards,
  Yi Zhang

