Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8937323DF
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 01:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjFOXsb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 19:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbjFOXsa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 19:48:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0B92D65
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 16:48:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5701b4d6ef3so3185397b3.3
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 16:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686872897; x=1689464897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VhJxMN6I0ms8d+c7+U8G+bHs3K5OQrOWF2SVM36do94=;
        b=U4monlo3fzCidxHuzMvMSRZcS30wuRe1/TRhNgADQomOk7e0bbzak/xeWUJznL1gHP
         XdlQDjp2eZCKKZ30shiHzgSW9sZCs58HakxVEpN7JiiHHaIns8d2nr8BYSySjR5Baxx1
         NBLj9fJYN23+HASk6LffJYBn02u9F0yat9BVJ/0P5rI+JrWbyg1gGHGi6zmu9W6OIS4b
         1V0QZmVhZ3bbSpPMNt8tlPdKkXRu8bRYQwtbRnECml4umOqNsJ5OFw6BJAca3wCveF78
         182wI/CamI+MkQCOeGpHoks0HwtJuD4gWOhgmovkPs95c+tLvFnFU4S+qkeB+qloqcX2
         ZV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686872897; x=1689464897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhJxMN6I0ms8d+c7+U8G+bHs3K5OQrOWF2SVM36do94=;
        b=MfHpmJNlmihXTGoJVhJLJppC0mjdgwSE3YoDw/xrQShttpWjJd+iyW6Y1zNyxNwG0H
         azzOVkDcuY2oDEogK+LebziwAoYXk8TsDNjSCE038arLgc5NDUIlM1bxZDq6tQY+OGPC
         XqxvBcEU61F+tC07bPfNaFsStPNSIsFRp9Ov2i7rtdH8UqmZRjzQepK3XWnswvk/Gx6r
         /WwT7MLSlzFFBuR8vR0wViM3Debw/0VzrK/ENdHpL0/jMOeN8ZrodKlMbTBxnC6MTUek
         B7eJ4rrjid2S04szTbkw3bklnDksY4kd2s3jeuYMwl313pzUPrnrkAvwiFlxgPb1IgmD
         J2DA==
X-Gm-Message-State: AC+VfDxoFOe+cK4zFiB32YALgyE+ZHAt9T4WytsACD5CwPWP/VUTTH3b
        C8zup6gdcSLVartDPNbtDTenv/JgkDFeya/0W3LZ4GgPiprOjoguvHo9bFmUWFTVwqOB2XoH6Rg
        sPzBvppFrJ8u7Dy+eE+Ak4RIPRzPxYRBHZKGLl6eeDADmNcFw11zeoNFR8WarPAYOMkqQXA==
X-Google-Smtp-Source: ACHHUZ4RCDblLkbbN6KY3b984aSW4UB4VXdXtN+6clkIVx5rH2NJjySG5WznUcw6r+J7ZqXzJntW1jTCj98cEl4=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a25:15c7:0:b0:bd6:7609:40a3 with SMTP id
 190-20020a2515c7000000b00bd6760940a3mr197740ybv.12.1686872897118; Thu, 15 Jun
 2023 16:48:17 -0700 (PDT)
Date:   Thu, 15 Jun 2023 23:48:06 +0000
In-Reply-To: <2023061125-chop-frequency-0b37@gregkh>
Mime-Version: 1.0
References: <2023061125-chop-frequency-0b37@gregkh>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230615234806.3390147-1-tjmercier@google.com>
Subject: [PATCH 5.15.y] cgroup: always put cset in cgroup_css_set_put_fork
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
index a92990f070d1..edae2f49f73f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6259,19 +6259,18 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
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

