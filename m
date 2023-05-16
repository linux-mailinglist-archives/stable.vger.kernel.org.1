Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2B70592A
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 22:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEPU73 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 16:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEPU72 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 16:59:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CAE59E0
        for <stable@vger.kernel.org>; Tue, 16 May 2023 13:59:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so8627705b3a.0
        for <stable@vger.kernel.org>; Tue, 16 May 2023 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684270767; x=1686862767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM660rXSVcN9oWH/JkR/2dCwZ/0PPpeUcJ1TWBxalsE=;
        b=qle+mMpD5mXwWmxOqRodWKMv/YfMpubGTtXVp2JF0NbGOFRBw2zJWfhe6D6GGITTi8
         7v5SLXHMup7GpcU85gunOv2mT8flrnkSru94QJE7m1KlIkE4S0MaCNFefSdExv4DQYr9
         O0PdGfKuo3yVUE0BuwIJDXWWhS915VGzAQj8npsSHOnGD7KNCdQRJbaCarXC4rmVfNsd
         NT0YJTuBegyDPWU7B9ImsVhR65V4cy7CvyZojlL7bvH7zgDk5WhVlxmVAC3wmZE9awOL
         o+exMTXltftfyIgXB8n8FTlh+zVLR9TxwJVXZcmXssRgFBjr8X/qfZWwjdyTy1bFV5/l
         oOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270767; x=1686862767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SM660rXSVcN9oWH/JkR/2dCwZ/0PPpeUcJ1TWBxalsE=;
        b=hvQC9QKdPVAr5YJmluzs965PKAlDEfHXO48NJW9rBPU5KdQzhaBMstnBcVePvQcfjP
         aGgiLsv8K0UxKVYEqcK0LklCSoJKnelBG5LBjT1Iv1KlzkK8Z1NKMeH2RVefmBDfdrTf
         F573rRixHcbeeTY8tXVZloQjYJoiBBH+JoUjzSMDG6GJHIScwDsGro787igMhFwXvNSn
         EcYvvLTrZy1N+x62aKUlo9vIz/Btl5VRmjcDIEsOHpZ97DO+Ov89zIWSVrYnOPjxVhGG
         BhIR6Nwa55MIEWtQTHVp1urlTWius4vqhpBrrECuQ70lgmlHZKxrbE51JgxnP34mfitx
         g9QA==
X-Gm-Message-State: AC+VfDzbPtSvZ9D6wB2tllaFPW6QRVJeiNDH9oUAkgh/Pi/EZ+KOtZgI
        s0HA9IoSt6glrcUBxyJBIXdkjJJGs+/j6nvQrI7fbykyIRFAT4MoQvQ=
X-Google-Smtp-Source: ACHHUZ5QkAsHl45WNADB6PJJGmiglZLzPlT8zMnVvlWVAVBBfHt0gSxR11NdcCPUNt8VdKG+KDumJRUxNyGMGXksKY0=
X-Received: by 2002:a05:6a20:3c9e:b0:104:873:c3be with SMTP id
 b30-20020a056a203c9e00b001040873c3bemr75149pzj.12.1684270766882; Tue, 16 May
 2023 13:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230426203256.237116-1-pandoh@google.com>
In-Reply-To: <20230426203256.237116-1-pandoh@google.com>
From:   Jon Pan-Doh <pandoh@google.com>
Date:   Tue, 16 May 2023 13:59:16 -0700
Message-ID: <CAMC_AXXgBoRZOaDpCex+g_YeOdPQpKD3moQ8VMsqVEm2nqSrjg@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nadav Amit <namit@vmware.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Joerg,

[Cc'ing stable@vger.kernel.org per Nadav's suggestion]

This bug fix seems to have gotten the necessary reviews (AMD and
previous commit author). Is it eligible to be applied?

Thanks,
Jon

On Wed, Apr 26, 2023 at 1:32=E2=80=AFPM Jon Pan-Doh <pandoh@google.com> wro=
te:
>
> When running on an AMD vIOMMU, we observed multiple invalidations (of
> decreasing power of 2 aligned sizes) when unmapping a single page.
>
> Domain flush takes gather bounds (end-start) as size param. However,
> gather->end is defined as the last inclusive address (start + size - 1).
> This leads to an off by 1 error.
>
> With this patch, verified that 1 invalidation occurs when unmapping a
> single page.
>
> Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM=
")
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Tested-by: Sudheer Dantuluri <dantuluris@google.com>
> Suggested-by: Gary Zibrat <gzibrat@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5a505ba5467e..da45b1ab042d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2378,7 +2378,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domai=
n *domain,
>         unsigned long flags;
>
>         spin_lock_irqsave(&dom->lock, flags);
> -       domain_flush_pages(dom, gather->start, gather->end - gather->star=
t, 1);
> +       domain_flush_pages(dom, gather->start, gather->end - gather->star=
t + 1, 1);
>         amd_iommu_domain_flush_complete(dom);
>         spin_unlock_irqrestore(&dom->lock, flags);
>  }
> --
> 2.40.0.634.g4ca3ef3211-goog
>
