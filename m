Return-Path: <stable+bounces-43650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDD28C41F6
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA41C20D04
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E161A152E14;
	Mon, 13 May 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xyGC4tkd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263F152DF7
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607098; cv=none; b=erCYbDqtFrJYpSuI+TYFdoT0ARSW2UvgRhkSC7/+qlhVKAicsck4VaU0Vq5z7nwGWnp0PwPSibQREdFbG3mD15QRczZuZ40MmkgpQUcbjA4XEVuI9CHDWmypBBnu8sz0XZBWhwSU3WHwggzhASVhTVjCBUwtcB47R32E0EfkeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607098; c=relaxed/simple;
	bh=jnWUyd2yLqZGZ9qUCC5XjAJaUonB/fSKUOBdJWlOuBg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nVoV1MhCWVt4ezoA5a6FinxtiShX5456/QOzQ9u8l1NiNo/C7nWIhoTJsyM8/blkd7X27mH4+UsHj5MCbMNuPGuBolaAo4TrdVbkiWFjBt/KKA7JKJhnZ87ufiNEZkiauH9/Ba+q+g00hxUuxAKd2af+B83MrPU6u941wXfZ2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xyGC4tkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10249C32781;
	Mon, 13 May 2024 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715607098;
	bh=jnWUyd2yLqZGZ9qUCC5XjAJaUonB/fSKUOBdJWlOuBg=;
	h=Subject:To:Cc:From:Date:From;
	b=xyGC4tkdQPBG4uHWDmZzWioeyonnDlrM9Llptcfu1Cnl+8mjcphoVC7XyPYyXFnHa
	 +g+GWtwh/izMhEbwPNPo7+7ibjfTDiORdXIx5X/rABSYtqT4ux7O4CIIb+AWbprDDW
	 ZN4N6IV8JLBOWNsIaFf3xXjDWImfms+7C3l2+ZUE=
Subject: FAILED: patch "[PATCH] mm/slab: make __free(kfree) accept error pointers" failed to apply to 6.1-stable tree
To: dan.carpenter@linaro.org,rientjes@google.com,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:31:35 +0200
Message-ID: <2024051335-aversion-endearing-7ab9@gregkh>
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
git cherry-pick -x cd7eb8f83fcf258f71e293f7fc52a70be8ed0128
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051335-aversion-endearing-7ab9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

cd7eb8f83fcf ("mm/slab: make __free(kfree) accept error pointers")
a67d74a4b163 ("mm/slab: Add __free() support for kvfree")
54da6a092431 ("locking: Introduce __cleanup() based infrastructure")

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
 


