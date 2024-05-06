Return-Path: <stable+bounces-43077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6DC8BC4CF
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 02:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0157B1F21062
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 00:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678B464C;
	Mon,  6 May 2024 00:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mXnxDDmP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E474C63;
	Mon,  6 May 2024 00:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714955328; cv=none; b=tvPf0cFE9/uVwVxZxbxtGyYIpT3gSZmQ7gxls+/2dtBRAIICRbZ/5oAXCUoJU+MoK8d2CkTnS5NThQBotaxMuTm1cIFHg8H9mfaSDDATXHnMVHkJpqX9E47d7JTqlUmCLFdFH1c7LYiKapzkACZaOHc1VZv/kk7CRT71L7YX6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714955328; c=relaxed/simple;
	bh=x2wBT5axEqfrVrEseQ6JwaX4d/yXbR6XlRJ6TRJAvj8=;
	h=Date:To:From:Subject:Message-Id; b=aX7uPwxHFVfpQo47VHxAWzZMDOF34fXcaOJtZXtDFPuXw2hVGIv8/jyUjO90rNVxq2i5ekSmvrpL9mx1xgOITIxhj2Jt5pfOJkQM52qjxXMZ4Lc9rioF/Q5Kk1DqWJyF+Abr2HYvvWxxOgXBl9Awncds1NwEWWgzvNZV9kVAPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mXnxDDmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C09C113CC;
	Mon,  6 May 2024 00:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714955328;
	bh=x2wBT5axEqfrVrEseQ6JwaX4d/yXbR6XlRJ6TRJAvj8=;
	h=Date:To:From:Subject:From;
	b=mXnxDDmPUnMg0gVSOmSnfl4iQC0Ci8qteBponJZMW1akpxTFEOqi0zFk4AE79KMN9
	 3hPY/+2ZBW1M2lrLCOiW29/3c9mQYcb5f1seGOmrev7BpU91UreNudGSQoPUei8VXS
	 TqS8LpvGBHhOGGnF3fIIRq9LsGmsvDzFJFGGTkUI=
Date: Sun, 05 May 2024 17:28:47 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,ojeda@kernel.org,elver@google.com,dvyukov@google.com,glider@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] kmsan-compiler_types-declare-__no_sanitize_or_inline.patch removed from -mm tree
Message-Id: <20240506002847.E7C09C113CC@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: kmsan: compiler_types: declare __no_sanitize_or_inline
has been removed from the -mm tree.  Its filename was
     kmsan-compiler_types-declare-__no_sanitize_or_inline.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Alexander Potapenko <glider@google.com>
Subject: kmsan: compiler_types: declare __no_sanitize_or_inline
Date: Fri, 26 Apr 2024 11:16:22 +0200

It turned out that KMSAN instruments READ_ONCE_NOCHECK(), resulting in
false positive reports, because __no_sanitize_or_inline enforced inlining.

Properly declare __no_sanitize_or_inline under __SANITIZE_MEMORY__, so
that it does not __always_inline the annotated function.

Link: https://lkml.kernel.org/r/20240426091622.3846771-1-glider@google.com
Fixes: 5de0ce85f5a4 ("kmsan: mark noinstr as __no_sanitize_memory")
Signed-off-by: Alexander Potapenko <glider@google.com>
Reported-by: syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
Link: https://lkml.kernel.org/r/000000000000826ac1061675b0e3@google.com
Cc: <stable@vger.kernel.org>
Reviewed-by: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/compiler_types.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/include/linux/compiler_types.h~kmsan-compiler_types-declare-__no_sanitize_or_inline
+++ a/include/linux/compiler_types.h
@@ -278,6 +278,17 @@ struct ftrace_likely_data {
 # define __no_kcsan
 #endif
 
+#ifdef __SANITIZE_MEMORY__
+/*
+ * Similarly to KASAN and KCSAN, KMSAN loses function attributes of inlined
+ * functions, therefore disabling KMSAN checks also requires disabling inlining.
+ *
+ * __no_sanitize_or_inline effectively prevents KMSAN from reporting errors
+ * within the function and marks all its outputs as initialized.
+ */
+# define __no_sanitize_or_inline __no_kmsan_checks notrace __maybe_unused
+#endif
+
 #ifndef __no_sanitize_or_inline
 #define __no_sanitize_or_inline __always_inline
 #endif
_

Patches currently in -mm which might be from glider@google.com are



