Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8046B6FA564
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjEHKI6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjEHKI5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B673293D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A16862395
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BE1C433EF;
        Mon,  8 May 2023 10:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540534;
        bh=aOzlE+ANOfR7mTJy+fxUnHQ1jqdFhdAPuhJ7O6Q5pnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jx11i5Cch/VXVQ/Bf3HhfcPiApLUS+uFhxNuqlu5GGUOSplC1NraWLOp0bw7jmz2O
         B9g+BqvToKSS4iMyl0w4QCzGzo29HMcasOzzr78hl/nKrMCiEdSlnFCGmGQzMXxxxi
         L3UYh4vQp263vgJa+nmsklP+uw0IL+Ph9HLds4Lc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        =?UTF-8?q?Chunhui=20Li=20 ?= <chunhui.li@mediatek.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 401/611] pstore: Revert pmsg_lock back to a normal mutex
Date:   Mon,  8 May 2023 11:44:03 +0200
Message-Id: <20230508094435.312510323@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: John Stultz <jstultz@google.com>

[ Upstream commit 5239a89b06d6b199f133bf0ffea421683187f257 ]

This reverts commit 76d62f24db07f22ccf9bc18ca793c27d4ebef721.

So while priority inversion on the pmsg_lock is an occasional
problem that an rt_mutex would help with, in uses where logging
is writing to pmsg heavily from multiple threads, the pmsg_lock
can be heavily contended.

After this change landed, it was reported that cases where the
mutex locking overhead was commonly adding on the order of 10s
of usecs delay had suddenly jumped to ~msec delay with rtmutex.

It seems the slight differences in the locks under this level
of contention causes the normal mutexes to utilize the spinning
optimizations, while the rtmutexes end up in the sleeping
slowpath (which allows additional threads to pile on trying
to take the lock).

In this case, it devolves to a worse case senerio where the lock
acquisition and scheduling overhead dominates, and each thread
is waiting on the order of ~ms to do ~us of work.

Obviously, having tons of threads all contending on a single
lock for logging is non-optimal, so the proper fix is probably
reworking pstore pmsg to have per-cpu buffers so we don't have
contention.

Additionally, Steven Rostedt has provided some furhter
optimizations for rtmutexes that improves the rtmutex spinning
path, but at least in my testing, I still see the test tripping
into the sleeping path on rtmutexes while utilizing the spinning
path with mutexes.

But in the short term, lets revert the change to the rt_mutex
and go back to normal mutexes to avoid a potentially major
performance regression. And we can work on optimizations to both
rtmutexes and finer-grained locking for pstore pmsg in the
future.

Cc: Wei Wang <wvw@google.com>
Cc: Midas Chien<midaschieh@google.com>
Cc: "Chunhui Li (李春辉)" <chunhui.li@mediatek.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: kernel-team@android.com
Fixes: 76d62f24db07 ("pstore: Switch pmsg_lock to an rt_mutex to avoid priority inversion")
Reported-by: "Chunhui Li (李春辉)" <chunhui.li@mediatek.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230308204043.2061631-1-jstultz@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/pmsg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index 18cf94b597e05..d8542ec2f38c6 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -7,10 +7,9 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
-#include <linux/rtmutex.h>
 #include "internal.h"
 
-static DEFINE_RT_MUTEX(pmsg_lock);
+static DEFINE_MUTEX(pmsg_lock);
 
 static ssize_t write_pmsg(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
@@ -29,9 +28,9 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
 	if (!access_ok(buf, count))
 		return -EFAULT;
 
-	rt_mutex_lock(&pmsg_lock);
+	mutex_lock(&pmsg_lock);
 	ret = psinfo->write_user(&record, buf);
-	rt_mutex_unlock(&pmsg_lock);
+	mutex_unlock(&pmsg_lock);
 	return ret ? ret : count;
 }
 
-- 
2.39.2



