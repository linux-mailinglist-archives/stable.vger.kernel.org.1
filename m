Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119FB7C98AF
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 12:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjJOKcb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOKcb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 06:32:31 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376F3AD
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 03:32:28 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7dd65052aso48119937b3.0
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 03:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697365947; x=1697970747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gQNEowOiA65pTVrY36QDnfIDvU+PkRiMRLEgKxooNo=;
        b=Jv9gkEYuZBP9cqRRBykbKKRgLshu1YrLHu1+aN30DcLiqJm0cXf36JMlRUZLMdyKPk
         aiH2rFZjuTsPGkTig3tIoLn8oixF6Pb6sYOfb5W4eezHMm4ddHIxq8RwtaofdqLXQo2n
         LTKK8Ohx2TMcDPaUMf0mP4JJXWggyQ2Qs1O94sA6dZFpm+ui6MYeFeqyHc7LGkWV9XbX
         eS7+jdIef5fB2iojGbu+qTELMTI3piidF6CTTd0c51QWegwCvBOVqbnA+NXF2FEppsoU
         tBP2ybFnHwUSPC/WmUXcAm+KQfzaHmz8DQLBHl0W8jptYfOcSLBTUCwdkPnGsr9TrgCx
         y9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697365947; x=1697970747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gQNEowOiA65pTVrY36QDnfIDvU+PkRiMRLEgKxooNo=;
        b=XpSI4AjgLKu7Sz43O62kwovELrMajBkuK9t/sVUn/TjWgayY42k4a9TCIKip66HdWW
         pnxbIXP8tlrjTlBiEWOsHLS57bvVjU0uOi6JCmk03AKzpsYB4rorT6OY5jMuTLhPSA73
         Ce22pV6wQ+lYEElHs4l4GaPaRKK08/7gUZEfCLTblDQJPJ9Kb6okQZNfhnaCDGV5qYmT
         kzSCjMu4Myb+xCH2i5WWYmru5wI1K0A8vgRGo/G97NXySiNODxswCqbmwBUGG5k/bPgn
         2wYUkfybhq8/cOeIHkjt/5fHVJDSZCT3iv6fEXVT3KVXTLe3jP8fA6spVp9lecxlgrA3
         8F1w==
X-Gm-Message-State: AOJu0YzlCqobRaE+Syp9SJnIgE6Mu2rH1oy55YzVDZfPrIQkndkQY0fb
        8YJMRs/GefAoVb3Dkn6S+TzbLYJmr7+qGriUKC0Sr7wXbctIyctb
X-Google-Smtp-Source: AGHT+IF+TgDOCsOoo05cN3P+tm6EmoIQc+ZjNPRd9L9fyFgFVozkSRxS5eWrm2Z/dHxzXEsGttaqPf9u4MIVNclH1PQ=
X-Received: by 2002:a05:690c:f0e:b0:5a8:1d0e:ca6 with SMTP id
 dc14-20020a05690c0f0e00b005a81d0e0ca6mr8599898ywb.32.1697365947253; Sun, 15
 Oct 2023 03:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231011073204.1069793-1-zyytlz.wz@163.com> <2023101214-trilogy-wildcard-29cb@gregkh>
In-Reply-To: <2023101214-trilogy-wildcard-29cb@gregkh>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sun, 15 Oct 2023 18:32:15 +0800
Message-ID: <CAJedcCyMCOT07=T=DKbYobXWGNXDZ9ccjmdCsdorm2fDoDGmng@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, stable@vger.kernel.org,
        sashal@kernel.org, patches@lists.linux.dev, amergnat@baylibre.com,
        wenst@chromium.org, angelogioacchino.delregno@collabora.com,
        hverkuil-cisco@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B410=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=BA=94 01:23=E5=86=99=E9=81=93=EF=BC=9A

>
> On Wed, Oct 11, 2023 at 03:32:04PM +0800, Zheng Wang wrote:
> > This is a security bug that has been reported to google.
> > It affected all platforms on chrome-os. Please apply this
> > patch to 4.14 4.19 5.4 5.10 and 5.15.
> >
> > [ Upstream commit c677d7ae83141d390d1253abebafa49c962afb52 ]
>
> Did you try to apply this?  The file:
>
> >  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 +
>
> Is not in the kernels you asked for this patch to be applied to.

Sorry I did't check the file. After reviewing the code, I found the
Directory Structure has been changed.
I'll write another patch for them.

Best Regards,
Zheng Wang
>
> How did you test this?
>
> confused,
>
> greg k-h
