Return-Path: <stable+bounces-181895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D90BA9198
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC353A7D3C
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229062C237D;
	Mon, 29 Sep 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UNvCjkHY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4556246BB6
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146468; cv=none; b=XUu4vJMRJNnyV7cfOoqStp/dcDWOldyY0fuKYladWVogAgtE4b0qrxO8/n3MiOMxsG4lo2FpwsD51adfNPn3nE2w01YkXYykHfSr/M6hq2zwnrI2vRR/pwiQWbvXt1F8byoEC/sDGSkYDrfyK7lI3qCB934At1t1WvtgA0mXrm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146468; c=relaxed/simple;
	bh=sjI/uHErZh5gotlK2RDHmWYqyxJDHGfBOKTEXgGMXRc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nRFCS90YpLf1ZDKLf2WsiAAoAYQvI5VyFn1N89VcnvGncWckpdmqV1wRYpFH0PxFGE33WeRIoxZnNFQsbEIXVLUfi7JjEstVZMauLEc9aDBfHYvI0CZH4ZzA2h3Id2fqLQCwLCelh/nUMM2oJYpuKbgBu840d/YKfJAejzAXChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UNvCjkHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17612C4CEF4;
	Mon, 29 Sep 2025 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759146467;
	bh=sjI/uHErZh5gotlK2RDHmWYqyxJDHGfBOKTEXgGMXRc=;
	h=Subject:To:Cc:From:Date:From;
	b=UNvCjkHY3hCuYJ2wSCQBEh3DLguJp9gFlktnGhplOUZclgQJjppymXDVLQODbRg0H
	 vWdz9UuFTYC97UJ3Ux3deXJjry2LB8H29NbqrfviqmkzLAse3o2MsS38hGbDIITMS1
	 zerSd7uUQlSRhmnXET9K+A09jnbQatu/fkviSo/0=
Subject: FAILED: patch "[PATCH] tracing: dynevent: Add a missing lockdown check on dynevent" failed to apply to 5.4-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 13:47:44 +0200
Message-ID: <2025092944-overact-prowler-60f7@gregkh>
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
git cherry-pick -x 456c32e3c4316654f95f9d49c12cbecfb77d5660
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092944-overact-prowler-60f7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 456c32e3c4316654f95f9d49c12cbecfb77d5660 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 19 Sep 2025 10:15:56 +0900
Subject: [PATCH] tracing: dynevent: Add a missing lockdown check on dynevent

Since dynamic_events interface on tracefs is compatible with
kprobe_events and uprobe_events, it should also check the lockdown
status and reject if it is set.

Link: https://lore.kernel.org/all/175824455687.45175.3734166065458520748.stgit@devnote2/

Fixes: 17911ff38aa5 ("tracing: Add locked_down checks to the open calls of files created for tracefs")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 5d64a18cacac..d06854bd32b3 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -230,6 +230,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = tracing_check_open_get_tr(NULL);
 	if (ret)
 		return ret;


