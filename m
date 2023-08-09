Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E299775DFE
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjHILnC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjHILnC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:43:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F351FFA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:42:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB1F63711
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78074C433C7;
        Wed,  9 Aug 2023 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581376;
        bh=I1GJuImQ15PpH6XRavHBpzK0jiCeHbc9K828tS6HhOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0+xQ8KWDrH9q2uwItcbnH26E5o8SrY1IRywmMUVRFlvtMGVRAwcKKDuTeqmWR34nb
         zaSiD3VkFOmIXe5vMytKc/D6oCORpVyR0alvq5430MJaQWM4HM5lpxI2Nd0r7PwPw/
         p0oChlcECPuyauH5HC2woSp9pHc43ZSK3uheBhw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.10 181/201] fs: Protect reconfiguration of sb read-write from racing writes
Date:   Wed,  9 Aug 2023 12:43:03 +0200
Message-ID: <20230809103649.840448040@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jan Kara <jack@suse.cz>

commit c541dce86c537714b6761a79a969c1623dfa222b upstream.

The reconfigure / remount code takes a lot of effort to protect
filesystem's reconfiguration code from racing writes on remounting
read-only. However during remounting read-only filesystem to read-write
mode userspace writes can start immediately once we clear SB_RDONLY
flag. This is inconvenient for example for ext4 because we need to do
some writes to the filesystem (such as preparation of quota files)
before we can take userspace writes so we are clearing SB_RDONLY flag
before we are fully ready to accept userpace writes and syzbot has found
a way to exploit this [1]. Also as far as I'm reading the code
the filesystem remount code was protected from racing writes in the
legacy mount path by the mount's MNT_READONLY flag so this is relatively
new problem. It is actually fairly easy to protect remount read-write
from racing writes using sb->s_readonly_remount flag so let's just do
that instead of having to workaround these races in the filesystem code.

[1] https://lore.kernel.org/all/00000000000006a0df05f6667499@google.com/T/

Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230615113848.8439-1-jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/super.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/fs/super.c
+++ b/fs/super.c
@@ -906,6 +906,7 @@ int reconfigure_super(struct fs_context
 	struct super_block *sb = fc->root->d_sb;
 	int retval;
 	bool remount_ro = false;
+	bool remount_rw = false;
 	bool force = fc->sb_flags & SB_FORCE;
 
 	if (fc->sb_flags_mask & ~MS_RMT_MASK)
@@ -922,7 +923,7 @@ int reconfigure_super(struct fs_context
 		if (!(fc->sb_flags & SB_RDONLY) && bdev_read_only(sb->s_bdev))
 			return -EACCES;
 #endif
-
+		remount_rw = !(fc->sb_flags & SB_RDONLY) && sb_rdonly(sb);
 		remount_ro = (fc->sb_flags & SB_RDONLY) && !sb_rdonly(sb);
 	}
 
@@ -952,6 +953,14 @@ int reconfigure_super(struct fs_context
 			if (retval)
 				return retval;
 		}
+	} else if (remount_rw) {
+		/*
+		 * We set s_readonly_remount here to protect filesystem's
+		 * reconfigure code from writes from userspace until
+		 * reconfigure finishes.
+		 */
+		sb->s_readonly_remount = 1;
+		smp_wmb();
 	}
 
 	if (fc->ops->reconfigure) {


