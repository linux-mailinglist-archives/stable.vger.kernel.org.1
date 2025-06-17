Return-Path: <stable+bounces-152753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9014ADC1E0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 07:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759E9168285
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 05:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083EB28A720;
	Tue, 17 Jun 2025 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wXi2D+nl"
X-Original-To: stable@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564B27EFE9;
	Tue, 17 Jun 2025 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750138872; cv=none; b=fpDlB1ho6iCmG78IkH7VWTt4rdYmaOxEM/XCfForngTbfRDpCaVk2WJc2fNcxCzbbSFZWbnRSQnUtnIAX8vHAfror6+mywIgssyk8tBGtMl7f742ywd3tm2hLoWhBkjDTfY2zmQUg5fQ988I2r2pqrgDE8V1Md6MC6G/lESuYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750138872; c=relaxed/simple;
	bh=4P501qOnaiDGUvEkuqikOzSt06uIW5v6X8vyinJMJng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDq0MEKXRNJK2jwIvJI3NAXdl0ygMXEiOUzIeMP9I28WPsGnW+c6Ph3c1JJ4O98WDA9SAj48DO0Nrb+5gLDs8JzjVB1nVJkJnXDRLT6le4Tc19givbZ0JiiYcz9Ax1XDAeA2tixMKNaw7dzx45PeTAHW69Vi7Vx875rad8D+Y/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wXi2D+nl; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750138861; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nk7HqULbpBMmwe47ngETLVBM1WQjusixsRNJ+uUQpcc=;
	b=wXi2D+nlx94Jimloxf6qfrGKYw0xEz5BuPlHfmlas8kciYCDmaMRg+ana2E5AWXknsBtv7SmhlQ3s5cNcTOXs6aXgQ706wOnYmIdUI/oC5Aa0B4wOgrMH7NHOOJ39dyHZ5jPYBOsxxWUH11BfC/L5Y/B78w/rFYDeRvnI6dG9JE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0We7iSMz_1750138856 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Jun 2025 13:41:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	stable@vger.kernel.org
Subject: [PATCH] erofs: remove unused trace event erofs_destroy_inode
Date: Tue, 17 Jun 2025 13:40:56 +0800
Message-ID: <20250617054056.3232365-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trace event `erofs_destroy_inode` was added but remains unused. This
unused event contributes approximately 5KB to the kernel module size.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/r/20250612224906.15000244@batman.local.home
Fixes: 13f06f48f7bf ("staging: erofs: support tracepoint")
Cc: stable@vger.kernel.org
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/trace/events/erofs.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index a5f4b9234f46..dad7360f42f9 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -211,24 +211,6 @@ TRACE_EVENT(erofs_map_blocks_exit,
 		  show_mflags(__entry->mflags), __entry->ret)
 );
 
-TRACE_EVENT(erofs_destroy_inode,
-	TP_PROTO(struct inode *inode),
-
-	TP_ARGS(inode),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,		dev		)
-		__field(	erofs_nid_t,	nid		)
-	),
-
-	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
-		__entry->nid	= EROFS_I(inode)->nid;
-	),
-
-	TP_printk("dev = (%d,%d), nid = %llu", show_dev_nid(__entry))
-);
-
 #endif /* _TRACE_EROFS_H */
 
  /* This part must be outside protection */
-- 
2.43.5


