Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD178ABCF
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjH1Kee (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjH1KeH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:34:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53C1AB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C4D963D24
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30176C433C8;
        Mon, 28 Aug 2023 10:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218833;
        bh=KxvcsIN2Q8nGQ1rDystgEo3sbuVZ4r69ffXhLfhwnTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEIrcfWvJWdRxLkzQ+GaAspaTNOpOLDaFj6w9kEeUE7t6axdpGioBH8oLJhK2QTH9
         A2fhblUwTqEkPZie3c/34aoRcbBfZEfeaYvOW+U8n15RUpk50bZz7ZsvMljbsceSfM
         eAZrXVHI+d0NstZ+9MzYOT4N0EpHbCn4jdIBedPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sherry Yang <sherry.yang@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.1 100/122] nfsd: use vfs setgid helper
Date:   Mon, 28 Aug 2023 12:13:35 +0200
Message-ID: <20230828101159.733955856@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

commit 2d8ae8c417db284f598dffb178cc01e7db0f1821 upstream.

We've aligned setgid behavior over multiple kernel releases. The details
can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
Consistent setgid stripping behavior is now encapsulated in the
setattr_should_drop_sgid() helper which is used by all filesystems that
strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
raised in e.g., chown_common() and is subject to the
setattr_should_drop_sgid() check to determine whether the setgid bit can
be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
will cause notify_change() to strip it even if the caller had the
necessary privileges to retain it. Ensure that nfsd only raises
ATR_KILL_SGID if the caller lacks the necessary privileges to retain the
setgid bit.

Without this patch the setgid stripping tests in LTP will fail:

> As you can see, the problem is S_ISGID (0002000) was dropped on a
> non-group-executable file while chown was invoked by super-user, while

[...]

> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700

[...]

> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700

With this patch all tests pass.

Reported-by: Sherry Yang <sherry.yang@oracle.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[Harshit: backport to 6.1.y:
 Use init_user_ns instead of nop_mnt_idmap as we don't have
 commit abf08576afe3 ("fs: port vfs_*() helpers to struct mnt_idmap")]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/vfs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -321,7 +321,9 @@ nfsd_sanitize_attrs(struct inode *inode,
 				iap->ia_mode &= ~S_ISGID;
 		} else {
 			/* set ATTR_KILL_* bits and let VFS handle it */
-			iap->ia_valid |= (ATTR_KILL_SUID | ATTR_KILL_SGID);
+			iap->ia_valid |= ATTR_KILL_SUID;
+			iap->ia_valid |=
+				setattr_should_drop_sgid(&init_user_ns, inode);
 		}
 	}
 }


