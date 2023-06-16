Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185A57327E1
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 08:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjFPGvz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 16 Jun 2023 02:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjFPGvy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Jun 2023 02:51:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F271FD4
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 23:51:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso2230645e9.3
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 23:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686898312; x=1689490312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lF8j2yuMAm7EbfaCMU0ysPlzaZKdK03OP3QqXiTw+vQ=;
        b=GK7uRYOvyFWouRnsQD+Vex/lFl+l+Wf6/pV26pCGCoLsBj2MRKtEwl3qiSCaze4Ers
         Gcl7VxyMx8idEcRZuquhsEKv+nMYu64XpUESq0i4rsbN+UDS8PcXja5U1uTjkml6Zban
         tcpCIAmeVez8IvCGUaD2Bt3XsJ0t+U3n4qPY6qWfyf314HtnSQQHtFBiWkG5u+hvsccb
         P8L9krMNQeHdP71iJKRS5CYoqa3FC66d2KGhSA3sBAmbKj5bkWjUXYB8t8DaGOUUOIuI
         HrWHfx0M49zEhWkrTn9Fb1r3MiVwYVQzf7351HG5LgpPYSGAgt454/FxOFR3X8GBDuNn
         y8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686898312; x=1689490312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lF8j2yuMAm7EbfaCMU0ysPlzaZKdK03OP3QqXiTw+vQ=;
        b=kzn0nHJbhiSi5uS/58bBvW+2jZqotfXD+Q/wIrOviubD3FZPsdaTw3PcqLFNXtVFdM
         qKRYY8SO4IXL2sOOSxoamJUzI7ytbJ4b4Vdf05W5iU9tVBitqJylX1vgslp55RPSMqBU
         7Gmf5OzyBDcJq0gXL/QlqtQLdddfqxuBeevlHKVM5b9qQXkIL2xQ/swJsVtUr/hE3yIx
         aFyKBJ4wTALmfdHP1tFy8oBtTBReoA85dMnG8YmkKsU9j3f1S5WA0aMt3VqZcSnaQdPh
         tX929+f0t5FP/UvnUu5tSVYIcDH/GgRbiXh3aF0LzFCtj6QOk8K2s58UmXuKZSBQrQs2
         lNAQ==
X-Gm-Message-State: AC+VfDwUgjf8RgAi9OFTnmzGtS7rWMQhsFICADor66F40PvY3Hd4gCBA
        5r/gtPsswrR1j3ES/JU7W48=
X-Google-Smtp-Source: ACHHUZ5sKJPSWCHaSWRNkJuOi1jmoCEhXeb6ECkkP9dTpyJDQ68N9qF/b+9dbjaMWPRPN8gJi6qNKg==
X-Received: by 2002:a5d:568a:0:b0:311:1497:a002 with SMTP id f10-20020a5d568a000000b003111497a002mr541143wrv.3.1686898311670;
        Thu, 15 Jun 2023 23:51:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1d:6120:b96b:62f7:161e:e519])
        by smtp.gmail.com with ESMTPSA id v18-20020adfebd2000000b0030789698eebsm22745674wrn.89.2023.06.15.23.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 23:51:51 -0700 (PDT)
From:   Samuel Pitoiset <samuel.pitoiset@gmail.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Samuel Pitoiset <samuel.pitoiset@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix clearing mappings for BOs that are always valid in VM
Date:   Fri, 16 Jun 2023 08:27:08 +0200
Message-ID: <20230616062708.15913-1-samuel.pitoiset@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

If the BO has been moved the PT should be updated, otherwise the VAs
might point to invalid PT.

This fixes random GPU hangs when replacing sparse mappings from the
userspace, while OP_MAP/OP_UNMAP works fine because always valid BOs
are correctly handled there.

Cc: stable@vger.kernel.org
Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
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

