Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450077A398E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbjIQTvA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbjIQTuy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:50:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B5DC6
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:50:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8F3C433C8;
        Sun, 17 Sep 2023 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980248;
        bh=ke7IPsbQ8+VVgMAgqTosc+thZe7aST4kpTri5PLwjuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FRgwnHsff95owSKjiDR70gd9A+urcq2To6fP98pd4C+mpl9m/ouAwg54jMii4WlDy
         8uNqUi8Hoj/IFk9VjQfrwLypILV2dRZajAAlYFm693/SvE6HuqFBJcdtKM9ZDQAbr2
         bnlrr0bhzUBUVU/G9jpse25jro1PkdyYVcvwkJMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yonghong Song <yonghong.song@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 100/285] selftests/bpf: Fix flaky cgroup_iter_sleepable subtest
Date:   Sun, 17 Sep 2023 21:11:40 +0200
Message-ID: <20230917191055.141824990@linuxfoundation.org>
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

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 5439cfa7fe612e7d02d5a1234feda3fa6e483ba7 ]

Occasionally, with './test_progs -j' on my vm, I will hit the
following failure:

  test_cgrp_local_storage:PASS:join_cgroup /cgrp_local_storage 0 nsec
  test_cgroup_iter_sleepable:PASS:skel_open 0 nsec
  test_cgroup_iter_sleepable:PASS:skel_load 0 nsec
  test_cgroup_iter_sleepable:PASS:attach_iter 0 nsec
  test_cgroup_iter_sleepable:PASS:iter_create 0 nsec
  test_cgroup_iter_sleepable:FAIL:cgroup_id unexpected cgroup_id: actual 1 != expected 2812
  #48/5    cgrp_local_storage/cgroup_iter_sleepable:FAIL
  #48      cgrp_local_storage:FAIL

Finally, I decided to do some investigation since the test is introduced
by myself. It turns out the reason is due to cgroup_fd with value 0.
In cgroup_iter, a cgroup_fd of value 0 means the root cgroup.

	/* from cgroup_iter.c */
        if (fd)
                cgrp = cgroup_v1v2_get_from_fd(fd);
        else if (id)
                cgrp = cgroup_get_from_id(id);
        else /* walk the entire hierarchy by default. */
                cgrp = cgroup_get_from_path("/");

That is why we got cgroup_id 1 instead of expected 2812.

Why we got a cgroup_fd 0? Nobody should really touch 'stdin' (fd 0) in
test_progs. I traced 'close' syscall with stack trace and found the root
cause, which is a bug in bpf_obj_pinning.c. Basically, the code closed
fd 0 although it should not. Fixing the bug in bpf_obj_pinning.c also
resolved the above cgroup_iter_sleepable subtest failure.

Fixes: 3b22f98e5a05 ("selftests/bpf: Add path_fd-based BPF_OBJ_PIN and BPF_OBJ_GET tests")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230827150551.1743497-1-yonghong.song@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c b/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
index 31f1e815f6719..ee0458a5ce789 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
@@ -8,6 +8,7 @@
 #include <linux/unistd.h>
 #include <linux/mount.h>
 #include <sys/syscall.h>
+#include "bpf/libbpf_internal.h"
 
 static inline int sys_fsopen(const char *fsname, unsigned flags)
 {
@@ -155,7 +156,7 @@ static void validate_pin(int map_fd, const char *map_name, int src_value,
 	ASSERT_OK(err, "obj_pin");
 
 	/* cleanup */
-	if (pin_opts.path_fd >= 0)
+	if (path_kind == PATH_FD_REL && pin_opts.path_fd >= 0)
 		close(pin_opts.path_fd);
 	if (old_cwd[0])
 		ASSERT_OK(chdir(old_cwd), "restore_cwd");
@@ -220,7 +221,7 @@ static void validate_get(int map_fd, const char *map_name, int src_value,
 		goto cleanup;
 
 	/* cleanup */
-	if (get_opts.path_fd >= 0)
+	if (path_kind == PATH_FD_REL && get_opts.path_fd >= 0)
 		close(get_opts.path_fd);
 	if (old_cwd[0])
 		ASSERT_OK(chdir(old_cwd), "restore_cwd");
-- 
2.40.1



