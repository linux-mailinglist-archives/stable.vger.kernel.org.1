Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C8B70C6EA
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjEVTX4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjEVTXx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFA6130
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA313620F6
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7284C433EF;
        Mon, 22 May 2023 19:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783423;
        bh=rYZrg77V0kPz+JvyHibL5KUx11BdL3H4k3HV6nJG2QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFTF4UzWFR4tbUjN/Q7kZP4yR5CYu34my5E9iqzjt0nv0piItfd3DmP6sIEqDx+gV
         mkev5ysvVV/ROVIeWbmfzWuywylv7uPr5RiMET/8x7YHaNcYDdg6H+K3yqn/11dl1V
         2z57+shE8QaNbOcQz7r0w8ow+DBn0Xu9dc3Qfxa8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pedro Falcato <pedro.falcato@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 039/292] open: return EINVAL for O_DIRECTORY | O_CREAT
Date:   Mon, 22 May 2023 20:06:36 +0100
Message-Id: <20230522190406.876202437@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 43b450632676fb60e9faeddff285d9fac94a4f58 ]

After a couple of years and multiple LTS releases we received a report
that the behavior of O_DIRECTORY | O_CREAT changed starting with v5.7.

On kernels prior to v5.7 combinations of O_DIRECTORY, O_CREAT, O_EXCL
had the following semantics:

(1) open("/tmp/d", O_DIRECTORY | O_CREAT)
    * d doesn't exist:                create regular file
    * d exists and is a regular file: ENOTDIR
    * d exists and is a directory:    EISDIR

(2) open("/tmp/d", O_DIRECTORY | O_CREAT | O_EXCL)
    * d doesn't exist:                create regular file
    * d exists and is a regular file: EEXIST
    * d exists and is a directory:    EEXIST

(3) open("/tmp/d", O_DIRECTORY | O_EXCL)
    * d doesn't exist:                ENOENT
    * d exists and is a regular file: ENOTDIR
    * d exists and is a directory:    open directory

On kernels since to v5.7 combinations of O_DIRECTORY, O_CREAT, O_EXCL
have the following semantics:

(1) open("/tmp/d", O_DIRECTORY | O_CREAT)
    * d doesn't exist:                ENOTDIR (create regular file)
    * d exists and is a regular file: ENOTDIR
    * d exists and is a directory:    EISDIR

(2) open("/tmp/d", O_DIRECTORY | O_CREAT | O_EXCL)
    * d doesn't exist:                ENOTDIR (create regular file)
    * d exists and is a regular file: EEXIST
    * d exists and is a directory:    EEXIST

(3) open("/tmp/d", O_DIRECTORY | O_EXCL)
    * d doesn't exist:                ENOENT
    * d exists and is a regular file: ENOTDIR
    * d exists and is a directory:    open directory

This is a fairly substantial semantic change that userspace didn't
notice until Pedro took the time to deliberately figure out corner
cases. Since no one noticed this breakage we can somewhat safely assume
that O_DIRECTORY | O_CREAT combinations are likely unused.

The v5.7 breakage is especially weird because while ENOTDIR is returned
indicating failure a regular file is actually created. This doesn't make
a lot of sense.

Time was spent finding potential users of this combination. Searching on
codesearch.debian.net showed that codebases often express semantical
expectations about O_DIRECTORY | O_CREAT which are completely contrary
to what our code has done and currently does.

The expectation often is that this particular combination would create
and open a directory. This suggests users who tried to use that
combination would stumble upon the counterintuitive behavior no matter
if pre-v5.7 or post v5.7 and quickly realize neither semantics give them
what they want. For some examples see the code examples in [1] to [3]
and the discussion in [4].

There are various ways to address this issue. The lazy/simple option
would be to restore the pre-v5.7 behavior and to just live with that bug
forever. But since there's a real chance that the O_DIRECTORY | O_CREAT
quirk isn't relied upon we should try to get away with murder(ing bad
semantics) first. If we need to Frankenstein pre-v5.7 behavior later so
be it.

So let's simply return EINVAL categorically for O_DIRECTORY | O_CREAT
combinations. In addition to cleaning up the old bug this also opens up
the possiblity to make that flag combination do something more intuitive
in the future.

Starting with this commit the following semantics apply:

(1) open("/tmp/d", O_DIRECTORY | O_CREAT)
    * d doesn't exist:                EINVAL
    * d exists and is a regular file: EINVAL
    * d exists and is a directory:    EINVAL

(2) open("/tmp/d", O_DIRECTORY | O_CREAT | O_EXCL)
    * d doesn't exist:                EINVAL
    * d exists and is a regular file: EINVAL
    * d exists and is a directory:    EINVAL

(3) open("/tmp/d", O_DIRECTORY | O_EXCL)
    * d doesn't exist:                ENOENT
    * d exists and is a regular file: ENOTDIR
    * d exists and is a directory:    open directory

One additional note, O_TMPFILE is implemented as:

    #define __O_TMPFILE    020000000
    #define O_TMPFILE      (__O_TMPFILE | O_DIRECTORY)
    #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)

For older kernels it was important to return an explicit error when
O_TMPFILE wasn't supported. So O_TMPFILE requires that O_DIRECTORY is
raised alongside __O_TMPFILE. It also enforced that O_CREAT wasn't
specified. Since O_DIRECTORY | O_CREAT could be used to create a regular
allowing that combination together with __O_TMPFILE would've meant that
false positives were possible, i.e., that a regular file was created
instead of a O_TMPFILE. This could've been used to trick userspace into
thinking it operated on a O_TMPFILE when it wasn't.

Now that we block O_DIRECTORY | O_CREAT completely the check for O_CREAT
in the __O_TMPFILE branch via if ((flags & O_TMPFILE_MASK) != O_TMPFILE)
can be dropped. Instead we can simply check verify that O_DIRECTORY is
raised via if (!(flags & O_DIRECTORY)) and explain this in two comments.

As Aleksa pointed out O_PATH is unaffected by this change since it
always returned EINVAL if O_CREAT was specified - with or without
O_DIRECTORY.

Link: https://lore.kernel.org/lkml/20230320071442.172228-1-pedro.falcato@gmail.com
Link: https://sources.debian.org/src/flatpak/1.14.4-1/subprojects/libglnx/glnx-dirfd.c/?hl=324#L324 [1]
Link: https://sources.debian.org/src/flatpak-builder/1.2.3-1/subprojects/libglnx/glnx-shutil.c/?hl=251#L251 [2]
Link: https://sources.debian.org/src/ostree/2022.7-2/libglnx/glnx-dirfd.c/?hl=324#L324 [3]
Link: https://www.openwall.com/lists/oss-security/2014/11/26/14 [4]
Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/open.c                              | 18 +++++++++++++-----
 include/uapi/asm-generic/fcntl.h       |  1 -
 tools/include/uapi/asm-generic/fcntl.h |  1 -
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 20717ec510c07..9541430ec5b30 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1158,13 +1158,21 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	}
 
 	/*
-	 * In order to ensure programs get explicit errors when trying to use
-	 * O_TMPFILE on old kernels, O_TMPFILE is implemented such that it
-	 * looks like (O_DIRECTORY|O_RDWR & ~O_CREAT) to old kernels. But we
-	 * have to require userspace to explicitly set it.
+	 * Block bugs where O_DIRECTORY | O_CREAT created regular files.
+	 * Note, that blocking O_DIRECTORY | O_CREAT here also protects
+	 * O_TMPFILE below which requires O_DIRECTORY being raised.
 	 */
+	if ((flags & (O_DIRECTORY | O_CREAT)) == (O_DIRECTORY | O_CREAT))
+		return -EINVAL;
+
+	/* Now handle the creative implementation of O_TMPFILE. */
 	if (flags & __O_TMPFILE) {
-		if ((flags & O_TMPFILE_MASK) != O_TMPFILE)
+		/*
+		 * In order to ensure programs get explicit errors when trying
+		 * to use O_TMPFILE on old kernels we enforce that O_DIRECTORY
+		 * is raised alongside __O_TMPFILE.
+		 */
+		if (!(flags & O_DIRECTORY))
 			return -EINVAL;
 		if (!(acc_mode & MAY_WRITE))
 			return -EINVAL;
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 1ecdb911add8d..80f37a0d40d7d 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -91,7 +91,6 @@
 
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
-#define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
 
 #ifndef O_NDELAY
 #define O_NDELAY	O_NONBLOCK
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index b02c8e0f40575..1c7a0f6632c09 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -91,7 +91,6 @@
 
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
-#define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
 
 #ifndef O_NDELAY
 #define O_NDELAY	O_NONBLOCK
-- 
2.39.2



