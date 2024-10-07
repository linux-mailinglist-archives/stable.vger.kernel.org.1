Return-Path: <stable+bounces-81437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE4B9934BA
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F41F1C20A15
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881781DB55D;
	Mon,  7 Oct 2024 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t717iVR7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877918BBB2
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321601; cv=none; b=JtLXeHGX2y718s6wh298lBjyuao614tnCMKOtWr2T/wkKuKCv9+/b5jILom9SMI+nB4CkQ554BiKg+hP4PALQr+Yn/lkP5W1Xvr4JsT0VEjjldFKBK3BeVGjC/FBrNkusB8PGM2Vwu+0ju1PYcJlt5aS2aPPEBBYZcm8oOMH01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321601; c=relaxed/simple;
	bh=Bo1JYY4jFrhGvnEn7q3xCGX/R/xGWh3tUEFmPXfx8bc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BcsRopkUd7NEhSv/n/arMMx9Orh8M1tOUxeYGXrAbI7y6oHxfEnwadh+eOfNQjK/m1KUp2xE6paIQb7RTTLZU+OioPBqh47DVpclC95wkWI1wJVPsigmSS9hXLbXY/G0WkQR5g1dMF3jlV8bZXUw8VEJyWjvlcGt8Y7x9xxzEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t717iVR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6869CC4CEC7;
	Mon,  7 Oct 2024 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728321600;
	bh=Bo1JYY4jFrhGvnEn7q3xCGX/R/xGWh3tUEFmPXfx8bc=;
	h=Subject:To:Cc:From:Date:From;
	b=t717iVR7Ng0F4z0kpSfarOT+DsqeHbTTm8i3YBSnlgWeI1G18PFmBpQPaL3xsQ50j
	 RuhMdvNVrezhMcNWDgYVIZhiU6gSv8PBKb7O+R80ygGUK0y74mplgwKDB0R4/tlEVP
	 hLkO8LZRZn2KxckjzYzSJWPIz2GwKIIO5ayv3OfQ=
Subject: FAILED: patch "[PATCH] uprobes: fix kernel info leak via "[uprobes]" vma" failed to apply to 6.11-stable tree
To: oleg@redhat.com,mhiramat@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:19:57 +0200
Message-ID: <2024100757-gambling-blurry-b71e@gregkh>
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
git cherry-pick -x 34820304cc2cd1804ee1f8f3504ec77813d29c8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100757-gambling-blurry-b71e@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:

34820304cc2c ("uprobes: fix kernel info leak via "[uprobes]" vma")
2abbcc099ec6 ("uprobes: turn xol_area->pages[2] into xol_area->page")
6d27a31ef195 ("uprobes: introduce the global struct vm_special_mapping xol_mapping")

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
 


