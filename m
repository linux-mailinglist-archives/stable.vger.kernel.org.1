Return-Path: <stable+bounces-12716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6F783712C
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29953B24FB1
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493FE40C08;
	Mon, 22 Jan 2024 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BusungNp"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57C47765
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945407; cv=none; b=CExvYd1oovIH/nKoG3f7uODC3ZejDw8hPobX8/QwLDfwIoyXUF05xpF/0codxVirfFZCkMvRkP4irMHyd4DZgZ845dKveXi4sxJkFYs1dNUWBdxz5txMoGFb2yx953nIFAMki3urY04ChxedDGFzcgZ4s3yGd+577gTZrGC/U/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945407; c=relaxed/simple;
	bh=XjZ89AaU4CZ4hbM0YhJVXQ1YWIDXj1f74a/9+K4qV1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y4oTw8VjolYebJxm6hrUa2tdw4sjuJvatmYNN0+b3cWUch1YCQFATP7ekLie8ixpPOunx80mGXyYFyt9NgoHB+tys8w6ERKmBPJO/U+ChgiGSjxIgn1P5YcJ1OaMy1D8AxhHkEhSYiqcZZ/JUXWqrPSA0m1a3ExVDeLuHGNx198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BusungNp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f6c12872fbso53219177b3.1
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 09:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705945404; x=1706550204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rbnhksQm2maENsnWdKsLgbwdQrC0Ub3PW/rOLZV5q9U=;
        b=BusungNpy+ohC3PceoKD3uzyZm0mADsmvZ4A7C384jCqx5ea0V13OwOj7rVOV3MKZL
         RzpHALjKnFWd6lhF6vgHiDHcSVFNLkHYXh9h0GMw2vQlza1IzXMOEDbr4sT8iarhJu9W
         3yyIA7aNdiZLkERuHfCkE3ZB45SPVfhZ30NvEmBgtOg2jUWom6XGxzjpXm+fF5X8iqFP
         NRlTlB6ImyasVz3YZNaY3pl6qxAp/mIvU83Q1RC3nx/Ditqk6EFhveJjH++vhVkVymei
         7dD+Tp1vElshVJEcygjPxaXmqrAACyju3T/phq1UECfllTq2z6QRGZzs1rztj46EB9VN
         tjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945404; x=1706550204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbnhksQm2maENsnWdKsLgbwdQrC0Ub3PW/rOLZV5q9U=;
        b=t/NBXMy4RXkTM9i5+kD7vPwWIQIDl7666LpAiyRMhsW2qBhZSF97WugljyNlmJG4jn
         WgKhXy5FHepazS/glhofRq1Yv9WLD8MqPALvwDF0RvY6a/8MxS7SUttZyryycZv1zjPa
         cptFjuy3oleBiRe6z6A9e7+kMr9HOf9Ffkq145NLNdCbvc9RYOTahpg0eWd9qfcHwiW4
         I6l7XSkifQhU/YlH5deJ0Yq6cmxp1nBE4mhbSjnMOVD44o19sY0KyJ/q3lhNw5OxwdRP
         WOKmNn6gT1o62B26Vkzi/gYs4l17sbKCnBldhXXABzbaey2LVnhDh8G2yhKDj44EGBhG
         WOpA==
X-Gm-Message-State: AOJu0Yxt7qfqDCfGsEWslfW+A4PueAna6N7GYx8GQqvWUrhTSrexmaYn
	GvWR6NfR5rb6tSdPAlWhhFXW+WNPIaeVZJYce9tiq7MOySObNR1XdyI8lTVPMdAEqDrO6G13txF
	zT7uCS8Cg7EHk0t8gTKNzWkJmEzo20ohTQ1yIF4NBFPifZFen5b+M2VJqVkIAREd1lrDjVcbMKh
	dQqV7k1vTF9ngox40YAdmdk476T2OR1OKNuX76mdK53uA=
X-Google-Smtp-Source: AGHT+IHRBH1zSuZEWNYOhB1ZS9cbcCYhtJpUbL+/hnap/4gBLsfFuPle6vDOsWE7sL0p0tj9fnkRZ1MEJy2zMw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:9903:0:b0:5f8:cb40:b393 with SMTP id
 q3-20020a819903000000b005f8cb40b393mr1571209ywg.0.1705945404521; Mon, 22 Jan
 2024 09:43:24 -0800 (PST)
Date: Mon, 22 Jan 2024 17:42:50 +0000
In-Reply-To: <20240122174250.2123854-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122174250.2123854-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122174250.2123854-2-cmllamas@google.com>
Subject: [PATCH 4.19.y 2/2] binder: fix unused alloc->free_async_space
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
index 79cac74f0f1a..6eb5be798d55 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -402,8 +402,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	/* Pad 0-size buffers so they get assigned unique addresses */
 	size = max(size, sizeof(void *));
 
-	if (is_async &&
-	    alloc->free_async_space < size + sizeof(struct binder_buffer)) {
+	if (is_async && alloc->free_async_space < size) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 			     "%d: binder_alloc_buf size %zd failed, no async space left\n",
 			      alloc->pid, size);
@@ -509,7 +508,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	buffer->async_transaction = is_async;
 	buffer->extra_buffers_size = extra_buffers_size;
 	if (is_async) {
-		alloc->free_async_space -= size + sizeof(struct binder_buffer);
+		alloc->free_async_space -= size;
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_alloc_buf size %zd async free %zd\n",
 			      alloc->pid, size, alloc->free_async_space);
@@ -631,8 +630,7 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	BUG_ON(buffer->data > alloc->buffer + alloc->buffer_size);
 
 	if (buffer->async_transaction) {
-		alloc->free_async_space += buffer_size + sizeof(struct binder_buffer);
-
+		alloc->free_async_space += buffer_size;
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_free_buf size %zd async free %zd\n",
 			      alloc->pid, size, alloc->free_async_space);
-- 
2.43.0.429.g432eaa2c6b-goog


