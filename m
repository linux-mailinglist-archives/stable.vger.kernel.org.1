Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEEC7DFE10
	for <lists+stable@lfdr.de>; Fri,  3 Nov 2023 03:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjKCCmr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 22:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjKCCmq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 22:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D9C19E
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 19:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698979316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ny2ZFzxeENDJSTZ9wCuQplKwvwWNLKdmgqeowZjx4K4=;
        b=f715odRS+4t7+GIVV0Go+ZC3+jSo4cBcSAIId+4h8kuS4it7zgw0iIW9a+PRFwUf1f4Ch/
        4FESHLoeqLeM6v3B/NNcu7KgytOzpl1r//xpVAtDLWO+apUAuVJSQtb0xrOQsKK7th9fff
        CozPD34hKVKgy7S+8vmKegCLVU70D1g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-hUUAZjvKPLmnI5dfV-086Q-1; Thu, 02 Nov 2023 22:41:54 -0400
X-MC-Unique: hUUAZjvKPLmnI5dfV-086Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ba247e03aeso112312466b.1
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 19:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698979313; x=1699584113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny2ZFzxeENDJSTZ9wCuQplKwvwWNLKdmgqeowZjx4K4=;
        b=Y5O10R0vIVtMOqi2ZNLPUXQktKVDUHlN0sZpoIua6Bu6feWp0AYleOteCDJmYtB46W
         xQORS43T5nSG3xPuvFNMWNyCEp36Mew+aVKsdz/6/e65F9OdI1F78EbwDkLtoFbC+L9u
         IariZTs/rzStfKUxHYxHUzwQ+ZNk+LzM42Y+GvA20CPiupR4wgWPFH30QuoWD+kLPyKm
         8Sc+4a+68g9cMwRBzQnnLxVat53wHEDLASAUtAW8jZd6fC6+isIdCmg9rJXHdnhlg8Gh
         hhLdR08fnKH7RvWXPTGAhiGWGtwsOVILlmjOM26UrKKc+ABVU+TNStP7+U7RWRr7IrUb
         DMVg==
X-Gm-Message-State: AOJu0Yw5CttZHzs2K5giI1oQHwc+WLlp4GxHieAQsdUMHKxW4kvlWbzJ
        NLG7Q0tLFTPiFDTjtyGusxagp6yukcZlhgVCXNNTSYbo5dM/qsts/bcgNwWfKD9dHBGwlxDQr+g
        OINM+e6zX1p2WVKyG
X-Received: by 2002:a17:907:2d28:b0:9bf:697b:8f44 with SMTP id gs40-20020a1709072d2800b009bf697b8f44mr6733368ejc.6.1698979313485;
        Thu, 02 Nov 2023 19:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj8ItR6ARgpxLWW8ZXsFRD1AjDYC8gptOiYDscDMcYxWPb9yjdvJ+NcwTXCgSU6cBODiLLHQ==
X-Received: by 2002:a17:907:2d28:b0:9bf:697b:8f44 with SMTP id gs40-20020a1709072d2800b009bf697b8f44mr6733360ejc.6.1698979313220;
        Thu, 02 Nov 2023 19:41:53 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id o18-20020a1709061b1200b009b8a4f9f20esm366691ejg.102.2023.11.02.19.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 19:41:52 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     nouveau@lists.freedesktop.org, faith@gfxstrand.net
Cc:     lyude@redhat.com, kherbst@redhat.com, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/gr/gf100-: unlock mutex failing to create golden context
Date:   Fri,  3 Nov 2023 03:41:06 +0100
Message-ID: <20231103024119.15031-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Do not return from gf100_gr_chan_new() with fecs mutex held when failing
to create the golden context image.

Cc: <stable@vger.kernel.org> # v6.2+
Fixes: ca081fff6ecc ("drm/nouveau/gr/gf100-: generate golden context during first object alloc")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index c494a1ff2d57..f72d3aa33442 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -442,6 +442,7 @@ gf100_gr_chan_new(struct nvkm_gr *base, struct nvkm_chan *fifoch,
 	if (gr->data == NULL) {
 		ret = gf100_grctx_generate(gr, chan, fifoch->inst);
 		if (ret) {
+			mutex_unlock(&gr->fecs.mutex);
 			nvkm_error(&base->engine.subdev, "failed to construct context\n");
 			return ret;
 		}
-- 
2.41.0

