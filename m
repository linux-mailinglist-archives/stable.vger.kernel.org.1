Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E65775974
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjHILAg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjHILAg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B3DED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6ACA62496
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37CBC433C8;
        Wed,  9 Aug 2023 11:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578834;
        bh=LxxPAO363gau4k3+8+d5yNDcEhAjhPn+8KCtVlaA+Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yloFmPo0GQ2B5F4zJ9W/yTFdZ3rxzHq5mBi1NpeZ08yrFEd6+3hjw8o58TflwtvYb
         +JYdy3sLfCw8SDnW7CQ3fYrDsryE7NdmFPOtB/4nQP5K7KdnvkimWY7Ie4GYMpdTfL
         7i0EpYqt36QJkwAxniQZKWh1+sM2Ucyj/TwNFst8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mateusz Guzik <mjguzik@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.15 73/92] file: reinstate f_pos locking optimization for regular files
Date:   Wed,  9 Aug 2023 12:41:49 +0200
Message-ID: <20230809103636.087989996@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 797964253d358cf8d705614dda394dbe30120223 upstream.

In commit 20ea1e7d13c1 ("file: always lock position for
FMODE_ATOMIC_POS") we ended up always taking the file pos lock, because
pidfd_getfd() could get a reference to the file even when it didn't have
an elevated file count due to threading of other sharing cases.

But Mateusz Guzik reports that the extra locking is actually measurable,
so let's re-introduce the optimization, and only force the locking for
directory traversal.

Directories need the lock for correctness reasons, while regular files
only need it for "POSIX semantics".  Since pidfd_getfd() is about
debuggers etc special things that are _way_ outside of POSIX, we can
relax the rules for that case.

Reported-by: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/linux-fsdevel/20230803095311.ijpvhx3fyrbkasul@f/
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/file.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/fs/file.c
+++ b/fs/file.c
@@ -1062,12 +1062,28 @@ unsigned long __fdget_raw(unsigned int f
 	return __fget_light(fd, 0);
 }
 
+/*
+ * Try to avoid f_pos locking. We only need it if the
+ * file is marked for FMODE_ATOMIC_POS, and it can be
+ * accessed multiple ways.
+ *
+ * Always do it for directories, because pidfd_getfd()
+ * can make a file accessible even if it otherwise would
+ * not be, and for directories this is a correctness
+ * issue, not a "POSIX requirement".
+ */
+static inline bool file_needs_f_pos_lock(struct file *file)
+{
+	return (file->f_mode & FMODE_ATOMIC_POS) &&
+		(file_count(file) > 1 || S_ISDIR(file_inode(file)->i_mode));
+}
+
 unsigned long __fdget_pos(unsigned int fd)
 {
 	unsigned long v = __fdget(fd);
 	struct file *file = (struct file *)(v & ~3);
 
-	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
+	if (file && file_needs_f_pos_lock(file)) {
 		v |= FDPUT_POS_UNLOCK;
 		mutex_lock(&file->f_pos_lock);
 	}


