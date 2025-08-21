Return-Path: <stable+bounces-172107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9933BB2FADA
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD121CE15ED
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC6432BF37;
	Thu, 21 Aug 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vGMM7IHW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B299334398
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783190; cv=none; b=L05WOlSVznViZDJis4BQ5hxaU9JF5PxiRTwV7EXFU52bb55UCbODTJSArhxYImOCRU1I6v94jsXEIZy/kiNku1ftq9yH2E/6K1ArO7ttZra5zfPJuxym1z9cV6zHu/L2rdDnSbDJJQFMZ1d4NEhsuOLMRKxS4az7YaQfCY8O+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783190; c=relaxed/simple;
	bh=TjnqJf8ib1JR8RS3td8LZaRKc8MzQsW+akusuZcavzM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mxvDj9tI+20cWzSXeBaK3OiSP+Nu4Nn/R6D2cuCQG7jGyATUxUZnJJMb4ZFjUCrTBhn+/EfSpeUDU98+4JOYpNnUJsVjtDdjjNPg5vfF4x8kss2P9/t22W9zZX8lpaS4Q0WfJ9O9kVn06P/rZFbqvISNQUdqFac6VNpVBg7h2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vGMM7IHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A409EC4CEED;
	Thu, 21 Aug 2025 13:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783190;
	bh=TjnqJf8ib1JR8RS3td8LZaRKc8MzQsW+akusuZcavzM=;
	h=Subject:To:Cc:From:Date:From;
	b=vGMM7IHWIxPUqkOFpTLUyEEZmN+kPEE4AdOPPsko1/v6HpL/b1NFPqdTAYkeOXRPv
	 NMGdV2wUqzfB8/ZxDksJjc+uaMkd0CiocIq833uVi0VdRSNWvpixEtP1oBJmJlwU4/
	 aPZA85eFRhjXKSOhRrrS4Mly/WvIFxowN6s/xbOI=
Subject: FAILED: patch "[PATCH] parisc: Drop WARN_ON_ONCE() from flush_cache_vmap" failed to apply to 6.1-stable tree
To: dave.anglin@bell.net,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:33:07 +0200
Message-ID: <2025082107-alabaster-monotype-aac8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4eab1c27ce1f0e89ab67b01bf1e4e4c75215708a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082107-alabaster-monotype-aac8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4eab1c27ce1f0e89ab67b01bf1e4e4c75215708a Mon Sep 17 00:00:00 2001
From: John David Anglin <dave.anglin@bell.net>
Date: Mon, 21 Jul 2025 16:18:41 -0400
Subject: [PATCH] parisc: Drop WARN_ON_ONCE() from flush_cache_vmap

I have observed warning to occassionally trigger.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 3b37a7e7abe4..37ca484cc495 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -841,7 +841,7 @@ void flush_cache_vmap(unsigned long start, unsigned long end)
 	}
 
 	vm = find_vm_area((void *)start);
-	if (WARN_ON_ONCE(!vm)) {
+	if (!vm) {
 		flush_cache_all();
 		return;
 	}


