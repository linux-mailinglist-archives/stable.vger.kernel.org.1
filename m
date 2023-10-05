Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1C7BA4F4
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbjJEQN0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbjJEQMP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 12:12:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792DB72B9
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 08:30:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so10988115e9.0
        for <stable@vger.kernel.org>; Thu, 05 Oct 2023 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696519828; x=1697124628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GKp0MD9Cgpi2oHMfaHGmd/Dbu86+qsFxxSp2lPfgXo=;
        b=T8/7CzQQSuRgrLXIAtilaot8Nk9DiyZnfYgoHp9UaSdpZD9Ic4zIhgXjCGiCo0cbx5
         Y70+sHgH24KUdAkwS3iFX/3pxqWt5BpzCGg1Le47hVF8WBGols3aiqMKNsHXOV7gk+qJ
         9nqPY3lfJiJ0YGoJm8GlnVDoSrMDbNouePtdeW6Z0qN6EYeZuuaVQ8MupR3TXaZyt8IL
         xesW9wQPrkeaqszsf+q+LzU9uuxx7qgyDNo6Bpd1+TxmAJiFibJR77ZyT1NtG7BlgsFW
         MAtoM1iHwdbR+WOxNCtWXPiJA820Ou5mUVjw47YCHeszNb05MVD/ne1reQ19xER0NuDS
         GeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696519828; x=1697124628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GKp0MD9Cgpi2oHMfaHGmd/Dbu86+qsFxxSp2lPfgXo=;
        b=TsrWnyUc1NDHTMtloYe9t/xxkEJmTa6WiTcoy2hRNoatK1hKfaxINY81v2m1lXNJ4d
         bH/w8yJfuGi07qxRzrGocQtMcsTgfSvq5gb7HkYUOe8o+Euig8aSQ/PWQDAwIKfbG27B
         iYaVVWzZpqm7i8T+7MlC6jaonBY4pFl67wccQ3fp/sVOQLGl9h6jaiNHP3mU4PkZNz5I
         ZY50D0dhvHTuhEg6ypATNOG9YJnwBbGbETzWjXUlVkdhTQE5GavFVbk+yjsOL37RqYwp
         OlD+cpqkfEh5yia+hK5Nf/x4n6JhS7AO+YUNh8+qMzkoo2tbtrNUXpz0IFGXdnO2WU8z
         YgqA==
X-Gm-Message-State: AOJu0YxQZFQqNVDl/JCFy4xwHHvIw+ER/IlUrfKZhflY53AKmChCq2KB
        H5jbpRKElqsaWfyDEMggYrDL0RjCO2E=
X-Google-Smtp-Source: AGHT+IHSEZLtukSOA60QO9aR+FJkoX4oxVesTcCwP+E8P6lpfdUkjLI0Cxg+GHCTFltl5e7RR1Sd1Q==
X-Received: by 2002:a5d:5487:0:b0:319:6997:942e with SMTP id h7-20020a5d5487000000b003196997942emr5359985wrv.8.1696519827709;
        Thu, 05 Oct 2023 08:30:27 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bce0a000000b00405953973c3sm3989560wmc.6.2023.10.05.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 08:30:26 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH for 5.4 1/4] rbd: move rbd_dev_refresh() definition
Date:   Thu,  5 Oct 2023 17:29:50 +0200
Message-ID: <20231005153003.326735-2-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005153003.326735-1-idryomov@gmail.com>
References: <20231005153003.326735-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
[idryomov@gmail.com: backport to 5.4: drop rbd_is_snap() assert,
 preserve rbd_exists_validate() call]
---
 drivers/block/rbd.c | 76 ++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9d21f90f93f0..e015b8610e27 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -627,8 +627,6 @@ static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
 
 static int rbd_dev_refresh(struct rbd_device *rbd_dev);
 static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
-static int rbd_dev_header_info(struct rbd_device *rbd_dev);
-static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev);
 static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 					u64 snap_id);
 static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
@@ -5075,43 +5073,6 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
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
-	if (rbd_dev->spec->snap_id == CEPH_NOSNAP) {
-		rbd_dev->mapping.size = rbd_dev->header.image_size;
-	} else {
-		/* validate mapped snapshot's EXISTS flag */
-		rbd_exists_validate(rbd_dev);
-	}
-
-out:
-	up_write(&rbd_dev->header_rwsem);
-	if (!ret && mapping_size != rbd_dev->mapping.size)
-		rbd_dev_update_size(rbd_dev);
-
-	return ret;
-}
-
 static int rbd_init_request(struct blk_mq_tag_set *set, struct request *rq,
 		unsigned int hctx_idx, unsigned int numa_node)
 {
@@ -7061,6 +7022,43 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
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
+	if (rbd_dev->spec->snap_id == CEPH_NOSNAP) {
+		rbd_dev->mapping.size = rbd_dev->header.image_size;
+	} else {
+		/* validate mapped snapshot's EXISTS flag */
+		rbd_exists_validate(rbd_dev);
+	}
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

