Return-Path: <stable+bounces-163446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B0CB0B32E
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 04:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83FC3A2CFC
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 02:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC3416DEB3;
	Sun, 20 Jul 2025 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft3Q3eDt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6937515687D
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752978387; cv=none; b=vDCzyiEj0Bd4xFnuhni6ipxzs9uepJ6oEkQsWaIpd4PM32XBVrVRSroLdKjsZ9Z/P8lGDQlCfuxbuGi3WxblfvETYyTiW6Qf+Saox6+9jC5J2ZDyeT+3RoQHmMJQsAzfnUNl17yFX6DnnHFAXQHPhZ0qxL7phmTZXVv+VQQRu9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752978387; c=relaxed/simple;
	bh=Hd7gue88Rk/fRxgT1hV0IcqNe0wgxxLH0peBNp9Pp9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cvb8zqx2vUYlzOIqz1Nx2wBPfGS4qacn1Sg1attnO4vaWIWCWsV2QD5EyvNfkiu1fk0Q7qLHHg8Gt55+JUyDq4VW2y0Dl4niMX2zRl0gsSe4hTuWOWnh443lZkMb7aXFIsyrrC+o9t3eo2xiUU5k47A5IHFEC/KBTVwfdPIt0cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft3Q3eDt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3220c39cffso3218680a12.0
        for <stable@vger.kernel.org>; Sat, 19 Jul 2025 19:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752978386; x=1753583186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhyN6g213CxFBMoSnw4dVmnZkCbj4Ce0pW0dZgtLzbI=;
        b=Ft3Q3eDt1SzOhyznSEueyRLP22C9hEmbUAEZ22wZU+RFp/y+FMjBfhPP5mVYIhO7Kn
         4giLS16IBgLPHN74NxsslYuvbBxJWyVlWzVY2Y7evTSmsi7nWkYq8D4gNIi74lVJepc9
         xNuwPQ23RhpJOs8t9e17bgl+hQtVLeem4VlWCtXxb9eN5R2r+KiKbDMJONqlALdeKFiY
         leA16IzuDtoLhRjYNFu7cikvMZFqVjcBKYvWSL1XXQRHGc8BwZt+ajAd4NvvOgFmIk+6
         TkAms41whvN9LgvIl4fDA09EdigoMwZHD/qjEMAV34bo9NFYxKcEeqzBc+capFEgPgOs
         Q+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752978386; x=1753583186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhyN6g213CxFBMoSnw4dVmnZkCbj4Ce0pW0dZgtLzbI=;
        b=VdvnMxGxFFzLggGqdtK5/KkFXVqEdp5/F8XmHYwlLlmkMg7+k3mw5lbVAkASWxoEQi
         dP6Re2mSqjERMyjIl3NANkXtgspX4WfkSfDhfg24QICxnlbNUu7dbeXzD1esWaZlfK03
         DLZg1AjXagdMXOymXVBTdKrxsipg45cN8dfItQ+aBLQm7mClOINKF1fRjwbbfBnhI2/Q
         muGHoqgmqnT3J3ToLLCcegTTJ2lVb0pSzppZWNOMBE0c2yxofIeu8fCSs5ngCh4DXrx+
         P6L0r+JRHlN08DLV/caQ5778FUd1h+dVatugbXWpvM2/9U+6TdvAJXojQgGcb16rDrSB
         t9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTHSsvBYOGlQKiaYXOXKDSma22FQ6krZQccQ8TsTbI9Cf0musutNFt2VjmrkJ/2T+xP40u38w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBeUWP+WuPCBQ/SCcHfYmRisMuUCfFwVKCNOqf+0sKUULQt8N
	a5H01wslpgF8EiRlsdf5lkmxduZepTHXTEDbpmw+aS7v895FLLGRTFWR
X-Gm-Gg: ASbGncu7TH+nS3UWmLw4TPx/f7EvQiUIrSFv5k8RVhnsi7oGQv9zWQkhDzlez2nxjsh
	/wvHsi74EOxtypbDSgaMqX2LUjmt09xPpC9JzYMhXYcDL3zYSuh0xwa7+Mh+hEoErvD+w55+Gzk
	6EJxIaY7CHE2wxPWaV1zaO9wQdqOOeyux1LTQd8dWBT8lvb9vNl5fp/OxkYZVIGN9alo0Qzek+z
	h4xeLZNTS5U0t2kf5wVQ9w6F+8qndpH1d2m2hOtLYW5EYwg6/pzieOmxTDs42LW2Whvdrlghbvu
	2FyT2vTAYtfF9BwMdBiu5ELtxeMbfD4KUioisMUgknv3CGMUupanXFRdy8uC1kcpTBZhpv5yHbD
	xQxSvQor1uRZYECytiCQUTxY=
X-Google-Smtp-Source: AGHT+IGtHopAjgdeGilWUAH5UqAMctWU0gqXg8HnMlWj+6Gq2AnccRtvP/BCxpEyEWuVXdzADcsirQ==
X-Received: by 2002:a05:6a21:33a7:b0:232:57c8:1bf4 with SMTP id adf61e73a8af0-23810d551bcmr26567045637.9.1752978385536;
        Sat, 19 Jul 2025 19:26:25 -0700 (PDT)
Received: from saturn01.. ([163.239.14.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89cfb3dsm3405754b3a.34.2025.07.19.19.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 19:26:25 -0700 (PDT)
From: Junhyeok Park <decargon123@gmail.com>
X-Google-Original-From: Junhyeok Park <junttang@sogang.ac.kr>
To: junttang@sogang.ac.kr
Cc: Steve French <stfrench@microsoft.com>,
	stable@vger.kernel.org,
	Ralph Boehme <slow@samba.org>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH] Fix SMB311 posix special file creation to servers which do not advertise reparse support
Date: Sun, 20 Jul 2025 02:26:12 +0000
Message-Id: <20250720022612.3857405-1-junttang@sogang.ac.kr>
X-Mailer: git-send-email 2.34.1
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


