Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6F475BC0C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 03:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjGUB72 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 21:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGUB71 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 21:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9136E47
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 18:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689904722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhGna8U3AbjXTK0GfHupfBmw9y8F8MsICtVmYYEO33w=;
        b=GP4XLbt5cvl0czhwCNdUNGR7NmIAiETdcI5KdQMK9h/olGsvhZH+Jpq7yMb44Fb8qwg33y
        BWijMnDBxSW3ZgqX8a9b/AYo977EilXLjNWf8L+Tt14ducjZF+uzhKw/u3diSZDl/QXUNo
        +p4bYfb4uf6MOpb7qXPI/9IYA9DR4jI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-78sEgGxjMPGNhyLhhSeBNg-1; Thu, 20 Jul 2023 21:58:40 -0400
X-MC-Unique: 78sEgGxjMPGNhyLhhSeBNg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-262f7a3bc80so1022848a91.3
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 18:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689904719; x=1690509519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhGna8U3AbjXTK0GfHupfBmw9y8F8MsICtVmYYEO33w=;
        b=dfJu3l4n1gfZiBVNKJVlNVxJJ2Zq5kRBoTbEFAXkt6ppeHTTfivNOh0zy+jCpUmBbr
         Xv5vuWnln00cOiwENVJ35sf4m55Kl0DZP0uvw363Iyu1yrMZJpD7fm3ejmOzQNlWvXGu
         UgIaKDk4EGroJphA401cMkdnCpYT1lnOk4HKxm0/Ek+Cz/hZAyalKKdTSvCZ2quM5k4T
         YWRc4l8vA88mwu2x3k9YKC4UgcRYTZZchkTEnKopsRWbieFbVnpftRRezR9UMdHPBONJ
         2q6gWpWfXTX6QnEtTiNBbDflSVYICUUftgbjO4QFqN8dW7C9d1oQXTOIRQYq/w2wtYqM
         wV+A==
X-Gm-Message-State: ABy/qLZlFLtfPrbb50/xsEjOXjrU69tecOVpeux5CCbYWsMV43Ps7tlG
        j93JQYQzfU7KCDXVX+CtO0fS9cXYZz1ot4rfiTNYtd+F4j+X63HkHGKTgkB+orh7avNz6gVNq/o
        kNEe4xFJJzPe7bXwSNTJvac7OhSe7dz3D
X-Received: by 2002:a17:90b:4a09:b0:263:f8e3:5a2a with SMTP id kk9-20020a17090b4a0900b00263f8e35a2amr412035pjb.36.1689904719613;
        Thu, 20 Jul 2023 18:58:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHmx7gzkmzHO8hdH2sBhDw+aAQB8z1c9a31bsYownTohBa6EDZtW882rjYQyue4CMwbuhLM5a3unc3+zyFdoOE=
X-Received: by 2002:a17:90b:4a09:b0:263:f8e3:5a2a with SMTP id
 kk9-20020a17090b4a0900b00263f8e35a2amr412026pjb.36.1689904719352; Thu, 20 Jul
 2023 18:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230711094041.1819102-1-ming.lei@redhat.com> <20230711094041.1819102-3-ming.lei@redhat.com>
In-Reply-To: <20230711094041.1819102-3-ming.lei@redhat.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 21 Jul 2023 09:58:27 +0800
Message-ID: <CAHj4cs9FfHRRJSQz=SPFJuMj_u9hSL5AaN3EyTdTdXkBSiqJ3Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] nvme-tcp: fix potential unbalanced freeze & unfreeze
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

Verified it with the nvme/tcp scenario, Thanks Ming
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Tue, Jul 11, 2023 at 5:41=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
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
> Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3e7dd6f91832..fb24cd8ac46c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1868,6 +1868,7 @@ static int nvme_tcp_configure_io_queues(struct nvme=
_ctrl *ctrl, bool new)
>                 goto out_cleanup_connect_q;
>
>         if (!new) {
> +               nvme_start_freeze(ctrl);
>                 nvme_unquiesce_io_queues(ctrl);
>                 if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
>                         /*
> @@ -1876,6 +1877,7 @@ static int nvme_tcp_configure_io_queues(struct nvme=
_ctrl *ctrl, bool new)
>                          * to be safe.
>                          */
>                         ret =3D -ENODEV;
> +                       nvme_unfreeze(ctrl);
>                         goto out_wait_freeze_timed_out;
>                 }
>                 blk_mq_update_nr_hw_queues(ctrl->tagset,
> @@ -1980,7 +1982,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme=
_ctrl *ctrl,
>         if (ctrl->queue_count <=3D 1)
>                 return;
>         nvme_quiesce_admin_queue(ctrl);
> -       nvme_start_freeze(ctrl);
>         nvme_quiesce_io_queues(ctrl);
>         nvme_sync_io_queues(ctrl);
>         nvme_tcp_stop_io_queues(ctrl);
> --
> 2.40.1
>


--=20
Best Regards,
  Yi Zhang

