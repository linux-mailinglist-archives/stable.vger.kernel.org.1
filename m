Return-Path: <stable+bounces-43648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DF58C41EE
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B40E1F222F6
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A4152E08;
	Mon, 13 May 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wwZwD5dq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C41152DF7
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607007; cv=none; b=t8NkjG9Z0QODFV3X081dAz+qEHoxCvNsw2gkxt3LT/ZOf2eevYoDkF64rJ5/KgyKHB2GzmMszwBeXUEuvFSi4YZhV0m3QJ93IkhiNtADXBNfLXul04f1bpn7RwM2AyY9vyt00c+p3OphG04qFqu2sxABzCpiK8TAE4yJ5LZEUDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607007; c=relaxed/simple;
	bh=fdQj5tpm1DVEdbOjzBNuiDD2iIHzRTPcRVUBvlbI/Ic=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=krZTJEAMhtQs8wgdyucrfV7hX7Knoxs6qn0ROGVe7JmGFCotovNUPpBIhIgU+cYAENbeMzOecc/wlE5aacrGvYtB7hs4P2OyESoo5pA2TRBGLL/W42DJqQq3lfQ0ZhaYAhtWkTRzf8FZe1VGxgCQy/fqtrwJ0zrIzA/JPxZPPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wwZwD5dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6886BC113CC;
	Mon, 13 May 2024 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715607006;
	bh=fdQj5tpm1DVEdbOjzBNuiDD2iIHzRTPcRVUBvlbI/Ic=;
	h=Subject:To:Cc:From:Date:From;
	b=wwZwD5dqreraQvSMAS+xElk/udAFDNzbng/Ul4IZdcpwYK1oRf0nEbH9yU4RrZeKg
	 ueqdu6n487uE21QP4i+pl9bYv8NgVHxMpqnr7Dfl5iDqEkdMfzrinzCDtBO9bOWJ9M
	 oRf5SjhmARJzvQkyxIRlpM3OVvwyVC2fTLNxWXa8=
Subject: FAILED: patch "[PATCH] maple_tree: fix mas_empty_area_rev() null pointer dereference" failed to apply to 6.12-stable tree
To: Liam.Howlett@oracle.com,akpm@linux-foundation.org,fleischermarius@gmail.com,sidhartha.kumar@oracle.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:29:45 +0200
Message-ID: <2024051344-squeamish-runaround-c445@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 955a923d2809803980ff574270f81510112be9cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051344-squeamish-runaround-c445@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 955a923d2809803980ff574270f81510112be9cf Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Mon, 22 Apr 2024 16:33:49 -0400
Subject: [PATCH] maple_tree: fix mas_empty_area_rev() null pointer dereference

Currently the code calls mas_start() followed by mas_data_end() if the
maple state is MA_START, but mas_start() may return with the maple state
node == NULL.  This will lead to a null pointer dereference when checking
information in the NULL node, which is done in mas_data_end().

Avoid setting the offset if there is no node by waiting until after the
maple state is checked for an empty or single entry state.

A user could trigger the events to cause a kernel oops by unmapping all
vmas to produce an empty maple tree, then mapping a vma that would cause
the scenario described above.

Link: https://lkml.kernel.org/r/20240422203349.2418465-1-Liam.Howlett@oracle.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Marius Fleischer <fleischermarius@gmail.com>
Closes: https://lore.kernel.org/lkml/CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com/
Link: https://lore.kernel.org/lkml/CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com/
Tested-by: Marius Fleischer <fleischermarius@gmail.com>
Tested-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 55e1b35bf877..2d7d27e6ae3c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5109,18 +5109,18 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 	if (size == 0 || max - min < size - 1)
 		return -EINVAL;
 
-	if (mas_is_start(mas)) {
+	if (mas_is_start(mas))
 		mas_start(mas);
-		mas->offset = mas_data_end(mas);
-	} else if (mas->offset >= 2) {
-		mas->offset -= 2;
-	} else if (!mas_rewind_node(mas)) {
+	else if ((mas->offset < 2) && (!mas_rewind_node(mas)))
 		return -EBUSY;
-	}
 
-	/* Empty set. */
-	if (mas_is_none(mas) || mas_is_ptr(mas))
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
 		return mas_sparse_area(mas, min, max, size, false);
+	else if (mas->offset >= 2)
+		mas->offset -= 2;
+	else
+		mas->offset = mas_data_end(mas);
+
 
 	/* The start of the window can only be within these values. */
 	mas->index = min;


