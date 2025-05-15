Return-Path: <stable+bounces-144548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A099AB8E34
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 19:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D63B1BC6562
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B29254B03;
	Thu, 15 May 2025 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQCsg9Le"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5243D35971;
	Thu, 15 May 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331723; cv=none; b=adyNrDdSjORVHoHWdOpw/e3Qk1Gh0rNmGixW7VIY5J4NfU19BEwF6zxy5lttjbpIugHvyjn4RND83NUxIc4gumm2rFCDN+RMK++tTP5FfRfWzxzSoTb0FMcVq2+mSrXy7e//HdgWEbei8V505K9h2of7XDi0EZi+7k8noedkhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331723; c=relaxed/simple;
	bh=9rEB8MGAMouvWT1mRTZ0aDO/9zJ1K3nvDRmId1JOb2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERNlPro45ldD+8VJ65e6LC6QOQIBfAGDgcjGY8ngN9E2ueLkuYS+66IeTGgHmACdlkMIvxTPzpEppro8awDjjEIV/mqMeqYstrbjFCt4ukpaebN3BksUdwactBJE26dZEgPyHbJIBVcdwTSP15ipKMi5j/ja3+rmfvcWOR9rJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQCsg9Le; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-326ca53a7f1so12436121fa.2;
        Thu, 15 May 2025 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747331719; x=1747936519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6BvMq2D5p+ldyLhswJqBQibnI6QVGEbvUpylGppPw8=;
        b=AQCsg9LeR8Ys7+OHy8VyA6pRT72kCIAJJSAHEWYhC4VTCcLfHGtt0pdz7Bnu2P12aR
         GY379mIhLi1bzuzoXVzCZY24IN1zOKj6kx8j0f9X8wsMSHSQ/Cy5ocGjNS+hhliL3uiY
         BmSpflAv8+es6h4xcn7x5Wo+/QicIVR+/f9+EFe+6m56/9Y/RxhT+apsxNq9I6NQWwvi
         c+5Aw2qipvZF7IJSVsM6T7RMH0c7Vo0FZMQoI3KdgokCzIq3Fgzr54ZLdQRkOKKXeO6w
         QsVRJqXQFiST7/XFwn5h57KqejYA7fatq/ewGJV04so4EhuoGl4vVZKr0OQmiQtHwlc8
         NK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747331719; x=1747936519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6BvMq2D5p+ldyLhswJqBQibnI6QVGEbvUpylGppPw8=;
        b=nzQY4mfLHk3TFK+/e1rCealeM+0zXnextI2QDd/0imLclJ0sJc+VvfeplQbJ1B1/KI
         kt7wLyTauUDI4uqqhVjMfhX9zHd4Aq9raCxan7rbO+uBoKqt748MEjQDvcpbOhGbiMW3
         R5G7hw6qHWTf6+5XzpOelBZJcYwbZ2AujPQDSl/iHY1EP+n5VS9Ok/fnJjvVOhOpqn99
         6mz7gcwI23bBSeIm55ZsopewWb2y1YOFuSKeVrVT2iqX8n9H3D5WUEx9yYXwtSbVKEdz
         fSZyXOVXgD9cONBIvkTvyIC/3KqJjRNJyPJNMXPgwGXdbm9raqYQrlYl061G2JpeHxG3
         +TgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx1d3hdy6ClAmWZrlmlPpL01lL1TAkcJd4XVmwSRKhfsacQKb918M5q6pISO6Ih8z67dZkjtRp@vger.kernel.org, AJvYcCXPGQ4yZoU2/KOGmoXGaRZhzn0bBJfQcIQsuXRWLYfBWjFf4S803VR+R2SttZglE+gHdIgnJQ+hpoNwgZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn49w6JW2Ck8jq/U2aoB31m3gPrlKdQRHDNlLMXZt/fOUhsGEd
	zbkOtjtC3h/JvS92uOymuErB6krXKSCJWQjkYUsdchwMekJA8Y9Ij1tg
X-Gm-Gg: ASbGncunyeSm/8mq5iFJcos0r2KjKHZj0ih0jXLhc4RC48jBeMWis7QmeGbZdC4Q/4s
	PlSOa8YHntEwUmBOAuk4NsG89QNgaoUmdZA5jnC8EuUhTX1wua0w1C/krpvNX4S1/AuImHIwRFi
	8NH0QtnmNF/TnMCXgUv/rEMZPlmiq8jnw3BfjaH4tslteXRKMG066dqLqQXvrV6igkc1ZEJNgpW
	DRiqyx4xSbiJTxamyiibdDunJWHvjzTimiIL7SU4lImZjuXYRJ1RigmHjNodevvgguQ3dxZz+MB
	1oMGNzgtLET4wgRU946qMUwU0PFjnm9rQ1LaUoDHxyXFJ6N/h5D/6ErvS6zRGxKm8RV3K2njos1
	D
X-Google-Smtp-Source: AGHT+IEAYT7A8V86V38Ir8ujqQaxYXXPI/SygzlFMMcOI46zlz+ZfaOlGXG2fLbME3wues+vX6CuKA==
X-Received: by 2002:a05:651c:4215:b0:326:c07e:b0a4 with SMTP id 38308e7fff4ca-3280771da40mr2056621fa.11.1747331719010;
        Thu, 15 May 2025 10:55:19 -0700 (PDT)
Received: from localhost.localdomain ([91.197.2.199])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-328084dd21esm137531fa.63.2025.05.15.10.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 10:55:18 -0700 (PDT)
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
Subject: [PATCH v3] fs: minix: Fix handling of corrupted directories
Date: Thu, 15 May 2025 20:54:57 +0300
Message-ID: <20250515175500.12128-1-kitotavrik.s@gmail.com>
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
v3: Move nlinks validaty check to minix_rmdir and minix_rename per Jan
Kara <jack@suse.cz> request.
v2: Move nlinks validaty check to V[12]_minix_iget() per Jan Kara
<jack@suse.cz> request. Change return error code to EUCLEAN. Don't block
directory in r/o mode per Al Viro <viro@zeniv.linux.org.uk> request.

 fs/minix/namei.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..5a1e5f8ef443 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -161,8 +161,12 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 static int minix_rmdir(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode = d_inode(dentry);
-	int err = -ENOTEMPTY;
+	int err = -EUCLEAN;
 
+	if (inode->i_nlink < 2)
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


