Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5547BA4FE
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbjJEQNa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240853AbjJEQMQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 12:12:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991439EFD
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 08:30:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405497850dbso10357105e9.0
        for <stable@vger.kernel.org>; Thu, 05 Oct 2023 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696519832; x=1697124632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8C7g9mirJCs6FbazMAoTST7zLISIvKYlK6zvgh1lUI=;
        b=M+y1ezQXkCn+R9dMYY8Fd5K9lCmdmmOOY3TA0GSEBAbKsB3U+hqVd7eLDzBl9VZZ11
         wEa5EUh9M0bw7EQJ9SsOFgg4WWa0QKVeMemV+1NTezpVhbnZGOHyrGHbn6ZFXu6vtUQr
         FAlF5AzhfNhgs7J/fCkDEyQDaVV79IhMJ4g8W3M9tT7hPOP/D0+rpyCajEQx9PjFoFqi
         KqTpRpM7AAPb63DjtsNDODURUu3xWcZoWyWwTyb8n1ipA8hfkdEQBxJGnXrpDruYgx5a
         WFTTlms1votkaYMzwPyz9H8l58U8Gh+woGbs795WZ2nBOu7BXOiFl22abDE4zONBV5Wv
         KV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696519832; x=1697124632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8C7g9mirJCs6FbazMAoTST7zLISIvKYlK6zvgh1lUI=;
        b=bGWKfUfsrPdPwBmJAU5IlSVCBuLSSemKqYwCh8jNOXWzMwpTMy/EO4J61U4eyVxKv4
         2hUyZkE1WlZs0f8JiQk33858/ngvqMd3uVeafQWZPi7m3CKYTQXpNU0pSu/houCU4RgI
         HczFxkZvM/ishU2uHZp/2GmP208YUgyXpLo0q44WdaVr5pl50DtjMjpgurTjqtSWKAcC
         OLPAPcqDHCMFcFdd/nyrBzWkzU8FD9RKoGTNSlqRWrOfFPDr/ufjxDftg2MgOUIjBJBK
         JOYfwSM1cbPgm+cRn6vB5XPb/zWnjS1Nvd0ZVzFk957fyr1junOaN+INMtb6B1lebbEz
         u7jw==
X-Gm-Message-State: AOJu0YyPyfOyjj/Pe3HQC1GPh/SP1CKH+8mWlllK4T1h2wjwmG+LdxLe
        56v6CUnGNelJARpom1V0TLhLEzWZXTM=
X-Google-Smtp-Source: AGHT+IFSOpAOV7ljPU1+sxTuw0fdY5jVnqLVJxyL8xFPqLf5m0ULc2qrWnBhoMm2kxUYXULMyeJC/A==
X-Received: by 2002:a1c:740d:0:b0:405:1ba2:4fd1 with SMTP id p13-20020a1c740d000000b004051ba24fd1mr5610035wmc.24.1696519832042;
        Thu, 05 Oct 2023 08:30:32 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bce0a000000b00405953973c3sm3989560wmc.6.2023.10.05.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 08:30:31 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH for 5.4 4/4] rbd: take header_rwsem in rbd_dev_refresh() only when updating
Date:   Thu,  5 Oct 2023 17:29:53 +0200
Message-ID: <20231005153003.326735-5-idryomov@gmail.com>
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
[idryomov@gmail.com: backport to 5.4: open-code rbd_is_snap(), preserve
 rbd_exists_validate() call]
---
 drivers/block/rbd.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e86dca49fae7..7117fa490243 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -7001,7 +7001,19 @@ static void rbd_dev_update_header(struct rbd_device *rbd_dev,
 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
 	rbd_assert(rbd_dev->header.object_prefix); /* !first_time */
 
-	rbd_dev->header.image_size = header->image_size;
+	if (rbd_dev->header.image_size != header->image_size) {
+		rbd_dev->header.image_size = header->image_size;
+
+		if (rbd_dev->spec->snap_id == CEPH_NOSNAP) {
+			rbd_dev->mapping.size = header->image_size;
+			rbd_dev_update_size(rbd_dev);
+		}
+	}
+
+	if (rbd_dev->spec->snap_id != CEPH_NOSNAP) {
+		/* validate mapped snapshot's EXISTS flag */
+		rbd_exists_validate(rbd_dev);
+	}
 
 	ceph_put_snap_context(rbd_dev->header.snapc);
 	rbd_dev->header.snapc = header->snapc;
@@ -7059,11 +7071,9 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
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
@@ -7079,22 +7089,13 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 			goto out;
 	}
 
+	down_write(&rbd_dev->header_rwsem);
 	rbd_dev_update_header(rbd_dev, &header);
 	if (rbd_dev->parent)
 		rbd_dev_update_parent(rbd_dev, &pii);
-
-	if (rbd_dev->spec->snap_id == CEPH_NOSNAP) {
-		rbd_dev->mapping.size = rbd_dev->header.image_size;
-	} else {
-		/* validate mapped snapshot's EXISTS flag */
-		rbd_exists_validate(rbd_dev);
-	}
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

