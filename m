Return-Path: <stable+bounces-233842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK7AIsY21mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:06:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0DC3BB142
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07B00301049D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A2437B41C;
	Wed,  8 Apr 2026 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl58i5yK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A12BDC0F
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646401; cv=none; b=HyJm6iBwEBEvSV5l3kzivgnjln0Oqqk2PpnaERsfFXlhPYEQ93QaH6z1tUZZR1uzj/k8Hy3Y8jW3kfqXwmZTUV22e2KJ3/QggojOPvJxoUbLMycVJd3zOVMdFwTlWLIfMcihovmYeapgBXyejujkfdnqY3YSSVak1YTmny7TR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646401; c=relaxed/simple;
	bh=pBrD4afcANre54gA36dUEi53tM1+f9fe/BaysZUHtyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1UFWMva1p6O9KS9nB+4h9/XQy1q1m5BZip798UkEd2ASlsdyOgjJdx2SDaDD7z1LDmR1evOjx++RZ+N1TCsmxP8ateiigyy0ceDkmFg+AZ9NagkB6zRZFfG9K5OdhGik0SwWzFgIE2lVgwolwjqK1CszpwMDHDXEh0n/V9favc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl58i5yK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD93C19424;
	Wed,  8 Apr 2026 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775646400;
	bh=pBrD4afcANre54gA36dUEi53tM1+f9fe/BaysZUHtyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zl58i5yKxYE5pxKdNvYriLlD3eZRjAxjDbEGzYCMU+9cXQe61TV6EQEJuTUaK9vAe
	 suy/qeWlhOakBDwB5ZOfdFJR4fJICAjuApRuut08eT345+jfq7Aet1H/qMPUqRZvwn
	 j9zVbbCoEymVYASbQ35mvuIsIEIL/xv2KjbOBQiN2gR3afHQLXNs9/p4KBaDcJd2tI
	 ws7DwkRt2Wm3ZW3dw5ouszKxqd9JOCBTFjmp3ldT+ecBkTn5id/XLA3vQJM9N8SUrf
	 13R0DBHvdmZZskO0cHJN8xKFG7ryWzfNSMiwftr6KP7YQeTR08QsmZcuA8fCURAMUg
	 EB5EaaLey7DdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] s390/cpum_sf: Cap sampling rate to prevent lsctl exception
Date: Wed,  8 Apr 2026 07:06:37 -0400
Message-ID: <20260408110637.978601-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408110637.978601-1-sashal@kernel.org>
References: <2026040840-running-plethora-7f54@gregkh>
 <20260408110637.978601-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233842-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A0DC3BB142
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 57ad0d4a00f5d3e80f33ba2da8d560c73d83dc22 ]

commit fcc43a7e294f ("s390/configs: Set HZ=1000") changed the interrupt
frequency of the system. On machines with heavy load and many perf event
overflows, this might lead to an exception. Dmesg displays these entries:
  [112.242542] cpum_sf: Loading sampling controls failed: op 1 err -22
One line per CPU online.

The root cause is the CPU Measurement sampling facility overflow
adjustment. Whenever an overflow (too much samples per tick) occurs, the
sampling rate is adjusted and increased. This was done without observing
the maximum sampling rate limit. When the current sampling interval is
higher than the maximum sampling rate limit, the lsctl instruction raises
an exception. The error messages is the result of such an exception.
Observe the upper limit when the new sampling rate is recalculated.

Cc: stable@vger.kernel.org
Fixes: 39d4a501a9ef ("s390/cpum_sf: Adjust sampling interval to avoid hitting sample limits")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 62247f20c2163..7d639b7ddc08b 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1188,6 +1188,7 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
 static void hw_perf_event_update(struct perf_event *event, int flush_all)
 {
 	unsigned long long event_overflow, sampl_overflow, num_sdb;
+	struct cpu_hw_sf *cpuhw = this_cpu_ptr(&cpu_hw_sf);
 	struct hw_perf_event *hwc = &event->hw;
 	union hws_trailer_header prev, new;
 	struct hws_trailer_entry *te;
@@ -1267,8 +1268,11 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 	 * are dropped.
 	 * Slightly increase the interval to avoid hitting this limit.
 	 */
-	if (event_overflow)
+	if (event_overflow) {
 		SAMPL_RATE(hwc) += DIV_ROUND_UP(SAMPL_RATE(hwc), 10);
+		if (SAMPL_RATE(hwc) > cpuhw->qsi.max_sampl_rate)
+			SAMPL_RATE(hwc) = cpuhw->qsi.max_sampl_rate;
+	}
 }
 
 static inline unsigned long aux_sdb_index(struct aux_buffer *aux,
-- 
2.53.0


