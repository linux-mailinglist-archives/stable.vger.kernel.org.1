Return-Path: <stable+bounces-213125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKVWHo8cgWm0EAMAu9opvQ
	(envelope-from <stable+bounces-213125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 22:52:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0ED1DE9
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 22:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0D0A302304C
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 21:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7743009DA;
	Mon,  2 Feb 2026 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbB6RwgR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3A27453;
	Mon,  2 Feb 2026 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068850; cv=none; b=NT/zWn6iVrFhhcaZ2KhIOS8ccpNQLl/nZBO7OYbscc7HIOToOlkm4708OukMZXCo4ILpjHmY0uqWNvoGGL8uKbTjzUZ3X08m1757/1iHm0qUDFcN/bUwpJV5h3MglclcEnHJM6w3d0ngU4h0YbD9hqewKSP1hkxS9ykiYhw/PEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068850; c=relaxed/simple;
	bh=rLGrE+MaErxQW3OluWWITCG7Jv6qU44Pywclqiz3Ero=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/MhQ11X9F961LK2I+oF2XXMr0xxSjqK3cWekJDoSHysoB9P0nFn9VO8GVcKxSCBFs1cPTbTFZ3IQhgQ9nJnwJL2Qx5D2HnD7NbKSsu6tyYnC4gp3iIcbrpwMJqM8auyGteC0HkGkLy4kn0e5/5ZidU+C57i6GEiTlg4s6TBkmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbB6RwgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D3FC19425;
	Mon,  2 Feb 2026 21:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770068850;
	bh=rLGrE+MaErxQW3OluWWITCG7Jv6qU44Pywclqiz3Ero=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbB6RwgRCUwByS9ly1ozP2pM3r2ns9aZFJcb1RLf1ika3NQi2ZWEMyOZ0H0uJLu//
	 nNHigTWBJpiYn1UYjAoAbAAnAA2hSL7KueajypVaJwtucnqKkrovAyjZzMTACw/Wur
	 i54VZv81b+yfV38+ABfCCH2lYy7BuSwp+1OYDUaFHd7RsZi1YxK1RDaGESojwhEveq
	 qIzR/enU0wALyLenK0itCb/+a34/TBwMcrsJZmMxFOLs0EFaW+HO2BOmFqSB7zJce0
	 VtACyx0nDGBOs6SHwGifOvWn/Cs2QINIptQV2Y4+3braOXRd1Yh5OSjfkQcKFeHBJG
	 GsnXzeEI+cAuQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] tracing: Avoid possible signed 64-bit truncation
Date: Mon,  2 Feb 2026 16:46:19 -0500
Message-ID: <20260202214643.212290-24-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202214643.212290-1-sashal@kernel.org>
References: <20260202214643.212290-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213125-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,efficios.com:email,goodmis.org:email]
X-Rspamd-Queue-Id: E7C0ED1DE9
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit 00f13e28a9c3acd40f0551cde7e9d2d1a41585bf ]

64-bit truncation to 32-bit can result in the sign of the truncated
value changing. The cmp_mod_entry is used in bsearch and so the
truncation could result in an invalid search order. This would only
happen were the addresses more than 2GB apart and so unlikely, but
let's fix the potentially broken compare anyway.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260108002625.333331-1-irogers@google.com
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The original buggy code was introduced in v6.15 and later. It's only
present in 6.15+ kernels.

### 8. SUMMARY OF ANALYSIS

**The Bug:**
- The `cmp_mod_entry()` function uses subtraction of two `unsigned long`
  values and returns the result as `int`
- On 64-bit systems, if addresses differ by more than 2^31 (~2GB), the
  truncation from 64-bit to 32-bit can flip the sign
- This would cause `bsearch()` to make wrong decisions about search
  direction
- Result: potentially incorrect module address lookups in trace data

**The Fix:**
- Replaces arithmetic subtraction with simple comparisons
- Returns -1, 0, or 1 directly based on comparisons
- No overflow or truncation possible with the new code
- Logic is more readable and provably correct

**Stable Criteria Evaluation:**
1. ✅ **Obviously correct and tested**: Simple logic, reviewed by
   maintainers
2. ✅ **Fixes a real bug**: Yes, a potential comparator correctness bug
3. ⚠️ **Important issue**: Moderate - unlikely to trigger (requires >2GB
   address separation) but could cause incorrect trace output
4. ✅ **Small and contained**: Only changes one function body (~6 lines)
5. ✅ **No new features**: Pure bug fix
6. ✅ **Applies cleanly**: Should apply to 6.15+ kernels where this code
   exists

**Risk Assessment:**
- Very low risk - the change is small and the new logic is simpler
- The original code has a provable bug (integer overflow on truncation)
- The new code has no such issues

**Concerns:**
- The code only exists in 6.15+ kernels (introduced March 2025)
- The bug is "unlikely" per the author (requires addresses >2GB apart)
- No known real-world reports of this actually causing issues

### DECISION

This is a valid bug fix that:
- Fixes a real (though unlikely to trigger) bug in the comparator
  function
- Is very small and self-contained
- Has been reviewed and acked by the tracing maintainers
- Has near-zero regression risk
- Applies to 6.15+ kernels only

The fix is surgical, obviously correct, and addresses a potential
correctness issue. While the bug is unlikely to trigger in practice
(addresses must be >2GB apart), it could cause silent data corruption in
trace output when it does trigger. The fix is trivial and risk-free.

**YES**

 kernel/trace/trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 142e3b737f0bc..907923d5f8bbb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6061,10 +6061,10 @@ static int cmp_mod_entry(const void *key, const void *pivot)
 	unsigned long addr = (unsigned long)key;
 	const struct trace_mod_entry *ent = pivot;
 
-	if (addr >= ent[0].mod_addr && addr < ent[1].mod_addr)
-		return 0;
-	else
-		return addr - ent->mod_addr;
+	if (addr < ent[0].mod_addr)
+		return -1;
+
+	return addr >= ent[1].mod_addr;
 }
 
 /**
-- 
2.51.0


