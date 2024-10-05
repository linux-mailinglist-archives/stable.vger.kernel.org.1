Return-Path: <stable+bounces-81159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2E09915DE
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C441F24B6C
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC0814659F;
	Sat,  5 Oct 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XchjH2nO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA677145348;
	Sat,  5 Oct 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122840; cv=none; b=qnRZhFWg8VLDbiTCJeowFsSratQVYBAIgFdlBA15dlccfY2NuUSMMylhiYrQgUEEBGSID8mzaCLvyC+zq+5eQqxtwHfzM1shew693DUT+MMYLHzM1TfxCUEdXpNsnHlpCSclquZIbkJ9z3aJ+O2cFx31wOlIfjp+D1jdutC95WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122840; c=relaxed/simple;
	bh=5Ib0kNVNvQg0c0d2ZUEETygeqfRQo7joOlN5mh/d8bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMaR0QrZ7/BWzffprEjbCCGNpY7CzOhJBPYRvYWmatouKd+CVA1fGYrJ9aNjfHyr4ACtPmZoTZkKkzGBEdYw3ssu/wnh1mK9IinTjmO1oj8/ExbSG8NqGvhKdqG5ULJY+ZF7bD0kAijunJswHOa+0vBPoTIQ5QVnkn1Pxo+prnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XchjH2nO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398e33155fso3754721e87.3;
        Sat, 05 Oct 2024 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728122837; x=1728727637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgmZynwG71OocyO0thzm1PkveGyf/L6c+8DunhW8BTE=;
        b=XchjH2nO4zUb2LwQxQifQJLE+KYsO0QB4DWG15grX6Oy3QIcUCzoUe8OzOT/QbHqOV
         pFfn1gpmBQCl7GHC0VQU4gTVaF6r6ae38BJ5DPETk9yfnE7JK+P1JvavNEIsezllzE0x
         g0g+M/vCrtx5Yo8B3xIFt1pGOIoHQ783tCarK6A7iRhBCayPyTPApbGs5zmhiBZ005Vp
         LL3vtflJ/v9K31l/pSQ7sWUSE0m2iY90MMnNQXRRILRTRXF0Wrk67roKcYpAN4RLszId
         kzHac9Zj8FTokn6BdTfISE1DdAkm5bJ9o1HjGFDLRhh3vkdTKwKi6vfC2a/AL/XpesJj
         CzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728122837; x=1728727637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgmZynwG71OocyO0thzm1PkveGyf/L6c+8DunhW8BTE=;
        b=R5UyGoeSkSwvHylMigCEEMF5EtWG2fP2Ode2CBVRSzWnhxRF4mqb4QBXG0yK5EOE+v
         GGwUfJHgPOUL+aMcDJs4kqNMxWE3WX7R0AEJ9AYfxmtTsi6IFygna4sosVdiOF6YgSHZ
         OPcYW/0YJf4dE7HCoRIavxhaBQ1QPcHY/s6mnJbZStgvIVKzV4Lx74fMxczgC48/cc9o
         u7pr0stOwrZUsnLSIBm003PXhQeNXgDVFuP4+ylNAyltAGglGWwD5csoRE6k/pJ+j3Zy
         HVbVgjDkLoxkDOK+ZotRe/4aS0Lnfzmptc1HaeeDyDMsorMFIBaRgzVvI6ijtkaYEHXc
         e8nA==
X-Forwarded-Encrypted: i=1; AJvYcCV8psvKrAnOB/NLlU56pp+q3FbNfIrJ+4Lk6+3axdDZcyWRhWTZTXi0Hy1l25uO0uUJJJRi1+DC@vger.kernel.org, AJvYcCWLL+AlePN3Xp1aKH0X5ATahN8+ZdceYHqW15TPpJ7+6r5+8bN1STGyALZwGMJTm3wjZ4Ri48pjZJoNEAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxY/OhVAg4sKvslO3i0VR3GWesiCyiDV8LsRikDYaVrUl+vPP6
	11cOtFP6zjn832hRP+J0eCfmyOcoKgIaJHz6yEvFEwRtW4IteJse
X-Google-Smtp-Source: AGHT+IGNYuQkErgECfD7RtrsNs0x0faBAPGYH1Yw0W5OTZRp9TC9znXQ0J+EMz4L/KmxiThpg7fNAw==
X-Received: by 2002:a05:6512:baa:b0:536:53fc:e8fc with SMTP id 2adb3069b0e04-539ab877139mr3473922e87.16.1728122836676;
        Sat, 05 Oct 2024 03:07:16 -0700 (PDT)
Received: from localhost.localdomain ([178.69.224.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec1240sm186305e87.55.2024.10.05.03.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 03:07:16 -0700 (PDT)
From: Artem Sadovnikov <ancowi69@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: Artem Sadovnikov <ancowi69@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] jfs: xattr: check invalid xattr size more strictly
Date: Sat,  5 Oct 2024 10:06:57 +0000
Message-ID: <20241005100658.2102-1-ancowi69@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7c55b78818cf ("jfs: xattr: fix buffer overflow for invalid xattr")
also addresses this issue but it only fixes it for positive values, while
ea_size is an integer type and can take negative values, e.g. in case of
a corrupted filesystem. This still breaks validation and would overflow
because of implicit conversion from int to size_t in print_hex_dump().

Fix this issue by clamping the ea_size value instead.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Cc: stable@vger.kernel.org
Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
---
 fs/jfs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 8ef8dfc3c194..95bcbbf7359c 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -557,7 +557,7 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 
       size_check:
 	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
-		int size = min_t(int, EALIST_SIZE(ea_buf->xattr), ea_size);
+		int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
 
 		printk(KERN_ERR "ea_get: invalid extended attribute\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
-- 
2.43.0



