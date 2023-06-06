Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E8724F16
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 23:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjFFV5V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjFFV5T (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 17:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC8A1702
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686088591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P5lAt7kRfYFDckAa7oTbGbS6kf9LQdARYfaNFuocyUg=;
        b=daIR36XQ7SZvWsH01GHQtkzSOoRtG+foY27aPUpfF+mj65FbMwk5ffIzZNXCCWMmv6IzKY
        6BvrylVvgIJbNSGj5IDSvcs3/67wwHFBUOfABmBFH4xc26loLcUs2RLwnocaHR76I20HEe
        WanvDoKKUjHShjSxuyfuLJTJnVAnAPg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-xdE4vRXMMe-dzhB7dBj5aA-1; Tue, 06 Jun 2023 17:56:30 -0400
X-MC-Unique: xdE4vRXMMe-dzhB7dBj5aA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 240B5803D15
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 21:56:28 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE20F2166B2A;
        Tue,  6 Jun 2023 21:56:27 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org
Subject: [PATCH dlm/next] fs: dlm: fix nfs async lock callback handling
Date:   Tue,  6 Jun 2023 17:56:26 -0400
Message-Id: <20230606215626.327239-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch is fixing the current the callback handling if it's a nfs
async lock request signaled if fl_lmops is set.

When using `stress-ng --fcntl 32` on the kernel log there are several
messages like:

[11185.123533] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000002dd10f4d fl 000000007d13afae
[11185.127135] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000002dd10f4d fl 00000000a6046fa0
[11185.142668] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000002dd10f4d fl 000000001d13dfa5

The commit 40595cdc93ed ("nfs: block notification on fs with its
own ->lock") using only trylocks in an asynchronous polling behaviour. The
behaviour before was however differently by evaluating F_SETLKW or F_SETLK
and evaluating FL_SLEEP which was the case before commit 40595cdc93ed
("nfs: block notification on fs with its own ->lock"). This behaviour
seems to be broken before. This patch will fix the behaviour for the
special nfs case before commit 40595cdc93ed ("nfs: block notification on
fs with its own ->lock").

There is still a TODO of solving the case when an nfs locking request
got interrupted.

Fixes: 40595cdc93ed ("nfs: block notification on fs with its own ->lock")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 70a4752ed913..6f0ecb2176b0 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -217,27 +217,7 @@ static int dlm_plock_callback(struct plock_op *op)
 	fl = op_data->fl;
 	notify = op_data->callback;
 
-	if (op->info.rv) {
-		notify(fl, op->info.rv);
-		goto out;
-	}
-
-	/* got fs lock; bookkeep locally as well: */
-	flc->fl_flags &= ~FL_SLEEP;
-	if (posix_lock_file(file, flc, NULL)) {
-		/*
-		 * This can only happen in the case of kmalloc() failure.
-		 * The filesystem's own lock is the authoritative lock,
-		 * so a failure to get the lock locally is not a disaster.
-		 * As long as the fs cannot reliably cancel locks (especially
-		 * in a low-memory situation), we're better off ignoring
-		 * this failure than trying to recover.
-		 */
-		log_print("dlm_plock_callback: vfs lock error %llx file %p fl %p",
-			  (unsigned long long)op->info.number, file, fl);
-	}
-
-	rv = notify(fl, 0);
+	rv = notify(fl, op->info.rv);
 	if (rv) {
 		/* XXX: We need to cancel the fs lock here: */
 		log_print("dlm_plock_callback: lock granted after lock request "
-- 
2.31.1

