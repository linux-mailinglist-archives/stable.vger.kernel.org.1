Return-Path: <stable+bounces-81444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B49934C6
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AC81F24EE1
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962911DD873;
	Mon,  7 Oct 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjSBj60m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568851DD878
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321626; cv=none; b=fvvnlbGftYF4VKaW4HLqESmueWKJv7CVPoo5qqV25HqRvaCCwjCIL4Y/K4+cYtd63Q/nTHcwjKVNk1CJPVONKXKU/v/jl/9xi43bH6SiR62ftwIOFAW2JAQtAa9vw4TmXmU2SVh0lrI7WHq0TsK0FxMBCQdwQd9f6Rflooe0owo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321626; c=relaxed/simple;
	bh=UdooRFkmlwM5bkfuQLVALIInqgpYV90wAPK8C8B9h8s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OJj3oGI2oG1aXZ00YzwvSFwxLt5FWa6AoWgbgpzVUf0lBAiAlPz8+74pwBzeVD2gq24uIi6sGt+mCHRp4XCxSwOeToiIa8WwnjPpIJbbZ46aDI02BG/ouUO7OrRzaDn6DS+9d1f/9ZvC3lO8lwrwp+A/PLxGa00sBv/ooCcB6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kjSBj60m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF86C4CEC6;
	Mon,  7 Oct 2024 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728321626;
	bh=UdooRFkmlwM5bkfuQLVALIInqgpYV90wAPK8C8B9h8s=;
	h=Subject:To:Cc:From:Date:From;
	b=kjSBj60myIyEWsT+4lOpkpwTZDEzq7QYSXtiEU//eJT8F84cEwW9xB1uMLewqX44q
	 N0TF+qygxeSyzoal4k47SlVdP1kA+ypRvx0vmpKOk0NqzH6YoxdzHxL9dVUlscdoTu
	 SgKzLeaLdDNbzRj2as6hE5yyrYRslqZIkLlTFCHA=
Subject: FAILED: patch "[PATCH] uprobes: fix kernel info leak via "[uprobes]" vma" failed to apply to 4.19-stable tree
To: oleg@redhat.com,mhiramat@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:20:02 +0200
Message-ID: <2024100702-doze-flashy-bbe9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 34820304cc2cd1804ee1f8f3504ec77813d29c8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100702-doze-flashy-bbe9@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

34820304cc2c ("uprobes: fix kernel info leak via "[uprobes]" vma")
2abbcc099ec6 ("uprobes: turn xol_area->pages[2] into xol_area->page")
6d27a31ef195 ("uprobes: introduce the global struct vm_special_mapping xol_mapping")
ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
1713b63a07a2 ("x86/shstk: Make return uprobe work with shadow stack")
05e36022c054 ("x86/shstk: Handle signals for shadow stack")
928054769dbd ("x86/shstk: Introduce routines modifying shstk")
b2926a36b97a ("x86/shstk: Handle thread shadow stack")
2d39a6add422 ("x86/shstk: Add user-mode shadow stack support")
98cfa4630912 ("x86: Introduce userspace API for shadow stack")
2da5b91fe409 ("x86/traps: Move control protection handler to separate file")
2f8794bd087e ("x86/mm: Provide arch_prctl() interface for LAM")
74c228d20a51 ("x86/uaccess: Provide untagged_addr() and remove tags before address check")
82721d8b25d7 ("x86/mm: Handle LAM on context switch")
5ef495e55f07 ("x86: Allow atomic MM_CONTEXT flags setting")
94a855111ed9 ("Merge tag 'x86_core_for_v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

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
 


