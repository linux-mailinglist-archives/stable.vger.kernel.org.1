Return-Path: <stable+bounces-183438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305FBBE5A4
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A243BFC3C
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ABE199385;
	Mon,  6 Oct 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCRaY8Qx"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730411DFFC
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761075; cv=none; b=bLcTzsY5NYiCUFzYaXCaXWVGBLEZD40wSl4ub0tx3VbZK1XbaBdAf6Nl9DvgXpAysgIxFByHCgWvKVBnzLDIq6/ZgkdGWZFIGB2F0DmdPLb3U+hsmJCndRI56+z7xs08ad72w4CHXEKb8fx2tJr+uNuYgNJ28PXc0+z0O49VwZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761075; c=relaxed/simple;
	bh=xXvB05+JXWunM/ZZ7+8SH3cVZRqU/GJnOV4tEaSXfi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dx3HDkmFIklaXMuhmNX4BEm3NmfcM5krHnSDNEjN2TRkKmTbxbhph5cBmohJ8TBXWxlB/kLu06hW+eTd0q6SMXVBCCxmBaCyU78icrgZGJse8RXayHtBsIQQJnrOEE+EuDJ8ZIrCI/oaRvlQK9ETd0VSPdvpqxjMTBaLO9tOaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCRaY8Qx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759761071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WG6rfa392OPZRww4x0r3OSF9GJZW1H33YuysnWkj2NU=;
	b=RCRaY8QxW23wpHTlOjnM3JSXfBk0WfyFUV3bxDQmA+ze6A3FB281a0Mxbx6oG6Dbl6aEoG
	3St/Ppog6B9FSqa5m5lJpDWc7Gg2Wy0HldQsP4OUQi7Bq164DBqEhyZ+q6MNQxwdLjZxc0
	/PDtDjhXhCHPEXXEv3TbvV29sRrKfjg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-0KhC7PTiM0mByPq9ZE3GDQ-1; Mon,
 06 Oct 2025 10:31:10 -0400
X-MC-Unique: 0KhC7PTiM0mByPq9ZE3GDQ-1
X-Mimecast-MFC-AGG-ID: 0KhC7PTiM0mByPq9ZE3GDQ_1759761068
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1903A195608F;
	Mon,  6 Oct 2025 14:31:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D9B81955F19;
	Mon,  6 Oct 2025 14:31:04 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] rtla/timerlat_bpf: Stop tracing on user latency
Date: Mon,  6 Oct 2025 16:31:00 +0200
Message-ID: <20251006143100.137255-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

rtla-timerlat allows a *thread* latency threshold to be set via the
-T/--thread option. However, the timerlat tracer calls this *total*
latency (stop_tracing_total_us), and stops tracing also when the
return-to-user latency is over the threshold.

Change the behavior of the timerlat BPF program to reflect what the
timerlat tracer is doing, to avoid discrepancy between stopping
collecting data in the BPF program and stopping tracing in the timerlat
tracer.

Cc: stable@vger.kernel.org
Fixes: e34293ddcebd ("rtla/timerlat: Add BPF skeleton to collect samples")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat.bpf.c b/tools/tracing/rtla/src/timerlat.bpf.c
index 084cd10c21fc..e2265b5d6491 100644
--- a/tools/tracing/rtla/src/timerlat.bpf.c
+++ b/tools/tracing/rtla/src/timerlat.bpf.c
@@ -148,6 +148,9 @@ int handle_timerlat_sample(struct trace_event_raw_timerlat_sample *tp_args)
 	} else {
 		update_main_hist(&hist_user, bucket);
 		update_summary(&summary_user, latency, bucket);
+
+		if (thread_threshold != 0 && latency_us >= thread_threshold)
+			set_stop_tracing();
 	}
 
 	return 0;
-- 
2.51.0


