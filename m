Return-Path: <stable+bounces-125897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05463A6DEA0
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2321899668
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00A2257448;
	Mon, 24 Mar 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AhrKSjiL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8189D26AFC
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830016; cv=none; b=V8HT95i0nvnAnH4etI90+uoVOK+8ShgD381jp44M6AgkJUdTU/BfCZOyy/DJWhPIKYKwAOgnjOAoilt0docOMfYElw9NQNYtWi9bfjafVaSdFuskxO+/gy2qpo8pSOiHICKd0RIKx7URoTLBRW806BTgXEpDDGwYeh98gd0ksg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830016; c=relaxed/simple;
	bh=yVLx4gwlLucJp9OBW8S0UDl4UPKOGVbCiwdSwq3kuKQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m8qVlxag9QMuj7pZTLlg67F3Cipb4rx20cbIX6cRRMXZVLaGd0TIqepTjAxdNuqo7iEFIyBvnhuME+8x6CKVwvw2FTtq+sBHjgIGYUeYVHrCkqBPR+cNmQrEhRtmr18+cz79cdRtBozq2HMrEJ/03iGHOHNTCmfYMbupxCRS2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AhrKSjiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD027C4CEDD;
	Mon, 24 Mar 2025 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830016;
	bh=yVLx4gwlLucJp9OBW8S0UDl4UPKOGVbCiwdSwq3kuKQ=;
	h=Subject:To:Cc:From:Date:From;
	b=AhrKSjiLq+NcT9pU/uVdUqQvyQFwrLsd5Vyka1fDW9YmnXC9Our3Uis49JA1JjzAx
	 E32T8XIXldc5MWyhRchqddjlpEqEOPu5z/tESOd61/6/llOM9rglZpR4RY7Lxl1owV
	 kDrQfpzsgOwzC0lH+sPprS4BU0aCq9QVDo4jxq5M=
Subject: FAILED: patch "[PATCH] tracing: Correct the refcount if the hist/hist_debug file" failed to apply to 6.13-stable tree
To: wutengda@huaweicloud.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,rostedt@goodmis.org,zhengyejian1@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:25:33 -0700
Message-ID: <2025032433-fancied-equate-04ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x 0b4ffbe4888a2c71185eaf5c1a02dd3586a9bc04
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032433-fancied-equate-04ec@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b4ffbe4888a2c71185eaf5c1a02dd3586a9bc04 Mon Sep 17 00:00:00 2001
From: Tengda Wu <wutengda@huaweicloud.com>
Date: Fri, 14 Mar 2025 06:53:35 +0000
Subject: [PATCH] tracing: Correct the refcount if the hist/hist_debug file
 fails to open

The function event_{hist,hist_debug}_open() maintains the refcount of
'file->tr' and 'file' through tracing_open_file_tr(). However, it does
not roll back these counts on subsequent failure paths, resulting in a
refcount leak.

A very obvious case is that if the hist/hist_debug file belongs to a
specific instance, the refcount leak will prevent the deletion of that
instance, as it relies on the condition 'tr->ref == 1' within
__remove_instance().

Fix this by calling tracing_release_file_tr() on all failure paths in
event_{hist,hist_debug}_open() to correct the refcount.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Link: https://lore.kernel.org/20250314065335.1202817-1-wutengda@huaweicloud.com
Fixes: 1cc111b9cddc ("tracing: Fix uaf issue when open the hist or hist_debug file")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ad7419e24055..53dc6719181e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5689,12 +5689,16 @@ static int event_hist_open(struct inode *inode, struct file *file)
 	guard(mutex)(&event_mutex);
 
 	event_file = event_file_data(file);
-	if (!event_file)
-		return -ENODEV;
+	if (!event_file) {
+		ret = -ENODEV;
+		goto err;
+	}
 
 	hist_file = kzalloc(sizeof(*hist_file), GFP_KERNEL);
-	if (!hist_file)
-		return -ENOMEM;
+	if (!hist_file) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	hist_file->file = file;
 	hist_file->last_act = get_hist_hit_count(event_file);
@@ -5702,9 +5706,14 @@ static int event_hist_open(struct inode *inode, struct file *file)
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
 	ret = single_open(file, hist_show, hist_file);
-	if (ret)
+	if (ret) {
 		kfree(hist_file);
+		goto err;
+	}
 
+	return 0;
+err:
+	tracing_release_file_tr(inode, file);
 	return ret;
 }
 
@@ -5979,7 +5988,10 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
-	return single_open(file, hist_debug_show, file);
+	ret = single_open(file, hist_debug_show, file);
+	if (ret)
+		tracing_release_file_tr(inode, file);
+	return ret;
 }
 
 const struct file_operations event_hist_debug_fops = {


