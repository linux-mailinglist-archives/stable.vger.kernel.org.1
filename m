Return-Path: <stable+bounces-144353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92DDAB6860
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 12:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD59E3AB0C2
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D408E26FA47;
	Wed, 14 May 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9TUSGOx"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3EE1A3155;
	Wed, 14 May 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217157; cv=none; b=exCqT1DxooBkah3zklhjxalN2zmZy009+H3TTsamd5LJa3w662z+fKyhSyAfCeQrm/6C22zsZkSZV0BM4nxXbxrodu8v6eQDH7wSlwWZ3dzcFpO1VF/5vBJ+Gf7bNEcFuej2hPIoIZn8DJtXDTcycQ3LsRamdNXWDbdmlHB99dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217157; c=relaxed/simple;
	bh=NYSmKEbAOdJG/SX+PS/JBDn7qXoAVnPYjv1kKaO6mBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTAPtDuHU0l8lzytmDrI9oUCSOJjQdVA18yN4ZAz/A6mhRPYqaFukJghadRaGlxn+3RapaHAEM1xagK98IA91oJ/xss4BCUgmWEzYh5GIuENCO1q2bDN7LyUiBHKTq5YgTuAO71E92BVxJZsB/ZZ2fdB9Ebny53xCfrmnX2r4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9TUSGOx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54e9021d2b5so868863e87.1;
        Wed, 14 May 2025 03:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747217153; x=1747821953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmdIq6qyH0eLEtriOCHpTWROy8Nurvm9ujMkcBHK6F0=;
        b=l9TUSGOxCE/+f8LsPgSBPEEMCd6xZ8J1WVYEU/eo8HJH4k/8JoXJ1ytXyBcI6zI+xS
         ydRuPlPcUztV2shDT8DgLFk81RquFANcPpYvK1L8eKWb1M8kj+QOoU+4LL3ubtVRC+MV
         8qaVhpmYvDI8x3jTTlNAhCIBHWHZK11cCNgMgKkt+m9Rw4oHiWyKFm7zjMNVhXgE8+GN
         7c1RP/4JAzdwNjUrOtJ0nunDw8cFg8tWAlIUwRq23xoNRE0oWxN+oRVRb0QSQA3FIGDD
         kRpmRz7iAhhHavcu9xzxBtCIuNi3F231xa+eB/11ITKvj/Qeu1TTX8f7O7HBycegNH3D
         aM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747217153; x=1747821953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmdIq6qyH0eLEtriOCHpTWROy8Nurvm9ujMkcBHK6F0=;
        b=hksGfJIwN/mX/j+g07vjqE4GgX/6VEllL4aHjUQfV/XqpuDVlL+gOxkC00FE37Ix2P
         tLI+9CzL5fGb8cnkVi2x635G++LGa6oZFV+gGBuwdgdBOIqg7/9Ps3MVs/nMqrizxu9o
         KQ1Erd+0XYifOhtGgnmdW3Kmu9i2cd2mSfRuPyBwxcSQ6ZSKe1uDmZyNM+2tLlquNpc8
         8dkg7h8IUWVEFbtCSCCv0io8IP/ii0xlP6FfPI1KxuBAPghEDODYJDiDDPmY8Q/wBY2b
         lDu/px2O4DJWn8O6puQGrp6YnheUiIgMPDoicFH1RCSZUXYBqzqwL4Q4O9kTSF7Gndfu
         ngvA==
X-Forwarded-Encrypted: i=1; AJvYcCUhXvqTr1b0qwKiPxt8yIAH3IjJkOCT8Va5uncG4IdAttfRjaUZdiQSzl1cFj1OHQAAZvBPARCw@vger.kernel.org, AJvYcCX2YfSPiZm6IIJ1eDsPajwu8W2CMW+CPQG6sEhXdTXDm7b1VnsWtvgxMd7P2k1zPkTGFjuJyp73GKIGKek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAULyFlmVqzZyovDllrF7Dt9ba+aXdtTAgqe1qnmoXEBorNka8
	IptmK8g9DSXzKy+wkvXCJymiVtZ61bIy3bSxbXPBbeVldjpQ9wYa
X-Gm-Gg: ASbGncs4Nwg/W3JdlR0P8XXpBIyzq9j0X3D0Yeg4M1ehMVfH4o5ghB/8eTKYSTfwj0f
	aC58wEVJgEoagats2JnJeyBlLFG5Wvm5Ang82Gsv1S7I7BIureUVTXjgSZ9p1wH2x8Jl6DadNEI
	R4DUwlVb2E+BJ2wvNoinP0V5Q0dB543TiiyvVCGdaWrIWDNQCrbRbiNqMBjPNxBLCleTwymYS7o
	aHEYEXZxA/VSS0VpNN8/4Uj71cADp8JzUa1/ufvfd7SJzLmKwE1CM98jPvXr6bxunHnPeoACHyG
	8vwUUI2Ouwf6/AXEHGNLGw95f6KymrOA7++FpEMRRUq4J2Ytb124LUfy9CszUWR/udMyUk55212
	j
X-Google-Smtp-Source: AGHT+IFAiosPT9P0KrMvz7v43+Z/+PsGFzGQEumyNwPQuzDEWCshn1lTLlSbn+SGS9f1mfQ9m7J4qw==
X-Received: by 2002:a05:6512:3d86:b0:54b:117f:67a0 with SMTP id 2adb3069b0e04-550d0c0a508mr2681992e87.28.1747217153021;
        Wed, 14 May 2025 03:05:53 -0700 (PDT)
Received: from localhost.localdomain ([91.197.2.199])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-326c35b04bfsm18897081fa.113.2025.05.14.03.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:05:52 -0700 (PDT)
From: Andrey Kriulin <kitotavrik.s@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrey Kriulin <kitotavrik.s@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] fs: minix: Fix handling of corrupted directories
Date: Wed, 14 May 2025 13:05:31 +0300
Message-ID: <20250514100536.23262-1-kitotavrik.s@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the directory is corrupted and the number of nlinks is less than 2
(valid nlinks have at least 2), then when the directory is deleted, the
minix_rmdir will try to reduce the nlinks(unsigned int) to a negative
value.

Make nlinks validity check for directory in minix_lookup.

Signed-off-by: Andrey Kriulin <kitotavrik.s@gmail.com>
---
v2: Move nlinks validaty check to V[12]_minix_iget() per Jan Kara
<jack@suse.cz> request. Change return error code to EUCLEAN. Don't block
directory in r/o mode per Al Viro <viro@zeniv.linux.org.uk> request.

 fs/minix/inode.c | 16 ++++++++++++++++
 fs/minix/namei.c |  7 +------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index f007e389d5d2..d815397b8b0d 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -517,6 +517,14 @@ static struct inode *V1_minix_iget(struct inode *inode)
 		iget_failed(inode);
 		return ERR_PTR(-ESTALE);
 	}
+	if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks < 2) {
+		printk("MINIX-fs: inode directory with corrupted number of links");
+		if (!sb_rdonly(inode->i_sb)) {
+			brelse(bh);
+			iget_failed(inode);
+			return ERR_PTR(-EUCLEAN);
+		}
+	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
 	i_gid_write(inode, raw_inode->i_gid);
@@ -555,6 +563,14 @@ static struct inode *V2_minix_iget(struct inode *inode)
 		iget_failed(inode);
 		return ERR_PTR(-ESTALE);
 	}
+	if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks < 2) {
+		printk("MINIX-fs: inode directory with corrupted number of links");
+		if (!sb_rdonly(inode->i_sb)) {
+			brelse(bh);
+			iget_failed(inode);
+			return ERR_PTR(-EUCLEAN);
+		}
+	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
 	i_gid_write(inode, raw_inode->i_gid);
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 5717a56fa01a..8938536d8d3c 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -28,13 +28,8 @@ static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry, un
 		return ERR_PTR(-ENAMETOOLONG);
 
 	ino = minix_inode_by_name(dentry);
-	if (ino) {
+	if (ino)
 		inode = minix_iget(dir->i_sb, ino);
-		if (S_ISDIR(inode->i_mode) && inode->i_nlink < 2) {
-			iput(inode);
-			return ERR_PTR(-EIO);
-		}
-	}
 	return d_splice_alias(inode, dentry);
 }
 
-- 
2.47.2


