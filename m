Return-Path: <stable+bounces-224273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM9vOfUAsGm0eQIAu9opvQ
	(envelope-from <stable+bounces-224273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:31:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF624AE19
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2995230891EB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB373876A1;
	Tue, 10 Mar 2026 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzVIUvPd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0C313E32;
	Tue, 10 Mar 2026 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141970; cv=none; b=AiBDzCEVHCBUC6S3myKA2qBHrVPUD+RU+VoT8vOse2a5ovLIj9/wbC3KSHGeTJbm6UjZnGCG5Kd9dVLlZw7iq9jGnXI/UvJ5UeNqteVzs8gJLnfIXOoYMHTPvQnFTyC9w/XCx3T7Dw4K4eJTPeSYsZN2yHtAlmldDZwAEzrcUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141970; c=relaxed/simple;
	bh=A10Gh4sIxtmQKcXmmcuWYhhS8h1bqOMUcwOCvkYGnvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpWHm200Ml+YZLvmkyywCpbuZTwPHKlf+R/366i96j0XynWLShRPcd3ij9wfBJkpTHjzgtIapzzCOScbmXXgmiDoZKxkxCyOvOgrvzyXdi2LnT+1IVz4CFwBqwqyOSIQ7cuQ/8lohfwI7MfbwVxMZ4C2aKJeKRKi5ozPNdjRGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzVIUvPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB08C19423;
	Tue, 10 Mar 2026 11:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141969;
	bh=A10Gh4sIxtmQKcXmmcuWYhhS8h1bqOMUcwOCvkYGnvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzVIUvPdqBosUO5Zr7hN7iI/yP/DeXVCCWmrK63OLk0Pb0obYCPDrD3nd+CnAV7n1
	 QlMUfm5mwJt1GqLvbCrqmLPJWJXRtq5xoRO6SZEc+9Q8WQjPscjBCPBuvxL3pmduti
	 g2O4QlQKcxlmG04ULjZmYhTT+gvrzyUxPndiEGQ+WEgfR0Ci0sWpMYoUrg/xsodgRi
	 NKz9UBx6JN31Rb0AEIxDMfQYvX5TxcN6oNVNgne4j2gj0AFltwWqxx8SBEtuAOPgXk
	 aEkrmOvcAnd11V2tBXfajfLmeN7Pg+WcyIoNdT5X5HRXUvYzEJedbSMIJ0pMouc4cs
	 THq1KyzCicdXg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 094/314] unwind: Simplify unwind_user_next_fp() alignment check
Date: Tue, 10 Mar 2026 07:15:53 -0400
Message-ID: <f52978eb0859642bdb61717dd10b6a9a16a17dfb.1773141555.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: 9DDF624AE19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224273-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 5578534e4b92350995a20068f2e6ea3186c62d7f ]

  2^log_2(n) == n

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://patch.msgid.link/20250924080119.497867836@infradead.org
Stable-dep-of: d55c571e4333 ("x86/uprobes: Fix XOL allocation failure for 32-bit tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/unwind/user.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 97a8415e3216f..9dcde797b5d93 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -19,7 +19,6 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
 {
 	const struct unwind_user_frame *frame = &fp_frame;
 	unsigned long cfa, fp, ra;
-	unsigned int shift;
 
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
@@ -37,8 +36,7 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
 		return -EINVAL;
 
 	/* Make sure that the address is word aligned */
-	shift = sizeof(long) == 4 ? 2 : 3;
-	if (cfa & ((1 << shift) - 1))
+	if (cfa & (sizeof(long) - 1))
 		return -EINVAL;
 
 	/* Find the Return Address (RA) */
-- 
2.51.0


