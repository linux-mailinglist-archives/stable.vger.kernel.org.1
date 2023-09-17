Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16A37A3979
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbjIQTtx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbjIQTtb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:49:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748B09F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:49:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1794C433C8;
        Sun, 17 Sep 2023 19:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980166;
        bh=R5dBXc1sQ/RiThmvzVbPfGGsjMRngK3L/XuUSxYZWPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHE22sBLOkZ7JWX2QIq/j1XetN8YutY+BzXvhQxb8jKhvZ2NKW0pcoWWkVG/Q0/GN
         IJsRLXa6oappiGBINw0oF9szP5HGyHfblv0g5T0sws0uS2Fid94qNakjQEAjDxS2SS
         bsuxu31CCdVjxkywAtr4ZKpXAROG1o/6nDaIuIU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiubo Li <xiubli@redhat.com>,
        Milind Changire <mchangir@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 113/285] ceph: make members in struct ceph_mds_request_args_ext a union
Date:   Sun, 17 Sep 2023 21:11:53 +0200
Message-ID: <20230917191055.579497834@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 3af5ae22030cb59fab4fba35f5a2b62f47e14df9 ]

In ceph mainline it will allow to set the btime in the setattr request
and just add a 'btime' member in the union 'ceph_mds_request_args' and
then bump up the header version to 4. That means the total size of union
'ceph_mds_request_args' will increase sizeof(struct ceph_timespec) bytes,
but in kclient it will increase the sizeof(setattr_ext) bytes for each
request.

Since the MDS will always depend on the header's vesion and front_len
members to decode the 'ceph_mds_request_head' struct, at the same time
kclient hasn't supported the 'btime' feature yet in setattr request,
so it's safe to do this change here.

This will save 48 bytes memories for each request.

Fixes: 4f1ddb1ea874 ("ceph: implement updated ceph_mds_request_head structure")
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ceph/ceph_fs.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 49586ff261520..b4fa2a25b7d95 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -462,17 +462,19 @@ union ceph_mds_request_args {
 } __attribute__ ((packed));
 
 union ceph_mds_request_args_ext {
-	union ceph_mds_request_args old;
-	struct {
-		__le32 mode;
-		__le32 uid;
-		__le32 gid;
-		struct ceph_timespec mtime;
-		struct ceph_timespec atime;
-		__le64 size, old_size;       /* old_size needed by truncate */
-		__le32 mask;                 /* CEPH_SETATTR_* */
-		struct ceph_timespec btime;
-	} __attribute__ ((packed)) setattr_ext;
+	union {
+		union ceph_mds_request_args old;
+		struct {
+			__le32 mode;
+			__le32 uid;
+			__le32 gid;
+			struct ceph_timespec mtime;
+			struct ceph_timespec atime;
+			__le64 size, old_size;       /* old_size needed by truncate */
+			__le32 mask;                 /* CEPH_SETATTR_* */
+			struct ceph_timespec btime;
+		} __attribute__ ((packed)) setattr_ext;
+	};
 };
 
 #define CEPH_MDS_FLAG_REPLAY		1 /* this is a replayed op */
-- 
2.40.1



