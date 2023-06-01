Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08DC719D63
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjFANWp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjFANWo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8928D124
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BAAD64442
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACF8C433EF;
        Thu,  1 Jun 2023 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625758;
        bh=RJuucqiWL1Zf/L+MKVyyoDF/pz2i0eusp1BuxLxG7qY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XoQBaOZMwIX3kZvdkVi0tpjF/mFjpdMTzPerEa0IWwqwvxLrQqxalED05ZL91ew65
         c1SlaWv3FHSbSeqC/Ki/dw8e7U/d4anur6iILW57SJrpDuLkDBd6ncQt+bhvV/I/vK
         a6qVe1WWpNMyctxfllpC1WO5O28Z1mO8KhJoAOE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hao Ge <gehao@kylinos.cn>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 06/16] fs: fix undefined behavior in bit shift for SB_NOUSER
Date:   Thu,  1 Jun 2023 14:21:01 +0100
Message-Id: <20230601131932.243233878@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131931.947241286@linuxfoundation.org>
References: <20230601131931.947241286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hao Ge <gehao@kylinos.cn>

[ Upstream commit f15afbd34d8fadbd375f1212e97837e32bc170cc ]

Shifting signed 32-bit value by 31 bits is undefined, so changing
significant bit to unsigned. It was spotted by UBSAN.

So let's just fix this by using the BIT() helper for all SB_* flags.

Fixes: e462ec50cb5f ("VFS: Differentiate mount flags (MS_*) from internal superblock flags")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
Message-Id: <20230424051835.374204-1-gehao@kylinos.cn>
[brauner@kernel.org: use BIT() for all SB_* flags]
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fs.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e003afcea3f3e..4b1553f570f2c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1360,28 +1360,28 @@ extern int send_sigurg(struct fown_struct *fown);
  * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
  * represented in both.
  */
-#define SB_RDONLY	 1	/* Mount read-only */
-#define SB_NOSUID	 2	/* Ignore suid and sgid bits */
-#define SB_NODEV	 4	/* Disallow access to device special files */
-#define SB_NOEXEC	 8	/* Disallow program execution */
-#define SB_SYNCHRONOUS	16	/* Writes are synced at once */
-#define SB_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define SB_DIRSYNC	128	/* Directory modifications are synchronous */
-#define SB_NOATIME	1024	/* Do not update access times. */
-#define SB_NODIRATIME	2048	/* Do not update directory access times */
-#define SB_SILENT	32768
-#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
-#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
-#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
+#define SB_RDONLY       BIT(0)	/* Mount read-only */
+#define SB_NOSUID       BIT(1)	/* Ignore suid and sgid bits */
+#define SB_NODEV        BIT(2)	/* Disallow access to device special files */
+#define SB_NOEXEC       BIT(3)	/* Disallow program execution */
+#define SB_SYNCHRONOUS  BIT(4)	/* Writes are synced at once */
+#define SB_MANDLOCK     BIT(6)	/* Allow mandatory locks on an FS */
+#define SB_DIRSYNC      BIT(7)	/* Directory modifications are synchronous */
+#define SB_NOATIME      BIT(10)	/* Do not update access times. */
+#define SB_NODIRATIME   BIT(11)	/* Do not update directory access times */
+#define SB_SILENT       BIT(15)
+#define SB_POSIXACL     BIT(16)	/* VFS does not apply the umask */
+#define SB_KERNMOUNT    BIT(22)	/* this is a kern_mount call */
+#define SB_I_VERSION    BIT(23)	/* Update inode I_version field */
+#define SB_LAZYTIME     BIT(25)	/* Update the on-disk [acm]times lazily */
 
 /* These sb flags are internal to the kernel */
-#define SB_SUBMOUNT     (1<<26)
-#define SB_FORCE    	(1<<27)
-#define SB_NOSEC	(1<<28)
-#define SB_BORN		(1<<29)
-#define SB_ACTIVE	(1<<30)
-#define SB_NOUSER	(1<<31)
+#define SB_SUBMOUNT     BIT(26)
+#define SB_FORCE        BIT(27)
+#define SB_NOSEC        BIT(28)
+#define SB_BORN         BIT(29)
+#define SB_ACTIVE       BIT(30)
+#define SB_NOUSER       BIT(31)
 
 /*
  *	Umount options
-- 
2.39.2



