Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23173E7B7
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjFZSSF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjFZSSC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE48CC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0FE460F3E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03678C433C0;
        Mon, 26 Jun 2023 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803480;
        bh=F4Fov9c1gQrz7jghtVneAvVJDKLt0AAP3W/pqdwPAuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cUdn1clK91ISMhZ0NCY+Cn7YvK44egU6e7orgAn4yeFWro5wG4gea4W6dnaL+mtpX
         Iq+UhMgm7ID5KiL0po+ru8MVWomkFmBmVcJTngao6G2sTTHtmMaxWwL6j8qD2GeEcE
         Pf9hDr0jq/B6aWxr2dbjzoaZ6jgnxBUjPmO1lUzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot <syzbot+2ab700fe1829880a2ec6@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.3 076/199] cgroup,freezer: hold cpu_hotplug_lock before freezer_mutex in freezer_css_{online,offline}()
Date:   Mon, 26 Jun 2023 20:09:42 +0200
Message-ID: <20230626180808.885815757@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit f0cc749254d12c78e93dae3b27b21dc9546843d0 upstream.

syzbot is again reporting circular locking dependency between
cpu_hotplug_lock and freezer_mutex. Do like what we did with
commit 57dcd64c7e036299 ("cgroup,freezer: hold cpu_hotplug_lock
before freezer_mutex").

Reported-by: syzbot <syzbot+2ab700fe1829880a2ec6@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=2ab700fe1829880a2ec6
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+2ab700fe1829880a2ec6@syzkaller.appspotmail.com>
Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cgroup/legacy_freezer.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -108,16 +108,18 @@ static int freezer_css_online(struct cgr
 	struct freezer *freezer = css_freezer(css);
 	struct freezer *parent = parent_freezer(freezer);
 
+	cpus_read_lock();
 	mutex_lock(&freezer_mutex);
 
 	freezer->state |= CGROUP_FREEZER_ONLINE;
 
 	if (parent && (parent->state & CGROUP_FREEZING)) {
 		freezer->state |= CGROUP_FREEZING_PARENT | CGROUP_FROZEN;
-		static_branch_inc(&freezer_active);
+		static_branch_inc_cpuslocked(&freezer_active);
 	}
 
 	mutex_unlock(&freezer_mutex);
+	cpus_read_unlock();
 	return 0;
 }
 
@@ -132,14 +134,16 @@ static void freezer_css_offline(struct c
 {
 	struct freezer *freezer = css_freezer(css);
 
+	cpus_read_lock();
 	mutex_lock(&freezer_mutex);
 
 	if (freezer->state & CGROUP_FREEZING)
-		static_branch_dec(&freezer_active);
+		static_branch_dec_cpuslocked(&freezer_active);
 
 	freezer->state = 0;
 
 	mutex_unlock(&freezer_mutex);
+	cpus_read_unlock();
 }
 
 static void freezer_css_free(struct cgroup_subsys_state *css)


