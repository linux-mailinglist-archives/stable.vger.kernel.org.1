Return-Path: <stable+bounces-89274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394359B5898
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 01:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA2A1C229FD
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 00:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E461799F;
	Wed, 30 Oct 2024 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zA7zIitO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435BF12E7E
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248152; cv=none; b=JRqNFzK/+vTZ5po8msS23QyesHzrP4c9ofoe7uxoxP00fLhL4odW4182yXjkAZrI1yV0mODUSU9dq24HLb2qt0zzxzY81AoU0mK1kKXLOfuTD9YPOS1PWWq2eIJ/vwn2bNtJ4Xa59wvhIK+YDEKdwg37/RwsYRdUk+5CSDrvlZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248152; c=relaxed/simple;
	bh=V1iNnvuBm2oNPGSNfSGCVmkg1t1E6dTFsv0w9mlYepo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TnvpKdiuY/TPE/sqpaVdcR+47Zoh6ZqRppPWU/o4khAM4icHR4GROjuyaw3MvhkC6xhqi/HR/0haqzFtrWTmKNzoNQocNQeIqz5M5iUqQ+C3wKgCFL1CqEXpK0E+PYDZMuSH+s+J5s30sTbIJ5BF356n99GLjgZZOD7h+RDNbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zA7zIitO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e6d31b3bdso8509079b3a.2
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 17:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730248149; x=1730852949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Ye+vbAHY2hoAlG8bCiiPKeIhcJVGNMWcPfmJps0LRM=;
        b=zA7zIitO1JDLLMVh2tDpB/Ydm3JznmxluumgnAAQ6WMBUCseUBjDcmx2aSepa5iFMB
         HSjvnGMHXxhkte8W0S3t+8vKStng2pG471DZjrS96ZBqOheyTx3r1Rmlzy9ULwDLiLcP
         rQvGSbSa0ducNsfRQKEmE2TUXcWn2qhJz7Ijr2C7b+d83a8G8RMpNg3ah9kWp+Pcz5qW
         cdo8gELtUl4Wk3KtB+s4mN8epfcU9wH1nPTQAiNSEEIrd8Wuj/mqguz1iTb45CPQLW+P
         C7lfbQplOCBz2b19DtKVbwP4Av747A7OhYbFmQ3/RSxmDiI4l60Nw1afKIOU39hv1QIg
         evBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730248149; x=1730852949;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ye+vbAHY2hoAlG8bCiiPKeIhcJVGNMWcPfmJps0LRM=;
        b=TwH/R++fafQIwOIVSfAvtfIaTb9T7vHn/H+PdsfPGtp/VTX8J0MUYYXzrlZwmYhVVf
         Rv2vBSjolD9l4ip25nXUMw+gdUrw3BqPDBycd89O4YIXfn2snaI6HbO/mbxXxQVVeghd
         7ynRPTPzWik+U344TNrXbw822M+DT3THX0nwc6MwzcH9aM9nuC2qM1Ma/0m/5uGukwpv
         KKL7hpG0qXpOzkXj8/jcgogZGGrs/l7AqIgl+ug8+H7As6t69Uu2o3I2eRVHtNAXAug2
         IJ+90TDjSqcm/d2oKnQTP2vNDBaAdWuC83xtyawHGg8UM4mLY9pJ53YMEgcuqBAi5Njj
         tHzA==
X-Forwarded-Encrypted: i=1; AJvYcCU8WxnaUuIT4Uqck+ni/IOhNwOcK/5NtG3aD0st/ScejGEb4OICOreYz5rzWtWtpbpAfDqrfdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3AlMnM8kzhKRkLci8fV3o9ibgjsIUbtDi7F/gUeHfPlJzjG5B
	wRPmVyC0ZmvUjxORlyZ04u/eI/qDltpKWZMsYBdoi2ItGrqs5X/eC4iVp0GNh3O8bQ==
X-Google-Smtp-Source: AGHT+IFmIqfjPUXzygglv0CS5v98bbZvDbHPlRnqqpROK5kUQdzIOV0DEK16WsMTN1yt3vYZ1XyvGZ0=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1148])
 (user=ovt job=sendgmr) by 2002:a05:6a00:3c50:b0:71e:5d1d:350a with SMTP id
 d2e1a72fcca58-72063089caamr24309b3a.3.1730248149442; Tue, 29 Oct 2024
 17:29:09 -0700 (PDT)
Date: Wed, 30 Oct 2024 00:28:55 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030002856.2103752-1-ovt@google.com>
Subject: [PATCH] ovl: properly handle large files in ovl_security_fileattr
From: Oleksandr Tymoshenko <ovt@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: ovt@google.com, stable@vger.kernel.org, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dentry_open in ovl_security_fileattr fails for any file
larger than 2GB if open method of the underlying filesystem
calls generic_file_open (e.g. fusefs).

The issue can be reproduce using the following script:
(passthrough_ll is an example app from libfuse).

  $ D=/opt/test/mnt
  $ mkdir -p ${D}/{source,base,top/uppr,top/work,ovlfs}
  $ dd if=/dev/zero of=${D}/source/zero.bin bs=1G count=2
  $ passthrough_ll -o source=${D}/source ${D}/base
  $ mount -t overlay overlay \
      -olowerdir=${D}/base,upperdir=${D}/top/uppr,workdir=${D}/top/work \
      ${D}/ovlfs
  $ chmod 0777 ${D}/mnt/ovlfs/zero.bin

Running this script results in "Value too large for defined data type"
error message from chmod.

Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
Fixes: 72db82115d2b ("ovl: copy up sync/noatime fileattr flags")
Cc: stable@vger.kernel.org # v5.15+
---
 fs/overlayfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 35fd3e3e1778..baa54c718bd7 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -616,8 +616,13 @@ static int ovl_security_fileattr(const struct path *realpath, struct fileattr *f
 	struct file *file;
 	unsigned int cmd;
 	int err;
+	unsigned int flags;
+
+	flags = O_RDONLY;
+	if (force_o_largefile())
+		flags |= O_LARGEFILE;
 
-	file = dentry_open(realpath, O_RDONLY, current_cred());
+	file = dentry_open(realpath, flags, current_cred());
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-- 
2.47.0.163.g1226f6d8fa-goog


