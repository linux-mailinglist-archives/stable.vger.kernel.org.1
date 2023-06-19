Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9A7354BD
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjFSK6s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjFSK6b (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F0F10F3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 059A460A4D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5F7C433C0;
        Mon, 19 Jun 2023 10:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172202;
        bh=EKZylMj1LczZsez8Yj0cqowH/+6VPMXA/Kin/w/466k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7EReSp6Mb8ytQoQuV6I1qPkW47uJC6NMYlMTxcbMGAjBB84TrTrZY97rndYxlZLj
         XKilCEB9yjZ0aAdSqm1fP/wTdq1e1yAGY59FP5Vabv2OntAWA9Yu0VsLIa6qrX9CmJ
         W6VJKGTUcdKHujCKkLpiTZwdmla/f94lvAeh89G0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Sperbeck <jsperbeck@google.com>,
        Tejun Heo <tj@kernel.org>,
        "T.J. Mercier" <tjmercier@google.com>
Subject: [PATCH 5.10 74/89] cgroup: always put cset in cgroup_css_set_put_fork
Date:   Mon, 19 Jun 2023 12:31:02 +0200
Message-ID: <20230619102141.628803408@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
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

From: John Sperbeck <jsperbeck@google.com>

commit 2bd110339288c18823dcace602b63b0d8627e520 upstream.

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
[TJM: This backport accommodates the lack of cgroup_unlock]
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cgroup/cgroup.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6138,19 +6138,18 @@ err:
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


