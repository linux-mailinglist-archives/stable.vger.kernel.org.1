Return-Path: <stable+bounces-268543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PrI6NnUuPWpdyggAu9opvQ
	(envelope-from <stable+bounces-268543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:34:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9926C62A4
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:34:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b=UQXe19AS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268543-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268543-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56A6F303457B
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A3632E128;
	Thu, 25 Jun 2026 13:33:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0632B99E;
	Thu, 25 Jun 2026 13:32:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394380; cv=none; b=CCD+7ux6M/+daVBMw/B3fRUJYwsOeatCt3M/XsyqYXuj2UeVEb5dq3bhIdEQ/It86/fzPPPAfT4jC8YzFUqiHTkzLewP8V/KGD7wLzU7yZ4xctgOhtT+xgYxaXQn1z3BtU93JqcsMGt0zhM7/7GLUVJMlWG/KTfvyGrotMefshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394380; c=relaxed/simple;
	bh=uinX7VfrDcyCLlZv5BCWfLiMKRCkJYGjqcTraIDeyo0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mruyY5Oqm2y7m3MTbfwPOD+zlaLOokhVZFQeDEXuYKCIUdR6TPoaTemq+aNizHCZWenfXkL4KszbqCpgr2ygg2kWQc3RpgPy7L4Hh9ByphLjq/pksrtDPMz+Cn0vcB/QiudVg4rsqddeILrhX6+zPss8CFTlRCvxq8DN2PcH0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=UQXe19AS; arc=none smtp.client-ip=35.83.148.184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1782394379; x=1813930379;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jhzw3hDe1qETvRMOXpQ3ufg25Aa3Q0kmNblxIpF9o3Q=;
  b=UQXe19ASWa5y/BwYwpbWinyfCvHMrvn4jTCA/RZij96wKI6NCTgIlSVz
   NmHPHK3yR+fUeyrD7T0eCSd/J5ukhHn9EbJdg+3Qt8kpLcfTWT9RlYPdX
   fh4x5ksJn1GT0QO1d44LSHRBQv8OTcvc89Tly1fY7qPV1kcLpZqncenU/
   0i+kPqAPha2HC8+klz/b8AeUGmaUlxFrNPtKbWIAvzkNqtTSZGcxxn6bT
   cQJ5IN3LZ7WySB1qUka45H4zQCJ27C7SeeHGV91qsf8994aHJKio92iA1
   NFR8gXPoHWXL4SdcBVYlzEt/7JTT03G+yCgp0nsFU3XMOtnaQ0UsJBWjl
   w==;
X-CSE-ConnectionGUID: 3i4i2+ppRnS1kTJFipTfdg==
X-CSE-MsgGUID: qLUHoCpdRjCzC4F5/UTbCQ==
X-IronPort-AV: E=Sophos;i="6.24,224,1774310400"; 
   d="scan'208";a="22277557"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 13:32:56 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:20069]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.142:2525] with esmtp (Farcaster)
 id 4af665ad-abdf-4f6c-942e-bae9622621b0; Thu, 25 Jun 2026 13:32:55 +0000 (UTC)
X-Farcaster-Flow-ID: 4af665ad-abdf-4f6c-942e-bae9622621b0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 25 Jun 2026 13:32:55 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 25 Jun 2026
 13:32:53 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, Simon Liebold <simonlie@amazon.de>, Ian Rogers
	<irogers@google.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.1.y 0/2] Backport dependency commits for 616b14b47a86 ("perf build: Conditionally define NDEBUG")
Date: Thu, 25 Jun 2026 13:32:20 +0000
Message-ID: <20260625133222.3412820-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.de:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268543-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[simonlie@amazon.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:namhyung@kernel.org,m:simonlie@amazon.de,m:irogers@google.com,m:linux-perf-users@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazon.de:dkim,amazon.de:mid,amazon.de:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simonlie@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B9926C62A4

Hi, please backport the following two patches to 6.1.y:

- d1babea9c382 ("perf bench: Avoid NDEBUG warning")
- 984a785f25e5 ("perf block-range: Move debug code behind ifndef NDEBUG")

They are stable dependencies for commit 616b14b47a86 ("perf build: Conditionally
define NDEBUG") which was backported to v6.1.176 as 7bf35a0237d04.

That commit adds -DNDEBUG=1 to perf CFLAGS, which compiles out assert() calls,
leaving variables consumed only by asserts as unused-but-set. Combined with
-Werror this breaks the build:

    bench/find-bit-bench.c:64:22: error: variable 'old' set but not used
    util/block-range.c:20:13: error: variable 'old' set but not used

We need these two dependency patches, because both guard assert-only variables
with #ifndef NDEBUG so they are compiled out alongside the asserts they
validate.

Tested using our regression test suite including kselftest and LTP on various
EC2 instances.

Thanks.

- Simon

Ian Rogers (2):
  perf bench: Avoid NDEBUG warning
  perf block-range: Move debug code behind ifndef NDEBUG

 tools/perf/bench/find-bit-bench.c | 8 ++++++--
 tools/perf/util/block-range.c     | 6 +-----
 2 files changed, 7 insertions(+), 7 deletions(-)


base-commit: fdb6fcb41cc741ad5eaa7995f278dfcb94fdf795
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


