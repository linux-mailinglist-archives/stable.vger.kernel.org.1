Return-Path: <stable+bounces-95641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE409DAB8D
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D794A281AC5
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58BA288D1;
	Wed, 27 Nov 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+zs9Sgz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95115200B8E
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724115; cv=none; b=gCi/i5sJTTQNUXZNl+yi/xOiFNRTEUHOJ0c9KjGdalLHILItGE/pkCmy6KoDwY2xJv0yM6n32KZBG0eOgYuHbztAbA2PcNx30x1DxC2aGEuIAOFqLFJZHu7MX4ojcsTNMIvOKrvY+Gv5Q9jloQjCVDxXOz81I962ozNXHOjRO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724115; c=relaxed/simple;
	bh=guJwqPMbO4Ccq1TYEAcvKKM0ScBTTC6RTthzDqriYBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnxzYqK/a6zulZJMctT/fQ64QBi+DlAVBEuIFobkPSDW+JAQJ/rOC5vPN4KT/HpD0lQHE40qZiEbQvImDyPmVLcCW6I2ah8rno8KUa2vJuDilcp3vOy7gu7EIszmLNipv6wW50P5VQRyhWHKG3FlWw7RGeFaqFWuy1WKwkgZTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+zs9Sgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E97FC4CED2;
	Wed, 27 Nov 2024 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724115;
	bh=guJwqPMbO4Ccq1TYEAcvKKM0ScBTTC6RTthzDqriYBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+zs9Sgz3bUH9IG+KyIUB2o2KPcXq6bKuYvEIZ/fkq4sAck0iH4NMF9VS63b+rxWH
	 7SCaFGyfgVDjvlnpFLYtC/8uEQ60SkeW3NrscGwj2JYctJMFVw8gym5wC7ZjJ44ahM
	 tefAeDXoyK+g3djbnJUjstiQrnIlTrH05kxmEPmNwJ+b4Bh7icp9sN5rgwHJA0aSIp
	 SWF1Ya6EQtQs1WWOM0GIG/aWpc0ZPTRx4inojFped7MbM3dZ/2cY8GH+FTJyicE4RW
	 KSKVxIdMCjpRnlYCQ1uIfQSmleGUmKyKtilDor1wBknV6uT8VjA00YU/DN0JoD4zQZ
	 tHlOWXttWUMUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] xfs: add bounds checking to xlog_recover_process_data
Date: Wed, 27 Nov 2024 11:15:13 -0500
Message-ID: <20241127091330-82db9244fc7b793d@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127124931.847488-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: fb63435b7c7dc112b1ae1baea5486e0a6e27b196

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: lei lu <llfamsec@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 09:08:44.495159015 -0500
+++ /tmp/tmp.uVpAtajSTd	2024-11-27 09:08:44.489488570 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit fb63435b7c7dc112b1ae1baea5486e0a6e27b196 ]
+
 There is a lack of verification of the space occupied by fixed members
 of xlog_op_header in the xlog_recover_process_data.
 
@@ -22,15 +24,16 @@
 Reviewed-by: Dave Chinner <dchinner@redhat.com>
 Reviewed-by: Darrick J. Wong <djwong@kernel.org>
 Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  fs/xfs/xfs_log_recover.c | 5 ++++-
  1 file changed, 4 insertions(+), 1 deletion(-)
 
 diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
-index 4fe627991e865..409b645ce7995 100644
+index 9f9d3abad2cf..d11de0fa5c5f 100644
 --- a/fs/xfs/xfs_log_recover.c
 +++ b/fs/xfs/xfs_log_recover.c
-@@ -2489,7 +2489,10 @@ xlog_recover_process_data(
+@@ -2456,7 +2456,10 @@ xlog_recover_process_data(
  
  		ohead = (struct xlog_op_header *)dp;
  		dp += sizeof(*ohead);
@@ -42,3 +45,6 @@
  
  		/* errors will abort recovery */
  		error = xlog_recover_process_ophdr(log, rhash, rhead, ohead,
+-- 
+2.34.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

