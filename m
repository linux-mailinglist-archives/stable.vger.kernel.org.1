Return-Path: <stable+bounces-159264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87921AF6241
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 21:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD98B1C473B9
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6C2BE65D;
	Wed,  2 Jul 2025 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clvk4KIC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98602BE630;
	Wed,  2 Jul 2025 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482831; cv=none; b=Ec75Sd/dLuT54Go5gUU0YRME3vysH/iy/G5MsgopsdSbM9PQPpy7Gmlow6vgTDn/q1OQ6CAs6UotxfhWHkISnYKenMLWrBwZ3qlR54J54PAgYS+p1DdT7QbTiylBrEZOmb5A5Yl3dwZwSdukX7a0b5k/dWfYm4Fcq4uTwd2tnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482831; c=relaxed/simple;
	bh=d8RdH4bygtc6dzbH1AbeiVyiXe9i4xNli8uyMLHR01g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r6DIW8Zctz1eJVgB31u41XH/zpCveUbN10xWZgizpJgYs+6t/UoBlbBPnezh6YlL1mvBm8dztVHpurbr/7ZlpoZMiaiQTcJu17y/ut7ZaSEOIE8Zcn+9FDq/9VZrcmnM3EQRS4Qrnkl3u3S71IsFCWojBLnc9E1qf4wKgbQD43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clvk4KIC; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so5994051a91.1;
        Wed, 02 Jul 2025 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751482829; x=1752087629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dNvEoNaOIW82DnFZ370ho50EsopFgUiF2vv7ai8Lmhs=;
        b=clvk4KICnU8snL/FbktHJZ7PdbQyZSrARigUBS09siWgeJMBZB+TLzUepKlwGoYfYo
         qL2WuPalebxGY5y/Tg9JTuGwBrlwPaV0B+AuT88cgGmJK2s0ONQb91D5PNxL40/8MRFC
         MYiG4oQuViy2/twLcweMnY54O4glLZpmxtxIELAawncWq6FZBQBumPptMt9XrgJYWSzn
         4AinxKZHkaSXUHJkcUFBovcYLUH6yG9RUPme42OtP5Vv8Ge17AoKesgQfVNWLqt9GrFE
         Dem4bH+UoSFoLAfWrdkUYcHjz8ItOEUTw3jGS5LnpjHWoTFno8x35rmzht9Rr9z8+81L
         ltMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751482829; x=1752087629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNvEoNaOIW82DnFZ370ho50EsopFgUiF2vv7ai8Lmhs=;
        b=tAshOQPTsfFsqZ/dbVGgGM81CiZrEKdgs8poZv3T1ZdAkbgFPcbtwfJiM1tyOBHlhp
         Gcy0Oi6Zg1d43xlyIk7wXRhfqZYTyJWOEF3j9ezG/tPlTiSaFRO2Ll+us/CbkLxQ6X3O
         eYsW3Ma1iGaUYaTCqEVE6IWJDctoxlTzHTPLlmJv1sBJd8n2AV0b9hP3AX5aucE4Bzkd
         v9FB+NeB1xMZMhACEFXDtpL1uwdew3E0G0bV+e89qZ5/zJeiZw9Mb96ih5xmJA3H6Hmk
         zd4hGBg8RkKXo1cv9PqQ7nkI4PG25gLnoABx9Phbh5hqwWMz1xMNAD5XR90WwDKBDVeW
         uEFA==
X-Forwarded-Encrypted: i=1; AJvYcCUXHTybjjj6dzW9SYo8DJTbSixKD/66IXe/PnIvaqOou3rkFMnIaNFfRKJ7+GnIYZddbJi31WtFZ7iC0TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUKjkujb44oBsz3De1IAiiGEEY+cJ9cDyoTfsFcgRo3vn2AWr
	keA4EWsOXo2+nhvWLYhqI189aVHLpBhtFGEB6BsxLsLQxjUbhDRuf28Ymg6wYbNV
X-Gm-Gg: ASbGncsZ7XSyXeW2Cxx8TFhHkJpuekYgX/qx+I8WHg1wQKmwqF8J7Hg+h6L2nv36ocT
	8TTwQs0Cy0CHEhja//YdCqadHLKMI2x+GglkAWpQAOG/IzrjrDGzwqyRPwwABfVrE2hQyrwRRZY
	ZnjXxxlwTmuLQnmLQTJ+LVAH9Rq8tpi/C2xxY7hJui4zwxCGASCmisq0zSU7PYRCWpo2l2ScpQk
	NtD0rSbdO2hNb1Xhc5BLo8QKr6I9PCL4snLlC3YrvnUlG6rsFjxksIvlRWt08p9Ce5iPcQI3ilx
	IKqI4LNp3fJ18D8dhbUurNEk4hpl9jcfo//c9sGet9c5PTjFZvq8ryhO6y4DHsTXCkwBiCZz
X-Google-Smtp-Source: AGHT+IHisT+jL2i9exD2iEGFPt0p0HhJMwOgwOqxm5sMieaqvdl02QcRn6IPSerxf/AqzuegXaPCvw==
X-Received: by 2002:a17:90b:52c6:b0:316:3972:b9d0 with SMTP id 98e67ed59e1d1-31a90a2d5d4mr7166223a91.0.1751482828855;
        Wed, 02 Jul 2025 12:00:28 -0700 (PDT)
Received: from pop-os.. ([49.207.217.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc66830sm415374a91.16.2025.07.02.12.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 12:00:28 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Dave Kleikamp <shaggy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	jfs-discussion@lists.sourceforge.net,
	skhan@linuxfoundation.org,
	Manas Ghandat <ghandatmanas@gmail.com>,
	syzbot+30b3e48dc48dd2ad45b6@syzkaller.appspotmail.com,
	syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com,
	Aditya Dutt <duttaditya18@gmail.com>
Subject: [PATCH 5.15.y] jfs: fix null ptr deref in dtInsertEntry
Date: Thu,  3 Jul 2025 00:29:36 +0530
Message-Id: <20250702185936.68245-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit ce6dede912f064a855acf6f04a04cbb2c25b8c8c ]

[syzbot reported]
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 5061 Comm: syz-executor404 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:dtInsertEntry+0xd0c/0x1780 fs/jfs/jfs_dtree.c:3713
...
[Analyze]
In dtInsertEntry(), when the pointer h has the same value as p, after writing
name in UniStrncpy_to_le(), p->header.flag will be cleared. This will cause the
previously true judgment "p->header.flag & BT-LEAF" to change to no after writing
the name operation, this leads to entering an incorrect branch and accessing the
uninitialized object ih when judging this condition for the second time.

[Fix]
After got the page, check freelist first, if freelist == 0 then exit dtInsert()
and return -EINVAL.

Closes: https://syzkaller.appspot.com/bug?extid=30b3e48dc48dd2ad45b6
Reported-by: syzbot+30b3e48dc48dd2ad45b6@syzkaller.appspotmail.com
Reported-by: syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---

I tested the patch manually using the C reproducer:
https://syzkaller.appspot.com/text?tag=ReproC&x=135c9b70580000
given in the syzkaller dashboard above.

 fs/jfs/jfs_dtree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 27ca98614b0b..cb57d4f1161f 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -835,6 +835,8 @@ int dtInsert(tid_t tid, struct inode *ip,
 	 * the full page.
 	 */
 	DT_GETSEARCH(ip, btstack->top, bn, mp, p, index);
+	if (p->header.freelist == 0)
+		return -EINVAL;
 
 	/*
 	 *	insert entry for new key
-- 
2.34.1


