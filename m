Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ABF733335
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 16:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244717AbjFPOME (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 16 Jun 2023 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjFPOMD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Jun 2023 10:12:03 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AF41BF8
        for <stable@vger.kernel.org>; Fri, 16 Jun 2023 07:12:02 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-38c35975545so624553b6e.1
        for <stable@vger.kernel.org>; Fri, 16 Jun 2023 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686924722; x=1689516722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZR8l87uxMTn24HKBJkRWEV1gNPPBQJxvGEngYiN4xkQ=;
        b=j5WOs6Ftj3JBiMEpAfWucV9BkxMbsAsHbfb/l4V8+uuD51kAZDiU5t9DOOKK3gIUdK
         z9T5+6pWqpRNpHx89X123mOstQwn8SvXyIWxcRtb37fzf5RQnxMqLPqN/wCMf9oe+dmp
         iGU57FwGUdCtpT2+tLzrqq3Iz9+gnZYoLyPziEk/k1Hhc3UbDoboIi6Tnwjti2rLP5bT
         f0A66MNudWL5BGLCPp3QmxDS8nTprmANOSnj4ClSTXybkFimf+gdma/1onkcQThsbAtX
         febgJqw5hpeT4XLhqWhio+OnMSspZt6yEm4qlxsfu6ZJPBH3PE3VzK1ayp9e8U467lEA
         cAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686924722; x=1689516722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZR8l87uxMTn24HKBJkRWEV1gNPPBQJxvGEngYiN4xkQ=;
        b=PyWK9YjaNQRgp3aqWpAQapWFUdsSeDykSYYxKE2quc3Q+TEj3DNljFGC0PLOGQPVWQ
         ej6HEC7hdCrZT/aFqJ09aRPjg8AWSF8/Y81SkDwqgwX149n73Jp0xJ41eSMae4O0/AAU
         1twGpQpkkQ5TWzdH7amFjnM9mgiGmDuQyAdeLBPuTdl6z8zftdw3LMtKf4oMeN+w7Hl1
         7aOap/oFSEiKXNweoCzmGjSDebv+BCmMilZxfldxfi3EQHmWSar3lxIgxHmDzw2fW3Pu
         PXVTE0+ag0f2TTDVC7ViVcM8TABcrKuFkX1rc01qY8nEGLp0FFNUvEwn1b2y4DbGglwc
         PGJw==
X-Gm-Message-State: AC+VfDw0yqaJDsrWz1Rv/1+4Pz+0601h+rXGwRD2YjNNpwn3fOD/Te6X
        Vz1PDswzPbTVunQypTg1Drw4DVhnQ+9OLqrEWCh+3iyn
X-Google-Smtp-Source: ACHHUZ7S7UcTqzYA4X92kgh1zTF0zzUpPOtfVou4EAWc1BUBVzWSXBetXuQNVekQXln0eh+Olb1I2/5nGt05X9ocfS4=
X-Received: by 2002:a05:6808:2394:b0:39e:78ae:1d2c with SMTP id
 bp20-20020a056808239400b0039e78ae1d2cmr2519162oib.58.1686924721691; Fri, 16
 Jun 2023 07:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230616062708.15913-1-samuel.pitoiset@gmail.com> <20230616131407.170149-1-samuel.pitoiset@gmail.com>
In-Reply-To: <20230616131407.170149-1-samuel.pitoiset@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 16 Jun 2023 10:11:50 -0400
Message-ID: <CADnq5_MxYHW8-LYvm2KevPQaiQGh=Yzq1QO7ejc7hwzjeZXW9Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix clearing mappings for BOs that are
 always valid in VM
To:     Samuel Pitoiset <samuel.pitoiset@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Jun 16, 2023 at 9:38=E2=80=AFAM Samuel Pitoiset
<samuel.pitoiset@gmail.com> wrote:
>
> Per VM BOs must be marked as moved or otherwise their ranges are not
> updated on use which might be necessary when the replace operation
> splits mappings.
>
> This fixes random GPU hangs when replacing sparse mappings from the
> userspace, while OP_MAP/OP_UNMAP works fine because always valid BOs
> are correctly handled there.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 143d11afe0e5..eff73c428b12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1771,18 +1771,30 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_dev=
ice *adev,
>
>         /* Insert partial mapping before the range */
>         if (!list_empty(&before->list)) {
> +               struct amdgpu_bo *bo =3D before->bo_va->base.bo;
> +
>                 amdgpu_vm_it_insert(before, &vm->va);
>                 if (before->flags & AMDGPU_PTE_PRT)
>                         amdgpu_vm_prt_get(adev);
> +
> +               if (bo && bo->tbo.base.resv =3D=3D vm->root.bo->tbo.base.=
resv &&
> +                   !before->bo_va->base.moved)
> +                       amdgpu_vm_bo_moved(&before->bo_va->base);
>         } else {
>                 kfree(before);
>         }
>
>         /* Insert partial mapping after the range */
>         if (!list_empty(&after->list)) {
> +               struct amdgpu_bo *bo =3D after->bo_va->base.bo;
> +
>                 amdgpu_vm_it_insert(after, &vm->va);
>                 if (after->flags & AMDGPU_PTE_PRT)
>                         amdgpu_vm_prt_get(adev);
> +
> +               if (bo && bo->tbo.base.resv =3D=3D vm->root.bo->tbo.base.=
resv &&
> +                   !after->bo_va->base.moved)
> +                       amdgpu_vm_bo_moved(&after->bo_va->base);
>         } else {
>                 kfree(after);
>         }
> --
> 2.41.0
>
