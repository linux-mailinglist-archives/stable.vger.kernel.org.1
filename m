Return-Path: <stable+bounces-136877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D80A9F027
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 14:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19CD3A3B2C
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C92926770A;
	Mon, 28 Apr 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HYmns4ML"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF062676CF
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841486; cv=none; b=AWC3GC6OCCYFhef0Cs8//RUD8BJa56bdd7J0lC1cVuI/0UhReYos4haKZTwZtNtesP9BA+XdepGgVlUjagnWgd7voW6HNBeJAwbUy8Y8j2tO0QdTP/Z7LI2nVsU4awqLnPXzRRAp1sxi7JcqW3tQ0ifKXvVj5LwodSMFkOHTkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841486; c=relaxed/simple;
	bh=XBSFcBIOkyynj5nIe4a0OUj1Pl0GzpigTh+PIuQp+qc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hLyYx5RO3zKZN4FaO96fph3IXwn/c+Vq2ibeDVQGmpTBRWYMZX9/hHpI2x5z+r978J/Oj5WqPNyIKu6r1dLY35xxswrsKCzeBTwqx6F32y0Cfz2qGRnfNE+cLNii6RqQG1dnHWnqZbeG/3z1bgV1TV9XrLArH/vCUQsS3qxeJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HYmns4ML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D713C4CEE4;
	Mon, 28 Apr 2025 11:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841486;
	bh=XBSFcBIOkyynj5nIe4a0OUj1Pl0GzpigTh+PIuQp+qc=;
	h=Subject:To:Cc:From:Date:From;
	b=HYmns4MLklggoLn7xT3X/VaYlAXCLfkrEOkgkjOaQ8i/pEl2wiZwsH9NUHtt6C31B
	 iUa+Z7F5KNhNUkHD+BFAxXSNIYtTBzon5HBrSgTgZWzHk+82hcYQuVZe3go/pzXAmU
	 ecSblW/kJr2jQ7/3B/TeIvUiVDWECx/3w171AL7M=
Subject: FAILED: patch "[PATCH] binder: fix offset calculation in debug log" failed to apply to 6.12-stable tree
To: cmllamas@google.com,gregkh@linuxfoundation.org,stable@kernel.org,ynaffit@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:58:03 +0200
Message-ID: <2025042803-deflected-overdue-01a5@gregkh>
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
git cherry-pick -x 170d1a3738908eef6a0dbf378ea77fb4ae8e294d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042803-deflected-overdue-01a5@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 170d1a3738908eef6a0dbf378ea77fb4ae8e294d Mon Sep 17 00:00:00 2001
From: Carlos Llamas <cmllamas@google.com>
Date: Tue, 25 Mar 2025 18:49:00 +0000
Subject: [PATCH] binder: fix offset calculation in debug log

The vma start address should be substracted from the buffer's user data
address and not the other way around.

Cc: Tiffany Y. Yang <ynaffit@google.com>
Cc: stable <stable@kernel.org>
Fixes: 162c79731448 ("binder: avoid user addresses in debug logs")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Tiffany Y. Yang <ynaffit@google.com>
Link: https://lore.kernel.org/r/20250325184902.587138-1-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 76052006bd87..5fc2c8ee61b1 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6373,7 +6373,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
 	seq_printf(m, " size %zd:%zd offset %lx\n",
 		   buffer->data_size, buffer->offsets_size,
-		   proc->alloc.vm_start - buffer->user_data);
+		   buffer->user_data - proc->alloc.vm_start);
 }
 
 static void print_binder_work_ilocked(struct seq_file *m,


