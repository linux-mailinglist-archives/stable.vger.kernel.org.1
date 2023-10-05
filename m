Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137727BA000
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjJEOcU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjJEOao (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 10:30:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D72D1F75E
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 03:00:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so732917f8f.3
        for <stable@vger.kernel.org>; Thu, 05 Oct 2023 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696499999; x=1697104799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1WI9TvkImQF/fqcaq6kEtU5fMxAStOtaMB/ec/9aZU=;
        b=OoUik6cKKQH5wO8KVjFqy7E5L4Y7PGH6SZwccEQ8sCClg+25gStsiV2sFIWYJUW0/i
         XgUXmO1sEkUMqbfa8HtRvne9vsOSOi/0iUtTzYBaVVaEn5yVxeRJBwnUYO2+CloNzGBo
         Cjk8idMQN7q0CJQBxh3dhT566L5QUn8swxx1KO/sjYPLQs9nqa6zXpu0eBasCRq7tn4J
         EYZMWOrM19TFryxat35V507YI/mP6s4nvodwHXvKTZ4Xphvw6QtPRdWUQTx0CEcABk6r
         BGlimj/lIy6m3f6e57HquwiFe4rpc8u7ZY5A6p1V8cq+l3E3kgwPcPdDDLQEZAlGtAHI
         gvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696499999; x=1697104799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1WI9TvkImQF/fqcaq6kEtU5fMxAStOtaMB/ec/9aZU=;
        b=RcEE5UgcSRpXADPs5NCbRI3stP+V6H0E9Lc6ctsPS19ziHUSqz0mvOM/jdu+H36cy3
         AP3EVc18AEH3nK6PTHgnxol7hzNIAejnexhiaslSV/KPtl7yM+QpuPmuUd4QCcJsWjft
         9cYqi6bednt2MUxTySET+67u/+L1uD58rUynlpdLe8ve2EyPBS7m6QbFIkmnD3snTgor
         jKuowvNRuYy3aQRqFC0P5VAC7RSIlq6Ym0TCkk2x/zrfjwmsFnkpXjdAj77HjBAM+5qE
         Z2WNeozugONZXMC4YBXszqHGXR92RJZk4I6TmI7y602vgsvpi2k/Aze9g3wr6F7VzJ4Y
         ToMw==
X-Gm-Message-State: AOJu0YxjUNgOCAdXI/FHWTSuemYfOSJKvpkWr7BJjQc1Mf5zwP4Og0aq
        cvbFYMrMtTYwW7842/NYVZgMiwpS6yc=
X-Google-Smtp-Source: AGHT+IHZ1+z9xpDZgosU7WEX0GZb/47MBnR2yKW3d0n56Q0K2FKVTCMlcTnMolDbsJOpANztgveAAA==
X-Received: by 2002:adf:e388:0:b0:31f:b0ba:f2ce with SMTP id e8-20020adfe388000000b0031fb0baf2cemr4552790wrm.9.1696499998603;
        Thu, 05 Oct 2023 02:59:58 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d4d4b000000b003231ca246b6sm1389897wru.95.2023.10.05.02.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 02:59:57 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH for 5.10-6.1 1/4] rbd: move rbd_dev_refresh() definition
Date:   Thu,  5 Oct 2023 11:59:32 +0200
Message-ID: <20231005095937.317188-2-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005095937.317188-1-idryomov@gmail.com>
References: <20231005095937.317188-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 0b035401c57021fc6c300272cbb1c5a889d4fe45 upstream.

Move rbd_dev_refresh() definition further down to avoid having to
move struct parent_image_info definition in the next commit.  This
spares some forward declarations too.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
[idryomov@gmail.com: backport to 5.10-6.1: context]
---
 drivers/block/rbd.c | 68 ++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 74ef3da54536..762795430b4d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -633,8 +633,6 @@ static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
 
 static int rbd_dev_refresh(struct rbd_device *rbd_dev);
 static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
-static int rbd_dev_header_info(struct rbd_device *rbd_dev);
-static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev);
 static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 					u64 snap_id);
 static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
@@ -4932,39 +4930,6 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
 	}
 }
 
-static int rbd_dev_refresh(struct rbd_device *rbd_dev)
-{
-	u64 mapping_size;
-	int ret;
-
-	down_write(&rbd_dev->header_rwsem);
-	mapping_size = rbd_dev->mapping.size;
-
-	ret = rbd_dev_header_info(rbd_dev);
-	if (ret)
-		goto out;
-
-	/*
-	 * If there is a parent, see if it has disappeared due to the
-	 * mapped image getting flattened.
-	 */
-	if (rbd_dev->parent) {
-		ret = rbd_dev_v2_parent_info(rbd_dev);
-		if (ret)
-			goto out;
-	}
-
-	rbd_assert(!rbd_is_snap(rbd_dev));
-	rbd_dev->mapping.size = rbd_dev->header.image_size;
-
-out:
-	up_write(&rbd_dev->header_rwsem);
-	if (!ret && mapping_size != rbd_dev->mapping.size)
-		rbd_dev_update_size(rbd_dev);
-
-	return ret;
-}
-
 static const struct blk_mq_ops rbd_mq_ops = {
 	.queue_rq	= rbd_queue_rq,
 };
@@ -7044,6 +7009,39 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 	return ret;
 }
 
+static int rbd_dev_refresh(struct rbd_device *rbd_dev)
+{
+	u64 mapping_size;
+	int ret;
+
+	down_write(&rbd_dev->header_rwsem);
+	mapping_size = rbd_dev->mapping.size;
+
+	ret = rbd_dev_header_info(rbd_dev);
+	if (ret)
+		goto out;
+
+	/*
+	 * If there is a parent, see if it has disappeared due to the
+	 * mapped image getting flattened.
+	 */
+	if (rbd_dev->parent) {
+		ret = rbd_dev_v2_parent_info(rbd_dev);
+		if (ret)
+			goto out;
+	}
+
+	rbd_assert(!rbd_is_snap(rbd_dev));
+	rbd_dev->mapping.size = rbd_dev->header.image_size;
+
+out:
+	up_write(&rbd_dev->header_rwsem);
+	if (!ret && mapping_size != rbd_dev->mapping.size)
+		rbd_dev_update_size(rbd_dev);
+
+	return ret;
+}
+
 static ssize_t do_rbd_add(struct bus_type *bus,
 			  const char *buf,
 			  size_t count)
-- 
2.41.0

