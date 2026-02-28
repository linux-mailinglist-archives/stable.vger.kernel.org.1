Return-Path: <stable+bounces-220157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPAoJRAso2mF+AQAu9opvQ
	(envelope-from <stable+bounces-220157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED611C5367
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7659530CF764
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB17B4949FD;
	Sat, 28 Feb 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAVrkk2M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96A4949F4;
	Sat, 28 Feb 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300065; cv=none; b=ED4qeg8O3kUHrTP5nizK8vhWW3TbN+F/DGardwZ37J7RaIeknpxzSAHxJTDRPTBck4+CLeYfjWp4qisFjKMB5ravxfgXawquzkRyM8pWm7STCnBDCoHFqrdMjycEMfSo4AICXDeQmSqz8wJJWmbUEQb2T9W04So/7IXI3E88EGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300065; c=relaxed/simple;
	bh=0MZBtuNaedMgvgH2TwTNzAS+vPFC78vsJmzGEl2nJmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzC2duILn2RjEWTn1/ipHuq8LboZsMeKTYKbwR3lqw0C6JCz1ylCha5UsNkgReSJk18FvPFTvHrK3ILVMAMa9YI9kC6Bz3oAHS+NnNVhCau1yfKXFWcINCb1Ti7bjygmI+IwCuyQ+KCT/c9bVErAQGaU0Px4q2z+eYN4x2L5fF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAVrkk2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83987C19424;
	Sat, 28 Feb 2026 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300065;
	bh=0MZBtuNaedMgvgH2TwTNzAS+vPFC78vsJmzGEl2nJmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAVrkk2MmBfRE1qpxhXWXvJjs0EfHBGK7NAgWgYxe1v2PpsRBUxHwBwQjULLmNV+y
	 GhYA6edTnqIzFMxQJ+2bxwkAKHp7Yc4rFSPeekk//QYSY1cddZMIz7ViYMGZX8Sqml
	 rbZE3VG3MZ3q8PPj2Dc1dxw/3p6BboLY7Lh8qgtLB8EFmZypx2LUit8tsvdB79RB/W
	 srbnoPn1wiRBDNZ6SQQFFvaHSiyvWiz8LXK0hc7k3u0y2b6Dt5f0s2EeXllkltvJDd
	 d3pw6CbSt6LYjNlyqTFsLBB4XOcSiQA8IfEMAz+l7jMFJNYtBUjcCkJm3TcZ6i3H5m
	 v2rb3DcOaAR7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Jan Polensky <japo@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 079/844] s390/perf: Disable register readout on sampling events
Date: Sat, 28 Feb 2026 12:19:52 -0500
Message-ID: <20260228173244.1509663-80-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220157-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7ED611C5367
X-Rspamd-Action: no action

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit b2c04fc1239062b39ddfdd8731ee1a10810dfb74 ]

Running commands
 # ./perf record  -IR0,R1 -a sleep 1
extracts and displays register value of general purpose register r1 and r0.
However the value displayed of any register is random and does not
reflect the register value recorded at the time of the sample interrupt.

The sampling device driver on s390 creates a very large buffer
for the hardware to store the samples. Only when that large buffer
gets full an interrupt is generated and many hundreds of sample
entries are processed and copied to the kernel ring buffer and
eventually get copied to the perf tool. It is during the copy
to the kernel ring buffer that each sample is processed (on s390)
and at that time the register values are extracted.
This is not the original goal, the register values should be read
when the samples are created not when the samples are copied to the
kernel ring buffer.

Prevent this event from being installed in the first place and
return -EOPNOTSUPP. This is already the case for PERF_SAMPLE_REGS_USER.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 459af23a47a5e..e8bd19ac82c7d 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -841,7 +841,7 @@ static bool is_callchain_event(struct perf_event *event)
 	u64 sample_type = event->attr.sample_type;
 
 	return sample_type & (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_REGS_USER |
-			      PERF_SAMPLE_STACK_USER);
+			      PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_STACK_USER);
 }
 
 static int cpumsf_pmu_event_init(struct perf_event *event)
-- 
2.51.0


