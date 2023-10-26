Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EA37D84D3
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 16:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbjJZOeA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345311AbjJZOd7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 10:33:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3095C91
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 07:33:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32daeed7771so632800f8f.3
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698330835; x=1698935635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdJyWHkR+YOUTBjltFWZKQC5z087EIsa7mjZmUcpTIM=;
        b=mA4mdGXeWVWedy+Wg+DbC80phzI7WUI1deTmET0MHnZE0t2HOF5bbMTp0D6CbxTvi+
         Gjze19G7en/PnR43Z0gUe/800rtTOx7ciUU1sJzDnYg+C3OuxtRTe7f29WBtvgwhJ8Uo
         FiZrnFav4yD7npW/aEcCsFvmacGQ0M3sN6RwQ3UU6BZUuDwo8EMgW9zNHtnnv0t1WUjn
         ETUX2V5iiKIepDooWp7/Q7XP8VjA644OyDHONeiZx6RKfZ920H8DohDDDi6skMJUkHbY
         e3ObnZGrHq15u7k20eCW+gsefTYX+BPXJiEq2WxSeydXFhGmjVCocuq/LrZnEuWbBJt0
         lXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330835; x=1698935635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdJyWHkR+YOUTBjltFWZKQC5z087EIsa7mjZmUcpTIM=;
        b=Wf3m40wkLqy+Js+z5EAiasoM8rNySEQURLQjYs3aDFtW6OY82MJ8Uvbn2j9QWOhVOi
         tTGz4r691K1Os4gwRB/RT/5nlDemeMZSEyA0zonf83HaZtt75DkTohH1IkhKlCGwhglj
         FANaA6hIIU/5N0ZJ+Nr8CwIIexr/v+N2m1CEr+QzvGiOtwYKZ5Mr+ne9qTVgxgQN42Bn
         rt5VemkKgrYS3Z1E4EaiCfnvaPTpKxDFaqsp2f2l2pD1yqVvAd8g5v3xRQ+dZS05QCA8
         yowo+ixaLtVocJHXfhTd7iw2qOZNbTNkMcEKZfEscM+QWPfDVNL2Exzt+ZsWL1smgGnD
         e7UQ==
X-Gm-Message-State: AOJu0Yx28HpnE5KsPb2km2YUy38AWtB9vC3Guc0wTnNb2wo5eg0svgDO
        aQffuZTWzYVkx8Qtgd9oU07jq/7TjRHbEVSK3xs=
X-Google-Smtp-Source: AGHT+IFE8MZGeVASEplQBzpAVayuF8bdX3w4Zb4uluFPxLUIJ37qxiDiq5EIA3ylFQSbI2qlpnJtIE2dP/zbDp+gRtk=
X-Received: by 2002:a5d:4483:0:b0:319:8a66:f695 with SMTP id
 j3-20020a5d4483000000b003198a66f695mr14810308wrq.55.1698330835333; Thu, 26
 Oct 2023 07:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp>
 <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com> <20231013154708.GA17455@lst.de>
 <CA+1E3rKaUW0YN+bphe9n26ZRTX1rq6M0z7Hpc=zLOJE1AER9hw@mail.gmail.com> <20231016054647.GA26170@lst.de>
In-Reply-To: <20231016054647.GA26170@lst.de>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Thu, 26 Oct 2023 20:03:30 +0530
Message-ID: <CA+1E3rKcN=bOw3613XWKm_NqPS=dGOz43g4zwwQG_pRQSWkH_w@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        Keith Busch <kbusch@kernel.org>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 11:16=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Mon, Oct 16, 2023 at 12:49:45AM +0530, Kanchan Joshi wrote:
> > OTOH, this patch implemented a software-only way out. There are some
> > checks, but someone (either SW or HW) has to do those to keep things
> > right.
>
> It only verifies it to the read/write family of commands by
> interpreting these commands.  It still leaves a wide hole for any
> other command.

Can you please explain for what command do you see the hole? I am
trying to see if it is really impossible to fix this hole for good.

We only need to check for specific io commands of the NVM/ZNS command
set that can do extra DMA.
Along the same lines, disallowing KV does not seem necessary either.
For admin commands, we allow only very few, and for those this hole
does not exist.
