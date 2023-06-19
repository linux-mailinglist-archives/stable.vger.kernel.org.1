Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A199A73542C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjFSKxX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjFSKwy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:52:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC29B3588
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55C1B60B36
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B39DC433C9;
        Mon, 19 Jun 2023 10:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171897;
        bh=2HczgtxYc6JmHN3wKYx/Nz4YbnYNJLgqwCzfiRFWGVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PiIIV3TIn/91pCyPZaMCSiJiCUTNFlZh6whu700pc2h+GDkAY34LOUX85wNgn44w+
         ja2LI4qgh2ZpmSISZYC0HOAbvzVK/6xeEA+zIY/LmuZ4ELN7eguhP+wqbWXlNiDZrG
         8Zgsb1GsijUnaifBWwx2HCVrtLa6grFoYoSMQjRE=
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
Subject: [PATCH 5.4 22/64] ocfs2: check new file size on fallocate call
Date:   Mon, 19 Jun 2023 12:30:18 +0200
Message-ID: <20230619102134.041504152@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
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
@@ -2103,14 +2103,20 @@ static long ocfs2_fallocate(struct file
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


