Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B7782FCE
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 20:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjHUSAO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbjHUSAN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 14:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C619F10D
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692640767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfAiUpnGDAzW8shZiXDJRH5MdVTUH7wqcu509n4TT+I=;
        b=DBZZJMmbDd8np7OFl93uPxq6rYiKbtdIaCOCO6rF1XQprDTmxOkndRyIQKXCh5LTIuvBpw
        Y50i0CPxo3KtvpivwmOBCVaJNm3+pSlOBn6s+Yeljv6Nch59wn0eoMttKZef1pe9sI7XBM
        +m72ciwX0dzvwWt1B/fNWSTkzwId/wE=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-FaCGmnfkPqe5CLZjmDkvBw-1; Mon, 21 Aug 2023 13:59:25 -0400
X-MC-Unique: FaCGmnfkPqe5CLZjmDkvBw-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7a010fdb98bso293234241.1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 10:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692640765; x=1693245565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfAiUpnGDAzW8shZiXDJRH5MdVTUH7wqcu509n4TT+I=;
        b=YiHjbuZArW2UaG/pJDKI26/+ycE9klFlhq3dKNOT5Ds/ARPqES5UYwufHteT395Gjd
         83TBfmmTfxAzoUjUH6WO1Q29Y33R0DBxHP/NbmvpjZgupuHm4ym2hUqm7MeTidxmsrDc
         AFKzz7z/rUrsxJhXtwzRHx+1gid/gtPj2+BEohhMmzuq9CRtoEw+IhGgSECx0TGC2uGT
         ZXBz43NcTXF/P4UKYmcpV1sE28mBV6XPihqUyyAvL6irNvB2z3gaT/9yYDNwBvucaLtY
         93Ua/hFqomXnUHsCSuHsKzPyomhogFEyWRNNg/LEmOKheCbz/9mXHRJOADV+b2Zb+vGl
         pJpQ==
X-Gm-Message-State: AOJu0YxSdw7Q8vmZNJxw23RCRtzAOPBfsVsgU/n/tDhAgxkuc2g3g2KH
        TaWGptuLPHIIuqnWEradttG/Hg83hE54k4rocVfpRGCtVuKyebcwYdPJz5CDpsCzLbCAWX3uVaQ
        mqmGjynN4FGyRIsVgswUBPD88x5iDnjan5UjF6dcsSnUz5GNoF2bVODhxQSD3LhOL/kBA3xRz+s
        U=
X-Received: by 2002:a05:6122:115c:b0:48d:8ba:b5d0 with SMTP id p28-20020a056122115c00b0048d08bab5d0mr2941834vko.0.1692640764960;
        Mon, 21 Aug 2023 10:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYiTVxU9E5bQozv2hA62A2/2rNgdY3LLDI6r0eTGAYWXlBfH3s9cVgv5g7z1lTMZK1XmA4Gw==
X-Received: by 2002:a05:6122:115c:b0:48d:8ba:b5d0 with SMTP id p28-20020a056122115c00b0048d08bab5d0mr2941824vko.0.1692640764588;
        Mon, 21 Aug 2023 10:59:24 -0700 (PDT)
Received: from kherbst.pingu.com (ip1f11106b.dynamic.kabel-deutschland.de. [31.17.16.107])
        by smtp.gmail.com with ESMTPSA id o19-20020ac841d3000000b004109b0f06c3sm728069qtm.36.2023.08.21.10.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 10:59:23 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     stable@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
Subject: [PATCH 6.1.y] drm/nouveau/disp: fix use-after-free in error handling of nouveau_connector_create
Date:   Mon, 21 Aug 2023 19:59:18 +0200
Message-ID: <20230821175918.639815-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023082146-oxidation-equate-185a@gregkh>
References: <2023082146-oxidation-equate-185a@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

We can't simply free the connector after calling drm_connector_init on it.
We need to clean up the drm side first.

It might not fix all regressions from commit 2b5d1c29f6c4
("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not PMGR AUX interrupts"),
but at least it fixes a memory corruption in error handling related to
that commit.

Link: https://lore.kernel.org/lkml/20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local/
Fixes: 95983aea8003 ("drm/nouveau/disp: add connector class")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230814144933.3956959-1-kherbst@redhat.com
(cherry picked from commit 1b254b791d7b7dea6e8adc887fbbd51746d8bb27)
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 49c5451cdfb16..d6dd79541f6a9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1407,8 +1407,7 @@ nouveau_connector_create(struct drm_device *dev,
 		ret = nvif_conn_ctor(&disp->disp, nv_connector->base.name, nv_connector->index,
 				     &nv_connector->conn);
 		if (ret) {
-			kfree(nv_connector);
-			return ERR_PTR(ret);
+			goto drm_conn_err;
 		}
 	}
 
@@ -1470,4 +1469,9 @@ nouveau_connector_create(struct drm_device *dev,
 
 	drm_connector_register(connector);
 	return connector;
+
+drm_conn_err:
+	drm_connector_cleanup(connector);
+	kfree(nv_connector);
+	return ERR_PTR(ret);
 }
-- 
2.41.0

