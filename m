Return-Path: <stable+bounces-60727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28712939B1E
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 08:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7951C21C02
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 06:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3440614A635;
	Tue, 23 Jul 2024 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WHY7yXFG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FDC13C90E
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717325; cv=none; b=utRG3Q8EWkzlcH208WAa1mOvOoVFbMGW62H/xqunykJiM12fc6PD0ADzFsejxJqrTx/Lj28kIZOq3BtrsWoE/qnpTe37cCsKrkccr0gkENuIKmVS4WbH35pcgT9pJIHfLYlWyB9hhd80JgppusgnKblA/rrdpLnWnNrSARts1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717325; c=relaxed/simple;
	bh=0HTnSe9uE8/TueQuUxnOYGQOa29Pxmdr03hf0QlYL/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=f4lGuUld5hj9vEUEwMaZhIXzEGIK4O3d2jFlbmEDUFOTTIUzGHfEhvvMuMNCKHETGqPJtjxikPMVlxCEURVpyK4S4Zt3h+zoj/iDwTfd5P030avul5avI4hVbpo1DSHZdpc7kyBD0Na5i6cbx0Tpyan8NZsH7GJjtbPQ/8psgg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WHY7yXFG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso1875975ad.2
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 23:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721717322; x=1722322122; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2ChgNmoVVY24yz+OG3mmRYW7ZSmqwZbJp6/ChgG1cTU=;
        b=WHY7yXFG/NJT9R41iqZ5LLRHAEGLO4rJGiyjH371O8ey9k6j/ylHJ0UhbCke5+fHrL
         AAcYb7vVyn/D7QYuL++xdLo3NFSZuW1Fr6vI8o4616hFI4pEy3ofVf7fbcTsc6ZAHVzr
         SbDnOgRUo3GeQdWp3LFej0ybXEisjOpvL4vTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717322; x=1722322122;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ChgNmoVVY24yz+OG3mmRYW7ZSmqwZbJp6/ChgG1cTU=;
        b=eeuUseHFlk2YTC8ooYEjGfJMp7Pn4SCbDNocSFU/oaKh6tufcnXzM43LaQSneNNTe3
         Nn+8dSf0SDtx0BPE8c9om1s1pXvCEAZUcXZIAkvEz6jVx8D2tupZtF8Qxkekw5mXThMB
         19O1HZ7fl7bNp0/Zt0jZgBAvAyiLXUtahDtGype4raYu9ihEru5OoRj2l1ngISJpcntD
         nOVsDOqLq0PzNLS3QxbkvW8P7uoIPSM3KglYmxQhmtWzq0hsTdhvaa9OWaAn43x71Yg/
         4XLxRcZ9Uoie2h5FsiDcmTCTxhNmXZ1ZpuuQ6Ut4xchVqrUCSUDZvVhQ9wBB+GS9DJ9A
         X5tQ==
X-Gm-Message-State: AOJu0YyzGoXiU7ZXAHSaIhA+RupGIfDUpeIiPu6eIicr69p7xfaJ5srw
	qtk6exiip9QW7Gb6bF0w5KgfymSYN9316eA9cBBW19ZF3kTb+QYgmj3SC7uEWExzzuLbdY4JjHV
	5fSLVsU308IHIOv0oEcDDv7wTN5KjpfAe+KADSDgw/oBRILXmjEgWOqb7+itb/90SQkFdIWvVBw
	WZOUcxBJ9nmM/0xG/jqQnrPfB+ptY05Q4xNkN1ancM
X-Google-Smtp-Source: AGHT+IGFp7Hi4mZSJbMCVB2pR1JfowqAokx6klKnEEefyFpxCStLTJoLpCfGDDfk9wJ6LcHiRTFQbA==
X-Received: by 2002:a17:902:ec91:b0:1f9:d0da:5b2f with SMTP id d9443c01a7336-1fd745879femr90429865ad.39.1721717322128;
        Mon, 22 Jul 2024 23:48:42 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd90sm66950175ad.173.2024.07.22.23.48.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2024 23:48:41 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v5.10.y] ext4: Send notifications on error
Date: Tue, 23 Jul 2024 12:17:20 +0530
Message-Id: <1721717240-8786-2-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com>
References: <1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit 9a089b21f79b47eed240d4da7ea0d049de7c9b4d ]

Send a FS_ERROR message via fsnotify to a userspace monitoring tool
whenever a ext4 error condition is triggered.  This follows the existing
error conditions in ext4, so it is hooked to the ext4_error* functions.

Link: https://lore.kernel.org/r/20211025192746.66445-30-krisman@collabora.com
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jan Kara <jack@suse.cz>
[Ajay: - Modified to apply on v5.10.y
       - Added fsnotify for __ext4_abort()]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 fs/ext4/super.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 18a493f..02236f2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -46,6 +46,7 @@
 #include <linux/part_stat.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
+#include <linux/fsnotify.h>
 
 #include "ext4.h"
 #include "ext4_extents.h"	/* Needed for trace points definition */
@@ -699,6 +700,7 @@ void __ext4_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, current->comm, &vaf);
 		va_end(args);
 	}
+	fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
 	save_error_info(sb, error, 0, block, function, line);
 	ext4_handle_error(sb);
 }
@@ -730,6 +732,7 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 			       current->comm, &vaf);
 		va_end(args);
 	}
+	fsnotify_sb_error(inode->i_sb, inode, error ? error : EFSCORRUPTED);
 	save_error_info(inode->i_sb, error, inode->i_ino, block,
 			function, line);
 	ext4_handle_error(inode->i_sb);
@@ -769,6 +772,7 @@ void __ext4_error_file(struct file *file, const char *function,
 			       current->comm, path, &vaf);
 		va_end(args);
 	}
+	fsnotify_sb_error(inode->i_sb, inode, EFSCORRUPTED);
 	save_error_info(inode->i_sb, EFSCORRUPTED, inode->i_ino, block,
 			function, line);
 	ext4_handle_error(inode->i_sb);
@@ -837,7 +841,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 		printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
 		       sb->s_id, function, line, errstr);
 	}
-
+	fsnotify_sb_error(sb, NULL, errno ? errno : EFSCORRUPTED);
 	save_error_info(sb, -errno, 0, 0, function, line);
 	ext4_handle_error(sb);
 }
@@ -861,6 +865,7 @@ void __ext4_abort(struct super_block *sb, const char *function,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
 		return;
 
+	fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
 	save_error_info(sb, error, 0, 0, function, line);
 	va_start(args, fmt);
 	vaf.fmt = fmt;
-- 
2.7.4


