Return-Path: <stable+bounces-47512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B938D0F68
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 23:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175132818F5
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E29353389;
	Mon, 27 May 2024 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuBcZCsn"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1617E8F6
	for <stable@vger.kernel.org>; Mon, 27 May 2024 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845194; cv=none; b=WrtrQNR/jvMxRwna3IntqpLWkbngZT2T1gkQ8lwi4FV5NL8q4jGgOWbdpiOBpAVOl5fkaAiZyFRkQtr+lxIH1Nae44pzIBTo/YWbeXv2U5v2vbyLPD7Q5Za5c48iUM7s7bv82t6fDKvcj7eAB815CMTdXGisS3r1yUmLo0sD5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845194; c=relaxed/simple;
	bh=Z081rUvUDIFa98q1fo0qDQmI8F6YFn8qvaQ3SADexYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCosnGDQ9X7AJLX4ZlHWFedclI7Gbh4iGCPA6SJFw4ad11CBUo2gLZZg7hYs+KzcTbdvymQv5jSX5TGnTJ3XzKnXfBanq982gLaE7c87KBrFx6MreeavvDlBGu8rayagEcd8pIJvqpA7qsQnzYmMGQiksUYgStrhpvVOqdqfcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuBcZCsn; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36db3304053so936125ab.2
        for <stable@vger.kernel.org>; Mon, 27 May 2024 14:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716845192; x=1717449992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii+LmJ10IQo1oIeFkQKnkBYaQ9PvVuKdo2JBzX/W2+o=;
        b=GuBcZCsn12ADECXT0iqY8AD35PT5RvkXDpcY8FxrQuDsv60ey5XdsDjqkPMt5XRsqv
         RHNOWXHNbyKLN862VceK1BiBBSrv9XLacDnk3QBBzFgqa+UpE7VfAeN22O23SXxLFyN7
         t2jB5JOgIZtg6lNtWqQUNBp/6iu+NaQr+8oJ+mGIfI13MuY/3XALwa9Pf0bSAiBzb6G6
         IlHKH4qBj7mCPerr/wtPa/GCCD84oXHId1RHxtzGeKZHf+KTOGwLJlrmObSvgkv28+K/
         VJll4o+3cos1a6cnHNh1rMl/Kiot3PSj99HcbT05Qi+GUozWZhNIi1epeqIE5OfcX9sK
         Lxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716845192; x=1717449992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ii+LmJ10IQo1oIeFkQKnkBYaQ9PvVuKdo2JBzX/W2+o=;
        b=TGLW40a54Tb0CXJk/5mN/ilfRNFqEIS29ui2bszLsxjetTlDbVNVbMKfcjYhXDlKhH
         bsfvkW12YEOg+iat1kX/ATNg/nWDdI+GSgUhYqol4PwaF2adEf3fsXtLHTfLKUbLP4wk
         eTNL7bLflMIlihNbKXm+KMCgDKvfN3OBaba0BeyR9V1HHUEfl1FMnka9bdv54lVV1e6N
         5kp9+vvCSGS9pjvWgp7msfJAMbYpOcsRPiaXqhq/9RAOhLzilCLOgZWQ4u0x2RiqZEhN
         ln/qEiyMk3qvfizFZ52oc830Uh1bJgWLLPG7ZWhjtipT8CN4fm3y8AdgHBxF7Ojc+u9g
         bilg==
X-Gm-Message-State: AOJu0YzNU+eE6v1u3R1qExe5RAQgnVgUDPxlo4hO1rCN4v5LmmWWZyNv
	bL5P211aZIslDFV33CECfE6z1P6XaYN4qnm6YvgxrmaK2D6oXe68+floUw==
X-Google-Smtp-Source: AGHT+IFhehqypfIWObfMV6kXaWQKYsCCVblW6Ms/PCSs5AQ0Huh/LnzkkY1s3I6RjZlyaTPXKAQAEg==
X-Received: by 2002:a05:6e02:15c4:b0:374:5d81:9142 with SMTP id e9e14a558f8ab-3745d819424mr27440965ab.7.1716845191962;
        Mon, 27 May 2024 14:26:31 -0700 (PDT)
Received: from carrot.. (i223-217-95-32.s42.a014.ap.plala.or.jp. [223.217.95.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-68221987266sm6395130a12.33.2024.05.27.14.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 14:26:31 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sjb7183@psu.edu
Subject: [PATCH 4.19 5.4 5.10 5.15 6.1] nilfs2: fix use-after-free of timer for log writer thread
Date: Tue, 28 May 2024 06:26:37 +0900
Message-Id: <20240527212637.5907-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024052603-deceiving-stood-2b59@gregkh>
References: <2024052603-deceiving-stood-2b59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f5d4e04634c9cf68bdf23de08ada0bb92e8befe7 upstream.

Patch series "nilfs2: fix log writer related issues".

This bug fix series covers three nilfs2 log writer-related issues,
including a timer use-after-free issue and potential deadlock issue on
unmount, and a potential freeze issue in event synchronization found
during their analysis.  Details are described in each commit log.

This patch (of 3):

A use-after-free issue has been reported regarding the timer sc_timer on
the nilfs_sc_info structure.

The problem is that even though it is used to wake up a sleeping log
writer thread, sc_timer is not shut down until the nilfs_sc_info structure
is about to be freed, and is used regardless of the thread's lifetime.

Fix this issue by limiting the use of sc_timer only while the log writer
thread is alive.

Link: https://lkml.kernel.org/r/20240520132621.4054-1-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/20240520132621.4054-2-konishi.ryusuke@gmail.com
Fixes: fdce895ea5dd ("nilfs2: change sc_timer from a pointer to an embedded one in struct nilfs_sc_info")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: "Bai, Shuangpeng" <sjb7183@psu.edu>
Closes: https://groups.google.com/g/syzkaller/c/MK_LYqtt8ko/m/8rgdWeseAwAJ
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please apply this patch to the stable trees indicated by the subject
prefix instead of the patch that failed.

This patch is tailored to replace a call to timer_shutdown_sync(), which
does not yet exist in these versions, with an equivalent function call,
and is applicable from v4.15 to v6.1.

Also, all the builds and tests I did on each stable tree passed.

Thanks,
Ryusuke Konishi

 fs/nilfs2/segment.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 006df4eac9fa..dfc459a62fb3 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2159,8 +2159,10 @@ static void nilfs_segctor_start_timer(struct nilfs_sc_info *sci)
 {
 	spin_lock(&sci->sc_state_lock);
 	if (!(sci->sc_state & NILFS_SEGCTOR_COMMIT)) {
-		sci->sc_timer.expires = jiffies + sci->sc_interval;
-		add_timer(&sci->sc_timer);
+		if (sci->sc_task) {
+			sci->sc_timer.expires = jiffies + sci->sc_interval;
+			add_timer(&sci->sc_timer);
+		}
 		sci->sc_state |= NILFS_SEGCTOR_COMMIT;
 	}
 	spin_unlock(&sci->sc_state_lock);
@@ -2378,10 +2380,21 @@ int nilfs_construct_dsync_segment(struct super_block *sb, struct inode *inode,
  */
 static void nilfs_segctor_accept(struct nilfs_sc_info *sci)
 {
+	bool thread_is_alive;
+
 	spin_lock(&sci->sc_state_lock);
 	sci->sc_seq_accepted = sci->sc_seq_request;
+	thread_is_alive = (bool)sci->sc_task;
 	spin_unlock(&sci->sc_state_lock);
-	del_timer_sync(&sci->sc_timer);
+
+	/*
+	 * This function does not race with the log writer thread's
+	 * termination.  Therefore, deleting sc_timer, which should not be
+	 * done after the log writer thread exits, can be done safely outside
+	 * the area protected by sc_state_lock.
+	 */
+	if (thread_is_alive)
+		del_timer_sync(&sci->sc_timer);
 }
 
 /**
@@ -2407,7 +2420,7 @@ static void nilfs_segctor_notify(struct nilfs_sc_info *sci, int mode, int err)
 			sci->sc_flush_request &= ~FLUSH_DAT_BIT;
 
 		/* re-enable timer if checkpoint creation was not done */
-		if ((sci->sc_state & NILFS_SEGCTOR_COMMIT) &&
+		if ((sci->sc_state & NILFS_SEGCTOR_COMMIT) && sci->sc_task &&
 		    time_before(jiffies, sci->sc_timer.expires))
 			add_timer(&sci->sc_timer);
 	}
@@ -2597,6 +2610,7 @@ static int nilfs_segctor_thread(void *arg)
 	int timeout = 0;
 
 	sci->sc_timer_task = current;
+	timer_setup(&sci->sc_timer, nilfs_construction_timeout, 0);
 
 	/* start sync. */
 	sci->sc_task = current;
@@ -2663,6 +2677,7 @@ static int nilfs_segctor_thread(void *arg)
  end_thread:
 	/* end sync. */
 	sci->sc_task = NULL;
+	del_timer_sync(&sci->sc_timer);
 	wake_up(&sci->sc_wait_task); /* for nilfs_segctor_kill_thread() */
 	spin_unlock(&sci->sc_state_lock);
 	return 0;
@@ -2726,7 +2741,6 @@ static struct nilfs_sc_info *nilfs_segctor_new(struct super_block *sb,
 	INIT_LIST_HEAD(&sci->sc_gc_inodes);
 	INIT_LIST_HEAD(&sci->sc_iput_queue);
 	INIT_WORK(&sci->sc_iput_work, nilfs_iput_work_func);
-	timer_setup(&sci->sc_timer, nilfs_construction_timeout, 0);
 
 	sci->sc_interval = HZ * NILFS_SC_DEFAULT_TIMEOUT;
 	sci->sc_mjcp_freq = HZ * NILFS_SC_DEFAULT_SR_FREQ;
@@ -2812,7 +2826,6 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 
 	down_write(&nilfs->ns_segctor_sem);
 
-	del_timer_sync(&sci->sc_timer);
 	kfree(sci);
 }
 
-- 
2.43.0


