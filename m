Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA63C7DD5DE
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 19:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376639AbjJaSNR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376632AbjJaSNQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 14:13:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9E7C9
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 11:13:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so10368563a12.2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1698775989; x=1699380789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+bea9ITYj3fJA+5jITbAwFJxHRR8ST9gfKocB/HsD0=;
        b=EMZvVnzCWRRUkxQ2KFbrmlwpIBb3uFTImWw99scyZczKIQPa1p0NQiu/qJQcQd52r8
         3bIcEO7ETyT8Phi+8I4Di1n8lgwXn32g3XhbClyaYTdtNHi+E02Lpvd7ew+WLSv+whX3
         vNm95MZSav2D8kDmRIgLmCCwxe1sZ33VY6qcWtA2YPARYOaipMH2QHE44MNspMQqRzj7
         Dgsit7Ps8YJLxWb2olOdghIo+OAPGG2Fv1joSCRXBvqLLelNmYMIKkEK+vS0cGhCpOG2
         ksc/hFUVx1ECnomcf0Zd+GyubUzkgH9BOM+sGf3uoJpdYQlkfsaBDuSNO01/3cdRz3Lx
         ZwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698775989; x=1699380789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+bea9ITYj3fJA+5jITbAwFJxHRR8ST9gfKocB/HsD0=;
        b=u+8N6oi2/1LLQmuca8Ebemfl+t4lqj7yUPm8CUfBvSmZ+FXfjouEvR7HZq0Hc0a8Zd
         7TnhcufQb4ioRRvxrWr+ZaX1i527ntfSp/3Yb/CVAmuMLIKfEjJJv++a0vv5JbfCitP+
         hMmmGA23cKfKumkL312z2Ioh+qR46lBUFlTXQLBbmTzcK21WZrUNZseA/LXlq47Wh04H
         HlypMKc/WTVRLxaHIg/ZYz93QqAhuXIdmrUPCPJeYyxPkjSNOL0N3zfY+KHpVX3uliE7
         x+G3GohbARMamSD6on9kMNjy1dyf708NVpqnF4FmS88HuZ1vvY3aR6FX/MKGSnTveHXT
         VZGw==
X-Gm-Message-State: AOJu0Yzs0lvb3GtQRgF3fnLAwfzrIf0nNvYVxA0uYGWA0paVEA+92Cu3
        yDZ1ZOzjzYXLVZDt/0JB+zZtIMyu/yWxu04tctx7tQ==
X-Google-Smtp-Source: AGHT+IHOErAN6Yr+37GaYVtwYv6CCUvnz472fiM/ktmi4ZHD8GdEwbhKFuq6ML6dHXHRBNlRuocIcZl449adkK5ZjGw=
X-Received: by 2002:aa7:d156:0:b0:533:c55f:5830 with SMTP id
 r22-20020aa7d156000000b00533c55f5830mr10614603edo.28.1698775988981; Tue, 31
 Oct 2023 11:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-sc8280xp-dpu-safe-lut-v1-1-6d485d7b428f@quicinc.com>
In-Reply-To: <20231030-sc8280xp-dpu-safe-lut-v1-1-6d485d7b428f@quicinc.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Tue, 31 Oct 2023 13:12:57 -0500
Message-ID: <CAKXuJqhrjUwhqb6SK65zAd3nfLTOm8_zfoYNKU5EMbWnPjPQ-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Add missing safe_lut_tbl in sc8280xp catalog
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 30, 2023 at 6:23=E2=80=AFPM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> During USB transfers on the SC8280XP __arm_smmu_tlb_sync() is seen to
> typically take 1-2ms to complete. As expected this results in poor
> performance, something that has been mitigated by proposing running the
> iommu in non-strict mode (boot with iommu.strict=3D0).
>
> This turns out to be related to the SAFE logic, and programming the QOS
> SAFE values in the DPU (per suggestion from Rob and Doug) reduces the
> TLB sync time to below 10us, which means significant less time spent
> with interrupts disabled and a significant boost in throughput.
>
> Fixes: 4a352c2fc15a ("drm/msm/dpu: Introduce SC8280XP")
> Cc: stable@vger.kernel.org
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Suggested-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b/d=
rivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> index 1ccd1edd693c..4c0528794e7a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> @@ -406,6 +406,7 @@ static const struct dpu_perf_cfg sc8280xp_perf_data =
=3D {
>         .min_llcc_ib =3D 0,
>         .min_dram_ib =3D 800000,
>         .danger_lut_tbl =3D {0xf, 0xffff, 0x0},
> +       .safe_lut_tbl =3D {0xfe00, 0xfe00, 0xffff},
>         .qos_lut_tbl =3D {
>                 {.nentry =3D ARRAY_SIZE(sc8180x_qos_linear),
>                 .entries =3D sc8180x_qos_linear
>
> ---
> base-commit: c503e3eec382ac708ee7adf874add37b77c5d312
> change-id: 20231030-sc8280xp-dpu-safe-lut-9769027b8452
>
> Best regards,
> --
> Bjorn Andersson <quic_bjorande@quicinc.com>
>

Tested-by: Steev Klimaszewski <steev@kali.org>
