Return-Path: <stable+bounces-204113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF62CE7B68
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 18:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C65B4300102D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD1833067F;
	Mon, 29 Dec 2025 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvVnM5rd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B72853FD
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767028469; cv=none; b=Fe4jS4STy61cF2QznxP+0GZsdioQjLiThE6kLQmWxwzRWlc6rUyNDqg9nsfywhbNlGJFzBHB8FhHP2CHY8J6aebg5mzp/8BEG4pnfMyQdIHqyqtHItGmAHzeMJOLKdK7z6+9EfXgoN4SSj6AkCzXoH3cIjOX4VLr8eZ5MkUwhrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767028469; c=relaxed/simple;
	bh=W6aUeOEN1SgFtWQZemlJwqK1F1smQGCcFNxoAevcZJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tsOzQJ+MpnZE1cUrqAe5ERpzNiGIrRXAWeGFQugPzjmgaF2tVEnHAGtH6X1w8mmQlnBdGnqu/kPw7AfC0kKuHa9UeRcGP+6hMRQZzCOyRxbFNDG3GF3scFacw44/baWOqwzK5lI1Xo2O7XMopGSep7iCH2jJ4W0lR0YxXBb1uTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvVnM5rd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so7153337b3a.1
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 09:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767028467; x=1767633267; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5NK6dp2s8X6NtEpLJQM+0l1rM8deukQbR1S/tTFRVRA=;
        b=dvVnM5rd/jX/Ai4hZK7yFww5FH7uhh6LGZXiiKIP48o5dkkUtM/QVUqq8kxg6gxDuR
         h4MoI3TW+ApwVBtmHumq5EySJbungMQ3xmXqaQ8O8CaFK6XKPY8IkSIm800RI8zRV7oq
         OV4X84JKgoxxSoof8ShyOYlnPnya94/IIj3B2nzU6mq78IJ+GvaFZ5Y6KVTGssDjs2e2
         /2/q33MIhmCqSjFQL58aERPtyH4Ea8lERMqHQ7thp2q/bkjr3++A0MxlM74oD11EdS0a
         b33/HiInivdxkoYftQrdxtrjEVSTNRHqKNM5ovhNN91L74NEWgOUh/D9c9Q5VVjJ/pNr
         oE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767028467; x=1767633267;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NK6dp2s8X6NtEpLJQM+0l1rM8deukQbR1S/tTFRVRA=;
        b=ZcxvBOwypNrOFUccsvSmQRkXMZv5Krwf4ZwRfopnt5fE6JzzHhaxRPuGystrkV0rqX
         Mp9gu3eWP2qRjqV+tZEkIKVY8UQEBtj/LWjh8LKjWODduwG3ClEYRsEvMKG9Gnzufpd0
         hr+ZYXpWMJrz0gZe2yJcc0ntpMjRsnY788K9fAthbebof9rpcLuljfrvWF52+fnCJKPa
         R6cd8uV3QHx7Z5Z97N+I09bKc6Ux9Z7EkZL0rAVtSMHEQc7sTa0Ojx6k4cI5pSlvVdbw
         ydF2YD5b5w4QFZoQ5tPiNwJqvp4famr2RKMlW6KsKCFasMVN/KKE21AeLpanJFxQu8IK
         dSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwV8RgRt5mwK/L04rk0kpsdiJ6R+vL0Cyl3Lc0cpO1wTqSTdTTxaNQ7JSORwKkYPC8ndz+qUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqkZjJP4/CyB8GH86nKz/rfov+93A7/93A/r/7t4IDuOD7xQes
	hbH2vJxuuN2Tpom1yAjmDCGzJH4KpBNxYSZVDuw6gRZ10B5xHdyvwh/4
X-Gm-Gg: AY/fxX5sEpfuk29NVf1pod6AQWRYhuhPlnxQhnCGRRfTfpjS5bLwCbZkzsMC4HkIm0V
	xcjsFs8/Z0qkMLKORqc8t+EFonoEZrt6lhKu6qGfQruGO2O5hEqaI2ONKtyDv46gybk/MEVUn+U
	37+rqWFAaoIfEiVQSb7JR1eAQlc87hInWVEY3quV7KhZ3WdH6FYnuuOMufebmWivBrFz72KR0iL
	cf5BcjT400BZsrVzCyw8uyjA7iW+vmzQlpM5DW/6FGXOfMVyplyD4F1g6yQC5Gq7fFXWCn7+/S+
	A+d3CGZTkVOOuCvO0I1dojXknZw0ZiuHkpPsd+wcEH5i16Nkb9CCfdiI7YNqJJXAySlT0//fYwO
	oI8Q62PhLRL7wiEJ1FuMWI1x2u7oHaTmgBBeTbEL2XLLIDQWtcljYU8zQ86I8g2igMv/kmjnONl
	t4KxRfyZ1RQq1phOt2PuI=
X-Google-Smtp-Source: AGHT+IE0UQafWJtzQnLvkcd4tjvwk6WEjuZXQW80bW7BYX7qVp8/RiTlljt2VidyeoCSfiVHLlor+g==
X-Received: by 2002:a05:6a00:1f0c:b0:7e8:4587:e8c4 with SMTP id d2e1a72fcca58-7ff66479a55mr26456010b3a.55.1767028467371;
        Mon, 29 Dec 2025 09:14:27 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cffesm29656429b3a.49.2025.12.29.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 09:14:26 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Tue, 30 Dec 2025 02:12:51 +0900
Subject: [PATCH] gfs2: Fix use-after-free in gfs2_fill_super
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-fix-use-after-free-gfs2-v1-1-ef0e46db6ec9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDUAwFryJZG9B8lOJVShdf+6LZWElaEcS7+
 +lyYGZOCrghaKhOcuwW9lkLtHVF05LXGWzvwiSNdK2khtUO/gU46xfO6gDPGsJ9P+kISWPODyr
 15ijq//x8XdcNrx2XbmkAAAA=
X-Change-ID: 20251230-fix-use-after-free-gfs2-66cfbe23baa8
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
 syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Ryota Sakamoto <sakamo.ryota@gmail.com>
X-Mailer: b4 0.14.2

The issue occurs when gfs2_freeze_lock_shared() fails in
gfs2_fill_super(). If !sb_rdonly(sb), threads for the quotad and logd
were started, however, in the error path for gfs2_freeze_lock_shared(),
the threads are not stopped by gfs2_destroy_threads() before jumping to
fail_per_node.

This patch introduces fail_threads to handle stopping the threads if the
threads were started.

Reported-by: syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4cb0d0336db6bc6930e9
Fixes: a28dc123fa66 ("gfs2: init system threads before freeze lock")
Cc: stable@vger.kernel.org
Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
 fs/gfs2/ops_fstype.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e7a88b717991ae3647c1da039636daef7005a7f0..4b5ac1a7050f1fd34e10be4100a2bc381f49c83d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1269,21 +1269,23 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	error = gfs2_freeze_lock_shared(sdp);
 	if (error)
-		goto fail_per_node;
+		goto fail_threads;
 
 	if (!sb_rdonly(sb))
 		error = gfs2_make_fs_rw(sdp);
 
 	if (error) {
 		gfs2_freeze_unlock(sdp);
-		gfs2_destroy_threads(sdp);
 		fs_err(sdp, "can't make FS RW: %d\n", error);
-		goto fail_per_node;
+		goto fail_threads;
 	}
 	gfs2_glock_dq_uninit(&mount_gh);
 	gfs2_online_uevent(sdp);
 	return 0;
 
+fail_threads:
+	if (!sb_rdonly(sb))
+		gfs2_destroy_threads(sdp);
 fail_per_node:
 	init_per_node(sdp, UNDO);
 fail_inodes:

---
base-commit: 7839932417dd53bb09eb5a585a7a92781dfd7cb2
change-id: 20251230-fix-use-after-free-gfs2-66cfbe23baa8

Best regards,
-- 
Ryota Sakamoto <sakamo.ryota@gmail.com>


