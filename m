Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E584B7C524F
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 13:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjJKLm3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 07:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJKLm2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 07:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E418F
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697024502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8NURkiBAbS6tTinRtwOYWNtz0h6Ztp9Eip3YWpE10Qw=;
        b=hOhsWj2UJGXAa8xc/AbVDHgtCTo+ai5J1hPgnth5hNOvaWRs576Z2/wZ6gIIiPr8/GJaGD
        UAWOcF+lMa2tfFu//51CTc5ZAProKv2Cb1HMGLsN+udxmgvQSGAjesFRTZTohZenp1uWEx
        L9+cehk0BZpS1OdbIfAcd/kWfjh8vus=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-qqYBb2EvOaS8kyBgrNk3mg-1; Wed, 11 Oct 2023 07:41:40 -0400
X-MC-Unique: qqYBb2EvOaS8kyBgrNk3mg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4194e7f41e1so14235021cf.0
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 04:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697024500; x=1697629300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NURkiBAbS6tTinRtwOYWNtz0h6Ztp9Eip3YWpE10Qw=;
        b=iuElemwYgv1KogPTp32KXsH+FsB8pE3KhBRmIAqFMgLuK+y7JQA6jYJ4BVB4Ot0qRo
         7WWFge112NDfXnPVLODQPAGbx5XYwbAdqIWXOMIB+5k0+HqctK9N+pX/v5t35nULQrrA
         6q3tg2oYr3YTxYQ9gKE0iIPQMr++KrVNeLGyIICerBMTw2PdniE6y8YvGmIvUu1rLeWk
         UR8/nfM8cpsI7IIyBUl1SgwHimAOhK+XhNfxRIBZQUiKCwCmDfBEt91zRknLmHZHXXIi
         I5WyBVXf/2ZtwJA//sWwZMB3jI8PbjhtyYhqPhQ2M2zeEX+VIahMJXsmEFjP0KfqV7oP
         E37w==
X-Gm-Message-State: AOJu0YwruY/si3fHfvyfSVY+UWU2kcVdniqqsjkEDrAZMVy201Rfy7YD
        dVRCVGv/cfzldpwQ1MXFU0whFXddnY/S5qob+Kj+tYAAZBN51SZTNvoT4NQ6ttApAIiyuXi7/7k
        Qg7TJ1EbeCkg7HS6h
X-Received: by 2002:a05:6214:c6a:b0:65a:fd40:b79 with SMTP id t10-20020a0562140c6a00b0065afd400b79mr23067465qvj.5.1697024500012;
        Wed, 11 Oct 2023 04:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/PJFqEzyZ8u0zaKxnpGRj7gcP1T2JeVyTubg38E45fbagYfNnX/UGlmnBkSjQ63uUN62XNg==
X-Received: by 2002:a05:6214:c6a:b0:65a:fd40:b79 with SMTP id t10-20020a0562140c6a00b0065afd400b79mr23067452qvj.5.1697024499781;
        Wed, 11 Oct 2023 04:41:39 -0700 (PDT)
Received: from kherbst.pingu.com ([178.24.169.250])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a136100b00774309d3e89sm5153179qkl.7.2023.10.11.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:41:38 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/disp: fix DP capable DSM connectors
Date:   Wed, 11 Oct 2023 13:41:34 +0200
Message-ID: <20231011114134.861818-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Just special case DP DSM connectors until we properly figure out how to
deal with this.

This resolves user regressions on GPUs with such connectors without
reverting the original fix.

Cc: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org # 6.4+
Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/255
Fixes: 2b5d1c29f6c4 ("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not PMGR AUX interrupts")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
index 46b057fe1412e..3249e5c1c8930 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
@@ -62,6 +62,18 @@ nvkm_uconn_uevent_gpio(struct nvkm_object *object, u64 token, u32 bits)
 	return object->client->event(token, &args, sizeof(args.v0));
 }
 
+static bool
+nvkm_connector_is_dp_dms(u8 type)
+{
+	switch (type) {
+	case DCB_CONNECTOR_DMS59_DP0:
+	case DCB_CONNECTOR_DMS59_DP1:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int
 nvkm_uconn_uevent(struct nvkm_object *object, void *argv, u32 argc, struct nvkm_uevent *uevent)
 {
@@ -101,7 +113,7 @@ nvkm_uconn_uevent(struct nvkm_object *object, void *argv, u32 argc, struct nvkm_
 	if (args->v0.types & NVIF_CONN_EVENT_V0_UNPLUG) bits |= NVKM_GPIO_LO;
 	if (args->v0.types & NVIF_CONN_EVENT_V0_IRQ) {
 		/* TODO: support DP IRQ on ANX9805 and remove this hack. */
-		if (!outp->info.location)
+		if (!outp->info.location && !nvkm_connector_is_dp_dms(conn->info.type))
 			return -EINVAL;
 	}
 
-- 
2.41.0

