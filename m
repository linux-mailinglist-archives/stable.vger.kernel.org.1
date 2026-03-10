Return-Path: <stable+bounces-224205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEwFLbb/r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:25:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C188724AA9A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6C0730588AB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95F2389477;
	Tue, 10 Mar 2026 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkxM5XRJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6FB38946E;
	Tue, 10 Mar 2026 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141659; cv=none; b=e0uh5sSuB6FJYdB5qV1gk9folI3TVK1ZRpf85AzW/s6WsaZLgev0WI/jZ5NcefkfG4NXH9ILnTG2s5ZlW2xqXhJWgA+PAVPr+vk1FiCiX6jwf09wZIaHzGtYmAOJwgFS1yabK/x3EG+DfLUhf1twVGvBhyZruRMHWP1ajEm0S5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141659; c=relaxed/simple;
	bh=MLCjBwNaXVG0n2+ySzFUJV+JLQzgmMgV8PYCLXRC4Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oski+aW9N8jPpJ4OvFq/qk3B0/bfjmj/qX6Q4sIagLMobiX8v3JzE9M4fR2pyoXqL6FQuPMPmEf121VMKIab+GwqbjsxcSkpisU7IQbrFOgkSQ5x91eKlgt80tKobiFK/xeEYXb4kObHB2AWf/FyU99/4ux8dX8y0M/fP7Eg8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkxM5XRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC53C19423;
	Tue, 10 Mar 2026 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141659;
	bh=MLCjBwNaXVG0n2+ySzFUJV+JLQzgmMgV8PYCLXRC4Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkxM5XRJ3zSDQp4RtjrwDr+1vdotYVSeuELzKu8u81oSi3jAcArcD/93Lud1yNz6j
	 NwyhxL2T2tjPehIHSiGv0H+L9ppjxEYOAH8Yn/U7UeBIv+/lj8odSRPQ0jAgZM6s+v
	 M8Y4jWBj/3wwF5e9cffvOUKDyFz3EpWBYYSJFJpTLqrdYOIORy7P4gs+34RxPwL7jM
	 HjvdwBnSDtMN/F3gaO0Hn30G4Az/E1a0Pp31XWeIhjqja3cIfukiX33UcNpWX8w9Zd
	 Qr7MFUxNEpFkab09A4pqW5f2auWxgQA8dHcy+WMw2dnnAKVHSXM3Mslgb2uVOS2/C3
	 q6Op5PpR9GDiw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 026/314] rseq: Clarify rseq registration rseq_size bound check comment
Date: Tue, 10 Mar 2026 07:14:45 -0400
Message-ID: <69ef557efe0ed8cfa88873c68def3e2ada5351ff.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C188724AA9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224205-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

[ Upstream commit 26d43a90be81fc90e26688a51d3ec83188602731 ]

The rseq registration validates that the rseq_size argument is greater
or equal to 32 (the original rseq size), but the comment associated with
this check does not clearly state this.

Clarify the comment to that effect.

Fixes: ee3e3ac05c26 ("rseq: Introduce extensible rseq ABI")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260220200642.1317826-2-mathieu.desnoyers@efficios.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rseq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 2452b7366b00e..07b0b46ec640f 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -519,8 +519,9 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	 * auxiliary vector AT_RSEQ_ALIGN. If rseq_len is the original rseq
 	 * size, the required alignment is the original struct rseq alignment.
 	 *
-	 * In order to be valid, rseq_len is either the original rseq size, or
-	 * large enough to contain all supported fields, as communicated to
+	 * The rseq_len is required to be greater or equal to the original rseq
+	 * size. In order to be valid, rseq_len is either the original rseq size,
+	 * or large enough to contain all supported fields, as communicated to
 	 * user-space through the ELF auxiliary vector AT_RSEQ_FEATURE_SIZE.
 	 */
 	if (rseq_len < ORIG_RSEQ_SIZE ||
-- 
2.51.0


