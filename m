Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546B7727D5F
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 12:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjFHK7O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 06:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjFHK7N (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 06:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F67611A
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 03:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686221906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uGF1QnRDPmXMvdo+ZBshyWxIyf+UKkHcu59ywxUVh7g=;
        b=eKv0Rct7cgvStgHRuELSFMoZvpk3ujTKqF+Osme+Puzz53G/7dPGoRWEmL/eiPZN2I6s2P
        cOlEhxw93HhFlozkIkMUnEVyQ/uKLdXrCwsdPA4CpwLGqBC5+vyPvPCVl0SUGtNPkokqRL
        x2qYyztoKJ8NSVri7larAr9KQWGt1c8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-hAet45ZONhCDtrSudHMV8w-1; Thu, 08 Jun 2023 06:58:25 -0400
X-MC-Unique: hAet45ZONhCDtrSudHMV8w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4BA7384CC48
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 10:58:24 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F20240CFD46;
        Thu,  8 Jun 2023 10:58:24 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org
Subject: [PATCHv2 dlm/next] fs: dlm: fix nfs async lock callback handling
Date:   Thu,  8 Jun 2023 06:58:21 -0400
Message-Id: <20230608105821.354272-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch is fixing the current the callback handling if a nfs async
lock request signaled if fl_lmops is set.

When using `stress-ng --fcntl 32` on the kernel log there are several
messages like:

[11185.123533] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000002dd10f4d fl 000000007d13afae
[11185.127135] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000002dd10f4d fl 00000000a6046fa0
[11185.142668] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000002dd10f4d fl 000000001d13dfa5

The commit 40595cdc93ed ("nfs: block notification on fs with its
own ->lock") removed the FL_SLEEP handling if the filesystem implements
its own ->lock. The strategy is now that the most clients polling
blocked requests by using trylock functionality.

Before commit 40595cdc93ed ("nfs: block notification on fs with its own
->lock") FL_SLEEP was used even with an own ->lock() callback. The fs
implementation needed to handle it to make a difference between a
blocking and non-blocking lock request. This was never being implemented
in such way in DLM plock handling. Every lock request doesn't matter if
it was a blocking request or not was handled as a non-blocking lock
request.

This patch fixes the behaviour until commit 40595cdc93ed ("nfs: block
notification on fs with its own ->lock"), but it was probably broken
long time before.

Fixes: 40595cdc93ed ("nfs: block notification on fs with its own ->lock")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
changes since v2:
 - rephrase commit msg
 - add cc stable

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

