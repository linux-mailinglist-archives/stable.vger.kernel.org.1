Return-Path: <stable+bounces-60726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BFF939B1A
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 08:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EE728501F
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 06:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ADF14A636;
	Tue, 23 Jul 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F+lfoQTE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27013CF9F
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717312; cv=none; b=Qjm4Sqq2kEaqRLZDyihtr+124p4bwrGU15D8tMEwYCqJalkPrYpGYpNzOb7JVczWu0zFYPiUgatHEyZFk4Mazyeqxs0G79psQm2jh+i+BszJl8uKtPKnGMitBrGZYXleK/7O4ZDYDvn8oImtMBG1Mtt6Lmuz48bspmzplY5/BXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717312; c=relaxed/simple;
	bh=0+XntXQQ9v9CMUCR2cJhmVHrlMqCupIkoRdvi4nr1rg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HkfmWNOxqDpm4s1r3JF8vsvlyBLfrxNcJJf71BQgTZ030Zi2tMrZjs2xaqdD/ssiSQW6SP5OnmqgMCT5vAZ+sygPvG3OzoXeAMiFlc/qDj+hDYpLqvB2iJO4PWb5iFcVsiSucxtNiHNb/kSJE3zrMY4gQiS/WDdVkGSChGaIK24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F+lfoQTE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc52394c92so3676755ad.1
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721717310; x=1722322110; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yG9WnxoAsP5jtqxXungkbLY1jakDH3nyoSv+8Ydvsc=;
        b=F+lfoQTEJdXxZWDu8xjfstHGgaYOsURLYCGIv/gYMxRMcOmj+i4LNHdmCCW0ksRxYq
         30eYUVykSXXNxaeRpbT4B7BkVzx2J3QF/41PQY1P7lQgKW3vxMnQOUqko+YWOv6JDQV8
         DVQqU9q+BOxWw6ty4JuuV/tHhdqrm3A5UFnAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717310; x=1722322110;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yG9WnxoAsP5jtqxXungkbLY1jakDH3nyoSv+8Ydvsc=;
        b=CoCrNZHI6tQjQ+MFyUkw8C8R8VyuUDCto3gDxSQ5nMkLMoJ/izTy71RA+HGOARI6G+
         qL0dqwM6Jtk30VbQQ1oZ2Tzg1v6rJcLa0K/B6QACySLRhgKd7HMkrL+Sqm0jQw1nvCK2
         Oaqwl/AwgO4AVE+R4Yq9z/APKHtoKoll7YHoGXD6WZUdFEqGAFv2lzHZJQrwJAVSh958
         FZzWecV55XjZspjamSNrUVjiRr3xWEs9bzCSgV48LgNl6Y4yTO9nEHBg9MoMY9EckHxu
         iIrLfuJhBqJSNHxNIliu9Sab9brYc1fZAViSNT6hzobmlqynCKDB3YAnSX2x3qI+X8Nh
         XKQw==
X-Gm-Message-State: AOJu0Yx2+7R3U2plwkPEapyyLfM5zYuu3URYM0UgViiGvYIaAFmYdVte
	SczKeIddkAW4pAILFZuhw9CFajX4TNKqcp/1WBm3G+yCUpKd43cKcs0cLaR2+Askp8cbnNM56aV
	t5JYzWpz2ji9FzVVG5FQpirRhrh65IMUDyMfp4MosCNYrZlzoD9J4QCpLOiO5+ALBzZP7suEEub
	KpQMgXv9NC+Yz+JfOeNa0nbh9xiru0uHQO7tcPfQ==
X-Google-Smtp-Source: AGHT+IHAObmxYU1HV+RmN2tsABt6hiYi3Tbms5Abfi+vZEx8a/c2GmYHqxZ9nQrGtERCuO54fBkrRQ==
X-Received: by 2002:a17:902:e843:b0:1fb:415d:81ab with SMTP id d9443c01a7336-1fdb5f6a05bmr19444185ad.20.1721717309537;
        Mon, 22 Jul 2024 23:48:29 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd90sm66950175ad.173.2024.07.22.23.48.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2024 23:48:29 -0700 (PDT)
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
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v5.10] ext4: fix error code saved on super block during file system abort
Date: Tue, 23 Jul 2024 12:17:19 +0530
Message-Id: <1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit 124e7c61deb27d758df5ec0521c36cf08d417f7a ]

ext4_abort will eventually call ext4_errno_to_code, which translates the
errno to an EXT4_ERR specific error.  This means that ext4_abort expects
an errno.  By using EXT4_ERR_ here, it gets misinterpreted (as an errno),
and ends up saving EXT4_ERR_EBUSY on the superblock during an abort,
which makes no sense.

ESHUTDOWN will get properly translated to EXT4_ERR_SHUTDOWN, so use that
instead.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Link: https://lore.kernel.org/r/20211026173302.84000-1-krisman@collabora.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 160e5824948270..0e8406f5bf0aa0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5820,7 +5820,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 
 	if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
-		ext4_abort(sb, EXT4_ERR_ESHUTDOWN, "Abort forced by user");
+		ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
-- 
cgit 1.2.3-korg


