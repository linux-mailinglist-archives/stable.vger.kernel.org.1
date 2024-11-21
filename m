Return-Path: <stable+bounces-94518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7198E9D4CF9
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 13:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294E91F213F1
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3511E1D5CE0;
	Thu, 21 Nov 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2EGJirN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E980C1D47C0
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192729; cv=none; b=aurATgP+EPW09j/nDo5hRFztH8KnpB6xix6jNyHzLeoc1uUyiq3iPxMd8r0KWqkK8TkfD1XV7dQU4mqApwkcn26bx64tS7d2dXplSGnoZbOkKAcBEQayublMjoTDoOB+rbK7XRzhDIdj3CCFgVP7m2ReG8pQ/Ft8phqLR9BVUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192729; c=relaxed/simple;
	bh=odyV+d2Ue7SKnQWJHkjZGRbtp8p/EfKCNZ2Rd1O7/CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nygc8RRsbFxoaTWeRykE/6ECx75wbeJz745bl0xgiMWKBmZ/UmRShkM8LJAxXcm1aQIUxP6NOk8QI1l2b43M1QJBBm2Ri9zJGHos9zpno8DbfwbSZyaOm7C+DWhbyNHXPlYamggUHb0/nEGMxvVFPH8iachhxO/3hI2Oj8uxaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2EGJirN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6A7C4CECC;
	Thu, 21 Nov 2024 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732192728;
	bh=odyV+d2Ue7SKnQWJHkjZGRbtp8p/EfKCNZ2Rd1O7/CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2EGJirNb91y2pxRAnD3RTgsQz06GnPT+NePCt6r84R98TkMVdt/3uUozwEJQzMs/
	 2zG3tqyrNsw2GG8DJQ/sTUgpHSHvaVMsUueANdMGFen7RuYSL6WK0hW9re9nyHxtB1
	 +/KNabogMDS1H5IOhCo3uenRawQUteePARmIpDGtSL/M6E5kaUsV3XJl5nmFVRt+YG
	 bWcffiWjIKZGdaulNeft9EKvLoGXnJgjRfFtglk/oglKTrsqAudQQoOMQrCKfWPqzY
	 StqGsziOngfaa1AKEP6hLRjc9x9SfgpzIFZTtCAgZt/w0lm150wrDxF3Tk+PPnbp0G
	 G37yB0+y+BuZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] s390/pkey: Wipe copies of clear-key structures on failure
Date: Thu, 21 Nov 2024 07:38:46 -0500
Message-ID: <20241121065925-b77d67e2692505a6@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241121081222.3792207-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: d65d76a44ffe74c73298ada25b0f578680576073

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Holger Dengler <dengler@linux.ibm.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-21 06:54:04.315780402 -0500
+++ /tmp/tmp.dzrYUeNwaI	2024-11-21 06:54:04.312033373 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit d65d76a44ffe74c73298ada25b0f578680576073 ]
+
 Wipe all sensitive data from stack for all IOCTLs, which convert a
 clear-key into a protected- or secure-key.
 
@@ -6,18 +8,20 @@
 Acked-by: Heiko Carstens <hca@linux.ibm.com>
 Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
 Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
+[ Resolve minor conflicts to fix CVE-2024-42156 ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  drivers/s390/crypto/pkey_api.c | 16 +++++++++-------
  1 file changed, 9 insertions(+), 7 deletions(-)
 
 diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
-index 179287157c2fe..1aa78a74fbade 100644
+index d2ffdf2491da..70fcb5c40cfe 100644
 --- a/drivers/s390/crypto/pkey_api.c
 +++ b/drivers/s390/crypto/pkey_api.c
-@@ -1374,9 +1374,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
+@@ -1366,9 +1366,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
  		rc = cca_clr2seckey(kcs.cardnr, kcs.domain, kcs.keytype,
  				    kcs.clrkey.clrkey, kcs.seckey.seckey);
- 		pr_debug("%s cca_clr2seckey()=%d\n", __func__, rc);
+ 		DEBUG_DBG("%s cca_clr2seckey()=%d\n", __func__, rc);
 -		if (rc)
 -			break;
 -		if (copy_to_user(ucs, &kcs, sizeof(kcs)))
@@ -25,10 +29,10 @@
  			rc = -EFAULT;
  		memzero_explicit(&kcs, sizeof(kcs));
  		break;
-@@ -1409,9 +1407,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
+@@ -1401,9 +1399,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
  				      kcp.protkey.protkey,
  				      &kcp.protkey.len, &kcp.protkey.type);
- 		pr_debug("%s pkey_clr2protkey()=%d\n", __func__, rc);
+ 		DEBUG_DBG("%s pkey_clr2protkey()=%d\n", __func__, rc);
 -		if (rc)
 -			break;
 -		if (copy_to_user(ucp, &kcp, sizeof(kcp)))
@@ -36,7 +40,7 @@
  			rc = -EFAULT;
  		memzero_explicit(&kcp, sizeof(kcp));
  		break;
-@@ -1562,11 +1558,14 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
+@@ -1555,11 +1551,14 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
  		if (copy_from_user(&kcs, ucs, sizeof(kcs)))
  			return -EFAULT;
  		apqns = _copy_apqns_from_user(kcs.apqns, kcs.apqn_entries);
@@ -52,7 +56,7 @@
  			return -ENOMEM;
  		}
  		rc = pkey_clr2seckey2(apqns, kcs.apqn_entries,
-@@ -1576,15 +1575,18 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
+@@ -1569,15 +1568,18 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
  		kfree(apqns);
  		if (rc) {
  			kfree(kkey);
@@ -71,3 +75,6 @@
  				return -EFAULT;
  			}
  		}
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

