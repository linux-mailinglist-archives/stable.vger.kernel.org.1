Return-Path: <stable+bounces-145769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00AEABEC01
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 08:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB517A6A60
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 06:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D3F232367;
	Wed, 21 May 2025 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCCxO5sR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE0219EB;
	Wed, 21 May 2025 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809286; cv=none; b=IJhWslnn5TULtaeD5ZU4i3hwXpF/Rn8No6DuqW/okUzE6EdKcYP6vQYE5+oKUUAfq2DtQ1i1OZI6fWeNCTcfqkmEw8irATPUKfGUItZtaUPofFTcaMplIw6FkILysAknX06O0mtqHRkrFBDO/saF7P1qTbNxIVPasJGCyvJEH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809286; c=relaxed/simple;
	bh=PXVta0mCTYq6yt9jSQRdHzSV6a2PJ/jUqh30SUGtbZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWkNYG0x0AgcChU1RVFQl1FVK2j5WkiOSTc/xljrQ52kuQfGDHqagDf8V//nC80uP2SOZobMqQwyu50aHnw6Vtod0jGbNAhXflLKNWV7xt2v4dP8rPE+VWEQCE1nEtddVkFjgyUSI5SJ/x8j0QaBvIqTFGqo6ibxq4fWmIjUXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCCxO5sR; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54298ec925bso9879939e87.3;
        Tue, 20 May 2025 23:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747809282; x=1748414082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CzYuom+zI5De3oMnCByXzViMDJT8mx4FU1edPifGipU=;
        b=nCCxO5sRFIMB1Q1UbCmRnBCpA1Z3BlVQZtNWEDAlu71EsbjVO8bh1mvtOB4UvfuUAF
         A5uFXRy9983XDu7WtJomT6azSGrrOGxn5Kl2fMSuIsqQ/lMNr6aNwrtSLhs3MwijR2gx
         H69hDBAZz+o7iBAwDvXwOz9Dd5YD9n0AKgNoXkFzpBz/g8DgGYeO9Bt5RF7/RSV68Lm+
         wmJlKoV6j4kEElf4FbNB9FxaM/is5yq8E2Io3pkklJfMcC7AHVxxEFc+V4CGd1AyPVT/
         Cj/aWk19PoHJQGY8euQtanOPQcVLcQb/91IIIMhfLLj4KdojhC2w+Zh0wRdxTMQVlSzh
         LnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747809282; x=1748414082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzYuom+zI5De3oMnCByXzViMDJT8mx4FU1edPifGipU=;
        b=B2mwju6nji/auTjQMa6SVEEuxJ6MFOumbdkHSC6JJXXWkyFscdEbuT/c8V5GjJSGnW
         t8viK3+jEw21y1eiDI0xsMCPcds7GnpAnSTLJAxfnUnPHVpwSMkxrNGSH0NRGCM0kfZW
         TNBJ2yOGRwTIbYcHWR6P1pQMRdDulwbMSdA28M+TtkpAA6Rz9jn5HZecM6WzmrsOEpzy
         tqaADzanoiU5UNhB9I76dze89jOKbeDZstsOuRaDoF34d26eh4LPK7vGdBSHvqBf+6u+
         VvGfO6yDbCcdohABSa+bn/3ILRXn3+H1nPazfHf3dfznkhyl9Llfx8tjsfTpYT786COf
         vt3w==
X-Forwarded-Encrypted: i=1; AJvYcCW838OXmO9WJ2HuA+s5zdFGbAFy0srPt4mHX1BVQ17+ngDnReECZ3sEbpzNlv/4PaREV/19qXIp@vger.kernel.org, AJvYcCXVY/HWffbh71W4YWLDTBEP5CnkCLzlX1XsbrSoMMVouNa/xfdJ290aZmL/PEdoWiSRdUNJAdsdjcSJjzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7HCAAKe1rd6C7N/deCUfLIFLS9PvT8SqMiMBCy7LJTdUiEkr
	Dx2oLFMRkJcDuwg64Mc+f3iQA8DNZuvtJ95JczgNDq6qHBybHC5MrjMB
X-Gm-Gg: ASbGncvmqCnk7tKWllrr2hE7cMGm9zuxU8U0YbF1fkvfAMF3yYKi7yJ795I8Q8HzZip
	fESaO6zjlgrYO4xPeINYgQ/GvbP6pajmSnuzWg2fkFk4pKKlqLts0jZ8PVdwVoATn01WrYojW/8
	YmGodDUEOBw9un7UDJCA1xNiV/b1e/Ux7bs1WFBnyziCQfkpYjKdT1WzsJStp9MOrQolU9cQk6/
	mQfS0oinwG4MWSlZM7ALyTbo3mrbEgnXTJnI6QN2GsusbgvqYZc7wimZE30R/drO9xOw/NmttmN
	rCjcVVoqEedcUyJNwKKszc86on/Fykivqc81hlp4RrCmNyIL0IZedDT6GNFB2fp1bG2boQpU7FW
	XEVm8jGGD/Eg=
X-Google-Smtp-Source: AGHT+IFXHe4PWXlcmE49bZfwmBLGRPRzztLBYCczKRWtpTZGGJTw5C4nvUmzzCCub+1cMSMYYFoMmw==
X-Received: by 2002:a05:6512:461b:b0:547:6733:b5a3 with SMTP id 2adb3069b0e04-550e71d6b1fmr5100149e87.28.1747809281807;
        Tue, 20 May 2025 23:34:41 -0700 (PDT)
Received: from localhost.localdomain ([91.197.2.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e702f462sm2690508e87.209.2025.05.20.23.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 23:34:41 -0700 (PDT)
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
Subject: [PATCH v4] fs: minix: Fix handling of corrupted directories
Date: Wed, 21 May 2025 09:34:31 +0300
Message-ID: <20250521063435.3217-1-kitotavrik.s@gmail.com>
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

Make nlinks validity check for directories.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Kriulin <kitotavrik.s@gmail.com>
---
v4: Add nlinks check for parent dirictory to minix_rmdir per Jan
Kara <jack@suse.cz> request.
v3: Move nlinks validaty check to minix_rmdir and minix_rename per Jan
Kara <jack@suse.cz> request.
v2: Move nlinks validaty check to V[12]_minix_iget() per Jan Kara
<jack@suse.cz> request. Change return error code to EUCLEAN. Don't block
directory in r/o mode per Al Viro <viro@zeniv.linux.org.uk> request.

 fs/minix/namei.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..ab86fd16e548 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -161,8 +161,12 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 static int minix_rmdir(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode = d_inode(dentry);
-	int err = -ENOTEMPTY;
+	int err = -EUCLEAN;
 
+	if (inode->i_nlink < 2 || dir->i_nlink <= 2)
+		return err;
+
+	err = -ENOTEMPTY;
 	if (minix_empty_dir(inode)) {
 		err = minix_unlink(dir, dentry);
 		if (!err) {
@@ -235,6 +239,10 @@ static int minix_rename(struct mnt_idmap *idmap,
 	mark_inode_dirty(old_inode);
 
 	if (dir_de) {
+		if (old_dir->i_nlink <= 2) {
+			err = -EUCLEAN;
+			goto out_dir;
+		}
 		err = minix_set_link(dir_de, dir_folio, new_dir);
 		if (!err)
 			inode_dec_link_count(old_dir);
-- 
2.47.2


