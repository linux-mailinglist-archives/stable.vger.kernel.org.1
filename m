Return-Path: <stable+bounces-254436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNqhLX/0FWqzfwcAu9opvQ
	(envelope-from <stable+bounces-254436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:29:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AF35DBFF5
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E54D3044817
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8513C060E;
	Tue, 26 May 2026 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="PFK9vFmY"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687C033FE33
	for <stable@vger.kernel.org>; Tue, 26 May 2026 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823497; cv=none; b=Yqz23ukT28nL8LqpH+QvI+CFcJ1ZCha8Bc8P2sgvhwsjgqdMZCTvcG0U86OlkhlCHxkQ1bDvNr17bDJo3dfNzF9kIIldTIhiRtMwiBSh+PJvuVIRx6lFZlyDmBbrG4hfa7LsTU11TMJf/3fVaEmw36wyrS85iTVTXSv5JNy9Dz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823497; c=relaxed/simple;
	bh=aYQIkyU23+2ZGQtlNcUqvPc9cbtwx1pJGKOT34fPbRM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h61m69U1d6rejj/UmCAQKYM3ic/vChMsCZC31QR+boQMBZXY81oP5JoWjZ6D5wi7CR1xszf+xSA2I7IAxq/EhIzNZvvJ+ymva/camGYW6/zsoSS5httSv7KENeOgQjasj5AsCjz0WOWE0XOiB7kou3KTDhXPtz9JwtMq1I7LwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=PFK9vFmY; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779823496; x=1811359496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QI5pqrgQZausjaud47QeEyBjvOaVr93foW8MP2UsAr4=;
  b=PFK9vFmY4ior8RTKqDoLNxwBNIVxWe5rwXBnqBBCa4h1A7gLmy+LJh5A
   1v6i2QT4TXq8FRFTl/mXwca4cwL9FQwDDDqkqFWT5lHOAjoPBA2gFJXI2
   HleCJlb3wgjTRR/09H2C14zUNuyglT1/UuXC9ofwMRDhJs3wlkDNPOmId
   WX2l09fm1o0ZP/Dty4PPeJND10MjDEa6/GPiaAhnWUP5jWBFhOqPwtU1G
   CVtfMk65ZzZ9cVmdHcU2I7w8SS0YaBguvmR2434kIgF2xcwsZQBaYPODd
   2RQjYBziZ8vbCPQfmUcVUsuLPSS9XAaBoZZMsnRSzHGTX3OyJohDddk5V
   A==;
X-CSE-ConnectionGUID: NpGOqmOKT4O8b/HvBdWj/g==
X-CSE-MsgGUID: QHubuRbaT4yEgHZ5sWUsoQ==
X-IronPort-AV: E=Sophos;i="6.24,170,1774310400"; 
   d="scan'208";a="20301174"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 19:24:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:5449]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.252:2525] with esmtp (Farcaster)
 id 752a9f20-8217-4266-8697-8272c09e7d45; Tue, 26 May 2026 19:24:55 +0000 (UTC)
X-Farcaster-Flow-ID: 752a9f20-8217-4266-8697-8272c09e7d45
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:24:53 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:24:52 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: <lukas.bulwahn@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: [PATCH 6.12] arm64: Kconfig: Remove selecting replaced HAVE_FUNCTION_GRAPH_RETVAL
Date: Tue, 26 May 2026 19:24:40 +0000
Message-ID: <20260526192440.81431-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254436-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazon.de:email,amazon.de:mid,amazon.de:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gyokhan@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 02AF35DBFF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

commit f458b2165d7ac0f2401fff48f19c8f864e7e1e38 upstream.

Commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
replaces the config HAVE_FUNCTION_GRAPH_RETVAL with the config
HAVE_FUNCTION_GRAPH_FREGS, and it replaces all the select commands in the
various architecture Kconfig files. In the arm64 architecture, the commit
adds the 'select HAVE_FUNCTION_GRAPH_FREGS', but misses to remove the
'select HAVE_FUNCTION_GRAPH_RETVAL', i.e., the select on the replaced
config.

Remove selecting the replaced config. No functional change, just cleanup.

Fixes: a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Link: https://lore.kernel.org/r/20250117125522.99071-1-lukas.bulwahn@redhat.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f487c5e21e2f..d4ebdc16cdb4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -219,7 +219,6 @@ config ARM64
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_GRAPH_RETVAL
 	select HAVE_GCC_PLUGINS
 	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && \
 		HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


