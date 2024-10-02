Return-Path: <stable+bounces-78611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DDD98D0C7
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2119528542C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83491E4930;
	Wed,  2 Oct 2024 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MSpcxCtu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A81CCB31
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863551; cv=none; b=qf8ztWr/WDgS/YVIUEurdMcaKTibcfGIeAeHlDBGnfQzE/Csk7+5difi6Hux8sOqi+9vHem2MUm1RIyTp/+Zatq+lFgOP4jSZFMUl4CpkLvUrVGgQ3UqtVdxE3IJN2tXgxruOnpSC3rbNrEThdN2rBpDv+YoN5NrxRQZdbRkhN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863551; c=relaxed/simple;
	bh=8ZnUKJxW6ZCNv9BhRGqCoxmMxB8GWrDzrvgxJ8GGtU8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QJHyCWF3OiHUXa2LmRofjbPcmWgAhYkKHVPQaTzOnY84K+Ium+RHMDkNWfJKKl9azKZnzph8L5scvR7+jQOF9W0fgadBOSwBh8FB7IWL4bU0ogephqI/djKQbLAhmIWkOUbfws8EUSMRG9uQ8XfK1+bRYG61tOg89dLyyPHrHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MSpcxCtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9A2C4CEC5;
	Wed,  2 Oct 2024 10:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727863551;
	bh=8ZnUKJxW6ZCNv9BhRGqCoxmMxB8GWrDzrvgxJ8GGtU8=;
	h=Subject:To:Cc:From:Date:From;
	b=MSpcxCtuyWKaXhNopR4k7mjeR7ceXNkmgrp0ONG+Vu9zOBjmXmoSP9Qy8Yq/Jfdv4
	 U0x7Rh7dm/DBMXwv4vQRkry5WCHhdSUJpWHhA22TMyNlaSxDxhp7W8nUv+W7n+VJH+
	 KdZ6lBvC2OqOgHndZNWcH3lvBRlsLSy+RkFt+cog=
Subject: FAILED: patch "[PATCH] bpf: Fix use-after-free in bpf_uprobe_multi_link_attach()" failed to apply to 6.11-stable tree
To: oleg@redhat.com,andrii@kernel.org,jolsa@kernel.org,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 12:05:48 +0200
Message-ID: <2024100247-spray-enjoyable-b1d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 5fe6e308abaea082c20fbf2aa5df8e14495622cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100247-spray-enjoyable-b1d0@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:

5fe6e308abae ("bpf: Fix use-after-free in bpf_uprobe_multi_link_attach()")
3c83a9ad0295 ("uprobes: make uprobe_register() return struct uprobe *")
e04332ebc8ac ("uprobes: kill uprobe_register_refctr()")
db61e6a4eee5 ("selftests/bpf: fix uprobe.path leak in bpf_testmod")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5fe6e308abaea082c20fbf2aa5df8e14495622cf Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 13 Aug 2024 17:25:24 +0200
Subject: [PATCH] bpf: Fix use-after-free in bpf_uprobe_multi_link_attach()

If bpf_link_prime() fails, bpf_uprobe_multi_link_attach() goes to the
error_free label and frees the array of bpf_uprobe's without calling
bpf_uprobe_unregister().

This leaks bpf_uprobe->uprobe and worse, this frees bpf_uprobe->consumer
without removing it from the uprobe->consumers list.

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Closes: https://lore.kernel.org/all/000000000000382d39061f59f2dd@google.com/
Reported-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240813152524.GA7292@redhat.com

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4e391daafa64..90cd30e9723e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3484,17 +3484,20 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 						    &uprobes[i].consumer);
 		if (IS_ERR(uprobes[i].uprobe)) {
 			err = PTR_ERR(uprobes[i].uprobe);
-			bpf_uprobe_unregister(uprobes, i);
-			goto error_free;
+			link->cnt = i;
+			goto error_unregister;
 		}
 	}
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-		goto error_free;
+		goto error_unregister;
 
 	return bpf_link_settle(&link_primer);
 
+error_unregister:
+	bpf_uprobe_unregister(uprobes, link->cnt);
+
 error_free:
 	kvfree(uprobes);
 	kfree(link);


