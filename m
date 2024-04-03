Return-Path: <stable+bounces-35705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8D2896FBE
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F5E1B25F29
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E565146A92;
	Wed,  3 Apr 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CSvSgKGM"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A85146A75
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149313; cv=none; b=Xc1bIS9+HH7uKTO/DsK9FAraZBYhp/GQpe4h7Y4QrFoekVo51dN07ZkTcE1tfY/ctBIKFpp17jVojrpkplcgd5Q+kOcurImU+TXQnH8yPS1Xq8pRcxrESdtoWPL59qhnG6AsS03y6MGueryHDc28vKCqT3bsZ0rZyOl4naa/qAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149313; c=relaxed/simple;
	bh=XJI0vOHfR+gJRwlZfNY8WpCKhldVg4RKgO184JG3h4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjIyn/2SdxbmoHirH25FEzuaaniWsJWIK2C9X3ZpKH1WzwsnO1x6nurSJ21EQgOtiqMZe6tW4THzcz4xHHBrWtLAxQIZ/fGNhFpyfuFTnLhYi5+tlIU7uQTOO0hn+c/4KLq5iAKknYlUJgI3Uq+Rc7q17MOpks9b0h7WtvY9tas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CSvSgKGM; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712149313; x=1743685313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yf1+69U4+67GiR4yP6R/Rmd5H9r99lPfpYHwaXZEB2I=;
  b=CSvSgKGM97Bhx+9tvaRWsE1u50hX1A7OCgJH4Muju/OXcFXtwDZJyMHq
   JMmgP1IPacqXob3Vu+d6IWZuvuzdsj4Pukwg4KmvFWw9JJzfQfWR8XdgL
   IFTjBcmuOAKtWbOjZ7iKFDS/N/jyyH3+cgk8paDftUdXsGNm3PQatRvgB
   o=;
X-IronPort-AV: E=Sophos;i="6.07,177,1708387200"; 
   d="scan'208";a="649506482"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:01:51 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:7404]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.181:2525] with esmtp (Farcaster)
 id 927c0a9f-8000-4c29-9d8a-b84b0cea5bcd; Wed, 3 Apr 2024 13:01:49 +0000 (UTC)
X-Farcaster-Flow-ID: 927c0a9f-8000-4c29-9d8a-b84b0cea5bcd
Received: from EX19EXOUWB001.ant.amazon.com (10.250.64.229) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 13:01:49 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19EXOUWB001.ant.amazon.com (10.250.64.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 13:01:48 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 3 Apr 2024 13:01:48 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 5AB3CBE6; Wed,  3 Apr 2024 15:01:48 +0200 (CEST)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <djwong@kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.1 4/6] xfs: short circuit xfs_growfs_data_private() if delta is zero
Date: Wed, 3 Apr 2024 14:59:53 +0200
Message-ID: <20240403125949.33676-5-mngyadam@amazon.com>
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

From: Eric Sandeen <sandeen@redhat.com>

commit 84712492e6dab803bf595fb8494d11098b74a652 upstream.

Although xfs_growfs_data() doesn't call xfs_growfs_data_private()
if in->newblocks == mp->m_sb.sb_dblocks, xfs_growfs_data_private()
further massages the new block count so that we don't i.e. try
to create a too-small new AG.

This may lead to a delta of "0" in xfs_growfs_data_private(), so
we end up in the shrink case and emit the EXPERIMENTAL warning
even if we're not changing anything at all.

Fix this by returning straightaway if the block delta is zero.

(nb: in older kernels, the result of entering the shrink case
with delta == 0 may actually let an -ENOSPC escape to userspace,
which is confusing for users.)

Fixes: fb2fc1720185 ("xfs: support shrinking unused space in the last AG")
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
 fs/xfs/xfs_fsops.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 13851c0d640b..332da0d7b85c 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -129,6 +129,10 @@ xfs_growfs_data_private(
 	if (delta < 0 && nagcount < 2)
 		return -EINVAL;

+	/* No work to do */
+	if (delta == 0)
+		return 0;
+
 	oagcount = mp->m_sb.sb_agcount;
 	/* allocate the new per-ag structures */
 	if (nagcount > oagcount) {
--
2.40.1

