Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4928A7C436E
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 00:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjJJWFu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 18:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJJWFt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 18:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1458798
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696975500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aigk33WTcaIIDVNVjDtFXvALQQrohhQcmn8R5rWJNLw=;
        b=QxRgTWTmDAeG4JTgtTR61BlHqf1H7Xe/PGOwBm7CZs/xZg1XQ2HrXABytsr2ogeSjM3yuH
        z6EB1/7rTDtUbwDXIoxwzcECX9CeAbieUfln+Fs9jGpsWynShRXnQ7+VA7cv/KgAfIsv9R
        9yWNKVqLAePpocOwWaPgo/9mwqdCE/w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-8Ft7_sEoOEGGjUCwcuzTUQ-1; Tue, 10 Oct 2023 18:04:58 -0400
X-MC-Unique: 8Ft7_sEoOEGGjUCwcuzTUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33FD5811E88;
        Tue, 10 Oct 2023 22:04:58 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 032649A;
        Tue, 10 Oct 2023 22:04:57 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, gfs2@lists.linux.dev,
        christophe.jaillet@wanadoo.fr, stable@vger.kernel.org,
        aahringo@redhat.com
Subject: [PATCH RESEND 5/8] dlm: fix remove member after close call
Date:   Tue, 10 Oct 2023 18:04:45 -0400
Message-Id: <20231010220448.2978176-5-aahringo@redhat.com>
In-Reply-To: <20231010220448.2978176-1-aahringo@redhat.com>
References: <20231010220448.2978176-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The idea of commit 63e711b08160 ("fs: dlm: create midcomms nodes when
configure") is to set the midcomms node lifetime when a node joins or
leaves the cluster. Currently we can hit the following warning:

[10844.611495] ------------[ cut here ]------------
[10844.615913] WARNING: CPU: 4 PID: 84304 at fs/dlm/midcomms.c:1263
dlm_midcomms_remove_member+0x13f/0x180 [dlm]

or running in a state where we hit a midcomms node usage count in a
negative value:

[  260.830782] node 2 users dec count -1

The first warning happens when the a specific node does not exists and
it was probably removed but dlm_midcomms_close() which is called when a
node leaves the cluster. The second kernel log message is probably in a
case when dlm_midcomms_addr() is called when a joined the cluster but
due fencing a node leaved the cluster without getting removed from the
lockspace. If the node joins the cluster and it was removed from the
cluster due fencing the first call is to remove the node from lockspaces
triggered by the user space. In both cases if the node wasn't found or
the user count is zero, we should ignore any additional midcomms handling
of dlm_midcomms_remove_member().

Cc: stable@vger.kernel.org
Fixes: 63e711b08160 ("fs: dlm: create midcomms nodes when configure")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/midcomms.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 455265c6ba53..4ad71e97cec2 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -1268,12 +1268,23 @@ void dlm_midcomms_remove_member(int nodeid)
 
 	idx = srcu_read_lock(&nodes_srcu);
 	node = nodeid2node(nodeid);
-	if (WARN_ON_ONCE(!node)) {
+	/* in case of dlm_midcomms_close() removes node */
+	if (!node) {
 		srcu_read_unlock(&nodes_srcu, idx);
 		return;
 	}
 
 	spin_lock(&node->state_lock);
+	/* case of dlm_midcomms_addr() created node but
+	 * was not added before because dlm_midcomms_close()
+	 * removed the node
+	 */
+	if (!node->users) {
+		spin_unlock(&node->state_lock);
+		srcu_read_unlock(&nodes_srcu, idx);
+		return;
+	}
+
 	node->users--;
 	pr_debug("node %d users dec count %d\n", nodeid, node->users);
 
-- 
2.39.3

