Return-Path: <stable+bounces-177709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD86B436F0
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 11:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2382548996
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 09:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA72F2EE601;
	Thu,  4 Sep 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="nzIItJpK"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337D28153C
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977720; cv=none; b=AMcmRqT5aon5Txo7dhvuBQrkU1oHngUNCEN/VJwlBerfWu5PedqfUylA0X4teTLpYoQNk8qynnCfvKh3Xn6LmOmj38UnyRMDYKFCq9I9IfhnB5VauziQyuzc+z+WkClmSb+yY1WpFIjENz+wZNTCAeKKOd9nccSb5uzjgATqGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977720; c=relaxed/simple;
	bh=hste1caNSFyqYtdhWnqlNmCPGnB50BXaOZVDkkiOQb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XalbOQJjFMH9sB8oOnTd5qTKRjcBbsMixDiYzJ7KGjKU5wFA6p2j1HLKQxBUpPIkc/pO1CGBGrH7QRq6r+YeSHXuyw2lYzxAhqDKiUN4YojdJTHGXnnW9ZB9dGcVWsd1ZpcAZ6tSAKfEfXwecHK2mg3TgL0Kru5mLzLKHd6+BpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=nzIItJpK; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756977718; x=1788513718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=chlSD0dZKVRMJISq3f2uXOA/HYcCMS3KQxdYeKEIlxk=;
  b=nzIItJpKDjRIk05pU5hgigXLrEx1oRcxVJiMdfdm8Hz4I5cYGyBjONj9
   wBIfaux32WLxqwEY2GXopwN3s6ygT2reflSkjqHN7/ttEPsiYFjAipQrA
   FQDJvht+giTOlvXm6ced4M9KmP+8cenhpThjbm7VpH3uVc3CJIl9L5xS8
   krIc6jrv7SHelKyJY0+lAGjJ/OuR3EYg0dZf6ly6v+cpVEbCKG9CDDqkI
   O6NAoFmwIrkZ9m4crw659sySbFesq3rN6Fu67yjNZfSAffjPKf4jaM7z4
   FusEg8nkMi70B9qP5QTpFGtdUriU1X6v47CoJtua9CNvFS3L4Xepi9N0Z
   Q==;
X-CSE-ConnectionGUID: IfGFPqrPTKCyWsrvsdBqLA==
X-CSE-MsgGUID: 15yO7JkzSZekfqjWXHc9wg==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1627368"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:21:48 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:19407]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.3.140:2525] with esmtp (Farcaster)
 id 2b56b933-5b76-4c94-9ddd-ba89d8345b8d; Thu, 4 Sep 2025 09:21:47 +0000 (UTC)
X-Farcaster-Flow-ID: 2b56b933-5b76-4c94-9ddd-ba89d8345b8d
Received: from EX19D002EUC004.ant.amazon.com (10.252.51.230) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 09:21:45 +0000
Received: from dev-dsk-nmanthey-1a-b3c7e931.eu-west-1.amazon.com
 (172.19.120.2) by EX19D002EUC004.ant.amazon.com (10.252.51.230) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 4 Sep 2025
 09:21:43 +0000
From: Norbert Manthey <nmanthey@amazon.de>
To: <stable@vger.kernel.org>
CC: Norbert Manthey <nmanthey@amazon.de>, Amir Goldstein <amir73il@gmail.com>,
	<syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com>, Dmitry Safonov
	<dima@arista.com>, Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1.y v2] fs: relax assertions on failure to encode file handles
Date: Thu, 4 Sep 2025 09:21:38 +0000
Message-ID: <20250904092138.10605-1-nmanthey@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2025011112-racing-handbrake-a317@gregkh>
References: <2025011112-racing-handbrake-a317@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D002EUC004.ant.amazon.com (10.252.51.230)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Amir Goldstein <amir73il@gmail.com>

Encoding file handles is usually performed by a filesystem >encode_fh()
method that may fail for various reasons.

The legacy users of exportfs_encode_fh(), namely, nfsd and
name_to_handle_at(2) syscall are ready to cope with the possibility
of failure to encode a file handle.

There are a few other users of exportfs_encode_{fh,fid}() that
currently have a WARN_ON() assertion when ->encode_fh() fails.
Relax those assertions because they are wrong.

The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
encoding non-decodable file handles") in v6.6 as the regressing commit,
but this is not accurate.

The aforementioned commit only increases the chances of the assertion
and allows triggering the assertion with the reproducer using overlayfs,
inotify and drop_caches.

Triggering this assertion was always possible with other filesystems and
other reasons of ->encode_fh() failures and more particularly, it was
also possible with the exact same reproducer using overlayfs that is
mounted with options index=on,nfs_export=on also on kernels < v6.6.
Therefore, I am not listing the aforementioned commit as a Fixes commit.

Backport hint: this patch will have a trivial conflict applying to
v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.

Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024f.GAE@google.com/
Reported-by: Dmitry Safonov <dima@arista.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ git-llm-picked from commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 ]
Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 fs/notify/fdinfo.c     | 4 +---
 fs/overlayfs/copy_up.c | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 55081ae3a6ec0..dd5bc6ffae858 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -51,10 +51,8 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	size = f.handle.handle_bytes >> 2;
 
 	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
-	if ((ret == FILEID_INVALID) || (ret < 0)) {
-		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
+	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
-	}
 
 	f.handle.handle_type = ret;
 	f.handle.handle_bytes = size * sizeof(u32);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 203b88293f6bb..ced56696beeb3 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -361,9 +361,8 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 	buflen = (dwords << 2);
 
 	err = -EIO;
-	if (WARN_ON(fh_type < 0) ||
-	    WARN_ON(buflen > MAX_HANDLE_SZ) ||
-	    WARN_ON(fh_type == FILEID_INVALID))
+	if (fh_type < 0 || fh_type == FILEID_INVALID ||
+	    WARN_ON(buflen > MAX_HANDLE_SZ))
 		goto out_err;
 
 	fh->fb.version = OVL_FH_VERSION;
-- 
2.34.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


