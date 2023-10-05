Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC697BA51E
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 18:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbjJEQN6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 12:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbjJEQNE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 12:13:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E723D1F762
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 03:00:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b98a699f45so136517666b.3
        for <stable@vger.kernel.org>; Thu, 05 Oct 2023 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696500002; x=1697104802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy7oWDaMcUoXMwBopu6xJvA4n+urU7k8+Wd5iqE6CDw=;
        b=hNwMmlDIRzo/CW29pbVRkkhKmGeo4iCK2xtmj5xrgW2b4guQUvoGHd2GUuwxCE8HPT
         +uYZce1/G9lS8FCrFHGdvkSj1OevnQGfF1Dd5fgVVMrua6M3sQq7qSrt5PUJw6vohEST
         OLxCeeJzyaryFDe/u6RgyG17QaFVkc9BMlfCr68ML9EsfqFLfDP63o1gn72AFAiTG5lI
         DUc8Z4rmrKmVLmeIMrkIHHDMd9x1MGqRiQ58SSoF8ShdZ+miH3VVZjMaDgUZgLian9yS
         IYqyrq+payG9UIM5YSi6ZkBgPkfQuE1XSVwrWsU8aNAV5NKacaJBRymLLxtJGmH7yE6t
         l8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696500002; x=1697104802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uy7oWDaMcUoXMwBopu6xJvA4n+urU7k8+Wd5iqE6CDw=;
        b=Ok1DsVoloup+hGJtq37WNScpZaTrqjSwFRUtwwh9Cnyngc2h75uoOExkaWObUew+ix
         bm+oATZLOWGZIgKKfvCFY2PulAFHVOI3YWkcD0sOpCSqZ97yy5FuLLxyk4zKwa2LK+z2
         oenlP7QQphwXVFvRxe+59ytVy3w0aXXheiWKbVWmk/IJfIfXhBAHqEIFvdywi/Mksf41
         X8z7HqgS/wpRhTk/Z7u5XoBG9aE+qhV7Ew4lh3X9om9lxNA1DmR2HgOF9E1Gx60d9Xez
         H8BAspM1NTQZXwHYg0nIwNPaCTbWsxCynJ8mGMDAtS1VeLuFj8FJB2j/JAFlBiSGbDuG
         5Hrw==
X-Gm-Message-State: AOJu0YxHmXAP67Zgsg3zh5tUSYTm+1zLWtcEiNwZ9DxK4AvmJ6DZfuvB
        pRt76O7uqs3+FcukKi498M+0UAVKRJs=
X-Google-Smtp-Source: AGHT+IEbd35Fo+5AUUBbemiHUoCPI1Jh2IUI2uLRvfRV5ZTrtz5FREKafO72C/k+wXiuKRuxm+J+gw==
X-Received: by 2002:a17:906:1daa:b0:9aa:63d:9ede with SMTP id u10-20020a1709061daa00b009aa063d9edemr4133044ejh.9.1696500002060;
        Thu, 05 Oct 2023 03:00:02 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d4d4b000000b003231ca246b6sm1389897wru.95.2023.10.05.03.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:00:01 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH for 5.10-6.1 4/4] rbd: take header_rwsem in rbd_dev_refresh() only when updating
Date:   Thu,  5 Oct 2023 11:59:35 +0200
Message-ID: <20231005095937.317188-5-idryomov@gmail.com>
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

commit 0b207d02bd9ab8dcc31b262ca9f60dbc1822500d upstream.

rbd_dev_refresh() has been holding header_rwsem across header and
parent info read-in unnecessarily for ages.  With commit 870611e4877e
("rbd: get snapshot context after exclusive lock is ensured to be
held"), the potential for deadlocks became much more real owning to
a) header_rwsem now nesting inside lock_rwsem and b) rw_semaphores
not allowing new readers after a writer is registered.

For example, assuming that I/O request 1, I/O request 2 and header
read-in request all target the same OSD:

1. I/O request 1 comes in and gets submitted
2. watch error occurs
3. rbd_watch_errcb() takes lock_rwsem for write, clears owner_cid and
   releases lock_rwsem
4. after reestablishing the watch, rbd_reregister_watch() calls
   rbd_dev_refresh() which takes header_rwsem for write and submits
   a header read-in request
5. I/O request 2 comes in: after taking lock_rwsem for read in
   __rbd_img_handle_request(), it blocks trying to take header_rwsem
   for read in rbd_img_object_requests()
6. another watch error occurs
7. rbd_watch_errcb() blocks trying to take lock_rwsem for write
8. I/O request 1 completion is received by the messenger but can't be
   processed because lock_rwsem won't be granted anymore
9. header read-in request completion can't be received, let alone
   processed, because the messenger is stranded

Change rbd_dev_refresh() to take header_rwsem only for actually
updating rbd_dev->header.  Header and parent info read-in don't need
any locking.

Cc: stable@vger.kernel.org # 0b035401c570: rbd: move rbd_dev_refresh() definition
Cc: stable@vger.kernel.org # 510a7330c82a: rbd: decouple header read-in from updating rbd_dev->header
Cc: stable@vger.kernel.org # c10311776f0a: rbd: decouple parent info read-in from updating rbd_dev
Cc: stable@vger.kernel.org
Fixes: 870611e4877e ("rbd: get snapshot context after exclusive lock is ensured to be held")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
---
 drivers/block/rbd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 38c92b1b0346..afc92869cba4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6987,7 +6987,14 @@ static void rbd_dev_update_header(struct rbd_device *rbd_dev,
 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
 	rbd_assert(rbd_dev->header.object_prefix); /* !first_time */
 
-	rbd_dev->header.image_size = header->image_size;
+	if (rbd_dev->header.image_size != header->image_size) {
+		rbd_dev->header.image_size = header->image_size;
+
+		if (!rbd_is_snap(rbd_dev)) {
+			rbd_dev->mapping.size = header->image_size;
+			rbd_dev_update_size(rbd_dev);
+		}
+	}
 
 	ceph_put_snap_context(rbd_dev->header.snapc);
 	rbd_dev->header.snapc = header->snapc;
@@ -7045,11 +7052,9 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 {
 	struct rbd_image_header	header = { 0 };
 	struct parent_image_info pii = { 0 };
-	u64 mapping_size;
 	int ret;
 
-	down_write(&rbd_dev->header_rwsem);
-	mapping_size = rbd_dev->mapping.size;
+	dout("%s rbd_dev %p\n", __func__, rbd_dev);
 
 	ret = rbd_dev_header_info(rbd_dev, &header, false);
 	if (ret)
@@ -7065,18 +7070,13 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 			goto out;
 	}
 
+	down_write(&rbd_dev->header_rwsem);
 	rbd_dev_update_header(rbd_dev, &header);
 	if (rbd_dev->parent)
 		rbd_dev_update_parent(rbd_dev, &pii);
-
-	rbd_assert(!rbd_is_snap(rbd_dev));
-	rbd_dev->mapping.size = rbd_dev->header.image_size;
-
-out:
 	up_write(&rbd_dev->header_rwsem);
-	if (!ret && mapping_size != rbd_dev->mapping.size)
-		rbd_dev_update_size(rbd_dev);
 
+out:
 	rbd_parent_info_cleanup(&pii);
 	rbd_image_header_cleanup(&header);
 	return ret;
-- 
2.41.0

