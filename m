Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98517735370
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFSKpl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFSKpT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9551701
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6FF460B86
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11EBC433C0;
        Mon, 19 Jun 2023 10:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171484;
        bh=5Ebxbjcjas21OpYXslzcOfuPyGjJlmqNXikjmEo8wxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sf+Y3W6ik78/dYcyMOTH/Memnhc9Yl8AEJHKPWwjSNzlbMg4HOwzFEKef2OWUSe1B
         MnN1lEVpF+B5QdvA0gTiUyesa+ju8tC0lU6XEZCYTb+oeDxd4t9KUsRrGLZ5NKrO8O
         SduutAj6KhOobbzDYL0iryXoJR6ccBobXE87oTyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 047/166] ocfs2: check new file size on fallocate call
Date:   Mon, 19 Jun 2023 12:28:44 +0200
Message-ID: <20230619102156.996013505@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Luís Henriques <ocfs2-devel@oss.oracle.com>

commit 26a6ffff7de5dd369cdb12e38ba11db682f1dec0 upstream.

When changing a file size with fallocate() the new size isn't being
checked.  In particular, the FSIZE ulimit isn't being checked, which makes
fstest generic/228 fail.  Simply adding a call to inode_newsize_ok() fixes
this issue.

Link: https://lkml.kernel.org/r/20230529152645.32680-1-lhenriques@suse.de
Signed-off-by: Luís Henriques <lhenriques@suse.de>
Reviewed-by: Mark Fasheh <mark@fasheh.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/file.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2100,14 +2100,20 @@ static long ocfs2_fallocate(struct file
 	struct ocfs2_space_resv sr;
 	int change_size = 1;
 	int cmd = OCFS2_IOC_RESVSP64;
+	int ret = 0;
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 	if (!ocfs2_writes_unwritten_extents(osb))
 		return -EOPNOTSUPP;
 
-	if (mode & FALLOC_FL_KEEP_SIZE)
+	if (mode & FALLOC_FL_KEEP_SIZE) {
 		change_size = 0;
+	} else {
+		ret = inode_newsize_ok(inode, offset + len);
+		if (ret)
+			return ret;
+	}
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		cmd = OCFS2_IOC_UNRESVSP64;


