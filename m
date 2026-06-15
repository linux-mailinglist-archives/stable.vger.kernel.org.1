Return-Path: <stable+bounces-263422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z549JaU7MGrzQAUAu9opvQ
	(envelope-from <stable+bounces-263422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:51:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA0C688F92
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:51:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=Nj8ARF20;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263422-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263422-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F3830DBAB5
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AAC2FFF90;
	Mon, 15 Jun 2026 17:49:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803124E4B4;
	Mon, 15 Jun 2026 17:49:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545770; cv=none; b=rIkVzHA7PiFfcSG9n9Je/UeUsieS5Ls7X+HMEWMXePsCx1clltfX9APtITiDlbbR7s28oz2LkGq0WIu/0fHztqG2TrDNjgLUOxX4w4K8beMPis1/LHh3gJ++4N873sp3+jNAuCOL+hR8AWbFDKK5DWY4ZeQtLA70CBtwlG05F7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545770; c=relaxed/simple;
	bh=pUQT9CsXT8CQUM/Dgn56GXDZkIOsLy2lpBqCJ8T2PEs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sQNJQQuV1aGIB7vLd+UiZZWk+2tppJGiO0wXYBu3OQSNRUkB0BLFk1Pwup9AbdjsFhsjuypNrP80bzrvY1ggQptqTUs9zgFrysbt8AipNZTDXJytk21SCRUk6aAK2Zs5opWFgkA2x3k+rMRI58sRHGGMdLJqN6KTIjJVxD5W2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Nj8ARF20; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=5wvmPgyc9uvgveJA+YngPrzTpU2IXWeRQ7fyKgf6vHY=; b=Nj8ARF2067PXREHbUlqIJHoaAe
	YGdSpe8jfqxPP5JnJu0bDglAAZHWDB4Mq9VUu2+GJfsxZql3w+B4QE688kOuVCGitBKHxkZW09H6T
	cscGnH0OUrlk3nYloF0HmTaNbcjg44mdig8Q1kv9aVcol4H04EYOeEMMnFibFqiPsukSOa8YETwom
	yhMKc9GxJGUG1lko8XrX3BQZei28b896xmAfnhnd97O7S9TSCNOi9JgQRTcADukiIrf5i/MfMD4lH
	LGDvZKNqKnKCIFdEOTW70HszHlbwFbhLuKs1QsmjVpPLpxiyPN2fmQv5quxD6jwlh6V2v0emSyjKn
	kX3cUkeQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZBR4-00DFK1-1F;
	Mon, 15 Jun 2026 17:49:22 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v3 0/3] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Date: Mon, 15 Jun 2026 10:49:05 -0700
Message-Id: <20260615-kmemleak-stack-resched-v3-0-acecd7d7fd92@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABE7MGoC/4XNyw6CMBBA0V9pZs2YdnhVVv6HcVHpAA3ySEsaD
 eHfDax0YdzexbkrBPaOA1RiBc/RBTeNUIk0EVB3ZmwZnYVKAEkqZKEU9gMPDzY9hsXUPXoOdcc
 WpWJbks61KRtIBMyeG/c84OstEdC5sEz+dXyi2utfMipUaAvKtLGcN5m5WL47M54m38JuRvp06
 KdDqDBPKZOWyzNr/eVs2/YGBXSWSgUBAAA=
X-Change-ID: 20260611-kmemleak-stack-resched-01ed72858a7f
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev, 
 Davidlohr Bueso <dave@stgolabs.net>, Oleg Nesterov <oleg@redhat.com>, 
 Qian Cai <cai@lca.pw>
Cc: oleg@redhat.com, sj@kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=leitao@debian.org;
 h=from:subject:message-id; bh=pUQT9CsXT8CQUM/Dgn56GXDZkIOsLy2lpBqCJ8T2PEs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqMDsepC4qV9HPAOcAmwK8L4No+fcaNcYc3M2f7
 8G7+Mr5AcCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajA7HgAKCRA1o5Of/Hh3
 beIoEACt/P86zHel9broPJBl8+3GHNLaWYYbBFpq+ykw9PWO6KYvjuO+UfsHa6mYOdvpTxkT+sK
 7KqkG78hRw9qAgz/nvMoUa0R/E5bg8bUIJXUtUr0GjCgjLFg91gcQJqBqW+eoUa3AKhoLG6g18W
 Uwlnc8jzV5e3LVtWuZVQIyTU+YWeD1a/ZcwQqYIus9vlnAzTOEnZM/b92lqs3hHt9hE5RfG6f9x
 P/gn/56B096qeREstMBIEL1/YZ53Rpql86LLUgsZyL7xiANpGk+Asaiw+V0CbugYJx6BlXFEyCN
 Br2ePNIyOMBZBhzyMZoJHAYs+0GuOOcGysB6+HCOp43OetvB7dci2ac6U5/g0fOWcoLx9zeIZvF
 7ZvE6aPIhiuW7TD7Gu0mtFLAKn0Z/e/RDR/0aPfW96SPI/Dwu2jFmTxbjyUqUmI02vZVQagQtmw
 0jsZtwtuh9k2+vdp/LR9KugkM5V8LRRv05i9Tu/upv05kr3WH39r9B0NryVMSGfKMgJUKhtTSsd
 zug5dtJSujBwrNTZKVqC5wPz/sT59jXph2sP539gonJDwa8+uzh3k6+aXvvFatwq0sCgOSB0NLC
 Hi0fIXE9FBu3N7yQPFP8/9KPogcrJVPeLve2O2JrCGGTXZJSAYHSuTVJt60QWBzQsMc9lRKDp/N
 VvwJNnhIspXqeSA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:catalin.marinas@arm.com,m:akpm@linux-foundation.org,m:lance.yang@linux.dev,m:dave@stgolabs.net,m:oleg@redhat.com,m:cai@lca.pw,m:sj@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-263422-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AA0C688F92

kmemleak_scan() scans every task stack under one rcu_read_lock() with no
reschedule point, which can trip the soft lockup watchdog on hosts with
very many threads.

That prints the following message, depending on the workload+host
configuration:

      watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
       scan_block
       kmemleak_scan
       kmemleak_scan_thread
       kthread

Patch 1 walks the tasks with find_ge_pid() so the scan reschedules between
tasks

Patches 2-3 let the scan loops stop early once a scan is interrupted.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v3:
- Rework the task stack walk to use find_ge_pid() instead of v1's array
  and v2's rcu_lock_break() helper (Catalin).
- Add two follow-up patches letting scan_block() report an interrupted
  scan so the scan loops stop early.
- Link to v2: https://lore.kernel.org/r/20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org

Changes in v2:
- Do not create the nasty array, but use the same pattern as
  kernel/hung_task.c.
- Link to v1: https://lore.kernel.org/r/20260611-kmemleak-stack-resched-v1-1-d6248ade5f4a@debian.org

---
Breno Leitao (3):
      mm/kmemleak: avoid soft lockup when scanning task stacks
      mm/kmemleak: stop the task stack scan early when interrupted
      mm/kmemleak: stop the per-cpu and struct page scans early too

 mm/kmemleak.c | 88 +++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 23 deletions(-)
---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260611-kmemleak-stack-resched-01ed72858a7f

Best regards,
-- 
Breno Leitao <leitao@debian.org>


