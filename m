Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EF4705F3D
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 07:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjEQFZN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 01:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjEQFZK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 01:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6438E420B
        for <stable@vger.kernel.org>; Tue, 16 May 2023 22:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684301062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jw9brB41FDXz2jgQEbr8oqsvxh/JrmUeFZGSqLXLrYE=;
        b=QmwAGcYjd9RcrfTg78JiQed55QPJNYcoYe0Z7mD4IhrId/mgReA9kVnBMnkAaJBPuAmwzh
        H18TMBOK243Oe+m52qJA5RtXLTBc6xGpTNIs5hBbiOhn7CV1Ylcw05f79IdpEtmh+3vtoW
        LTuMZ++QXIgg1wyYlfWAtPHowSc6XCw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-YYpC63RgMhCNkxUfHHUVFQ-1; Wed, 17 May 2023 01:24:19 -0400
X-MC-Unique: YYpC63RgMhCNkxUfHHUVFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E25B2A59544;
        Wed, 17 May 2023 05:24:18 +0000 (UTC)
Received: from li-a71a4dcc-35d1-11b2-a85c-951838863c8d.ibm.com.com (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF80E14171C0;
        Wed, 17 May 2023 05:24:13 +0000 (UTC)
From:   xiubli@redhat.com
To:     idryomov@gmail.com, ceph-devel@vger.kernel.org
Cc:     jlayton@kernel.org, vshankar@redhat.com,
        Xiubo Li <xiubli@redhat.com>, stable@vger.kernel.org,
        Frank Schilder <frans@dtu.dk>
Subject: [PATCH] ceph: force updating the msg pointer in non-split case
Date:   Wed, 17 May 2023 13:24:04 +0800
Message-Id: <20230517052404.99904-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

When the MClientSnap reqeust's op is not CEPH_SNAP_OP_SPLIT the
request may still contain a list of 'split_realms', and we need
to skip it anyway. Or it will be parsed as a corrupt snaptrace.

Cc: stable@vger.kernel.org
Cc: Frank Schilder <frans@dtu.dk>
Reported-by: Frank Schilder <frans@dtu.dk>
URL: https://tracker.ceph.com/issues/61200
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/snap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 0e59e95a96d9..d95dfe16b624 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1114,6 +1114,9 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 				continue;
 			adjust_snap_realm_parent(mdsc, child, realm->ino);
 		}
+	} else {
+		p += sizeof(u64) * num_split_inos;
+		p += sizeof(u64) * num_split_realms;
 	}
 
 	/*
-- 
2.40.1

