Return-Path: <stable+bounces-232543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF5sF0gCzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:20:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D346E36E803
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C8AC3126536
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A839731717E;
	Tue, 31 Mar 2026 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDX5nyH1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50130FF20;
	Tue, 31 Mar 2026 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977012; cv=none; b=TYqbe53SZWGRxBnN3OCMgzNtRvhkhAmWbADXtBtRFE3MPnU481rgN4Bcah9CuHaNNxXG7iKDjdTnBbLxNAVptsS9bADU5bNrzfKwhYCMrYJdoOpyGsEQZa9tml+upiiDF7I9jNCa1LoMFcse2LsGAJ298WSd9IgRRLiVMo6QDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977012; c=relaxed/simple;
	bh=ahWl1Y0GG/FGBTfvGxQ5qHBa1S2dyz6U+tcVTigvj+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqTZBhUYS46Tz13/2A8aR7utu408q5TxN8lSLV1b0Jk10I/YZDk+vGtp+5N0vTchW0jGO+opBtlfs3kQ6tHxF2flDN4HvSdbMpIDCeBjAXcDaudjDCr5nmQOj7aWCOHh/g/wKb+wdT3aLT3q/KqxwOhSEcAd5cw0o/reBj9wxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDX5nyH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE950C2BCB1;
	Tue, 31 Mar 2026 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774977012;
	bh=ahWl1Y0GG/FGBTfvGxQ5qHBa1S2dyz6U+tcVTigvj+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDX5nyH1aTo7/wI0X6ckhgwx55fqKeCE4vmtlsHncmvuPmCLUMyL1oVAJeIV5PZ69
	 cvvTWtOWKT7nzidleVU8T1/exKXjXZTZnoMWE6I0xqsoFq6+t3nvZFL3V2vbLcZVoI
	 1QRFAManzYOaqy0YMwqyk5SEK9X3pPMsqGU4cczk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicholas Carlini <npc@anthropic.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 307/309] futex: Require sys_futex_requeue() to have identical flags
Date: Tue, 31 Mar 2026 18:23:30 +0200
Message-ID: <20260331161804.863013966@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232543-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,anthropic.com:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D346E36E803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 19f94b39058681dec64a10ebeb6f23fe7fc3f77a ]

Nicholas reported that his LLM found it was possible to create a UaF
when sys_futex_requeue() is used with different flags. The initial
motivation for allowing different flags was the variable sized futex,
but since that hasn't been merged (yet), simply mandate the flags are
identical, as is the case for the old style sys_futex() requeue
operations.

Fixes: 0f4b5f972216 ("futex: Add sys_futex_requeue()")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/syscalls.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 880c9bf2f3150..99723189c8cf7 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -459,6 +459,14 @@ SYSCALL_DEFINE4(futex_requeue,
 	if (ret)
 		return ret;
 
+	/*
+	 * For now mandate both flags are identical, like the sys_futex()
+	 * interface has. If/when we merge the variable sized futex support,
+	 * that patch can modify this test to allow a difference in size.
+	 */
+	if (futexes[0].w.flags != futexes[1].w.flags)
+		return -EINVAL;
+
 	cmpval = futexes[0].w.val;
 
 	return futex_requeue(u64_to_user_ptr(futexes[0].w.uaddr), futexes[0].w.flags,
-- 
2.53.0




