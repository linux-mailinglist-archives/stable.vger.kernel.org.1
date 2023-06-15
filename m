Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8997323E1
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 01:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjFOXtg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 19:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjFOXtf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 19:49:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592D81BC
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 16:49:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc505a8dd60so73589276.2
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 16:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686872973; x=1689464973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXvtJIfacakp6Xrtgw7rC9+msXovTjsmeT2PuTLr0Dk=;
        b=xPT7zCs8/lLn+pDDadEQn/kqsOeCIc188eoNLXawU2PZ10/bGprmxt0NwTUdeQ+Zjf
         sE/rk/1ZmQfXSHbbU1MpQIhF17H26FypXISsXjCcVvrPiCTyQJkeEspsNTcyvV1I+D6V
         YFTHYSUSjL3Ij7VWQPUC1qexjQ4KrwNsGF0PXdIxTf785nfBkqTJyynaUsVeesBD/K+K
         J449sXC2+IUC3nNLwB7RyX4x7HtoJoH+G9IdVMIKnXeIjMOmoO/o4mjm4UeGuNOkZqtL
         UVXzRMDYZlT3315Whm3EWIcitVAjmoTL2VxOkv09urjU2IwmVIvBb4FBfq01Tk/SBB0U
         +gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686872973; x=1689464973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXvtJIfacakp6Xrtgw7rC9+msXovTjsmeT2PuTLr0Dk=;
        b=IT5/JSGGqCBoE7DVH8M1fj2Iw13ZJdT+d77iOLIWzEGRIEZBwAAlk4mqGgh+CUXf5Z
         x5fpS2wxu32K6BjlU3dwKrlrQ5yN8KU8rBABPCSxVNXWE5JWNouZF4qq+E+WCsb8qHY1
         beBkvqe7w9GlXrnV23WcZlkC3SWkPR4VGco1RS1CbDldDoPJydzOzGJE8JbKSU/CCgRe
         7jtmXxff3YOZgK0GsaI0H9gvk1hBINzvtcMXBdJCOBeaBNHbG5ZKpTJo720C26Vcs3f/
         vPmlx4fS8n3/3G6t4EVjRbxaxNIKuBs+lTu1MkIEQbIGPjCsu+rAop2EZhml1/WVao01
         i3Rw==
X-Gm-Message-State: AC+VfDwNKKcR68DyEtcWb3pdI8aWd8M9oq0l13z6S3uTY01Z2guJ74ME
        RWx+nf6hz3c4O3iyiw8a+xuykf6QnciR5+8OSbU8dUYAz1T7f1sI5Y4HV51NV0rYTqMltoFRes3
        W+51m/XyKa8q1eDqvkMRIRI+01KnBcnGtIYIZ3BqyqETCl5V/4OKaZg/Xbw5lGtjIPUMMUg==
X-Google-Smtp-Source: ACHHUZ6u//SHeeMjBIezj4nAGdzoUPsngYx+/1emfp7bW6gqpv0F/XQMyNg8iPknv/Sx66dRbzp1HOhsPbRPQ4Q=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a25:e751:0:b0:bac:a7d5:f895 with SMTP id
 e78-20020a25e751000000b00baca7d5f895mr66947ybh.10.1686872973537; Thu, 15 Jun
 2023 16:49:33 -0700 (PDT)
Date:   Thu, 15 Jun 2023 23:49:27 +0000
In-Reply-To: <2023061122-spherical-drone-089d@gregkh>
Mime-Version: 1.0
References: <2023061122-spherical-drone-089d@gregkh>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230615234927.3391123-1-tjmercier@google.com>
Subject: [PATCH 6.3.y] cgroup: always put cset in cgroup_css_set_put_fork
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
index 935e8121b21e..1605a6744458 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6476,19 +6476,18 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
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

