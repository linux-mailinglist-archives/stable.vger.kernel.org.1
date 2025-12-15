Return-Path: <stable+bounces-201115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC499CC00A4
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 22:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 377F13002B8A
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 21:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2767F329C57;
	Mon, 15 Dec 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="rC/VurrI"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829D320380;
	Mon, 15 Dec 2025 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835555; cv=none; b=pFdXvZrYQRhksjMueWduCzDSQx0sRtPm6Mws+LGmVmOq982w64AbvBJrFQJ2RVbvvz6CctfvcPpYF+uOHNzz4vwhJhLOZeh1H5kUANCUdRSt/55+0BntBJDW2VqD3Vs+q6EFqzrqldIaXN+MPpFNFc2KrFA2ZYHdoRVBD0UWIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835555; c=relaxed/simple;
	bh=eaGA087uYYrPTq6nnMnjwWkWuezwx3/55F0Bz2u4ldI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=twV37F9nkJa3na3pUfm+8GFlrxHrqs7k9sFt7GB9wNvSDeS2VThIFU5RelUqQvlgxKCFDFtMMA/lH1KLoFpKIlPvm5EJ3/nywsx4iVm4hSS1dPJMF5tmxMuiL8asmiWg8fzGL9gHDvJd3MvTHi+CUZJgGyZ3k2F59apuTp/RG1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=rC/VurrI; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1765835554; x=1797371554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VqwPj0Gw5mdtt2CsEjIsDatIMeNxRjIJfr5Q1G1xiAU=;
  b=rC/VurrISjQmaZbkEsMnU0sU52E4YoQoQlawicj11MJ9h8MYpaEpUg7s
   pPifsT7Dk0Yqi86UMb2vMerrbOjMqVwtZommRUd1belNVGbKtLSAOTpB+
   7Y2HlcDB2S9VT1F5dYfEeKydjDpp4TDslc8e1QwCkUTFCG+xyNVxXi+sj
   DbZtFfeZS9ubaxCXO+i3kW66Nljm4XYiH8SlUzl+AD0svg2XE/+g1PzEX
   tf/XTOFDOi+WYsMqB3pgEgNmD+KLWKdhy4PAMef4DqA0Ivmx8EpY3AjzR
   g5hTsWC/AHuLn7iEV/z553LB7o3OfXIuStf5nNHaSr8J/TXe78fmKUqk6
   Q==;
X-CSE-ConnectionGUID: 7pAGTbZRQSKg+ehWYyEmDg==
X-CSE-MsgGUID: mOs92IoUQPeyZfbTVEEAYQ==
X-IronPort-AV: E=Sophos;i="6.21,151,1763424000"; 
   d="scan'208";a="8948533"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 21:51:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:4467]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.145:2525] with esmtp (Farcaster)
 id 00178745-562b-47d3-9734-b192518e71c8; Mon, 15 Dec 2025 21:51:24 +0000 (UTC)
X-Farcaster-Flow-ID: 00178745-562b-47d3-9734-b192518e71c8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 15 Dec 2025 21:51:24 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 15 Dec 2025 21:51:22 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>
CC: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux@gyokhan.com>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.12.y 0/2] net: dst: Backport fix CVE-2025-40075
Date: Mon, 15 Dec 2025 21:51:17 +0000
Message-ID: <20251215215119.63681-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Gyokhan Kochmarla <gyokhan@amazon.com>

This patch series backports two commits from mainline to fix CVE-2025-40075,
a data race vulnerability in dst->dev access.

The first patch introduces dst->dev_rcu and dst_dev_net_rcu() helper to
provide proper RCU protection with lockdep support. The second patch uses
the new helper in tcp_metrics to eliminate unsafe dst_dev() calls.

These are clean cherry-picks from mainline commits:
- caedcc5b6df1 ("net: dst: introduce dst->dev_rcu")
- 50c127a69cd6 ("tcp_metrics: use dst_dev_net_rcu()")

Eric Dumazet (2):
  net: dst: introduce dst->dev_rcu
  tcp_metrics: use dst_dev_net_rcu()

 include/net/dst.h      | 16 +++++++++++-----
 net/core/dst.c         |  2 +-
 net/ipv4/route.c       |  4 ++--
 net/ipv4/tcp_metrics.c |  6 +++---
 4 files changed, 17 insertions(+), 11 deletions(-)

-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


