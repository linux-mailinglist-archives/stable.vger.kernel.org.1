Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880697323E0
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 01:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjFOXtF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 19:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjFOXtE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 19:49:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607BE2110
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 16:49:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57059f90cc5so2853217b3.0
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 16:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686872941; x=1689464941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zOwC959QY8dj1xin0yemzLxOjGmefW4gmMyZQxqnmU=;
        b=u+/nCIES4fita/jdmpFjV1uhpYEsG9AgbNkc6RP3uaFtqY2etEe6cff1EW1QD5i4hi
         DxXVEQBhctzU+LG5Zv9f5XW72AB9GeXX0H+z8/yrtFbRbgVKIHf60R2yE2Ck4fnusVnm
         mvjQSH8f2MUNKDK1ZQFMhmaNXWI4qNafCt4JHMNSNqsopZHf8/+L/whj/Ah0z2otzXeu
         b8dSZkXnGiawc7Z11iS3GEWGCgPUSVzxFqeY6NsDETJhrqmr4ub08Sqt1NNx5UBfGV8A
         ymI7SKoIcWiaOPl50mnLTYN5O60JbCbEAqJqjRhck6AmjIVPcmnNQIThInAwnVibxwOU
         p7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686872941; x=1689464941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zOwC959QY8dj1xin0yemzLxOjGmefW4gmMyZQxqnmU=;
        b=BJJg/yz7QNkZDDp5FwF+SLHDjFdGJobmZ3Sl7xIZxYmJfRwxCKzoJHYwjGG64LeSRH
         V6E1PeM6U0EzPWl8t/lQEdNRW3il9Jlf8PJ4EIVFwLwlfKiKHuRhRRdffLEgP7bw6rAo
         UsPpB9SnkiLf2BcFoeLkbeyYKMd9Np7NZhJbPv1jYk5Gra6bPzG7/h0OKUF18mvR3tCn
         R6SRqSYVEprZX2jp3Bi5rnHBkJXLdBl5EwDbqcplxZWrv0jkxux792Qbg+a9hVBn0TzQ
         QWbcJrN1izU5VIp8UE2IKSiTSjV2SQKu6Y54uPxIZomyyN2ELEJwXK8Rnt9SUHXrM328
         pA2A==
X-Gm-Message-State: AC+VfDwgORz7JqHD7jx+xIx6vR9gCeXFftHVrb7RStyyPpBVzzEUBteA
        e+xd/Kwq22SDqiKOJztrxybJrcb5J23p/DJrsvVZNDjofggDlqJC9nW9Q9yTlyYfLBgZgNPUwgp
        QPMSPlybZ3WF+RiPA98PVCskGi8WwWAN+8ALpmern64KQQsovilN1zD0nHu5iV31BMdr8lA==
X-Google-Smtp-Source: ACHHUZ6BohvayuRov6XQ+RphVFWVR1FE85WJtX/DEOAG1U35jIgUBJDEhQGz8jgYpPoUZ33n5QuR37PjlAjPu3M=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a81:ad15:0:b0:56c:b037:88aa with SMTP id
 l21-20020a81ad15000000b0056cb03788aamr77517ywh.5.1686872941590; Thu, 15 Jun
 2023 16:49:01 -0700 (PDT)
Date:   Thu, 15 Jun 2023 23:48:55 +0000
In-Reply-To: <2023061123-camcorder-shed-f888@gregkh>
Mime-Version: 1.0
References: <2023061123-camcorder-shed-f888@gregkh>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230615234855.3390662-1-tjmercier@google.com>
Subject: [PATCH 6.1.y] cgroup: always put cset in cgroup_css_set_put_fork
From:   "T.J. Mercier" <tjmercier@google.com>
To:     stable@vger.kernel.org
Cc:     kernel-team@android.com, John Sperbeck <jsperbeck@google.com>,
        Tejun Heo <tj@kernel.org>,
        "T . J . Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: John Sperbeck <jsperbeck@google.com>

commit 2bd110339288c18823dcace602b63b0d8627e520 upstream

A successful call to cgroup_css_set_fork() will always have taken
a ref on kargs->cset (regardless of CLONE_INTO_CGROUP), so always
do a corresponding put in cgroup_css_set_put_fork().

Without this, a cset and its contained css structures will be
leaked for some fork failures.  The following script reproduces
the leak for a fork failure due to exceeding pids.max in the
pids controller.  A similar thing can happen if we jump to the
bad_fork_cancel_cgroup label in copy_process().

[ -z "$1" ] && echo "Usage $0 pids-root" && exit 1
PID_ROOT=$1
CGROUP=$PID_ROOT/foo

[ -e $CGROUP ] && rmdir -f $CGROUP
mkdir $CGROUP
echo 5 > $CGROUP/pids.max
echo $$ > $CGROUP/cgroup.procs

fork_bomb()
{
	set -e
	for i in $(seq 10); do
		/bin/sleep 3600 &
	done
}

(fork_bomb) &
wait
echo $$ > $PID_ROOT/cgroup.procs
kill $(cat $CGROUP/cgroup.procs)
rmdir $CGROUP

Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
Cc: stable@vger.kernel.org # v5.7+
Signed-off-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Tested-by: T.J. Mercier <tjmercier@google.com>
(cherry picked from commit 2bd110339288c18823dcace602b63b0d8627e520)
[TJM: This backport accommodates the lack of cgroup_unlock]
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/cgroup/cgroup.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2319946715e0..fe33528d70fb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6471,19 +6471,18 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
 	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
 {
+	struct cgroup *cgrp = kargs->cgrp;
+	struct css_set *cset = kargs->cset;
+
 	cgroup_threadgroup_change_end(current);
 
-	if (kargs->flags & CLONE_INTO_CGROUP) {
-		struct cgroup *cgrp = kargs->cgrp;
-		struct css_set *cset = kargs->cset;
+	if (cset) {
+		put_css_set(cset);
+		kargs->cset = NULL;
+	}
 
+	if (kargs->flags & CLONE_INTO_CGROUP) {
 		mutex_unlock(&cgroup_mutex);
-
-		if (cset) {
-			put_css_set(cset);
-			kargs->cset = NULL;
-		}
-
 		if (cgrp) {
 			cgroup_put(cgrp);
 			kargs->cgrp = NULL;
-- 
2.41.0.162.gfafddb0af9-goog

