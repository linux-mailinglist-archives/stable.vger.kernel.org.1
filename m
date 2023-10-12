Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5B67C6217
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 03:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjJLBOq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 21:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjJLBOp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 21:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D2A4
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 18:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697073237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jH2c5TGSfJekGivUEYxsFL4FK9Io40owW7aORS1qLk0=;
        b=M2R3Gqxg60FBQ4ecQGMH7z7+WkaB386KXCc8EEPH4SGL4QrpPVNgkz+6aZ3rq/GaqyR4ox
        BRlRTja2+3xTXeInP+JpJ7xbhaxYvfpZ75ubPzRD5TL4nry42ftPtA6n6FIdDX9VG6XC5B
        2Rgt3p5rhwy8kY84iZoR1KSo44FYs6U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-0IEyacywMHSgzHdv1cA1xg-1; Wed, 11 Oct 2023 21:13:54 -0400
X-MC-Unique: 0IEyacywMHSgzHdv1cA1xg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CAB0811E7D;
        Thu, 12 Oct 2023 01:13:53 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.22.10.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E51FEC0F789;
        Thu, 12 Oct 2023 01:13:52 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     stable@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.10.y] ipc: replace costly bailout check in sysvipc_find_ipc()
Date:   Wed, 11 Oct 2023 21:13:41 -0400
Message-ID: <20231012011341.111660-1-aquini@redhat.com>
In-Reply-To: <aaa0d2cc-832d-4b57-a06d-0d1fa77a4b03@denx.de>
References: <aaa0d2cc-832d-4b57-a06d-0d1fa77a4b03@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 20401d1058f3f841f35a594ac2fc1293710e55b9 upstream

This is CVE-2021-3669

sysvipc_find_ipc() was left with a costly way to check if the offset
position fed to it is bigger than the total number of IPC IDs in use.  So
much so that the time it takes to iterate over /proc/sysvipc/* files grows
exponentially for a custom benchmark that creates "N" SYSV shm segments
and then times the read of /proc/sysvipc/shm (milliseconds):

    12 msecs to read   1024 segs from /proc/sysvipc/shm
    18 msecs to read   2048 segs from /proc/sysvipc/shm
    65 msecs to read   4096 segs from /proc/sysvipc/shm
   325 msecs to read   8192 segs from /proc/sysvipc/shm
  1303 msecs to read  16384 segs from /proc/sysvipc/shm
  5182 msecs to read  32768 segs from /proc/sysvipc/shm

The root problem lies with the loop that computes the total amount of ids
in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger than
"ids->in_use".  That is a quite inneficient way to get to the maximum
index in the id lookup table, specially when that value is already
provided by struct ipc_ids.max_idx.

This patch follows up on the optimization introduced via commit
15df03c879836 ("sysvipc: make get_maxid O(1) again") and gets rid of the
aforementioned costly loop replacing it by a simpler checkpoint based on
ipc_get_maxidx() returned value, which allows for a smooth linear increase
in time complexity for the same custom benchmark:

     2 msecs to read   1024 segs from /proc/sysvipc/shm
     2 msecs to read   2048 segs from /proc/sysvipc/shm
     4 msecs to read   4096 segs from /proc/sysvipc/shm
     9 msecs to read   8192 segs from /proc/sysvipc/shm
    19 msecs to read  16384 segs from /proc/sysvipc/shm
    39 msecs to read  32768 segs from /proc/sysvipc/shm

Link: https://lkml.kernel.org/r/20210809203554.1562989-1-aquini@redhat.com
Signed-off-by: Rafael Aquini <aquini@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <llong@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 ipc/util.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index bbb5190af6d9..7c3601dad9bd 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -754,21 +754,13 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
 static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 					      loff_t *new_pos)
 {
-	struct kern_ipc_perm *ipc;
-	int total, id;
-
-	total = 0;
-	for (id = 0; id < pos && total < ids->in_use; id++) {
-		ipc = idr_find(&ids->ipcs_idr, id);
-		if (ipc != NULL)
-			total++;
-	}
+	struct kern_ipc_perm *ipc = NULL;
+	int max_idx = ipc_get_maxidx(ids);
 
-	ipc = NULL;
-	if (total >= ids->in_use)
+	if (max_idx == -1 || pos > max_idx)
 		goto out;
 
-	for (; pos < ipc_mni; pos++) {
+	for (; pos <= max_idx; pos++) {
 		ipc = idr_find(&ids->ipcs_idr, pos);
 		if (ipc != NULL) {
 			rcu_read_lock();
-- 
2.41.0

