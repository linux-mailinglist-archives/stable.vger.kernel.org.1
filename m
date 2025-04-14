Return-Path: <stable+bounces-132568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF7A8836C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538221885887
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD012D026C;
	Mon, 14 Apr 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg0nwQ0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CB2D0265;
	Mon, 14 Apr 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637428; cv=none; b=FkZCKQwRDhrwWXyDxocf9vId2oK5dFQS/WEelYNdfgv5uKCLhNmi6mlVEGcOj9P9yebfj81BKapJHrosPQBIx4xek9XNeAC/JoR9GjfcGw1rnkBxy0X/x60V6hQI++JhLqxH9Mhih7kI6D1MAt5Q7aQspNoVMofhHSfMrEEKj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637428; c=relaxed/simple;
	bh=WG6nYmIipf/h+LIKfrFwCwM14Gawq37Z8U1JBiXGeRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cgn5LGbHX8kR45AtRgA6BUf86bUHLsUfzuFDAk8sYJKXS2qSXI27P7LTCb/owqK+cU8TThB19XwydN8MLfOkunhixL4RcN5fvURiEpWBXhrqhOCj008MB8jiXS8L+6D37+eE/D7ilxJuh/kaIHbE2bThKVqCKXRLSFlIpaFm6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg0nwQ0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92672C4CEED;
	Mon, 14 Apr 2025 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637428;
	bh=WG6nYmIipf/h+LIKfrFwCwM14Gawq37Z8U1JBiXGeRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qg0nwQ0jn2JYf4fNJxQhDAKDk6Q628OuWi+W6PBYQl8CLeApPU88B8Bcc6L41H/Tq
	 n0ZOWYwWy8fxa9rZT0uUCbGxmlxeDZxZ76T5cbgMmrvjWHGdAEvJboFnmjDEDBxyX8
	 WhjevAO3bAgutt1LoMT0wkkktwWc3fK0VrTNpSpeTsPCdUHXax/VkRdMCQAwfGqMUF
	 f/OqZxvgOFtL4PvFDsaVBEQt0Zl5FByJw8h0UxXBcRowqNgTl6BDZVBH83ilK8cM28
	 4o7zygAZgveHqWU6ClxqMAcKp9CwQeY1QyQgHEuQtrdnftOEaoCjXAAHBFovW67lST
	 tGPgj6PzjghcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.6 15/24] x86/bugs: Use SBPB in write_ibpb() if applicable
Date: Mon, 14 Apr 2025 09:29:48 -0400
Message-Id: <20250414132957.680250-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit fc9fd3f98423367c79e0bd85a9515df26dc1b3cc ]

write_ibpb() does IBPB, which (among other things) flushes branch type
predictions on AMD.  If the CPU has SRSO_NO, or if the SRSO mitigation
has been disabled, branch type flushing isn't needed, in which case the
lighter-weight SBPB can be used.

The 'x86_pred_cmd' variable already keeps track of whether IBPB or SBPB
should be used.  Use that instead of hardcoding IBPB.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/17c5dcd14b29199b75199d67ff7758de9d9a4928.1744148254.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index 2143358d0c4c7..78fd2442b49dc 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -16,7 +16,7 @@
 
 SYM_FUNC_START(entry_ibpb)
 	movl	$MSR_IA32_PRED_CMD, %ecx
-	movl	$PRED_CMD_IBPB, %eax
+	movl	_ASM_RIP(x86_pred_cmd), %eax
 	xorl	%edx, %edx
 	wrmsr
 
-- 
2.39.5


