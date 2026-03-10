Return-Path: <stable+bounces-224136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNq1DioAsGmoeQIAu9opvQ
	(envelope-from <stable+bounces-224136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C8424ABCE
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCBA232444D3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC6038759A;
	Tue, 10 Mar 2026 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRL3eiz+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D57352C4F;
	Tue, 10 Mar 2026 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141269; cv=none; b=jypRrYwrD3L6OVExdH5s7tDTzuadiLZ9EE5oVhvfm+TaNwNuX9iQ+VMNS0sQIpfjfeNGetJDi4x/SYINFKKXYfWThgVG/tpTAhTkorJozGZBU4jk61UxTHjhEokp4MJa5gk5TMr4RjhQV1ZU3V01TQgDTmmGx3RqXEPGIAF+/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141269; c=relaxed/simple;
	bh=p6HhFnj41+gt4S2qiZTEEYG5f15sCB9yNnk3+7+23iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZkvBE1RBWPq6Av+/T1eD8FENZ8GAlqqOLrzMNorKg5bU47Qd21GQhaB/xT7wwG04njBfYz8lLS6BU3Tx2s8loQ+3oVqnvx2PmyXguZ0fP6jF+DOPrtNC8JS3BfPfFoxUqEVkt3AHlbuIXIToW4mgcNYPVvNsPrgOi65wVXGmEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRL3eiz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD737C19423;
	Tue, 10 Mar 2026 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141269;
	bh=p6HhFnj41+gt4S2qiZTEEYG5f15sCB9yNnk3+7+23iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRL3eiz+O7F65T3crBy4wHd8DPao8McCUdtwpLxdOv1O+S98PS5KtdzwMXJV2Kxij
	 gPq3/D5WdqAMvY+cNkdW3ReoBnEFLu1Ckan7B/C7dKIKKJc9/0rTpnDVwAIOMcAraU
	 GlLoGC9xENBMuQIjtfpHy50pAspZDGJ2zQIgChgpg7qRjvMuZvBMWqCyRG+NPnJ/QQ
	 la7TxH4Ei+FskrXGbNMvV7Zr32YZjmpanP4A39fDkFBUeLYdmoDQ890rsAl9axAtKH
	 5qR4m3kj2NIF/yP+ZGBP6uC8Iifoob7Z/PC1P2pAapP4yD/ASetMD0/p0qrib8Btjk
	 ZZ3G7IyUw/BUQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 271/311] timekeeping: Fix timex status validation for auxiliary clocks
Date: Tue, 10 Mar 2026 07:05:18 -0400
Message-ID: <6141b8f1b537bb884e8836f7376ca9a3e52dadb5.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 88C8424ABCE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224136-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Miroslav Lichvar <mlichvar@redhat.com>

[ Upstream commit e48a869957a70cc39b4090cd27c36a86f8db9b92 ]

The timekeeping_validate_timex() function validates the timex status
of an auxiliary system clock even when the status is not to be changed,
which causes unexpected errors for applications that make read-only
clock_adjtime() calls, or set some other timex fields, but without
clearing the status field.

Do the AUX-specific status validation only when the modes field contains
ADJ_STATUS, i.e. the application is actually trying to change the
status. This makes the AUX-specific clock_adjtime() behavior consistent
with CLOCK_REALTIME.

Fixes: 4eca49d0b621 ("timekeeping: Prepare do_adtimex() for auxiliary clocks")
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260225085231.276751-1-mlichvar@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timekeeping.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 91fa2003351c9..c07e562ee4c1a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2653,7 +2653,8 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc, bool aux
 
 	if (aux_clock) {
 		/* Auxiliary clocks are similar to TAI and do not have leap seconds */
-		if (txc->status & (STA_INS | STA_DEL))
+		if (txc->modes & ADJ_STATUS &&
+		    txc->status & (STA_INS | STA_DEL))
 			return -EINVAL;
 
 		/* No TAI offset setting */
@@ -2661,7 +2662,8 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc, bool aux
 			return -EINVAL;
 
 		/* No PPS support either */
-		if (txc->status & (STA_PPSFREQ | STA_PPSTIME))
+		if (txc->modes & ADJ_STATUS &&
+		    txc->status & (STA_PPSFREQ | STA_PPSTIME))
 			return -EINVAL;
 	}
 
-- 
2.51.0


