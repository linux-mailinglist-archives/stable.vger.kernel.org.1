Return-Path: <stable+bounces-35702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77981896FB6
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 15:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3165E283236
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 13:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEF2146A75;
	Wed,  3 Apr 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X9yJw6Ey"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F651411F0
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149243; cv=none; b=jQbJbRitNTbIcmKBg1s+Cc3IYevFQJtoj/riSwSiUSjmEJEITCedZ3Ql3P4mrMDoqWMvF7DDIKR/pWw3a9Wz44o0chVPT1mTdDjyTCoPEV0QzhcrGu/Wjw2LiAZnkpANgZRt0BFcZcUJlz4PNZbANpZI9VTrYRz9K7gWUDKPMVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149243; c=relaxed/simple;
	bh=SpJaxDZMtOTQc6ZgzZxcDyTpnR5rq38vQ8uf2ryP2jI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCVljox2frJif84f161nCDfs6CRpMo4i2ZXyk9otFlAyAMk9ru6P1mbT+nU83UJCzgHfGPXV5OThhbRQsaW3CWezF1oIfSS4GWN8tP1DdUb5ovIfxPCX7gKa9VGyc/hsCPbL4LtGbJQ4W59Za0bsURVcNNfnRQjvOIdhqxx+MT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=X9yJw6Ey; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712149243; x=1743685243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBzcVLPH/hoe/Z9yikVI76rs9JtdVbpupJpJKzuCLu0=;
  b=X9yJw6Ey0sqv1jvLESM770fXs54SMQr2VBcvUpZMd7kRDa2u7onZERVF
   5cfqSGWuzq5Hjc2Hu1QlL1kPEB6O1fZ3HKwAyK/3+l69yI2cYeeHS1C9E
   /GakB+ZHvMmwyLS9ng5CUUF9LeKyrQOo2xWxsp3OQBJeifZ5nF7Uz1AlF
   g=;
X-IronPort-AV: E=Sophos;i="6.07,177,1708387200"; 
   d="scan'208";a="649506050"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:00:36 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.29.78:25771]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.45.125:2525] with esmtp (Farcaster)
 id c6fd02b9-80aa-4012-b8fb-f834f4f49faa; Wed, 3 Apr 2024 13:00:34 +0000 (UTC)
X-Farcaster-Flow-ID: c6fd02b9-80aa-4012-b8fb-f834f4f49faa
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 13:00:31 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 3 Apr 2024 13:00:31 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 6BAA3BE6; Wed,  3 Apr 2024 15:00:31 +0200 (CEST)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <djwong@kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.1 1/6] xfs: allow inode inactivation during a ro mount log recovery
Date: Wed, 3 Apr 2024 14:59:46 +0200
Message-ID: <20240403125949.33676-2-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240403125949.33676-1-mngyadam@amazon.com>
References: <20240403125949.33676-1-mngyadam@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: "Darrick J. Wong" <djwong@kernel.org>

commit 76e589013fec672c3587d6314f2d1f0aeddc26d9 upstream.

In the next patch, we're going to prohibit log recovery if the primary
superblock contains an unrecognized rocompat feature bit even on
readonly mounts.  This requires removing all the code in the log
mounting process that temporarily disables the readonly state.

Unfortunately, inode inactivation disables itself on readonly mounts.
Clearing the iunlinked lists after log recovery needs inactivation to
run to free the unreferenced inodes, which (AFAICT) is the only reason
why log mounting plays games with the readonly state in the first place.

Therefore, change the inactivation predicates to allow inactivation
during log recovery of a readonly mount.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
 fs/xfs/xfs_inode.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index aa303be11576..0468243bcee6 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1652,8 +1652,11 @@ xfs_inode_needs_inactive(
 	if (VFS_I(ip)->i_mode == 0)
 		return false;

-	/* If this is a read-only mount, don't do this (would generate I/O) */
-	if (xfs_is_readonly(mp))
+	/*
+	 * If this is a read-only mount, don't do this (would generate I/O)
+	 * unless we're in log recovery and cleaning the iunlinked list.
+	 */
+	if (xfs_is_readonly(mp) && !xlog_recovery_needed(mp->m_log))
 		return false;

 	/* If the log isn't running, push inodes straight to reclaim. */
@@ -1713,8 +1716,11 @@ xfs_inactive(
 	mp = ip->i_mount;
 	ASSERT(!xfs_iflags_test(ip, XFS_IRECOVERY));

-	/* If this is a read-only mount, don't do this (would generate I/O) */
-	if (xfs_is_readonly(mp))
+	/*
+	 * If this is a read-only mount, don't do this (would generate I/O)
+	 * unless we're in log recovery and cleaning the iunlinked list.
+	 */
+	if (xfs_is_readonly(mp) && !xlog_recovery_needed(mp->m_log))
 		goto out;

 	/* Metadata inodes require explicit resource cleanup. */
--
2.40.1

