Return-Path: <stable+bounces-60705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB21B939098
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 16:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AB9282042
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8F51EB3D;
	Mon, 22 Jul 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1KZ3vhV4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964508BEA
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658189; cv=none; b=OQgLcJUfJ75frSc1EgGp0JJT7cdwVdi66NDoJIkl+Ab7BPk91DZvgQC87dhPGp71UCNghtcZIbN4Ic+FGskn7NXxS9Pm2JUyboo5krDOZ6XoB1/ll0VKQnHCKor6wVJcMz2obIHeuzirbI1GwS0rJCi+MU4kq7Fi0kjNf8fxqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658189; c=relaxed/simple;
	bh=x3hXaDpk6G0hsbOw1ZDFQ7qvC93c14EXUfk93NIBMZ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b6LctNwVqRS8ShzpN7xS8ytgsVE3HxhPFHpcRlCAVl64g517TPeqUhrbShca6UQBouLWFjA/IBSHr1OSRnneA59RY0HACIUXykcOR5ABriKty4DbZLxRfLuLpxOxtSc5NtHiouKWB2EBx3Rg3y5kk7ERnxDw/wZA4NDidCqIZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1KZ3vhV4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42666b89057so148885e9.0
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721658186; x=1722262986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nm69CtE6VQRKL/lPeUhl3NnXx6oMWgEL7L+HAkh6o/8=;
        b=1KZ3vhV4EodAvV9njRae8RbqehFRgVVOKpitGkGh3cQvmB37+t57BmCbZjyCt0jMvW
         PjEqslhYMB5enXMQIdfBt3pGSCXNPYjQlbXOu3i90v3v2O2NP9vB6E3uiiBqY7pJPG1V
         Oqg9rkP46vonTtw32Y/zamjjhRXQlppJCk22xCKxCuWmFGeo/GCkclbkvUBAEVV3ETjN
         1Z7FwPkWGXRmkGqfsrHdDHPPAYY2EEyBn+/NV+5KcT3rucE9YRNHhwQw2vzSOsvdkigl
         gK60mNnN6TBji4oA7szBTMXOXJc5FLIfIEAQgcPbVkR726F0mfUwCAYGpr6hjS+Vgyh7
         nWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721658186; x=1722262986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm69CtE6VQRKL/lPeUhl3NnXx6oMWgEL7L+HAkh6o/8=;
        b=R15L2qMKt8+nWl4XC7HMe0FdVSh6Kg+swaXNsuyvzDhlQESlkuT3Hlo65FcXXX2HLI
         vMhA4f58RkhTcrCkzLb2NHDjZRhUCHN4g7OE/eW2wgD9Db6QD4ODNZjqQ1CU+W5O+6iV
         F7H2bBabTvNhLJu0TZun5Ruc0yub+AIjDEAqstT1qPXw0R5oSPOCWSOiUxrUuX7fv6UL
         XqI+wDsT5zCKLeHJyqFDMXBtiihXUPDT7G/335wVN6oJMrqfIgAqHh/0NPc5KFz8jo37
         0IHW39hLFtI3HVPGDSpJCzLDuv7hDPEfi6owd37+U2FS6w9sL4gAqbVvIy5N5EUl8YEJ
         hvrQ==
X-Gm-Message-State: AOJu0YwVhHV5MR4jFlimQuZ8E4nw1A4z8ug7ASgKuw7w3+RD7YqC0cfq
	eqUzSrjFQXbBeCwH9KtW7t/TP2ZPsg3JUEQD5mtQjZ+Xz/vZ5HW9AIp8jBfUkXUBXI90+9Xzi0G
	auZvP93s=
X-Google-Smtp-Source: AGHT+IE+ZlE5Se1n9BE40hJ1q5N/JMYE8VQmmFm9fpYHEAEpoSD85rNfq4IjtgBe0etWmOyVoiRbeA==
X-Received: by 2002:a05:600c:1d0a:b0:426:8ee5:3e9c with SMTP id 5b1f17b1804b1-427dbb47c03mr3059115e9.6.1721658185304;
        Mon, 22 Jul 2024 07:23:05 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:560c:dcc0:a84e:7aff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368788117d5sm8642110f8f.115.2024.07.22.07.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 07:23:04 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH stable 4.19-6.6] filelock: Remove locks reliably when fcntl/close race is detected
Date: Mon, 22 Jul 2024 16:22:50 +0200
Message-ID: <20240722142250.155873-1-jannh@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 3cad1bc010416c6dd780643476bc59ed742436b9 upstream.

When fcntl_setlk() races with close(), it removes the created lock with
do_lock_file_wait().
However, LSMs can allow the first do_lock_file_wait() that created the lock
while denying the second do_lock_file_wait() that tries to remove the lock.
In theory (but AFAIK not in practice), posix_lock_file() could also fail to
remove a lock due to GFP_KERNEL allocation failure (when splitting a range
in the middle).

After the bug has been triggered, use-after-free reads will occur in
lock_get_status() when userspace reads /proc/locks. This can likely be used
to read arbitrary kernel memory, but can't corrupt kernel memory.
This only affects systems with SELinux / Smack / AppArmor / BPF-LSM in
enforcing mode and only works from some security contexts.

Fix it by calling locks_remove_posix() instead, which is designed to
reliably get rid of POSIX locks associated with the given file and
files_struct and is also used by filp_flush().

Fixes: c293621bbf67 ("[PATCH] stale POSIX lock handling")
Cc: stable@kernel.org
Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=2563
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/r/20240702-fs-lock-recover-2-v1-1-edd456f63789@google.com
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
[stable fixup: ->c.flc_type was ->fl_type in older kernels]
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/locks.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index fb717dae9029..31659a2d9862 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2381,8 +2381,9 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 	error = do_lock_file_wait(filp, cmd, file_lock);
 
 	/*
-	 * Attempt to detect a close/fcntl race and recover by releasing the
-	 * lock that was just acquired. There is no need to do that when we're
+	 * Detect close/fcntl races and recover by zapping all POSIX locks
+	 * associated with this file and our files_struct, just like on
+	 * filp_flush(). There is no need to do that when we're
 	 * unlocking though, or for OFD locks.
 	 */
 	if (!error && file_lock->fl_type != F_UNLCK &&
@@ -2397,9 +2398,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = files_lookup_fd_locked(files, fd);
 		spin_unlock(&files->file_lock);
 		if (f != filp) {
-			file_lock->fl_type = F_UNLCK;
-			error = do_lock_file_wait(filp, cmd, file_lock);
-			WARN_ON_ONCE(error);
+			locks_remove_posix(filp, files);
 			error = -EBADF;
 		}
 	}

base-commit: 2eaf5c0d81911ba05bace3a722cbcd708fdbbcba
-- 
2.45.2.1089.g2a221341d9-goog


