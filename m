Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A32A75A4DE
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 05:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGTDsX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 23:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTDsV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 23:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A531FCD
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 20:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689824856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMXP7altHm/7Mw09h91xEEpQ6/t+g4/QQ0zh+b97ssY=;
        b=XcOXPheZgm+aMcuw2wif5htJ4Z5lfhP42jfkst4iAbYBnq9gD4IPcj7fTqSf5du4nGZqM8
        NvzUoace1C2CoxVqnuhWQSCtlMhccS5LxF9WDMwVoqMH67Bd2I2PodQ5GokA3rAkqa/JqD
        SnEqjnG1YpPodWytfOSL07Z2xbtjV6s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-lhsA0NkwPrK2eIIT5CiArA-1; Wed, 19 Jul 2023 23:47:34 -0400
X-MC-Unique: lhsA0NkwPrK2eIIT5CiArA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34a0b75eso25066566b.1
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 20:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689824854; x=1690429654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMXP7altHm/7Mw09h91xEEpQ6/t+g4/QQ0zh+b97ssY=;
        b=OHuH+XgoUaIQBBZRi61S3S/j4MDNg9E8m3N9YOGcy+dJ1ZSgu9NswEVsyPup50qJwX
         zffY47wuBwFqHleLL3DFtYW6x16xfR7a4SA0jEkq+7qyO/+ZeNjnuueteTb8FKluJuXr
         Hc+elsAN+eu85H1mNHmzeFggTW4rmsDMXAupPsZpsMMcjbizhllRu2cGH/su5evRSTEi
         /GXH7xfNsXFoVL0Sec1EYR4ZFukkkPkPxT8huNmKGaC/9JTOZBSMJYNGmpF1CEz0mAgp
         G+YlPEl7LvhL559wtOyrjIkDafPyK9PHbl3VKEPiIQ9opqUSfrShYUNj4RzBcHK7NUkM
         IWrA==
X-Gm-Message-State: ABy/qLbyStRVo2Sz7GSAPgHMY89EcG/r5O/s9XnMXMrqBKqdsNa/dC5F
        gtN15pdxnL52/zjxy2fH8k8yUtceyUyObiEBfNyzspyzL9dPAj4XOQY+ighYwhClFWmCiFEaE0c
        6Unj/UJIM77hilIccJVfPTW+irtfT410n
X-Received: by 2002:a17:906:6a1b:b0:98f:ab82:8893 with SMTP id qw27-20020a1709066a1b00b0098fab828893mr4519908ejc.73.1689824853826;
        Wed, 19 Jul 2023 20:47:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlExPMicLhw4ROPl0YGM4jgV0CsdHm0gXLIT9ZqIQlTI9ZqZkKjSG8g4BWZ8FnL38i8lFvG2/u2dKwXMeCQ/iUk=
X-Received: by 2002:a17:906:6a1b:b0:98f:ab82:8893 with SMTP id
 qw27-20020a1709066a1b00b0098fab828893mr4519891ejc.73.1689824853506; Wed, 19
 Jul 2023 20:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230720033800.110717-1-xiubli@redhat.com>
In-Reply-To: <20230720033800.110717-1-xiubli@redhat.com>
From:   Venky Shankar <vshankar@redhat.com>
Date:   Thu, 20 Jul 2023 09:16:56 +0530
Message-ID: <CACPzV1=KRCH_PvaxrmWq=Q9Q6oP6XuLcHCtn3b5LNfmqjwdAmQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: disable sending metrics thoroughly when it's disabled
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        mchangir@redhat.com, stable@vger.kernel.org
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

On Thu, Jul 20, 2023 at 9:09=E2=80=AFAM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> Even the 'disable_send_metrics' is true so when the session is
> being opened it will always trigger to send the metric for the
> first time.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/metric.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
> index cce78d769f55..6d3584f16f9a 100644
> --- a/fs/ceph/metric.c
> +++ b/fs/ceph/metric.c
> @@ -216,7 +216,7 @@ static void metric_delayed_work(struct work_struct *w=
ork)
>         struct ceph_mds_client *mdsc =3D
>                 container_of(m, struct ceph_mds_client, metric);
>
> -       if (mdsc->stopping)
> +       if (mdsc->stopping || disable_send_metrics)
>                 return;
>
>         if (!m->session || !check_session_state(m->session)) {
> --
> 2.40.1
>

LGTM.

Reviewed-by: Venky Shankar <vshankar@redhat.com>

--=20
Cheers,
Venky

