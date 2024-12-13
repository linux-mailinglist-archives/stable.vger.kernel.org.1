Return-Path: <stable+bounces-104001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3619F0A7A
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FFF16A479
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE401CDA09;
	Fri, 13 Dec 2024 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JunJ3Izr"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C951CCEF6
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088266; cv=none; b=Eb5nJGM6NkjutAI3Laf8IRbN+uDhCtE6EORLcH26SjGXBDCvymJQgJ6dTgJh5+CHt61diJ4Q6M+VEBw3KkdGvfukCNjwCvOITguQZ2mfZybXqGHLLDnpPfZJvEVh8bpR/MP+SWIGClJkXjnbH7aCpOoEKaBQxyQ2U+CJOgx2qxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088266; c=relaxed/simple;
	bh=tPGBoMBRzD7ikTTMKfBPEEwJgcEwa6jH3P0qW9XokKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIVqPbirStAtPlJrNZR27cWYL6Hsja0WJpVjbKui1pCZr2IPAPwzdN1+NfpMzh8XSSkDDn4LL9b3Hkac1VuButR/YWzO1qYr4qUb3QJGnO7O/gUH8JJD5oOQsYCyDNSPYGURaJB7XocPMY3Z9kMDAdKkFD3HpSqUagk7CWru02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JunJ3Izr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734088261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bjFsUOdUkAR3f6+6uKgfu4sz0xxqY9TUQG1ZX7f2nrM=;
	b=JunJ3IzrwrkvwUIHiZG0MM0EDpOEf3DXEwL8GOhv9vRzC35pPd8VdtcLknd92/uWs3zgt7
	oStYto+Ef4kl4mbeh29uju9efSDWA6+3f2Y1vlfTKtp+MP2PDzfri8CM1M6Qywsu9O+/jF
	alNdLXl+lZagtCaqwDEjt3bqq9MAxNY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-d1DEX8ysP2uSSCCyJKd1xg-1; Fri,
 13 Dec 2024 06:10:57 -0500
X-MC-Unique: d1DEX8ysP2uSSCCyJKd1xg-1
X-Mimecast-MFC-AGG-ID: d1DEX8ysP2uSSCCyJKd1xg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 371F919560B3;
	Fri, 13 Dec 2024 11:10:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E72E1955F40;
	Fri, 13 Dec 2024 11:10:54 +0000 (UTC)
From: tglozar@redhat.com
To: stable@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6] rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long
Date: Fri, 13 Dec 2024 12:10:42 +0100
Message-ID: <20241213111042.2550939-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Tomas Glozar <tglozar@redhat.com>

commit 76b3102148135945b013797fac9b206273f0f777 upstream.

Do the same fix as in previous commit also for timerlat-hist.

Link: https://lore.kernel.org/20241011121015.2868751-2-tglozar@redhat.com
Reported-by: Attila Fazekas <afazekas@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[ Drop hunk fixing printf in timerlat_print_stats_all since that is not
in 6.6 ]
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 1c8ecd4ebcbd..667f12f2d67f 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -58,9 +58,9 @@ struct timerlat_hist_cpu {
 	int			*thread;
 	int			*user;
 
-	int			irq_count;
-	int			thread_count;
-	int			user_count;
+	unsigned long long	irq_count;
+	unsigned long long	thread_count;
+	unsigned long long	user_count;
 
 	unsigned long long	min_irq;
 	unsigned long long	sum_irq;
@@ -300,15 +300,15 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 			continue;
 
 		if (!params->no_irq)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].irq_count);
 
 		if (!params->no_thread)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].thread_count);
 
 		if (params->user_hist)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					 data->hist[cpu].user_count);
 	}
 	trace_seq_printf(trace->seq, "\n");
-- 
2.47.1


