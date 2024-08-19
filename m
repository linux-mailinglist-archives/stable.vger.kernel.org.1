Return-Path: <stable+bounces-69618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72895718B
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 19:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01342849CF
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43313C3F2;
	Mon, 19 Aug 2024 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DKDRMSwf"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0241804E
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087177; cv=none; b=Uhuua8k0OhYP+opWr4ZoFsgLh3axklzze68KyZ5WuHGTcQSoqdntoZDGzSY7HUtGEbCTlkcmAa0fh89EvSCgU/mtTLTiHQ+6ErY63143UJ45VIVpeHrv4pxtlwb/l6V2zmnEu0grnujbwJpfJzFa+GzM9bCsuwAYzx+9CC5u6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087177; c=relaxed/simple;
	bh=8kWTMmSxSt5DMF0lXqT25yw4vN3UYx/dycyrSmV1OhI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZH8RTPFsJKv1hdYGHBBmMGcUoZy38M0kqPNR179lgUN/V1Prs5GhaZZ+z8bzoUkY++PIUTJ3K+gAS/K8QMO1UU/ly+8eDAJV7JT0/uA9/gUpYHEljPbqiCDSYm0BTt7wCn86OmafwC2IF38lg//DabcvBxiht23ZEOVHJNL8pis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DKDRMSwf; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724087175; x=1755623175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L9ayoLxNV21fOPsv4CV6mx10HPR4UYURwV105WjseVU=;
  b=DKDRMSwf8sD3jDcZXLUF/PCuuN8aZt7UzuZ0AQMMS6u6OfPT9nYhnyyz
   97skxbJArWCg2b/tRTRtrLWjF9dr5s52HndqVVeH5d+lBGO9EfZ/HOiGh
   Z6fA7dKwxVxSn7Yllm8vf6XlAJpWLMjVss5vhTSzQRVe3d78T0Uak5niR
   0=;
X-IronPort-AV: E=Sophos;i="6.10,159,1719878400"; 
   d="scan'208";a="19791950"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 17:06:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:57207]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.1:2525] with esmtp (Farcaster)
 id 4913a01d-3a3f-4278-b863-45bc36cb092c; Mon, 19 Aug 2024 17:06:11 +0000 (UTC)
X-Farcaster-Flow-ID: 4913a01d-3a3f-4278-b863-45bc36cb092c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 17:06:11 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 17:06:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown
	<neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, Hughdan Liu
	<hughliu@amazon.com>
Subject: [PATCH 5.10.y] nfsd: Don't call freezable_schedule_timeout() after each successful page allocation in svc_alloc_arg().
Date: Mon, 19 Aug 2024 10:05:51 -0700
Message-ID: <20240819170551.10764-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When commit 390390240145 ("nfsd: don't allow nfsd threads to be
signalled.") is backported to 5.10, it was adjusted considering commit
3feac2b55293 ("sunrpc: exclude from freezer when waiting for requests:").

However, 3feac2b55293 is based on commit f6e70aab9dfe ("SUNRPC: refresh
rq_pages using a bulk page allocator"), which converted page-by-page
allocation to a batch allocation, so schedule_timeout() is placed
un-nested.

As a result, the backported commit 7229200f6866 ("nfsd: don't allow nfsd
threads to be signalled.") placed freezable_schedule_timeout() in the wrong
place.

Now, freezable_schedule_timeout() is called after every successful page
allocation, and we see 30%+ performance regression on 5.10.220 in our
test suite.

Let's move it to the correct place so that freezable_schedule_timeout()
is called only when page allocation fails.

Fixes: 7229200f6866 ("nfsd: don't allow nfsd threads to be signalled.")
Reported-by: Hughdan Liu <hughliu@amazon.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/sunrpc/svc_xprt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index d1eacf3358b8..60782504ad3e 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -679,8 +679,8 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 					set_current_state(TASK_RUNNING);
 					return -EINTR;
 				}
+				freezable_schedule_timeout(msecs_to_jiffies(500));
 			}
-			freezable_schedule_timeout(msecs_to_jiffies(500));
 			rqstp->rq_pages[i] = p;
 		}
 	rqstp->rq_page_end = &rqstp->rq_pages[i];
-- 
2.30.2


