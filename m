Return-Path: <stable+bounces-43651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBF88C41F8
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3761C20C61
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809AB152E00;
	Mon, 13 May 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2GrpL9pJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430511474BB
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607107; cv=none; b=gsMRALynWD3V1aS96Yv2DI4AZ+DoMcxDEeEOR0I1KRyxJoXFluI7Ha5zYxyHrLdpzXCOa8+Pe4Q5VYHk8BDcdgxtCPd1XfLaQDuRG4A9jyUQ7c7YvAOmaw+bmShjr9yShyDchTq6U91y1mb9Mzig7TbOyZmDoymDu9J/H8AFjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607107; c=relaxed/simple;
	bh=azicpyCWCDFfNujSr1Nchv5US0gnBB0eYl68iQH9v6A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gwAbrk8Oys/bL4mocx6e7HW9ZbVLUS5iU5lG3nSmOMiP8SSwHhRGXBN+CNMdwDI43a0LPvSmYJdbTmnK/6DpMFfe0+W/SpaErvkFN9+ewxcc2TbOV+ugAZB2OvBqViPTPu1KuFHLRbyNjlvWQMk9QfcSQWOGhqbSgIiHOBvSYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2GrpL9pJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEF6C113CC;
	Mon, 13 May 2024 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715607107;
	bh=azicpyCWCDFfNujSr1Nchv5US0gnBB0eYl68iQH9v6A=;
	h=Subject:To:Cc:From:Date:From;
	b=2GrpL9pJ2k7oXEY4idm2p/DLxPvBjpq0rC9gNHL1euBsE3WJcFw4NxiKQMHGkeJTN
	 Vyg8yUZBR1o0thutsqjWLqd65fhawtziNc4hlKfDPJrTAOFKekaJIomochZA+MxUCG
	 0b43ZfGdBuDkRfyCfrLXigxIWnXA72pzMGm5/G94=
Subject: FAILED: patch "[PATCH] mm/slab: make __free(kfree) accept error pointers" failed to apply to 6.6-stable tree
To: dan.carpenter@linaro.org,rientjes@google.com,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:31:36 +0200
Message-ID: <2024051335-botch-pregame-1b8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cd7eb8f83fcf258f71e293f7fc52a70be8ed0128
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051335-botch-pregame-1b8b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

cd7eb8f83fcf ("mm/slab: make __free(kfree) accept error pointers")
a67d74a4b163 ("mm/slab: Add __free() support for kvfree")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd7eb8f83fcf258f71e293f7fc52a70be8ed0128 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Sun, 28 Apr 2024 17:26:44 +0300
Subject: [PATCH] mm/slab: make __free(kfree) accept error pointers

Currently, if an automatically freed allocation is an error pointer that
will lead to a crash.  An example of this is in wm831x_gpio_dbg_show().

   171	char *label __free(kfree) = gpiochip_dup_line_label(chip, i);
   172	if (IS_ERR(label)) {
   173		dev_err(wm831x->dev, "Failed to duplicate label\n");
   174		continue;
   175  }

The auto clean up function should check for error pointers as well,
otherwise we're going to keep hitting issues like this.

Fixes: 54da6a092431 ("locking: Introduce __cleanup() based infrastructure")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

diff --git a/include/linux/slab.h b/include/linux/slab.h
index e53cbfa18325..739b21262507 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -266,7 +266,7 @@ void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
-DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
+DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
 
 /**
  * ksize - Report actual allocation size of associated object
@@ -792,7 +792,7 @@ static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t fla
 extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
 		      __realloc_size(3);
 extern void kvfree(const void *addr);
-DEFINE_FREE(kvfree, void *, if (_T) kvfree(_T))
+DEFINE_FREE(kvfree, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T))
 
 extern void kvfree_sensitive(const void *addr, size_t len);
 


