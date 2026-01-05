Return-Path: <stable+bounces-204747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF16DCF35F8
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90DCD30133CC
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5913A33970F;
	Mon,  5 Jan 2026 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PmakitZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940733970C
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613883; cv=none; b=FUjB8J+AkgoYDpJXckjVxCUg2bgkWClLk076HdSnNIuQipBayx8EbyBm034XSS8fr2k7ngyw+xrncAA8erGUIMKHdzdKTiBytZxZWWIchatQ7KfGCICiwiWml/kqamhwsvYL56CcpOrvGIRWidyNsJcHBfSIlzV3pj8NQztwQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613883; c=relaxed/simple;
	bh=VWOgsi+0dlj4ncH1yJFmRsRKkhVfzaLKvZ3wfJBiHTc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ttZcmKcwTOK282Ik7Ze7Q9amcb17lgmRcggL8HlVYMELdsbMTMCGxjue7d1IKDmaJQZ+lgC1BOHhYtyRD/CGhQn4pJVoH4lMRANLm9t5QeYtwtmWhRjvzngJmdh11DuWlG1BevmM43kpSHo6XxK2QBVc+v3y9IUPZ6zsaxTYKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PmakitZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33874C116D0;
	Mon,  5 Jan 2026 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767613882;
	bh=VWOgsi+0dlj4ncH1yJFmRsRKkhVfzaLKvZ3wfJBiHTc=;
	h=Subject:To:Cc:From:Date:From;
	b=PmakitZJx1+6cDZZbNX7AstZcXfeuw8wFVoASPa7Og9OeRbnxhf6TFG9fTvqbOWCR
	 pgUtg9rcyR8z7ydfwhZ8cUIBUNwybjK6FPBUWP+XgWpLdWqbIFQANrin7nXcv4l0gk
	 8lldWLv0mC1ABc++f/CBbqqTgbfOZzz0SkFkYWkY=
Subject: FAILED: patch "[PATCH] tools/mm/page_owner_sort: fix timestamp comparison for stable" failed to apply to 6.1-stable tree
To: kaushlendra.kumar@intel.com,akpm@linux-foundation.org,stable@vger.kernel.org,zhaochongxi2019@email.szu.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:51:19 +0100
Message-ID: <2026010519-jawline-playing-8c04@gregkh>
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
git cherry-pick -x 7013803444dd3bbbe28fd3360c084cec3057c554
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010519-jawline-playing-8c04@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7013803444dd3bbbe28fd3360c084cec3057c554 Mon Sep 17 00:00:00 2001
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Date: Tue, 9 Dec 2025 10:15:52 +0530
Subject: [PATCH] tools/mm/page_owner_sort: fix timestamp comparison for stable
 sorting

The ternary operator in compare_ts() returns 1 when timestamps are equal,
causing unstable sorting behavior. Replace with explicit three-way
comparison that returns 0 for equal timestamps, ensuring stable qsort
ordering and consistent output.

Link: https://lkml.kernel.org/r/20251209044552.3396468-1-kaushlendra.kumar@intel.com
Fixes: 8f9c447e2e2b ("tools/vm/page_owner_sort.c: support sorting pid and time")
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: Chongxi Zhao <zhaochongxi2019@email.szu.edu.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index 14c67e9e84c4..e6954909401c 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -181,7 +181,11 @@ static int compare_ts(const void *p1, const void *p2)
 {
 	const struct block_list *l1 = p1, *l2 = p2;
 
-	return l1->ts_nsec < l2->ts_nsec ? -1 : 1;
+	if (l1->ts_nsec < l2->ts_nsec)
+		return -1;
+	if (l1->ts_nsec > l2->ts_nsec)
+		return 1;
+	return 0;
 }
 
 static int compare_cull_condition(const void *p1, const void *p2)


