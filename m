Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78D77323DC
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 01:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbjFOXrv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 19:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbjFOXrk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 19:47:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55383295B
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 16:47:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569e7aec37bso3247137b3.2
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686872858; x=1689464858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EY7LZ0z0er5tpNAeNV4NbUJ4wkE8ArklKncpS4EePqs=;
        b=BE3qWZ5hzMOxsm1HH7wjTVeWhAE1etXxCQkCDw8l6EJpwFS0D8SVbXV1D8pb3Hhtcb
         dN00my9qr6B5TLM+3dbon7yeoBBoHK0hI/mr+M8AWfJ5xLm1SkF+3Qq5Rf77zJmOvvC7
         lH+nI10rJAci5baWo7JxZLXufwRu9tfowboKOoKUQU1Q/muS7AQf/CqCPX1nNoaBWgeJ
         IKqdgDhfpa10etNVoJV9G4gu2fvyp6BY47tpA5cBGzpz2DnK1lhG7h94SdqTVVULqubE
         D2/Sf7/LBkyjL2kibX2MFp60iyYpRRFjc5ppWuyZlFSRDKps1FoJ9KKZgM5lhZQ3JvPW
         9DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686872858; x=1689464858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EY7LZ0z0er5tpNAeNV4NbUJ4wkE8ArklKncpS4EePqs=;
        b=aXjLizKWRzntXhWrlsTsjImtAfFwZXybBnQBr2fKZHWEhwoNh0+WlMVi/UyezhnSrH
         8h2TqI1+TOezAqzcukpv6UknK0d+eqMw1zph223V+3hzxswskWKWV2wcu1SuZxn9CVma
         R7LWT0DaPk2HTbWckYrNSVrmiWMukFr94uOT676kD3y1sYh0pCHSrZrX8ZNXrW9x22zB
         d1NMpgHemn9ThYl4AH6dQj/B6h9mfCDMog+c2XkH0K1whDJNrAad4vIlFQ4B994viUFU
         YLXkoMHEuf8vbC113L4WbGOpfD/Fgq2dCZooEtSuU9cHjSipl8suWmxtIjI5niplY0OO
         g2Dw==
X-Gm-Message-State: AC+VfDwHFHkNwrbnC2ZAPAXe/pvKurd3o/N2lZsNLqKBhfgPILsZCCpq
        vLkA+I0WZCTUXU2/MQlTJ6Lh57jJ9HHKu6WF6Wl7qoIKKhrlkUQ74rs/onaNAh2hTAi+fYnGEpn
        w3MAiijh/arAQ2ksjHSlGv0DlLzR8ca4z2sbH2E0s0a30t0z4wzR/ALkmtc0Jbw9QfY8V9A==
X-Google-Smtp-Source: ACHHUZ63jCnmQygOpR7dWIgpkyu8NNUcZph6Ja+KjYeJRKFW65CNp2cPkM6IuxCQfPzfFD6IdSAm3LBPJUsFRYQ=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a5b:f88:0:b0:bc5:4150:8e8d with SMTP id
 q8-20020a5b0f88000000b00bc541508e8dmr91916ybh.4.1686872858579; Thu, 15 Jun
 2023 16:47:38 -0700 (PDT)
Date:   Thu, 15 Jun 2023 23:47:07 +0000
In-Reply-To: <2023061126-outthink-improvise-7307@gregkh>
Mime-Version: 1.0
References: <2023061126-outthink-improvise-7307@gregkh>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230615234707.3389367-1-tjmercier@google.com>
Subject: [PATCH 5.10.y] cgroup: always put cset in cgroup_css_set_put_fork
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
index 684c16849eff..f123b7f64249 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6138,19 +6138,18 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
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

