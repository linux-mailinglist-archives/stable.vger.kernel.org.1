Return-Path: <stable+bounces-62453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C966B93F294
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829C82820D7
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E5143C75;
	Mon, 29 Jul 2024 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wvvq/LAK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T5mN0OGu"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C5D1448C7;
	Mon, 29 Jul 2024 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248693; cv=none; b=ClBwnt0CcABdx+BQndaaKRE5XC7PiABu5c+v4kDOJVSeiTvW8pXdUzthJRYSiiwkHYR9YHkWnLfj0hcbRy+VGINCe5n3UFTprSkuU1lonlr+g/sfVhQqq6tV/xTFlhuyejiVvvYOYRgp6/nx+OxeHDk67s/FQGYcRdB6rcPUc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248693; c=relaxed/simple;
	bh=at8u3DJ8ldslYFHKUFh5EDZh0NrJ9Pu5WUoQK6V+vDg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gxSqlZOmEBy918G53sXXyWn5Lfucc14A9Oaa/SGKJwGew1IbqbZh2RX9yD/udsXSpYgNhooIUwyOvgbzObWq3KCO/AwhSoXjLpbkgbeYD986H/dm8uVveZABC/bGYJj8P82Phqe+JGNZidxdMHM8LpIz6sPvtw2ORpk7OVuwWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wvvq/LAK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T5mN0OGu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:24:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722248689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BVrPkutTcpIwTGJOb+VN/yLfSss6WtwpS1OtXXSDe4=;
	b=Wvvq/LAK7mcOFKOBz8BlQyspWMTtvaa9vveSWkKOnw66rq5L0oKAyN8hdTlklxalA9YVvl
	10XEoHI5lg67F6kdiW9oJzeEddYsUi+NG+MTlrgGu4XXGQqU77aX3AgzgMa8Tw4mxh9kiF
	txpj+aupDvIRQYa5od7pkniKDAbGQlyA45sXEoKvOfzrbxpHYp1FVbXKsDHWcnXSjOyGwo
	d5QllJTVSPH0UjlV4g6km3JovRh3rkrEsGNVTOYOga3t7mW5Szf7eGBK3O5+TZI7VVD8dW
	KgpCwgQb2oTl/+y6j/kHmsBMjEg80Z3OOeGG7abaq7RIL5VBwNC9wMKkLWa9Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722248689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BVrPkutTcpIwTGJOb+VN/yLfSss6WtwpS1OtXXSDe4=;
	b=T5mN0OGuGu47yhOzJDlb7kjoEzl1RBVU4F/Mk6/pk21xWpwhdGj/it1NZxHOYqJDLnnx11
	Jc7t037lntmVD6Bw==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Fix sampling synchronization
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240715160712.127117-2-adrian.hunter@intel.com>
References: <20240715160712.127117-2-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224868902.2215.217749808171783560.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d92792a4b26e50b96ab734cbe203d8a4c932a7a9
Gitweb:        https://git.kernel.org/tip/d92792a4b26e50b96ab734cbe203d8a4c932a7a9
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 15 Jul 2024 19:07:00 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:16:24 +02:00

perf/x86/intel/pt: Fix sampling synchronization

pt_event_snapshot_aux() uses pt->handle_nmi to determine if tracing
needs to be stopped, however tracing can still be going because
pt->handle_nmi is set to zero before tracing is stopped in pt_event_stop,
whereas pt_event_snapshot_aux() requires that tracing must be stopped in
order to copy a sample of trace from the buffer.

Instead call pt_config_stop() always, which anyway checks config for
RTIT_CTL_TRACEEN and does nothing if it is already clear.

Note pt_event_snapshot_aux() can continue to use pt->handle_nmi to
determine if the trace needs to be restarted afterwards.

Fixes: 25e8920b301c ("perf/x86/intel/pt: Add sampling support")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20240715160712.127117-2-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index b4aa8da..2959970 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1606,6 +1606,7 @@ static void pt_event_stop(struct perf_event *event, int mode)
 	 * see comment in intel_pt_interrupt().
 	 */
 	WRITE_ONCE(pt->handle_nmi, 0);
+	barrier();
 
 	pt_config_stop(event);
 
@@ -1657,11 +1658,10 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 		return 0;
 
 	/*
-	 * Here, handle_nmi tells us if the tracing is on
+	 * There is no PT interrupt in this mode, so stop the trace and it will
+	 * remain stopped while the buffer is copied.
 	 */
-	if (READ_ONCE(pt->handle_nmi))
-		pt_config_stop(event);
-
+	pt_config_stop(event);
 	pt_read_offset(buf);
 	pt_update_head(pt);
 
@@ -1673,11 +1673,10 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 	ret = perf_output_copy_aux(&pt->handle, handle, from, to);
 
 	/*
-	 * If the tracing was on when we turned up, restart it.
-	 * Compiler barrier not needed as we couldn't have been
-	 * preempted by anything that touches pt->handle_nmi.
+	 * Here, handle_nmi tells us if the tracing was on.
+	 * If the tracing was on, restart it.
 	 */
-	if (pt->handle_nmi)
+	if (READ_ONCE(pt->handle_nmi))
 		pt_config_start(event);
 
 	return ret;

