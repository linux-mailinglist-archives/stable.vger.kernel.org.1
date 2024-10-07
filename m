Return-Path: <stable+bounces-81438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4982B9934BC
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0104A1F2499D
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B4D1DD544;
	Mon,  7 Oct 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ooQpn8yy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A341DD531
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321604; cv=none; b=tNtQCIBks3iDjQ6aKcNbR/KJKRpHleZHCbT6skFpEuS4zwykthwOVXUpZKqA/EdozdBdXb2iJAA2H5vwClRIsVHXucHR4rrlKJLv/w9Fi8E3EYbHwtzdx2/0H7PkZCVq64rds6IGa6DRIIBkL0Eh3YnGAvlseCIzhM70TsputQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321604; c=relaxed/simple;
	bh=TR5GZqiAG1pDnF4hCyxDQlKg9z4fTn8uPsVaQdnnYiE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VwtmlW0axsJIu+kSH3kvUPJBlBgwfaHb+UF9HPGxMJq4fXRLH1BjHtxldLcX52RvM6ad9EU0s6gfCWLnH2yy6jxwEYdY0LAiFFwVfD+BzSjS9U9qrVB6lqFt8iRQ9bmjTK6Gtf189bFMaXCUjIMYm1L+bAXSso2FX06BkR3L60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ooQpn8yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD6FC4CEC7;
	Mon,  7 Oct 2024 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728321604;
	bh=TR5GZqiAG1pDnF4hCyxDQlKg9z4fTn8uPsVaQdnnYiE=;
	h=Subject:To:Cc:From:Date:From;
	b=ooQpn8yylzfdGG7ztmpdlXtJmaExcK9gduLfKUza77CwxdBPuTeX9detYAj2T6XT9
	 gqjt0A+0d2GdQc4FNqHDef8NFA2gKcitppdo/sGddyh7ags7J5/oavT3O4Y8ay1PyB
	 GO7KAPCjtgEBnB5+U8eG3shj5zvQGmfB+38cVIxU=
Subject: FAILED: patch "[PATCH] uprobes: fix kernel info leak via "[uprobes]" vma" failed to apply to 6.10-stable tree
To: oleg@redhat.com,mhiramat@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:19:58 +0200
Message-ID: <2024100758-cupbearer-bobtail-6583@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 34820304cc2cd1804ee1f8f3504ec77813d29c8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100758-cupbearer-bobtail-6583@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

34820304cc2c ("uprobes: fix kernel info leak via "[uprobes]" vma")
2abbcc099ec6 ("uprobes: turn xol_area->pages[2] into xol_area->page")
6d27a31ef195 ("uprobes: introduce the global struct vm_special_mapping xol_mapping")
ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
1713b63a07a2 ("x86/shstk: Make return uprobe work with shadow stack")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 34820304cc2cd1804ee1f8f3504ec77813d29c8e Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Sun, 29 Sep 2024 18:20:47 +0200
Subject: [PATCH] uprobes: fix kernel info leak via "[uprobes]" vma

xol_add_vma() maps the uninitialized page allocated by __create_xol_area()
into userspace. On some architectures (x86) this memory is readable even
without VM_READ, VM_EXEC results in the same pgprot_t as VM_EXEC|VM_READ,
although this doesn't really matter, debugger can read this memory anyway.

Link: https://lore.kernel.org/all/20240929162047.GA12611@redhat.com/

Reported-by: Will Deacon <will@kernel.org>
Fixes: d4b3b6384f98 ("uprobes/core: Allocate XOL slots for uprobes use")
Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ec796e2f055..4b52cb2ae6d6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1545,7 +1545,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (!area->bitmap)
 		goto free_area;
 
-	area->page = alloc_page(GFP_HIGHUSER);
+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
 	if (!area->page)
 		goto free_bitmap;
 


