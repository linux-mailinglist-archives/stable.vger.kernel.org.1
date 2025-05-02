Return-Path: <stable+bounces-139505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9F9AA77D3
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 18:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC14E521D
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 16:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD40126156B;
	Fri,  2 May 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBjKyihP"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93915264FA5;
	Fri,  2 May 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204869; cv=none; b=ebxjM+QeTw/ftPg8GZ08rarXTm1KMJFSGYQPHBvG+4i1PGqtONXr0PIRwVcOegbpuuCYLlkW7UfAudJn2cqjsVtgWVpV9ddVeq3oSUNVHBDJ/mdeyoYMh0NwSiQPYIiLC79zAzRK6S24h1sLBkti2Chx/lx+M7enNhzrmdNp7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204869; c=relaxed/simple;
	bh=amLX7FDEwYM1CydOTz1TzXbPOF2Acs7PuTpiYKs/K6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9PgFh4Oe568lqLX2kREVHnBvT2qydR8sqDb6LIQykPb2/XkVbwIPFDdwhcY8PxF1PIr2e6L+C8W9tfi20aXa4qCuu5jTzRuC2N/cOdcQ8PcO87CHzsgNs0RP+k8oYy1h3EEU/doLeMpKDiDX5p9hZDIYofpl56y6bGYxOzvtL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBjKyihP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54af20849bbso2596247e87.0;
        Fri, 02 May 2025 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746204862; x=1746809662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhPxxO8YPt82z7DOp+d+tt8ExEv/tDtudEGn21E0idc=;
        b=aBjKyihPUoic/kZ8U8vQsfSjkvBrYVSbiWIQzHBOoGgPY6cbyHEmWsaPRipdpXeRby
         dTdKcvG923ZDJT5lXZdnn/uMh+zoWVcOlmDn1Sa7faDWFerxCuww3NKjUegiKJJmLKg4
         BfrEuuUaj5tS7ImLMb/Ks+1kbzpE/NFT0Qd4rfbmzNayuUV06unLdPrxvmLkW1zZm+Zm
         su7Cr2zhcc9+qtvHDfPBj1Hc8rDHnZNcwShLOX55cXyutwmV9osUP4ioh1c5U7VGn6gI
         eooyRQVswHOK+9j1ibLNdiD7NoebWBspUmvGy+qvnyYHD68LvSUwmgvFM8i5jvnvYt39
         bABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746204862; x=1746809662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhPxxO8YPt82z7DOp+d+tt8ExEv/tDtudEGn21E0idc=;
        b=Tz8uwTMyePrPZ5Phj3TiFWBb9wlSHeCcuRQyMQhJefIHszxPrCh0k1TnopTSHDIn/1
         NNUKwcVYnrJjVMFnvXef2vI654ZutTMv+GQIBBP1mdLP4QSxBCYbaUXtzIz8dPCFuEks
         1G+4TueUZj7fc9AkzP8OOpoOWOjQ/svlAMWx0K4dBWeTeHE5Lpak1wzSGcKe1ladXkqo
         H8bKBW7Qf0sGxnzMO97MqKSQsqoBnx0f3sLCWTRdpRHpJP4+zmYDrqm6wT7j4uDo4/Of
         vtrSzLREQ74Uafpx1ZkT0BQ2Au+NbvLcLBghvGVj79mK/2Z5WL/z8ymKts/W4QrSudL7
         P1hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDO39Q8LJERmAZdCTc9zV54ja77l12yCyqi7ju2hs66n0nM6lzvk9DAHmBnrIJclE9QLSR9AVQ@vger.kernel.org, AJvYcCVnzTFXBmrnuo2hKNKNxQFAGvsZWIPx0xJ6CE9eUuBtVUuKMQuna4EyKeFr/5VK+YesE2nrWIUU7h8MBJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuG2KruIUKJu7tlYV2a19aQG35pzcOrxtJQ71OxuBihQzz7+lc
	4zamMxPNmfVKaEJ6418Eh3Nts1uE6V/YgAmAgijYCTfYzQhJJYH1MT1KEd7ZHIm5Jg==
X-Gm-Gg: ASbGnct3Yq5eakD5fhZnz/mGPhQaiAT8H1zUBlOdNAaNnjvgtuq9yDGvt4J+Q4pEwdJ
	sxhl+JqclFjCak0xjhpEdDEyCuDDmGft6WNZicgSYurL/hMZZuah//nykwl9qfaGnIglZqLMgQ3
	XFDGjeoOs/8NrPBRHd16MEo49uqpLdClTSfAqHHvyifW6KrtreUMRJRYqiX8WJH1uMo6pX/43n8
	CQmrkPFZfjw5soqNrKLkEnRyW4q22+SY6UesgKpu7LB76/JCUZjKgrJc0NxY9LXFTWmdbr7et9n
	ugpm21IqhntjOT/6imyzsd9497dpfzx0qKc4IRhyVWM4qys1l8IymhfXqVWL4A==
X-Google-Smtp-Source: AGHT+IGbvaDTC9NrNKd+YptZd2762bNPwxplnUaVY985tpKbgOAhcZCYedFWxnpKU5vEqKbeSyCHwQ==
X-Received: by 2002:a05:6512:239a:b0:549:7145:5d24 with SMTP id 2adb3069b0e04-54eac242b4bmr1023552e87.46.1746204862291;
        Fri, 02 May 2025 09:54:22 -0700 (PDT)
Received: from localhost.localdomain ([91.193.179.235])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94f6969sm396685e87.248.2025.05.02.09.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:54:21 -0700 (PDT)
From: Andrey Kriulin <kitotavrik.s@gmail.com>
X-Google-Original-From: Andrey Kriulin <kitotavrik.media@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrey Kriulin <kitotavrik.media@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] fs: minix: Fix handling of corrupted directories
Date: Fri,  2 May 2025 19:50:57 +0300
Message-ID: <20250502165059.63012-1-kitotavrik.media@gmail.com>
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

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Kriulin <kitotavrik.media@gmail.com>
---
 fs/minix/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8..5717a56fa 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -28,8 +28,13 @@ static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry, un
 		return ERR_PTR(-ENAMETOOLONG);
 
 	ino = minix_inode_by_name(dentry);
-	if (ino)
+	if (ino) {
 		inode = minix_iget(dir->i_sb, ino);
+		if (S_ISDIR(inode->i_mode) && inode->i_nlink < 2) {
+			iput(inode);
+			return ERR_PTR(-EIO);
+		}
+	}
 	return d_splice_alias(inode, dentry);
 }
 
-- 
2.47.2


