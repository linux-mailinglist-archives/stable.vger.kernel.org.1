Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A9C7426A3
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjF2Mjb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 08:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjF2Mja (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 08:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F132690
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688042322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FnP9oilsoMoB7AtYJwwEtIEMgEo4MsQIn87hskKdYFs=;
        b=PCCOZX82WvYASXwOfY3AZu6nV+p1r6hbk0rERMuJmmZ9QlDlevBw9vhGDMv6geUY/xlKvB
        f1CwV/MkMv4yC5YnsCfxPQNt7uRCFh5s1A7VWYfVId0chQceoL+W9tAhjcn28xX59hkzZM
        2XrlqHgAdIEmVXyFlS21Cw4b4lbxp6g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-i1kYvDsHNy6jQXbLyGV-Dg-1; Thu, 29 Jun 2023 08:38:41 -0400
X-MC-Unique: i1kYvDsHNy6jQXbLyGV-Dg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6351121aa10so8026926d6.0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 05:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042321; x=1690634321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnP9oilsoMoB7AtYJwwEtIEMgEo4MsQIn87hskKdYFs=;
        b=dmrZhEnFZMLKry0KczLXXwypGfpt6J61SWvLGpPjiEoqR/jY3klBOJ8vFHzqZ0WDTP
         vr5SyC57NgxNWnOp0W3diTmvVrWDAET2jIvVjdn3t7pZi4rH84hXG1zToHxhKW76Zwfh
         LzZgHzPUu/DexdLakXwj3cUhAvL+ree6OIydz5MacvQ0fELCscUZtE8M3mjG9EaduCXs
         DMkVm3Zf3+2dbpeI6M4ePQKgnhg7NY7oA3xpoV1ZuohFOC8gmcC9QOcH8B5u51qKfNqC
         opAa+WwMf+XZhllHohbbLP+vlvTf15GlgU7kUX+rKX5WYptJkzNy+LPkpgLBguB+304d
         oFEw==
X-Gm-Message-State: AC+VfDzuI/tA/4Ur/JWZb2gOlpTL3VuZnFtMQv6Q9wdIiaDE0miP8u+f
        syarse2nln8be9r5PxbQFlJsUGpj1Tuwk7JDYfNfK5mWsgiggGNSgCQ1qU5KLJzru4FXwtLDzD9
        MULFnPprDMsO1zdjE2heUmtx9tMz4mPap
X-Received: by 2002:a05:6214:19c2:b0:635:c247:312a with SMTP id j2-20020a05621419c200b00635c247312amr15913309qvc.53.1688042320844;
        Thu, 29 Jun 2023 05:38:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7X6buVB0t1jTXCbD+JKRvPyhTugtLrrs5s1SZjYZaMo0ypvnQYZ9ps6BqargUT3AJwbTCZLlDQHHhL2FDjg28=
X-Received: by 2002:a05:6214:19c2:b0:635:c247:312a with SMTP id
 j2-20020a05621419c200b00635c247312amr15913291qvc.53.1688042320626; Thu, 29
 Jun 2023 05:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230629023118.267295-1-xiubli@redhat.com>
In-Reply-To: <20230629023118.267295-1-xiubli@redhat.com>
From:   Patrick Donnelly <pdonnell@redhat.com>
Date:   Thu, 29 Jun 2023 08:38:13 -0400
Message-ID: <CA+2bHPZLVSPRfRD6yis6MZR9tRv-mqkRZ2aY8jjAMgvju-5rQA@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: don't let check_caps skip sending responses for
 revoke msgs
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, mchangir@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 28, 2023 at 10:36=E2=80=AFPM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> If a client sends out a cap update dropping caps with the prior 'seq'
> just before an incoming cap revoke request, then the client may drop
> the revoke because it believes it's already released the requested
> capabilities.
>
> This causes the MDS to wait indefinitely for the client to respond
> to the revoke. It's therefore always a good idea to ack the cap
> revoke request with the bumped up 'seq'.
>
> Cc: stable@vger.kernel.org
> Link: https://tracker.ceph.com/issues/61782
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> Reviewed-by: Milind Changire <mchangir@redhat.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D

