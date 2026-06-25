Return-Path: <stable+bounces-268545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VINqB70uPWpryggAu9opvQ
	(envelope-from <stable+bounces-268545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:35:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0F06C62C5
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:35:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b=Iubw0+xx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268545-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268545-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EA5630D9945
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EED32ED55;
	Thu, 25 Jun 2026 13:33:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037532B99E;
	Thu, 25 Jun 2026 13:33:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394395; cv=none; b=a8MAxG5TPTqzQ3cr3pNItWMdTN4B6TyTY0XFql4txGMvWa8JTfz2X1xnmeyieXQTm+Ms9F+6JYkpSvbNv2KTw4MJGnMriLDVZ07XBT2Qh6hGYYHHZ/x8YZcXLbz8Ub1iawYxTQnwl+0qROtCnJfyirOMia6jwMF6RDN1XzQX+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394395; c=relaxed/simple;
	bh=SXhUwl+laSI9u/4qk/+IskF6bDfbnxjEkCdnyyGQ8hw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGWBwzM6GmzxhfcawCi9+Hz6DzaNUpCZiSzjmxneZ52qUwm6Hax2B/pkYZusHXU7jqBQeBW1Pxo0pXzIF6akevPAab1Q49iI0IVV+mzilUlDiVP1R/ZYw6mTkDzYpO0L+Kz3LyKKIurYJksMEaxgIDDrJQo6frjjjpe8Z7JRMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Iubw0+xx; arc=none smtp.client-ip=35.155.198.111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1782394393; x=1813930393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Pi1Ori/UusSIX4A+OO709SsxBMpol/iraNZc5CkFgM=;
  b=Iubw0+xxprPE/jeZIhDTHTfgMZno8K8xJqcCVubnu2xxvM8p1dj3x0j/
   04KRfFsZAXeA2aycRCeWciZTekogRohPQ/JKjXLkGHYX222w9BcCaAifT
   tF3e11JZW/Es2lfznQ+aj3jeckAC+ANjGKDVE8WBoztrcmswJ6zUpAneV
   s3aHsk3y23GNdnM2mKA8oKx+M2kVHyjjZcDaaLcwd2mRCxsMk/YKg8Zy6
   h/yVt/juo3Ac0ERUPHop8N67e4QKbQYJ2DhhfAcCX7BDTtyLnkntCY1j3
   yfnMX4rGFak5Dw63FZ0Co62xNGgNgsUUBp/lnKj8Lwh3MCgacN9GHCrcT
   g==;
X-CSE-ConnectionGUID: ePwdvc6dSKadaXm6e8pX8Q==
X-CSE-MsgGUID: cyEeNFEmQX+jt2p593ydzA==
X-IronPort-AV: E=Sophos;i="6.24,224,1774310400"; 
   d="scan'208";a="22378713"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 13:33:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:12286]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.116:2525] with esmtp (Farcaster)
 id 678a7bb4-0869-42dd-8705-9e4ab771808f; Thu, 25 Jun 2026 13:33:11 +0000 (UTC)
X-Farcaster-Flow-ID: 678a7bb4-0869-42dd-8705-9e4ab771808f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 25 Jun 2026 13:33:10 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 25 Jun 2026
 13:33:08 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, Simon Liebold <simonlie@amazon.de>, Ian Rogers
	<irogers@google.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>
Subject: [PATCH 6.1.y 2/2] perf block-range: Move debug code behind ifndef NDEBUG
Date: Thu, 25 Jun 2026 13:32:22 +0000
Message-ID: <20260625133222.3412820-3-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260625133222.3412820-1-simonlie@amazon.de>
References: <20260625133222.3412820-1-simonlie@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268545-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[simonlie@amazon.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:namhyung@kernel.org,m:simonlie@amazon.de,m:irogers@google.com,m:linux-perf-users@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:adrian.hunter@intel.com,m:pbonzini@redhat.com,m:seanjc@google.com,m:acme@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:dkim,amazon.de:email,amazon.de:mid,amazon.de:from_mime,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,arm.com:email,infradead.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simonlie@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A0F06C62C5

From: Ian Rogers <irogers@google.com>

[ Upstream commit 984a785f25e5b5db5fa673130b60dca6ca794406 ]

Make good on a comment and avoid a unused-but-set-variable warning.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20230330183827.1412303-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 616b14b47a86 ("perf build: Conditionally define NDEBUG")
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 tools/perf/util/block-range.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.c
index 1be4326575013..680e92774d0cd 100644
--- a/tools/perf/util/block-range.c
+++ b/tools/perf/util/block-range.c
@@ -11,11 +11,7 @@ struct {
 
 static void block_range__debug(void)
 {
-	/*
-	 * XXX still paranoid for now; see if we can make this depend on
-	 * DEBUG=1 builds.
-	 */
-#if 1
+#ifndef NDEBUG
 	struct rb_node *rb;
 	u64 old = 0; /* NULL isn't executable */
 
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


