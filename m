Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777B8733257
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 15:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjFPNik (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 16 Jun 2023 09:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFPNij (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Jun 2023 09:38:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4802D76
        for <stable@vger.kernel.org>; Fri, 16 Jun 2023 06:38:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8c9cb3144so5632345e9.0
        for <stable@vger.kernel.org>; Fri, 16 Jun 2023 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686922717; x=1689514717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIWau0mr01tGhOtBWnFul5XGT0nsGLJvIp6JVr2giD8=;
        b=AXOy33pWhLcZVbrME/WeWSiKlXCw4bWZAUZ+9xJmiKedgQg4Mb/ba6BHEsO+AqLhqD
         3DktOiLhA/5KJJPPAo/CTj803YB0qPrt7on+J0VgukQlDZ0lXrxRSYiULhwW/7mC2S0h
         UiLS/VYaxEWR4bN7D+UnyavtxY3XKOa534u6aOoamuaU3Sno2Zm3oe7AQmrfT8r0mUI1
         56jalrXovUqOe61TPAW4NCTvGGidZQUJujnXurMeSSBkAFCgyjCjQ7DCeYQvWwDppU+7
         EMGlX372fVzjnaFGbxAOQO2UET10W4n4zjVLJI5itli45WYmpqunEg/WEI400ofckGIH
         MWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686922717; x=1689514717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIWau0mr01tGhOtBWnFul5XGT0nsGLJvIp6JVr2giD8=;
        b=NvEtKnyzf1zwiUoR2jP1MV12N1qqa8U3w2FBv4DpN7b1T41DzpKd7X3kqllZGwZePi
         ywy9kvacTpZKhrhuy5pCp61cpewgGvW0yQv9zU4ENCbDupa37Nlf2V2/I/mll9rAo7zi
         9UutNHmUUrA4egmWZabO8xV4vaRA+1hdP0cB2pdPYILr8dd1RGtxTZRbVZ3rRfVvs6Q7
         G3fpyg4tf+aQd2axDJp79rv1c0vOiTW3rM1nOFojh5NimTr7nL5/i4aJb2YSlNQpVbU0
         ks7DSJXVrxw0Nrfl1Wvek/hoWx4u/jpmUmMGBX0h4sLan6YWdpa5YQzyCNIMwaHOKc/y
         sjcA==
X-Gm-Message-State: AC+VfDxnSTUAqyI9qNehr9Ts4prUtDvoZ9FlsM5JyDU+HRyYFrK5SFSH
        r6vq0qa7l4oxegI6h0V9E79ZzFSJUxA=
X-Google-Smtp-Source: ACHHUZ4urvk3PUHTi1O9x9HYfKDtMqx3CABSzVCjLIvAOfH190ozDhtQ/sR0I9n8h64E7+5Db8iRTQ==
X-Received: by 2002:a7b:cb4e:0:b0:3f7:f884:7be3 with SMTP id v14-20020a7bcb4e000000b003f7f8847be3mr1768922wmj.4.1686922716514;
        Fri, 16 Jun 2023 06:38:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1d:6120:b96b:62f7:161e:e519])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b003f60a9ccd34sm2206271wmj.37.2023.06.16.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 06:38:36 -0700 (PDT)
From:   Samuel Pitoiset <samuel.pitoiset@gmail.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix clearing mappings for BOs that are always valid in VM
Date:   Fri, 16 Jun 2023 15:14:07 +0200
Message-ID: <20230616131407.170149-1-samuel.pitoiset@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616062708.15913-1-samuel.pitoiset@gmail.com>
References: <20230616062708.15913-1-samuel.pitoiset@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Per VM BOs must be marked as moved or otherwise their ranges are not
updated on use which might be necessary when the replace operation
splits mappings.

This fixes random GPU hangs when replacing sparse mappings from the
userspace, while OP_MAP/OP_UNMAP works fine because always valid BOs
are correctly handled there.

Cc: stable@vger.kernel.org
Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 143d11afe0e5..eff73c428b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1771,18 +1771,30 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 
 	/* Insert partial mapping before the range */
 	if (!list_empty(&before->list)) {
+		struct amdgpu_bo *bo = before->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(before, &vm->va);
 		if (before->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !before->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&before->bo_va->base);
 	} else {
 		kfree(before);
 	}
 
 	/* Insert partial mapping after the range */
 	if (!list_empty(&after->list)) {
+		struct amdgpu_bo *bo = after->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(after, &vm->va);
 		if (after->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !after->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&after->bo_va->base);
 	} else {
 		kfree(after);
 	}
-- 
2.41.0

