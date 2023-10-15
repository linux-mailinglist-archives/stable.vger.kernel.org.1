Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A867C99A2
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 16:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJOOxv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJOOxu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 10:53:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F29C1
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 07:53:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27d129e2e7cso2729516a91.3
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697381628; x=1697986428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QeST0PLMb2ZNLVkBlW8NWrl/t5BNJXpDpuJk9M9hV8=;
        b=gFSfqOAXzLprQefixNwQKW1vOaqzLOeYe2CExbIBpNsjN0n6sy8ifqcLdc4NQ1UOWC
         I1WBhNmGVhlUKitDBVJmxQUPEE6YjOe1+VPfNwHRlMiZ5nyqcfFb7uvP523YUbK5c900
         +OCUHvUp0bNBMFAksbz/4vXcGSmIQWfN8tFvIOsC/lQM+6VvEo5KUsULgsXD1v6bsA5d
         ZRu4jR/G5cs+N9IW7Hh7oxTZWoEEkn19SqpTbOgJgZbFV+G5bi8UCSWcuOE6TJTV5KuC
         Ef1wiT5XfnNz/tZuHldz7C5IOzYgGpba3olo48GQh8NbA1rszPzgjYvNdvgkoUay6jNA
         2GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697381628; x=1697986428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QeST0PLMb2ZNLVkBlW8NWrl/t5BNJXpDpuJk9M9hV8=;
        b=bhLPgFaD35c6qBGyBhW+8vtqIc7HgDa1UOmYwo6F65PcC/sj0rnqc8138sT4KjeUkI
         aYEmH5w7QRkIb80zP21AG1a12AgkwW5+ihPttAA1Cf08coKXP3tCv6wJjK4jIxh/EIHS
         l6Rp7ZD6wEN12MDq3KWiQQWZjy3R+4U14pZf5eApZQuiDvYsEmag0pKYS7aLoVtc987A
         PAoxICMJlayc3HbJrP9DgMbTPOay4Cd583QxVrQXC4WSojDsXrEwPdQ1AqGRlJkIsBCL
         oEoIfseKCC/MGcdpNiUO54WdTnr2JJA/m6hv48ya1wLkXdGH1t1/07ACX+bfsWEAlAmA
         LHDA==
X-Gm-Message-State: AOJu0YwIXktLRR1sYOEVZsMhuuc1Xp4vbkZC91ymNl45QfdjpNI7SBLx
        /RfROC9j8mGcxfsNmJBGuwDxRtl23NzjkOnfvYc=
X-Google-Smtp-Source: AGHT+IEIOT0a5ybHGwxl+XgCIU2lssNErK/upJACr6wQD7mQA49G4NivoJig5DFqodsMF6FSrRiyq/sFEy1N/LlMrks=
X-Received: by 2002:a17:90a:3f16:b0:274:6839:6a8c with SMTP id
 l22-20020a17090a3f1600b0027468396a8cmr25891511pjc.6.1697381627589; Sun, 15
 Oct 2023 07:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231015144242.723743-1-zyytlz.wz@163.com>
In-Reply-To: <20231015144242.723743-1-zyytlz.wz@163.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sun, 15 Oct 2023 22:53:35 +0800
Message-ID: <CAJedcCxQbRrOm7gCx95GSxWBG3SOp0bS-ORHWR2n969e9wOViA@mail.gmail.com>
Subject: Re: [PATCH] media: mtk-jpeg: Fix use after free bug due to uncanceled work
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     stable@vger.kernel.org, sashal@kernel.org,
        gregkh@linuxfoundation.org, patches@lists.linux.dev,
        amergnat@baylibre.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, hverkuil-cisco@xs4all.nl
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

This patch has some mistakes in the typo. Please ignore it.

Zheng Wang <zyytlz.wz@163.com> =E4=BA=8E2023=E5=B9=B410=E6=9C=8815=E6=97=A5=
=E5=91=A8=E6=97=A5 22:44=E5=86=99=E9=81=93=EF=BC=9A
>
> This is a security bug that has been reported to google.
> It affected all platforms on chrome-os. Please apply this
> patch to 5.10.
>
> Due to the directory structure change, the file path to
> be be patched is different from that in upstream.
>
> [ Upstream commit c677d7ae83141d390d1253abebafa49c962afb52 ]
>
> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> and mtk_jpeg_enc_device_run may be called to start the
> work.
>
> If we remove the module which will call mtk_jpeg_remove
> to make cleanup, there may be a unfinished work. The
> possible sequence is as follows, which will cause a
> typical UAF bug.
>
> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
>
> CPU0                  CPU1
>
>                     |mtk_jpeg_job_timeout_work
> mtk_jpeg_remove     |
>   v4l2_m2m_release  |
>     kfree(m2m_dev); |
>                     |
>                     | v4l2_m2m_get_curr_priv
>                     |   m2m_dev->curr_ctx //use
> Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder=
 Driver")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/me=
dia/platform/mtk-jpeg/mtk_jpeg_core.c
> index ee802fc3bcdf..67c9ca4cfcd2 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> @@ -1189,6 +1189,7 @@ static int mtk_jpeg_remove(struct platform_device *=
pdev)
>  {
>         struct mtk_jpeg_dev *jpeg =3D platform_get_drvdata(pdev);
>
> +       ancel_delayed_work_sync(&jpeg->job_timeout_work);
>         pm_runtime_disable(&pdev->dev);
>         video_unregister_device(jpeg->dec_vdev);
>         video_device_release(jpeg->dec_vdev);
> --
> 2.25.1
>
