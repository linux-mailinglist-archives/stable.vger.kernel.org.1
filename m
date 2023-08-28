Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0773678ABF9
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjH1KgF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjH1Kfn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:35:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7576D18B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C08D612AB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88452C433C7;
        Mon, 28 Aug 2023 10:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218936;
        bh=EHuUXsI+FI3g3O0hiinDI0lft4NmQ+5V3/irPU+mSx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cUbiW8lyZq+vZBlx7noALOlHTLWDUzHWlu3fe02T+Q17fwAkMHZ3KAgjdVjPzJXQr
         zbAsvnpdy74uN04QhKIjf237YFJir3iiYZ80+7S0WkhvokcpBxXrVsmMhc1mQrsiCo
         /Qnl5IAaZ328boTYhAjRE3eiKmdVnOxwt+6Zu06I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com,
        Immad Mir <mirimmad17@gmail.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 015/158] FS: JFS: Fix null-ptr-deref Read in txBegin
Date:   Mon, 28 Aug 2023 12:11:52 +0200
Message-ID: <20230828101157.859901277@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Immad Mir <mirimmad17@gmail.com>

[ Upstream commit 47cfdc338d674d38f4b2f22b7612cc6a2763ba27 ]

 Syzkaller reported an issue where txBegin may be called
 on a superblock in a read-only mounted filesystem which leads
 to NULL pointer deref. This could be solved by checking if
 the filesystem is read-only before calling txBegin, and returning
 with appropiate error code.

Reported-By: syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=be7e52c50c5182cc09a09ea6fc456446b2039de3

Signed-off-by: Immad Mir <mirimmad17@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 7a55d14cc1af0..f155ad6650bd4 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -798,6 +798,11 @@ static int jfs_link(struct dentry *old_dentry,
 	if (rc)
 		goto out;
 
+	if (isReadOnly(ip)) {
+		jfs_error(ip->i_sb, "read-only filesystem\n");
+		return -EROFS;
+	}
+
 	tid = txBegin(ip->i_sb, 0);
 
 	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
-- 
2.40.1



