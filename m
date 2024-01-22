Return-Path: <stable+bounces-12715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BCF836F7B
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C581C28B60
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904C83D981;
	Mon, 22 Jan 2024 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWKhb/Vm"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5FF47762
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945406; cv=none; b=Bg2g7Lgeovqe8rDTGrXQYHX3Xf4xrRHNBkXJPwjRMAZSRhfeiqjVZ7AyTxZF3aZ9DDFaoqYeAR7eQIoq+QfCDZKqDul3I+SSuTeR1RezKXF7Vr1Ms/5dbxZYz7FfL4CdyqSixCTM7SUKWC05sRjusLUOzw6VOjMIdYUSnQI7O+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945406; c=relaxed/simple;
	bh=rwlJqXYf5Ib+LfRFTtqGRwCTJtsY8WqhX6jO8zSh/7M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=khj1iQVgcOlSTq7pZGhO2XXaChKfOiGJgKINf8p9uxddaCzlJKK9tYMPiIQqdOkxh8emhuV167FIFAU6TA1pb5QDBZhLEHp02M8Xt0sU+A4jGIWtUtZC8/PaR+NyxRFv0qR+o6PXjp+bwTkOxWz+hHb7LzJleK+mOTPAeKccDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWKhb/Vm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff85fabbecso44482117b3.3
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 09:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705945403; x=1706550203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m821fw9PUpBfidwz5fgpq0QqvmhZzChMwf+OKZLmczo=;
        b=lWKhb/VmCCBVr4kb/7DDte5W+mvdeqrmEMomsUNKb7dZRp49gnsgqXghzk+HWM1RY5
         2fJedWaWlkL78XjF7zuSSTMv1oQzTv5SoOTAwOlJB2qcMFmdqRWxGjKf5vvz4kxLcdgh
         x9JDgcaspOwKy31JKZ1tXuSl+6T4c2W4LFITb98x9s9tZMGDRPK8qqCfCT7HaR44rRCp
         emu358IykwrlWwmu+Du9vSsYgNM8ZO+RX6HGsEMEnonK6fKH8HWZY4e0nrsJcl2sF+wI
         og3hsfnT6wDZo1Xj8xCRF122ONNgiL0YqcN1wDmYk+gEIUpG+g93emiZgysuxYU+sud3
         M7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945403; x=1706550203;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m821fw9PUpBfidwz5fgpq0QqvmhZzChMwf+OKZLmczo=;
        b=p0GpDJAlqXZ58XZhrsYYGbryfvQOSA3ZGtE+IV5O2cj+lbJIhjVBZq6MBn8f6D48hg
         BBsJNbLjr5I/2ab/YPRWTY7h6abXf8psqUfspvxtsPJ9rx7famreUAN66jyUH38mhxZd
         IWT6gsBFG9lBcsF3rj/aKpVw/nDAVr8/VUMZE/Ai8On8QoHQPC+gti49dy4TTv5ui8YN
         7/ZLskfryZZwxwbP+2RpJNsC5lvVD+e84TZrc/2D7EQnDylegBylJsYUNRXn78pV3eYI
         zDCRxSmbuyvuVxumdfgFD+dvAqUuaojrCYiRd5qwMm7oAjixKURyJMWEPEsy+MyYjJVF
         t2fw==
X-Gm-Message-State: AOJu0YxMgQpn1Bm+PXrQMlzRbuVA4RNbeBeFmDCWfZpcuDqVPzgF90hc
	xrkjyBrXuEA8aR+2zuVl0O1vlL7czCNKFNxZaf5tK0zJKpXy9WJSqLHvYMyMdWad/SX8r0B2UGF
	7XxxBTqRu8W/IxrRZHlI0iSmlECtqyT+KPKDEdYh4KpQYpFxOpYzSFkFL4nBM3kou5TVWZqEEP8
	B8R6El3nQyKZ7MAkh3IdMDd71gq4yU2WUpOBXEFCrUfkQ=
X-Google-Smtp-Source: AGHT+IEVd0xKzV/DMD+c47CHp0lxdFjA4Sk7Nn9ixJAZI3jLc5Q2Dd38g1zStxcRrBGseOwDq8sJ20wk8UFX2A==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:484e:0:b0:5fc:548:ca50 with SMTP id
 v75-20020a81484e000000b005fc0548ca50mr1564343ywa.10.1705945402829; Mon, 22
 Jan 2024 09:43:22 -0800 (PST)
Date: Mon, 22 Jan 2024 17:42:49 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122174250.2123854-1-cmllamas@google.com>
Subject: [PATCH 4.19.y 1/2] binder: fix race between mmput() and do_exit()
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

commit 9a9ab0d963621d9d12199df9817e66982582d5a5 upstream.

Task A calls binder_update_page_range() to allocate and insert pages on
a remote address space from Task B. For this, Task A pins the remote mm
via mmget_not_zero() first. This can race with Task B do_exit() and the
final mmput() refcount decrement will come from Task A.

  Task A            | Task B
  ------------------+------------------
  mmget_not_zero()  |
                    |  do_exit()
                    |    exit_mm()
                    |      mmput()
  mmput()           |
    exit_mmap()     |
      remove_vma()  |
        fput()      |

In this case, the work of ____fput() from Task B is queued up in Task A
as TWA_RESUME. So in theory, Task A returns to userspace and the cleanup
work gets executed. However, Task A instead sleep, waiting for a reply
from Task B that never comes (it's dead).

This means the binder_deferred_release() is blocked until an unrelated
binder event forces Task A to go back to userspace. All the associated
death notifications will also be delayed until then.

In order to fix this use mmput_async() that will schedule the work in
the corresponding mm->async_put_work WQ instead of Task A.

Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Link: https://lore.kernel.org/r/20231201172212.1813387-4-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cmllamas: fix trivial conflict with missing d8ed45c5dcd4.]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 27950f901595..79cac74f0f1a 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -290,7 +290,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	}
 	if (mm) {
 		up_read(&mm->mmap_sem);
-		mmput(mm);
+		mmput_async(mm);
 	}
 	return 0;
 
@@ -325,7 +325,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 err_no_vma:
 	if (mm) {
 		up_read(&mm->mmap_sem);
-		mmput(mm);
+		mmput_async(mm);
 	}
 	return vma ? -ENOMEM : -ESRCH;
 }

base-commit: abc2dd6a248d443c27888aee13cfefd94c3f7407
prerequisite-patch-id: 040c7991c3b5fb63a9d12350a1400c91a057f7d5
-- 
2.43.0.429.g432eaa2c6b-goog


