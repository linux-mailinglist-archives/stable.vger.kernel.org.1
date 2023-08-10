Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4C37776A9
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 13:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjHJLQL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 07:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjHJLQL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 07:16:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FBD26BD
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 04:15:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso11750881fa.3
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691666148; x=1692270948;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cC+LXUiYC58zzcubzCZtUERtYtEd9dOgwmivIxJQNMw=;
        b=d6z/M/dVtyWLcck32LHscjnJVsPgOoDMTTIyZlBTYPBPYrAA3P9Za7bCPEUAL8GpVj
         CVoE3j4HbJwUtNxlm1YmlqeYlUUu0kUwlbCpxib5NdXLYzLGKHzd22Ne6cO7nNlm0wUZ
         S/1ueAWgcAkkqXUS6Eq3o2+sdtDFLVga0TqcQQIi0fJqrozfqlB/l6DZVTdo/tZ93IgQ
         zeRwhTAOJBESj3gR6gVuUI/MHJgSg+0InX476e6lBIw7y1sTA33S3eFsnOGSUeV0cBnK
         dPZaIaZxVkXIxIKYnInBUfkJNZBoQ5SHBcW8ERHAC16kUKBstN+odoUzeZaHnojM4X2i
         gkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666148; x=1692270948;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cC+LXUiYC58zzcubzCZtUERtYtEd9dOgwmivIxJQNMw=;
        b=lzKFsntzDRiA9zE4S/uWTpu7VsZc+aUbR6Xi6RM4rdTu4EU/9TYv9CduXB8S9oH12q
         U4041Zb9/xqLtteI0uV67JosO4zr+gTd7Wx8KtqX2yPCtp4WOmX8FvOMxnX4sr8TImdl
         9DYY3WRKn0Vm9wgy4Y8aNcfj9k1kGwiNpD966B+OXSGqGhSJI1nwsHn74zk8HeqGaPWQ
         9ngGS6vt9OyxtAZ7x+qalv3nnAVSM8b02gbtGRWHLsesqTkVS2rQroa0IABBOTv7usd0
         JXlvftQwwAv35AUwW9FRZNMzDnWEgVXXJviq5ha4Z8kHjCWwgZOrn1JMrJRzQPmYSqnL
         WZag==
X-Gm-Message-State: AOJu0YwOXegDEsmx7szDPukjDWANjxlTlnWc/wERUpAwAptHqt/epSJD
        TV/iZ/ZLdr4rdsEBx7kP4eXi3O/7ImGMUpA/oRo=
X-Received: by 2002:a2e:9dd0:0:b0:2b6:e651:8591 with SMTP id
 x16-20020a2e9dd0000000b002b6e6518591mt1184104ljj.37.1691666147455; Thu, 10
 Aug 2023 04:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230810110405.25558-1-yin31149@gmail.com>
In-Reply-To: <20230810110405.25558-1-yin31149@gmail.com>
From:   Hawkins Jiawei <yin31149@gmail.com>
Date:   Thu, 10 Aug 2023 19:15:35 +0800
Message-ID: <CAKrof1NrDq7WoFSMXt0_XuAOBKBSwdKusmSG3Vrr4yNUuPW5tA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Zero max_tx_vq field for
 VIRTIO_NET_CTRL_MQ_HASH_CONFIG case
Cc:     eperezma@redhat.com, 18801353760@163.com,
        Andrew Melnychenko <andrew@daynix.com>, stable@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023/8/10 19:04, Hawkins Jiawei wrote:
> Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
> for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.
>
> According to the VirtIO standard, "Field reserved MUST contain zeroes.
> It is defined to make the structure to match the layout of
> virtio_net_rss_config structure, defined in 5.1.6.5.7.".
>
> Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
> field in struct virtio_net_ctrl_rss, which corresponds to the
> `reserved` field in struct virtio_net_hash_config, is not zeroed,
> thereby violating the VirtIO standard.
>
> This patch solves this problem by zeroing this field in
> virtnet_init_default_rss().
>
> Cc: Andrew Melnychenko <andrew@daynix.com>
> Cc: stable@vger.kernel.org
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Sorry for missing the ChangeLog here.

v2:
   - Add the missing tags, no code changes.

v1: https://lore.kernel.org/all/20230810031557.135557-1-yin31149@gmail.com/

Thanks!


>   drivers/net/virtio_net.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..8db38634ae82 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2761,7 +2761,7 @@ static void virtnet_init_default_rss(struct virtnet=
_info *vi)
>               vi->ctrl->rss.indirection_table[i] =3D indir_val;
>       }
>
> -     vi->ctrl->rss.max_tx_vq =3D vi->curr_queue_pairs;
> +     vi->ctrl->rss.max_tx_vq =3D vi->has_rss ? vi->curr_queue_pairs : 0;
>       vi->ctrl->rss.hash_key_length =3D vi->rss_key_size;
>
>       netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
