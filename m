Return-Path: <stable+bounces-267375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JgDkFA4nNWqzngYAu9opvQ
	(envelope-from <stable+bounces-267375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 13:25:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE736A5696
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 13:25:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b=UjBa+zEx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267375-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267375-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66356301E988
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 11:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9061C37B40A;
	Fri, 19 Jun 2026 11:24:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B5346E51;
	Fri, 19 Jun 2026 11:24:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868294; cv=none; b=OWiXmjCqE8wi3mkbDyWRAsoVCOCwK9ic0Tysnnh//uwoPgDqDOD63mQg9VHiQUwXVU96VSaUILf5Go+oC5tJrpTrmwaokC61jSTgKBuc7mrCYvyGvP9Nfa1cdTZhfv415CIU495rc7knyHFI5Ap3FJjhTWLwrpfp0yW+HZDEOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868294; c=relaxed/simple;
	bh=Y9cWku7S6JE1DqqS49GtF1XXxypNL9El/aa5+Wm3n/4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hRm3yJzJYEOWQdh9PG7ymKudi+ZNTx83FpwfG+0WK+f2oIxM5hirKpbSEbyLjjJ9Y3jF4UqOwLvSaT/swOoHL2ZukobmJtiGypgaxY+N8kT8MH7qofdKSk+s5Yyw1fKpDVEEnU4MpOE18fqOt1sO7SDsy5BKiGXvoLfrbZinEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=UjBa+zEx; arc=none smtp.client-ip=35.162.73.231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781868293; x=1813404293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w42M3LnJxIH+VV7zTVmo6Cxkvmq+b+O1y2iBFIzo9sA=;
  b=UjBa+zExB/SkEMxAyhcR3K0s3oXOOjihOzQHQiiocduwj4gwntlh/TLY
   GiKvLMuFDixzPOHvT9PtS3RzEM/70+M7Rc6MULBIiMa57oQXMFoHZbCYd
   MQwdLnL2mboKC7dKbs8P+fUaOCL+m9bmzu8Wef2+FFSIQbcThuUJb25IB
   74hMeCr5CR4OKNc4J2XYSIxCnsK47PQ/cN8syFSXToxcbXqyXwK3H+XIn
   SvCLB+N63dWJIMl+2K4kqigFXI5TF/AnpuEoQqxGy4evnu/rRDpvcwBga
   8pUEEX2EbzsJB6ypYXpU9gpqax1ynlWfcn8s7CyIXrLqx69BUYNw8Edic
   Q==;
X-CSE-ConnectionGUID: frGJtwiKT9qydUkksS+71g==
X-CSE-MsgGUID: 7WcsJXOYTfa/dnpzFuyN0g==
X-IronPort-AV: E=Sophos;i="6.24,213,1774310400"; 
   d="scan'208";a="21879501"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 11:24:50 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:11622]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.143:2525] with esmtp (Farcaster)
 id d906945f-d6c9-4bad-8c7c-cec9b80d97a3; Fri, 19 Jun 2026 11:24:49 +0000 (UTC)
X-Farcaster-Flow-ID: d906945f-d6c9-4bad-8c7c-cec9b80d97a3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 19 Jun 2026 11:24:49 +0000
Received: from dev-dsk-mheyne-1b-8cc83676.eu-west-1.amazon.com (10.13.235.223)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 19 Jun 2026 11:24:47 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: <stable@vger.kernel.org>
CC: Maximilian Heyne <mheyne@amazon.de>, Shuah Khan <shuah@kernel.org>, "Wei
 Yang" <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Christian Brauner <christianvanbrauner@gmail.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests: uevent filtering: don't shrink the socket buffer
Date: Fri, 19 Jun 2026 11:24:29 +0000
Message-ID: <20260619-get-swam-a1cd4cca@mheyne-amazon>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.de:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267375-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:dkim,amazon.de:email,amazon.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:mheyne@amazon.de,m:shuah@kernel.org,m:richard.weiyang@gmail.com,m:akpm@linux-foundation.org,m:reddybalavignesh9979@gmail.com,m:davem@davemloft.net,m:christianvanbrauner@gmail.com,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mheyne@amazon.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amazon.de,kernel.org,gmail.com,linux-foundation.org,davemloft.net,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheyne@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AE736A5696

The uevent_filtering test shrinks the uevent socket buffer to 4 KB
although the default socket buffer size is much higher. This leads to
this test being flaky when too many unrelated uevents are fired on the
machine. They might fill up the netlink receive buffer leading to
ENOBUFS errors when trying to receive the uevents.
For example, I could trigger test failures when running triggering a lot
of udev events in the background:

  $ # run multiple of that in the background:
  $ while :; do sudo udevadm trigger --action=change; done &
  $ sudo ./uevent_filtering
    # Starting 1 tests from 1 test cases.
    #  RUN           global.uevent_filtering ...
    add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=304458
    add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=304471
    add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=304481
    add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=349156
    No buffer space available - Failed to receive uevent
    # uevent_filtering.c:463:uevent_filtering:Expected 0 (0) == ret (-1)
    # uevent_filtering: Test failed
    #          FAIL  global.uevent_filtering
    not ok 1 global.uevent_filtering

The default receive buffer size (SK_RMEM_MAX) is far larger than the
requested 4 KB, so keep this to make the test less flaky.

Fixes: 9d3df886d17b ("selftests: uevent filtering")
Cc: stable@vger.kernel.org
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 tools/testing/selftests/uevent/uevent_filtering.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index 974b076f9235..dd3549faf5db 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -78,7 +78,6 @@ static int uevent_listener(unsigned long post_flags, bool expect_uevent,
 {
 	int sk_fd, ret;
 	socklen_t sk_addr_len;
-	int rcv_buf_sz = __UEVENT_BUFFER_SIZE;
 	uint64_t sync_add = 1;
 	struct sockaddr_nl sk_addr = { 0 }, rcv_addr = { 0 };
 	char buf[__UEVENT_BUFFER_SIZE] = { 0 };
@@ -96,13 +95,6 @@ static int uevent_listener(unsigned long post_flags, bool expect_uevent,
 		return -1;
 	}
 
-	ret = setsockopt(sk_fd, SOL_SOCKET, SO_RCVBUF, &rcv_buf_sz,
-			 sizeof(rcv_buf_sz));
-	if (ret < 0) {
-		fprintf(stderr, "%s - Failed to set socket options\n", strerror(errno));
-		goto on_error;
-	}
-
 	sk_addr.nl_family = AF_NETLINK;
 	sk_addr.nl_groups = __UEVENT_LISTEN_ALL;
 
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


