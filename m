Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED2709B3A
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 17:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjESPWX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 11:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjESPWW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 11:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A945C19B
        for <stable@vger.kernel.org>; Fri, 19 May 2023 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684509691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uGwQfv8wybZ9bN/zsAV3hMLC0zq83H1SfhLkvBnZWy8=;
        b=FFBhzrUl1jFsrYePmFT7HJeygD25bElEwOzszm8hW3xmG3A4yRdFNHohUY6dSxOESSCM1u
        p24NVc/eFsJPy6rGyfWsua4+2PHuddRYJhTkkpXhENtmDk9kTaxCJCdtjMqPv0Hb0kzH+v
        9pSoChn4j2sTTPpn7Jh6FatFw45fAIk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-EiaE3nS6Nt-93CjR8DQATw-1; Fri, 19 May 2023 11:21:30 -0400
X-MC-Unique: EiaE3nS6Nt-93CjR8DQATw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37B77800C81
        for <stable@vger.kernel.org>; Fri, 19 May 2023 15:21:30 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0153A48205E;
        Fri, 19 May 2023 15:21:29 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, agruenba@redhat.com,
        stable@vger.kernel.org, aahringo@redhat.com
Subject: [PATCH v6.4-rc2 1/5] fs: dlm: change local pids to be positive pids
Date:   Fri, 19 May 2023 11:21:24 -0400
Message-Id: <20230519152128.65272-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch fixes to set local processes and their pid value represented
inside the struct flock when using F_GETLK if there is a conflict with
another process.

Currently every pid in struct flock l_pid is set as negative pid number.
This was changed by commit 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use
fs-specific l_pid for remote locks"). There is still the question how to
represent remote pid lock holders, which is possible for DLM posix
handling, in the flock structure. This patch however will only change
local process holders to be represented as positive pids.

Further patches may change the behaviour for remote pid lock holders,
for now this patch will leave the behaviour of remote lock holders
unchanged which will be represented as negative pid.

There exists a simple ltp testcase [0] as reproducer.

[0] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testcase/testcases/kernel/syscalls/fcntl/fcntl05.c

Cc: stable@vger.kernel.org
Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid for remote locks")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index ed4357e62f35..ff364901f22b 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -360,7 +360,9 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		locks_init_lock(fl);
 		fl->fl_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
 		fl->fl_flags = FL_POSIX;
-		fl->fl_pid = -op->info.pid;
+		fl->fl_pid = op->info.pid;
+		if (op->info.nodeid != dlm_our_nodeid())
+			fl->fl_pid = -fl->fl_pid;
 		fl->fl_start = op->info.start;
 		fl->fl_end = op->info.end;
 		rv = 0;
-- 
2.31.1

