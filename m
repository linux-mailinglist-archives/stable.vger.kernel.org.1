Return-Path: <stable+bounces-106248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19DF9FE3AB
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286A93A1F15
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93922199EAF;
	Mon, 30 Dec 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f9NGuBK8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B501EAD2
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547102; cv=none; b=YPz5xD7oIHgHpkzZTq3Y2Gk2wh21sme9xOYUtahPMH6zluCyQKZdJV23OR/9z0yoS1O1jPXclBhm+sgBaDrnIe7YtDTnJdmsJkTqWpm2RGJA1XmYzi9ts4g+lRT+r87aygQQQW4zX/Ke1/eRekalaq9CwMpP04g1hlgIijqjpbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547102; c=relaxed/simple;
	bh=6lchqIznKaZ7N2ResdSqcpdAm56d87+FGrVIPNbFWjw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sP1napgkgycND66L1Yi0eyPvGZkgXGiQCvWWn33m5uBnk5s61kvNW4Gn/BHxZgGjsfCokSR5kY1eK0iZvKf6UxSdzoofmXu4Zk237WjqPrWW1y1yUxRIh7L/TIqSh6cbC3VSsr3bGoNCFevt/Hc72U+ZPVthdA2Gk3GX4Hxm4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f9NGuBK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6053BC4CED0;
	Mon, 30 Dec 2024 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735547101;
	bh=6lchqIznKaZ7N2ResdSqcpdAm56d87+FGrVIPNbFWjw=;
	h=Subject:To:Cc:From:Date:From;
	b=f9NGuBK88djCgoSOXAUuv7PeuuuyVLB+U7Rg8dUog1V0ooDuW2l4jvgt7KsvMAVi+
	 +avJYfjKJ0Vo+y0T+erqJhOpLXJ/IK++QQkcjtvCO8szJ8jmEvgAF1JxSgsA+LQcTY
	 eKAdHKbRUYEbPdBrQRm8DLep2BqGqY870WeJu9ag=
Subject: FAILED: patch "[PATCH] tracing: Prevent bad count for tracing_cpumask_write" failed to apply to 5.4-stable tree
To: lizhi.xu@windriver.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:24:53 +0100
Message-ID: <2024123053-acting-chase-d961@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 98feccbf32cfdde8c722bc4587aaa60ee5ac33f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123053-acting-chase-d961@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98feccbf32cfdde8c722bc4587aaa60ee5ac33f0 Mon Sep 17 00:00:00 2001
From: Lizhi Xu <lizhi.xu@windriver.com>
Date: Mon, 16 Dec 2024 15:32:38 +0800
Subject: [PATCH] tracing: Prevent bad count for tracing_cpumask_write

If a large count is provided, it will trigger a warning in bitmap_parse_user.
Also check zero for it.

Cc: stable@vger.kernel.org
Fixes: 9e01c1b74c953 ("cpumask: convert kernel trace functions")
Link: https://lore.kernel.org/20241216073238.2573704-1-lizhi.xu@windriver.com
Reported-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0aecfd34fb878546f3fd
Tested-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 957f941a08e7..f8aebcb01e62 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5087,6 +5087,9 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	cpumask_var_t tracing_cpumask_new;
 	int err;
 
+	if (count == 0 || count > KMALLOC_MAX_SIZE)
+		return -EINVAL;
+
 	if (!zalloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
 


