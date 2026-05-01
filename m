Return-Path: <stable+bounces-242327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OANDHSKN9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:23:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7494ABFB8
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93481300BE3C
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B133A75BC;
	Fri,  1 May 2026 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQWFvU2p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2843A6B75
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634436; cv=none; b=jLj1PUS0sEUMz5fKc0rNyqX77OGtEd3+e9ovhO+bFrwJQn7qQz28JIZdG9aOa5kDYDDOGAfnNbi4Ml7Fho9iNhzI4U5fuWZCVY3RKq8fJjcjpQ1jMA4RD4Go/V1uGh2FPddel6ynpnipNkN5Y6dnfasoKFDqmPt2LfPFPsDIMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634436; c=relaxed/simple;
	bh=LwvNSAXXnSWzoHT3Wi0kz3QpPPutFGXNvtJ3F3liFfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PckPYoy0fM51+TxUObGA8QvW7gr+unlPaG1/JFZyOaTUlJPj8mGl9eR0UvY4HzyCbcEGiu+niDPm23nPHC2uJ3bh9njal3HPBCFut0K2j+U5nX5XIJXP3DT5FbuY2ZYhT0mkfMSWw0a139WHzzt1PfkLP8EKa9Q4BAwUhRYuIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQWFvU2p; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-835066ef130so898216b3a.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777634433; x=1778239233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRWgA5OmDOPPbc7jmvxeovxvP/jnc1UOCkDIWNmHkgQ=;
        b=sQWFvU2psz4r2lMyz69t4CeGPFUyCjKlSTMq4Int0RN//syyy3lw4JwO2RnvVjW4Wl
         +5mJSF7d2AgRgy+HV6EmsNaeaJP7nmC3tam20fRTTk0/08G3lHjyWq0/pCKSmHQ4Hf9k
         +WUBabu0SUFXTFVMdrp7ejYcdI763Ce9aCRyuAFo9/L2acF04NhbwtF7h4zHc9egItf0
         ZiVCum/2Af1rpdHgHfSubEcAq5Ac8p+nD8F40ZZfeey/p1yEMOFga2sl3GYLreISLnTI
         pjSDR1Eclsw12Tuw64xCao7oGGiiWWu/7f9O9GgsL+YHXv7v2Z36VerczQuQwNppL2na
         96nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634433; x=1778239233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRWgA5OmDOPPbc7jmvxeovxvP/jnc1UOCkDIWNmHkgQ=;
        b=LHHDB3jMlcAfVuC/QIJjAXXaCLubDZTjej/DF38SGr781gHKNkwLyuBYkjonVAdNz2
         zKk4AMqi5lC0MYAO0btNXLo8+JoCgF6zLQGopBAhczkFtMCcwOQDxGzfoL4zImg9mYvq
         3Oqf2p0AdVHyt/qY4YWJR4EK1jIgQsb1rS1aRvzSN+3fa4yzIPtXP1oGR2WrlJuVddCf
         j+LEDXyQggnbPb4U+bylruopGsIsA+OEXFKt+toFB6L+BBokcEbQT1YrFmRR8BRj9rOQ
         YbgpAXXCACVcbInfzMzEgQqqzT0aK3QgqCgcmQ+x0mIjiq/pt/EjOOOWqYlJ+wIzZRb9
         jQmw==
X-Forwarded-Encrypted: i=1; AFNElJ8SUF7BbahBUHJs4wdkifqTe0mWCWASa9uXYX9YxUASLQe2l5kvWk0FgM7CsJXgQr/cVvJ6DxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3I0SrHyxJswIyObmP7cj3Y54jFTc6o5BeMQ0z/aQe+dmk9wr
	2B1BYM2AyMKsrf2HRTfmAZJao5/E2alKttop5OV+BVrH9RnLpQjuMUq+
X-Gm-Gg: AeBDievMDX2wXC5kSjsA3Ge1TvMnWUXoKbqYgjEEaxr5/jXyMmtstEkLlVTVJkGtn7E
	5W/5h4rePXX//hociIvPOx8iqCMWDDyrqbKlCBQs+p7rjUBnXV7Nx1148JKekFk+4ose4PzFyFg
	69/oLhFxmxNiAQI26Qr8GRA67+jt4AJDp7JihzycEyzKyeg51IyUPCQFKW1ZR4gxsa3psX+Kwjq
	VVsD893XqI2e2ODxG8vCjq77EBFU54UTKV2/tO9SH/xfYkigoPps+gj2YSM8RylpHvyT9Fibt1C
	rCAcPS5QDJJfsZ7qRTx2iGAdmwH5j2A86p3sHFR1pq7M5KF43EbCF8DUnvsI5pIAaSfk7f5hJlz
	JphuON/RQOPf4w79Xa1HA5JxJyZKqBEWCT7IomlYaoYYavwo35ZYnHPsOgcvRMk1ukKCwIL1Nwo
	Z8+4c4dUebjxGrYf5PT9QM5qtowlc+A8oSrr6rad2SRNJ38XnL/6QyNBskOIJXzRiZ
X-Received: by 2002:a05:6a00:1794:b0:823:1c5f:1c43 with SMTP id d2e1a72fcca58-8351a570ea0mr2916454b3a.36.1777634433437;
        Fri, 01 May 2026 04:20:33 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351587db67sm2331922b3a.13.2026.05.01.04.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:20:32 -0700 (PDT)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	henrique.carvalho@suse.com,
	ematsumiya@suse.de
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 03/19] cifs: invalidate cfid on unlink/rename/rmdir
Date: Fri,  1 May 2026 16:50:06 +0530
Message-ID: <20260501112023.338005-3-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501112023.338005-1-sprasad@microsoft.com>
References: <20260501112023.338005-1-sprasad@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B7494ABFB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242327-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Shyam Prasad N <sprasad@microsoft.com>

Today we do not invalidate the cached_dirent or the entire
parent cfid when a dentry in a dir has been removed/moved.

This change invalidates the parent cfid so that we don't serve
directory contents from the cache.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/inode.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 888f9e35f14b8..f0b76670b0921 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -28,6 +28,23 @@
 #include "cached_dir.h"
 #include "reparse.h"
 
+static void cifs_invalidate_cached_dir(struct cifs_tcon *tcon,
+				       struct dentry *parent)
+{
+	struct cached_fid *parent_cfid = NULL;
+
+	if (!tcon || !parent)
+		return;
+
+	if (!open_cached_dir_by_dentry(tcon, parent, &parent_cfid)) {
+		mutex_lock(&parent_cfid->dirents.de_mutex);
+		parent_cfid->dirents.is_valid = false;
+		parent_cfid->dirents.is_failed = true;
+		mutex_unlock(&parent_cfid->dirents.de_mutex);
+		close_cached_dir(parent_cfid);
+	}
+}
+
 /*
  * Set parameters for the netfs library
  */
@@ -2067,6 +2084,9 @@ static int __cifs_unlink(struct inode *dir, struct dentry *dentry, bool sillyren
 		cifs_set_file_info(inode, attrs, xid, full_path, origattr);
 
 out_reval:
+	if (!rc && dentry->d_parent)
+		cifs_invalidate_cached_dir(tcon, dentry->d_parent);
+
 	if (inode) {
 		cifs_inode = CIFS_I(inode);
 		cifs_inode->time = 0;	/* will force revalidate to get info
@@ -2378,7 +2398,6 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 	}
 
 	rc = server->ops->rmdir(xid, tcon, full_path, cifs_sb);
-	cifs_put_tlink(tlink);
 
 	cifsInode = CIFS_I(d_inode(direntry));
 
@@ -2388,6 +2407,8 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 		i_size_write(d_inode(direntry), 0);
 		clear_nlink(d_inode(direntry));
 		spin_unlock(&d_inode(direntry)->i_lock);
+		if (direntry->d_parent)
+			cifs_invalidate_cached_dir(tcon, direntry->d_parent);
 	}
 
 	/* force revalidate to go get info when needed */
@@ -2402,6 +2423,7 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 
 	inode_set_ctime_current(d_inode(direntry));
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	cifs_put_tlink(tlink);
 
 rmdir_exit:
 	free_dentry_path(page);
@@ -2668,6 +2690,12 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	}
 
 	/* force revalidate to go get info when needed */
+	if (!rc) {
+		cifs_invalidate_cached_dir(tcon, source_dentry->d_parent);
+		if (target_dentry->d_parent != source_dentry->d_parent)
+			cifs_invalidate_cached_dir(tcon, target_dentry->d_parent);
+	}
+
 	CIFS_I(source_dir)->time = CIFS_I(target_dir)->time = 0;
 
 cifs_rename_exit:
-- 
2.43.0


