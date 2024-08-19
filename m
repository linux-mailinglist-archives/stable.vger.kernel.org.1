Return-Path: <stable+bounces-69620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389A95726F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 19:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CD0B238BE
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 17:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AABB1891A0;
	Mon, 19 Aug 2024 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z9tLN+ju"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191A18757F
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089977; cv=none; b=GULcq6spcnVwdhZ0LjZ985UQVUrzoZ3QS/mhvVhXFAurXoPcocb0hORgC03pziqQSGmvpCv4ZB7/m/uKxoo2OJOyFFGVuGiIRmz7I0NX1W+4SF49azDlxdkSijqF9SH09HH3mQUXuFI14vBGCLOYaSZ3UnfLzmMj9UWJ/zJEjBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089977; c=relaxed/simple;
	bh=cVTzqwZxap3iVomL1QKHBohhVggQhfoi3NhyFSh4m+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FN9m5VyjBMmOfl7z4Ab9s+PqggA9u9D6tds4m64WErZ7bUioo0RplnBCiBFhTVnpf/kLQglrzuUI3PbrAUCWtLTbHl1rgVkLGWnSCWiuJUFgZdz5U+drqNxpDk1DTjN/IHiYE2PzdMVP5MbuFkosyTM7AMG/ujYVraym1XoubYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z9tLN+ju; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427fc9834deso2835e9.0
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724089973; x=1724694773; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8gMtRG0oO8Nirv/pH9tl2QYzZXra6QzE+ysSHUsbX5Q=;
        b=z9tLN+juahjwDC8+QcDPPxrD8DA3F2I0uL4dNK3yogCpjEtSjW8vYbijTND6mNo1ZA
         P07sCtLvonv5nRXnuu+QtlXoC3oh8aJDM5rUfdY8DuenRvYRUgGcYDcC9ZhfxjLQ6wyz
         7pYq2XvwPTa4gDWz73Aw0ljOXNJdaaDWl02Mfl1YCjF5ei93yYnpvG/bGoHL2VmDjeIN
         EVrG/FkT1DsDHuorEVhjYzzLmQ0TrECtChoJacencfXbqn5MiJCJJb3x7yAQT2X/uHvF
         QsuuqTCVYF/TrEN0M+0sdjT9UyrMduo6Q7IHvFdh2nmvEZD3gKQN/fnk6Zup+G8kWYlk
         +Ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089973; x=1724694773;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gMtRG0oO8Nirv/pH9tl2QYzZXra6QzE+ysSHUsbX5Q=;
        b=ckcN27a/YcqZI4UZObcBH8bBer4fbdPxQcKeCjrDJL6taRSeJPoLNh2lgqDXdvt8Kl
         H6ACpkoPSX50VMkFDBVV0F9LYSxjWyHxDheuxqG8la+tjgv7V0yb4m/px4gDVNWay7mv
         CxyNGRMd9Q4cJytV5MWEXVFOwvz8wclbKJe8DDPvhzwE4RBepd4BWbfdp1cIctwQn5fu
         Z0kCdlPN6ICZ5u9BuTCWPxPZ+ByO6PCMX6tZDfRRMSGWIwZYAOHfUaFtTwUcJXiHqXn2
         wLzCcHkHJgfvOw2SNw2e56OaAfilrobfk6OLWqLecJ4ZQ+6r3DQ87QLWXYwgARawpLaq
         FP4w==
X-Forwarded-Encrypted: i=1; AJvYcCWQIWVd+XpJcLzOZX/e9yuSpwfYLSYu+W6A5GilJcKmRFs8vF0evNwM4G+XXuy4HK0is8D+OjeWU6JPIvvAbN1037BpU61S
X-Gm-Message-State: AOJu0Yy4Rrp/JTuq98vMxHaUjo/ApXeBcSxo1r+tiFoPUvdxHcOFlg42
	aW1T7PdqX7nyaKYZYysfZFV/9j3+BnorBNuMSbaAjvr4mBug/jNgniwjVUjW7A==
X-Google-Smtp-Source: AGHT+IEfrtYkRbMyHE+evxSmNhWANR4xJdsvBU1gG/nyq5RBdF2604zrBs8r7RvRtK65WLsJyMDnjA==
X-Received: by 2002:a05:600c:1f09:b0:426:66fd:5fac with SMTP id 5b1f17b1804b1-42ab6028c33mr25945e9.2.1724089972573;
        Mon, 19 Aug 2024 10:52:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:90ba:acf6:9644:9e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898b8e8asm11120073f8f.116.2024.08.19.10.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:52:51 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 19 Aug 2024 19:52:30 +0200
Subject: [PATCH] fuse: use unsigned type for getxattr/listxattr size
 truncation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-fuse-oob-error-fix-v1-1-9af04eeb4833@google.com>
X-B4-Tracking: v=1; b=H4sIAF2Gw2YC/x2MQQqAIBAAvxJ7bkHFzPpKdKjcai8aK0UQ/T3pO
 AMzD2QSpgx99YDQxZlTLKDrCpZ9ihshh8JglLHK6w7XMxOmNCOJJMGVb3TOBuWNbl1ooISHUNH
 /dBjf9wNZy9uVZAAAAA==
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724089967; l=2556;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=cVTzqwZxap3iVomL1QKHBohhVggQhfoi3NhyFSh4m+c=;
 b=k7g0mM4redxq0rCjuhFOUqDAemNc6dhKrUvEJAP8MN/HN7KDyKQIkFk803VCqqn5scePWum8q
 BKDV7gy4DECDxFhAP8KXxfgrb1YsT8BpZzgNMpu0+pI2gzhvJhCdYHB
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The existing code uses min_t(ssize_t, outarg.size, XATTR_LIST_MAX) when
parsing the FUSE daemon's response to a zero-length getxattr/listxattr
request.
On 32-bit kernels, where ssize_t and outarg.size are the same size, this is
wrong: The min_t() will pass through any size values that are negative when
interpreted as signed.
fuse_listxattr() will then return this userspace-supplied negative value,
which callers will treat as an error value.


This kind of bug pattern can lead to fairly bad security bugs because of
how error codes are used in the Linux kernel. If a caller were to convert
the numeric error into an error pointer, like so:

    struct foo *func(...) {
      int len = fuse_getxattr(..., NULL, 0);
      if (len < 0)
        return ERR_PTR(len);
      ...
    }

then it would end up returning this userspace-supplied negative value cast
to a pointer - but the caller of this function wouldn't recognize it as an
error pointer (IS_ERR_VALUE() only detects values in the narrow range in
which legitimate errno values are), and so it would just be treated as a
kernel pointer.

I think there is at least one theoretical codepath where this could happen,
but that path would involve virtio-fs with submounts plus some weird
SELinux configuration, so I think it's probably not a concern in practice.

Cc: stable@vger.kernel.org
Fixes: 63401ccdb2ca ("fuse: limit xattr returned size")
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/fuse/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 5b423fdbb13f..9f568d345c51 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -81,7 +81,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 	}
 	ret = fuse_simple_request(fm, &args);
 	if (!ret && !size)
-		ret = min_t(ssize_t, outarg.size, XATTR_SIZE_MAX);
+		ret = min_t(size_t, outarg.size, XATTR_SIZE_MAX);
 	if (ret == -ENOSYS) {
 		fm->fc->no_getxattr = 1;
 		ret = -EOPNOTSUPP;
@@ -143,7 +143,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	}
 	ret = fuse_simple_request(fm, &args);
 	if (!ret && !size)
-		ret = min_t(ssize_t, outarg.size, XATTR_LIST_MAX);
+		ret = min_t(size_t, outarg.size, XATTR_LIST_MAX);
 	if (ret > 0 && size)
 		ret = fuse_verify_xattr_list(list, ret);
 	if (ret == -ENOSYS) {

---
base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
change-id: 20240819-fuse-oob-error-fix-664d082176d5
-- 
Jann Horn <jannh@google.com>


