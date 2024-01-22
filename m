Return-Path: <stable+bounces-12723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5388371AB
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AFEAB2B649
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 18:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A795BAD4;
	Mon, 22 Jan 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYAmYN+r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED85BAD1
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946280; cv=none; b=cchPunjy/tngl4MdnBds0VwWMkJHDpPcPMLtHTIFiv6yXcrRJ1kNxWsX855D0QLIk3eCX7hpm7MAwP9VBOncdJw7v79C6P2/70+hEl5VAOuTv0ft877u37X5zzqLsZvxzg//3hw6fRaKsEJ2cK8Yp2IWTgppqDBwEziS3DP7B2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946280; c=relaxed/simple;
	bh=2EYcuDmI/1mBostzDpnjHbfPqOwfmru4H9Bd7iZiR1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aca5Zyc9qYY+OlUTPAYbQQBMuENR9HBUNjc2HL8ZTRu0sbO6lYLtUJOHSi0BFtOQfTSAcq7yzTFZNKwHJsfGyzqDRerYv6lQm1wIbiGB+6un//BEpN4QTLAhsJ/+2Wm1eIiosqX0HU0iz4QTKEZySXeBkrlVRO9f/esenZLjmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYAmYN+r; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cf35636346so1647888a12.3
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 09:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705946278; x=1706551078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8/bNY9180u9oEcf2QmzJng2EAH1JQHl4RHoj7uc6BM=;
        b=GYAmYN+r0fEvieehzFdywEujwEX8SBkoS6FIDdOOuKSG6AQ2Wt54yZ63LZsVvjo0Tm
         D3v8UUUU4v6/EZisD5NkX0IeiREvybLf2RFoLbGUkR2yQGIAH/zaE4xjBwbIGzuCgDUI
         cLufrpjBvNn/PVr5WyIogJUmTOOavkcEte/1X8qRGUtEc9ByNA3yBJY+KOe0qZ8vhM2d
         tKB87XKbcmm60KD2Z1W3249lgo4tT7o144+ceGNPBadbfxQB/VDh2qEl9GpdeVZRhMAH
         yoauphaR1BY6RX3dbL4Eheb6Dsvay0I4vOyho/eUj1O2+U+wzfCddS0wW0cLzMTqlo22
         qw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946278; x=1706551078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8/bNY9180u9oEcf2QmzJng2EAH1JQHl4RHoj7uc6BM=;
        b=eLFWcOHgvSi3r2NCBJBc2hV5MmwV9sG5p4kA++FETcCkUn1XqUE6NpHV7NJsF1ISzw
         bkLLfl1FQXyhcOpTBUUhemNH+HDZDDGmlejHdoKjd3/8Tot+Es5lgH3EEkDdpv+0J+jb
         IW9wIZs3MLtWpMXLbCfZv4ImXq7lDxAgoS2/x4rrGgg8jRitkVzEYT/GJf86TchHLW3/
         QBiQbPpJqunYfOx0mY3O8Ai2jVSh4JtHvmmVtLX+qVqzuHz8Zy14a4zUNLV1VMZikT4C
         1AfMCfwISeh+RvfK6RMZhB2G61YKWOqs1zCV4/rc6c0D8fLyv8OG27Bg63HcDPpwuXaz
         9f/A==
X-Gm-Message-State: AOJu0YynU+M4pid4U83KJXZodvkGz2M98R04aVsDM+0nSfSgEN2mNTjr
	a+e+Odvo8U4qCQpUt/tBOUNubB0/YVkgvnBqVpMdwS3qJ00LTvR7cOo2AakcQ29mDICQi0Mx6L5
	cLlqqFpH/qWjQW9PHpFNGE9G0S0XXzBXtZJTMvXNr0vzc/YJP8nZYIaVY9lntYovffg4H6sQmHO
	MM6/SkbdVJpzZkZR8K00af2Q0Ag6IzHNqyvE3k6TLZzb4=
X-Google-Smtp-Source: AGHT+IHwUeuY5ob+b2CcCyW1/FUCPagrD7vCqXU3CTmKvwxuktigtYcBoibjIZGlrvicehXg7rVlqdQBG/r3Uw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:3ecd:0:b0:5cd:8355:66de with SMTP id
 l196-20020a633ecd000000b005cd835566demr25423pga.10.1705946278368; Mon, 22 Jan
 2024 09:57:58 -0800 (PST)
Date: Mon, 22 Jan 2024 17:57:51 +0000
In-Reply-To: <20240122175751.2214176-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122175751.2214176-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122175751.2214176-2-cmllamas@google.com>
Subject: [PATCH 5.4.y 2/2] binder: fix unused alloc->free_async_space
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

commit c6d05e0762ab276102246d24affd1e116a46aa0c upstream.

Each transaction is associated with a 'struct binder_buffer' that stores
the metadata about its buffer area. Since commit 74310e06be4d ("android:
binder: Move buffer out of area shared with user space") this struct is
no longer embedded within the buffer itself but is instead allocated on
the heap to prevent userspace access to this driver-exclusive info.

Unfortunately, the space of this struct is still being accounted for in
the total buffer size calculation, specifically for async transactions.
This results in an additional 104 bytes added to every async buffer
request, and this area is never used.

This wasted space can be substantial. If we consider the maximum mmap
buffer space of SZ_4M, the driver will reserve half of it for async
transactions, or 0x200000. This area should, in theory, accommodate up
to 262,144 buffers of the minimum 8-byte size. However, after adding
the extra 'sizeof(struct binder_buffer)', the total number of buffers
drops to only 18,724, which is a sad 7.14% of the actual capacity.

This patch fixes the buffer size calculation to enable the utilization
of the entire async buffer space. This is expected to reduce the number
of -ENOSPC errors that are seen on the field.

Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20231201172212.1813387-6-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cmllamas: fix trivial conflict with missing 261e7818f06e.]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---

Notes:
    This patch depends on commit 3091c21d3e93 ("binder: fix async space
    check for 0-sized buffers") to apply cleanly which is currently queued
    up for stable trees.

 drivers/android/binder_alloc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index d2c887d96d33..1f29931724ce 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -382,8 +382,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	/* Pad 0-size buffers so they get assigned unique addresses */
 	size = max(size, sizeof(void *));
 
-	if (is_async &&
-	    alloc->free_async_space < size + sizeof(struct binder_buffer)) {
+	if (is_async && alloc->free_async_space < size) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 			     "%d: binder_alloc_buf size %zd failed, no async space left\n",
 			      alloc->pid, size);
@@ -489,7 +488,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	buffer->async_transaction = is_async;
 	buffer->extra_buffers_size = extra_buffers_size;
 	if (is_async) {
-		alloc->free_async_space -= size + sizeof(struct binder_buffer);
+		alloc->free_async_space -= size;
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_alloc_buf size %zd async free %zd\n",
 			      alloc->pid, size, alloc->free_async_space);
@@ -614,8 +613,7 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	BUG_ON(buffer->user_data > alloc->buffer + alloc->buffer_size);
 
 	if (buffer->async_transaction) {
-		alloc->free_async_space += buffer_size + sizeof(struct binder_buffer);
-
+		alloc->free_async_space += buffer_size;
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_free_buf size %zd async free %zd\n",
 			      alloc->pid, size, alloc->free_async_space);
-- 
2.43.0.429.g432eaa2c6b-goog


