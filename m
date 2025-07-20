Return-Path: <stable+bounces-163470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBC9B0B826
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 22:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5116C7ABA4A
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 20:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEE318DB26;
	Sun, 20 Jul 2025 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUNxdHfM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F6A920
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753043587; cv=none; b=TSKiSrw1ZJfk4fHPKaBsLehpOulEsM3fi7vS7OL+GuaMHwl9W0OTL8JjNre0ccasOhmcl1jfcZHIWY9xqykhqMAm32t1BAP1O1HTD7GafAfuqxPa6TM0cHwcpiqHzRnnAe3QpXeZUKnkcbA7I0TTafv4b4IDO4cbIEBpqCdPwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753043587; c=relaxed/simple;
	bh=Rx2BVUp0A4izm78E6BmgC8CVNsK2yDmuGNKwkZPRJcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iydNYJw3iwUXRz8F3bKFW8kv+MvDClFM7Obhqnl6+75Wd1ffjFROqNf2wJerJSvTGnOSmNa462I/m8Zi5YMq/knNzNbmKGF0+EIaCaFUTHd+9ejCDQuQkFFi4WWF9wfDOjgNfB8bRSVULuh+KTIwjiQTtTeFXWljxzpQV+VyP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUNxdHfM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d3f72391so37032165e9.3
        for <stable@vger.kernel.org>; Sun, 20 Jul 2025 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753043584; x=1753648384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xRxEaO9zq6PeNwawyNbvIvHBzqqbq9EwueHqKIJoy8=;
        b=bUNxdHfMu7J/iVEZmlFLj80X+hGWnbS7D6UrNeht+eXgvGAr+rwcIqJqm1U/dyh7x1
         2tldBcdpPgID9JKH4HosLQrMZG6ZzxI5SSlmBa+0F3ffVsZerYIK4Ei6SzHbnIP5fKao
         Jy0Wlhpsrxb5E1nJ6G3EjX8eaMDKPNEFAVg4Vztg1UhkQrixG4KZbAZDksDUSsimbYbk
         ycRjvHYQUp5aHJsqnkVj5jQ+pH5+q0iNK8E5TL/0uWHZj4gVB6H1QjVZDQg3ZhPY5IO0
         uZokzvklXMaKwbj6JhQ21zT6+o9qTO3EScghrbjjjkdMpaTK4U75YyxITNIqC0gxcZYV
         vm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753043584; x=1753648384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xRxEaO9zq6PeNwawyNbvIvHBzqqbq9EwueHqKIJoy8=;
        b=iz4lnhL7QDeb5dGb8JhI8eTDrF3N9ypStRfgU4gn0N/p7jskHiqQNvmN4dPdNof/nN
         4VjlYEohutwFiS1C88t2qAew9aGCFKNDn/Bm1GHfIpIvO8NAI27Q/0ouvWMqKn/Wg6ra
         v6HSdO/KqvXn8OUt9BPQT/qBoVX4veqQLYGXzEUgYQh28F9qWIXGVmvvyFdnSa9Fp2Qp
         fzljqU2P2hyXwTkt7bs7g5AWW8NxQ2aurUlLjOlWzXfkRVkeLxjvi0cXKCRwsy4+aTvg
         erDbe+JFj3B4Th/CukUNuFDbHD5HiQ82rwCCyl/Bpua//4HH9XZ95xowvx5PuOdIfTKA
         iNQA==
X-Forwarded-Encrypted: i=1; AJvYcCWu0uZ22P85lyXOsVwtwa4Uvwxmnu/TpjK3BaRII5Lfc2FvNwBMQgGMLlrQ8R3JfwKP2ioBiys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/yp/KQ6YxtSxEF9cAEOpyXk3KdteHu+ff+yH6Ne5IdXyZysf2
	eTZ1CJT71m/7Jp8lf9KObu7G5Jr3AwvCAK78GtjbuAzSAseMPXVXq7vdzJDf0TW7
X-Gm-Gg: ASbGncv5PuwuWxr72/OEsBtBVpz7B35cw/22hETNqtj8o9Zm4ALf2O6Zt59sUauG8ip
	FNEu2YoNfVK0t+ttzT2DYXZLg6g3GRUmQ5QepTI4DUu8c4Tftiq1oE/IFsrDztwV6Erfi7PRXPv
	iwE9iqvNmp8ipF++NsvT4AWm0ey03/IGBMkr7rDc12prPtcRphUT1Qk1hIiQnJXbu49HO5KpY+i
	GQVbP+d2Kyj37g5PLf+cm+E/9JZnv2rILzQnqGJDlcNmgeX/LfQILb4igTVbx38xH7TZl8qD8hI
	QWlRbZz0WD9fB6GiT1nD0kWOolYg+u2mbEpWWp4WIdUczG+cnnIwQ/uw+Eyf/qvs8fZTPB5ExfB
	7jFE6/t7ZqVwZo4nu7vqtLcs8sQ==
X-Google-Smtp-Source: AGHT+IHYMcd7+CUX+0jYhhwmTTInAnDdOy3WavT2BWrJM/iWmYUaF+8+e4HNp2UqECdazDU6az+zFA==
X-Received: by 2002:a05:600c:3e12:b0:456:1bae:5478 with SMTP id 5b1f17b1804b1-4562e364789mr198740305e9.2.1753043583669;
        Sun, 20 Jul 2025 13:33:03 -0700 (PDT)
Received: from eray-kasa.local ([88.233.220.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e818525sm139745755e9.16.2025.07.20.13.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 13:33:03 -0700 (PDT)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: eraykrdg1@gmail.com
Cc: Steve French <stfrench@microsoft.com>,
	stable@vger.kernel.org,
	Ralph Boehme <slow@samba.org>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH] Fix SMB311 posix special file creation to servers which do not advertise reparse support
Date: Sun, 20 Jul 2025 23:32:48 +0300
Message-Id: <20250720203248.5702-1-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steve French <stfrench@microsoft.com>

Some servers (including Samba), support the SMB3.1.1 POSIX Extensions (which use reparse
points for handling special files) but do not properly advertise file system attribute
FILE_SUPPORTS_REPARSE_POINTS.  Although we don't check for this attribute flag when
querying special file information, we do check it when creating special files which
causes them to fail unnecessarily.   If we have negotiated SMB3.1.1 POSIX Extensions
with the server we can expect the server to support creating special files via
reparse points, and even if the server fails the operation due to really forbidding
creating special files, then it should be no problem and is more likely to return a
more accurate rc in any case (e.g. EACCES instead of EOPNOTSUPP).

Allow creating special files as long as the server supports either reparse points
or the SMB3.1.1 POSIX Extensions (note that if the "sfu" mount option is specified
it uses a different way of storing special files that does not rely on reparse points).

Cc: <stable@vger.kernel.org>
Fixes: 6c06be908ca19 ("cifs: Check if server supports reparse points before using them")
Acked-by: Ralph Boehme <slow@samba.org>
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 fs/smb/client/smb2inode.c | 3 ++-
 fs/smb/client/smb2ops.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 2a3e46b8e15a..a11a2a693c51 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -1346,7 +1346,8 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 	 * empty object on the server.
 	 */
 	if (!(le32_to_cpu(tcon->fsAttrInfo.Attributes) & FILE_SUPPORTS_REPARSE_POINTS))
-		return ERR_PTR(-EOPNOTSUPP);
+		if (!tcon->posix_extensions)
+			return ERR_PTR(-EOPNOTSUPP);
 
 	oparms = CIFS_OPARMS(cifs_sb, tcon, full_path,
 			     SYNCHRONIZE | DELETE |
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index cb659256d219..938a8a7c5d21 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5260,7 +5260,8 @@ static int smb2_make_node(unsigned int xid, struct inode *inode,
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL) {
 		rc = cifs_sfu_make_node(xid, inode, dentry, tcon,
 					full_path, mode, dev);
-	} else if (le32_to_cpu(tcon->fsAttrInfo.Attributes) & FILE_SUPPORTS_REPARSE_POINTS) {
+	} else if ((le32_to_cpu(tcon->fsAttrInfo.Attributes) & FILE_SUPPORTS_REPARSE_POINTS)
+		|| (tcon->posix_extensions)) {
 		rc = smb2_mknod_reparse(xid, inode, dentry, tcon,
 					full_path, mode, dev);
 	}
-- 
2.34.1


