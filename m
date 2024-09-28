Return-Path: <stable+bounces-78167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA429988D94
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 04:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14891C2118C
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 02:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951413AA47;
	Sat, 28 Sep 2024 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aMFx2ycW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE0171A7
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727490850; cv=none; b=nTN/yiGZFCeFlDTsQztshrDOoqX8DyX+exhLaisjmNwpyctxrVRdqajjQ93dY1VpnM0YK591RGRKTDYHbFZ9ph9mO9ntbxNvMxWN9BV3IuQi4KzG6zTg/LLX/KsLCG79XkKUv1S5bYqUNx7ta053iFWHqKXOgGVwYTFJJI9bJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727490850; c=relaxed/simple;
	bh=7JETgzVlPniE2th61i/1NTROAETK/T9gFI7yNKCepTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMwejyWQHpoD34J8VEjiLZ+nEOv9jy0D/7XnQfzpTh6sccorbRaqmAUqFiad2E6hwocmR3diZfhrn8tMSFyckTrud9owESR7SZsPNLPQF3RXG3moSYGR2xr6T/ZCn5l3nV1qt1CVs9A3V6XyMwkH9iIi035VPWygmjS1eYch4vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aMFx2ycW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-719ba0654f9so2369790b3a.3
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 19:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727490847; x=1728095647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MI/YrD/lCyZQfuqc6LhwT8YNbgbBZkfv6QDOo41ZKyI=;
        b=aMFx2ycWAK8bsubMRJIBZ/EjAwqN8pWRyjzUTnJxWPL49P/SyS0iwhHlpFKGYK5R7f
         ZQjEOyHznmAeoWZVm2DFrbo45q84o6QqSFNJ2js/hkFx5kKYVPfYy9/tvxvd3z7+KVGf
         xYsvbI2HKiBWNJjObn8HQV3Cvlug3VLhFUF80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727490847; x=1728095647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI/YrD/lCyZQfuqc6LhwT8YNbgbBZkfv6QDOo41ZKyI=;
        b=mRqX7yZ94E0qpqnmmKHtZAybRfFHoUTIgbgPvzW1T6fjSwRRTh+QQ/r540SLNx/eSH
         QP8KK2+cFDF3ZDePdRSKg269o1MHmEUfFnj99oRVbtzgqGcHqQUeb5wdlW+i/tQpNjch
         bUaKolnu8j5P/d6z5MRlO5MRonxxAnM75oCFbCy9JQlvUduuYIHZexguWzDOoz5hX48m
         tnE8+zYon3ImkWBHV8+G9copW/kgViFvMaW/sbIWeGozfdN6AIyiglNLaan6i5O7FIhn
         Y0fdi88jBoi94+ZTHHzorVNcODwCCUn1vm+VCwNIKqJzln+glAJN6UbPTpRVnLOnktiB
         LAXg==
X-Gm-Message-State: AOJu0YwlCiyZ21hBv6OavPPFzgiJgmWbwH8qZESmVsu3J08hfRqnrYCZ
	bZj5FJ2YrDOGH+hMmSiXFMm1OxEHbMGSgL+C/DBfIE148ha0RxhFA0LgbgVWnxJERF9xsYNmY8c
	OJgJjleG2uFy9odzvKNc5pbPSJR0eVj9cjr7Mwxipjom7K0lZUDb5A6nqVQV8FLHdhHT7NgCnNp
	4IdPsp+ZjB0l259oaRg9repQS3nEtBFC18utc6nRabmq7fYQQ=
X-Google-Smtp-Source: AGHT+IGTfEyKEUJ1bOxW3m6LmtiOzTr6iqhwVfVJE+TgVQjvrt/Sp9jAPDeJvlAOlFnzYfv9q/kc+A==
X-Received: by 2002:a05:6a00:3cce:b0:718:cabe:aa8 with SMTP id d2e1a72fcca58-71b26059666mr8670611b3a.18.1727490846779;
        Fri, 27 Sep 2024 19:34:06 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26516223sm2254154b3a.112.2024.09.27.19.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 19:34:06 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	jmorris@namei.org,
	serge@hallyn.com,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Scott Mayhew <smayhew@redhat.com>,
	stable@kernel.org,
	Marek Gresko <marek.gresko@protonmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] selinux,smack: don't bypass permissions check in  inode_setsecctx hook
Date: Fri, 27 Sep 2024 19:33:49 -0700
Message-Id: <20240928023349.154389-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Scott Mayhew <smayhew@redhat.com>

commit 76a0e79bc84f466999fa501fce5bf7a07641b8a7 upstream.

Marek Gresko reports that the root user on an NFS client is able to
change the security labels on files on an NFS filesystem that is
exported with root squashing enabled.

The end of the kerneldoc comment for __vfs_setxattr_noperm() states:

 *  This function requires the caller to lock the inode's i_mutex before it
 *  is executed. It also assumes that the caller will make the appropriate
 *  permission checks.

nfsd_setattr() does do permissions checking via fh_verify() and
nfsd_permission(), but those don't do all the same permissions checks
that are done by security_inode_setxattr() and its related LSM hooks do.

Since nfsd_setattr() is the only consumer of security_inode_setsecctx(),
simplest solution appears to be to replace the call to
__vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
fixes the above issue and has the added benefit of causing nfsd to
recall conflicting delegations on a file when a client tries to change
its security label.

Cc: stable@kernel.org
Reported-by: Marek Gresko <marek.gresko@protonmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218809
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Shivani: Modified to apply on v5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 security/selinux/hooks.c   | 3 ++-
 security/smack/smack_lsm.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 46c00a68bb4b..90935ed3d8d8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6570,7 +6570,8 @@ static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen
  */
 static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
+	return __vfs_setxattr_locked(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0,
+				     NULL);
 }
 
 static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 92bc6c9d793d..cb4801fcf9a8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4651,7 +4651,8 @@ static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, ctx, ctxlen, 0);
+	return __vfs_setxattr_locked(dentry, XATTR_NAME_SMACK, ctx, ctxlen, 0,
+				     NULL);
 }
 
 static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
-- 
2.39.4


