Return-Path: <stable+bounces-55878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B1C918EC8
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 20:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8A32824A4
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C832144D2D;
	Wed, 26 Jun 2024 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I9wUTdKI"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D633C5
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427611; cv=none; b=pr4D6Alc2jl7f/5LA03ZHHgFgQFcLuGJaoZctUmK5OHvujkcqsX0ILkbUaWf75fZa000TWDs7taVRO4HbxXOjtbRXYLSMM6iz2XKUaTASrdImjqpYJtJbhWeWLSD5DTYjqw8AYssR2W8EZZslkGbRSseOom0YyTOpt8eHdlIMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427611; c=relaxed/simple;
	bh=FBginwRWS8RyrsK2NCr1DXwbyqt2+vTA4HvtY6Td3R8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gSmw7VauStsaBYxyyEyPJeyu/QChurlq3K/uqaE/A3e4gsX0aaphahnvzcMIm8N0GWvAuzv5uf+gCg4qFbwmCO/sBqOJVMT4iV/SsIXwpq/GTkb+vsWuKzujl1xEp7DeDQMNzwLX3V3CU4+wSDPkQc7HnrX/UqIdcEqUUvgzSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I9wUTdKI; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719427609; x=1750963609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c7zyM3fbjY427lHY+lIGKnOq+I3+MTNsbDciAEwKpio=;
  b=I9wUTdKIBg4246DjuIvNSeK4V/9fM6dbUopfqUa4qwX/sF4Wcf3bftt4
   PM2GlJjr0QAERrJpFhpq8IXXy0pvAln2eCdoIAsJ2Mzz733F+v6CtbM3W
   8dcLrY9Zt7kb2CW/fUPx6UGm38v56ztMHJYPV1C2bEDR2Rm70vpp9/d3g
   8=;
X-IronPort-AV: E=Sophos;i="6.08,267,1712620800"; 
   d="scan'208";a="735738706"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 18:46:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:59143]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.83:2525] with esmtp (Farcaster)
 id 3e1c0c34-6042-4251-8f32-cd465003938c; Wed, 26 Jun 2024 18:46:43 +0000 (UTC)
X-Farcaster-Flow-ID: 3e1c0c34-6042-4251-8f32-cd465003938c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 26 Jun 2024 18:46:41 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 26 Jun 2024 18:46:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, <stable@vger.kernel.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 5.4/5.10/5.15] nfs: Leave pages in the pagecache if readpage failed
Date: Wed, 26 Jun 2024 11:46:14 -0700
Message-ID: <20240626184614.80363-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

commit 0b768a9610c6de9811c6d33900bebfb665192ee1 upstream

The pagecache handles readpage failing by itself; it doesn't want
filesystems to remove pages from under it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
When NFS server returns NFS4ERR_SERVERFAULT, the client returned
Remote I/O error immediately on 4.14 and 6.1, but on 5.4/5.10/5.15,
the client retries forever and get stuck until userspace aborts it.

The patch fixed the issue but did not have Fixes: tag.

Please backport this to 5.4/5.10/5.15.
---
 fs/nfs/read.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 08d6cc57cbc3..b02372ec07a5 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -120,12 +120,8 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 	if (nfs_error_is_fatal_on_server(error) && error != -ETIMEDOUT)
 		SetPageError(page);
 	if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)) {
-		struct address_space *mapping = page_file_mapping(page);
-
 		if (PageUptodate(page))
 			nfs_readpage_to_fscache(inode, page, 0);
-		else if (!PageError(page) && !PagePrivate(page))
-			generic_error_remove_page(mapping, page);
 		unlock_page(page);
 	}
 	nfs_release_request(req);
-- 
2.30.2


