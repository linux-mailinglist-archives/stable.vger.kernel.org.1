Return-Path: <stable+bounces-221982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC41KMiqo2nfJQUAu9opvQ
	(envelope-from <stable+bounces-221982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:56:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6911CE127
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B42823218FAE
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9782F3C07;
	Sun,  1 Mar 2026 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyDco+KJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5112C21F2;
	Sun,  1 Mar 2026 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329616; cv=none; b=EpADL8VNY7JqxL8Ad46RXPl4+bCr9+aIx3yzmYos3x3rqe1EVEFS2+3vKK/sNm7Ox4WtXRZlAKg01+ZOaGBltBFsH8/PnxrsYmmwAmRqpNwjJF4rnFanUfdAB2n9Ur/Fipu7qPjxZeLU1ygL9bXgN//ybxWQn51VMj+tEJBBnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329616; c=relaxed/simple;
	bh=Wt7vAbRN4g/1VfZIYotAYgi9eKSXglSA2OazHE4sJHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=By3qR/oRJ7kah1JRKOdxCJfQoSSdwX27K5ab3BjftBfRPgHDPothFaVKGy2nIONpiLfgn0zVjCisU1jSzEw209KfJlgyiM8R3ORuhYpgV2UTeS2TSMH+Wdo4HVzwxveBZUMwIogQcmTR0te2IxBrRK4m8aOm32MBWmdBgmAzR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyDco+KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF05C19421;
	Sun,  1 Mar 2026 01:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329615;
	bh=Wt7vAbRN4g/1VfZIYotAYgi9eKSXglSA2OazHE4sJHs=;
	h=From:To:Cc:Subject:Date:From;
	b=qyDco+KJSqYVh3+poEdQgZRY+lOEEQrRBL/lJEv6xLJA2kYX4EsdrhFkNj1/mYYT1
	 YtP44Bbv+e3Bl3XV7hQN0gbmCmfIWoGnl2FrnrfkDzQMi11Ru/e1/TKtLLDnVlXn5l
	 LVvj1a6kksM+bvowH6bHvyfKcVGOEpcfMALOE1BUAMZRzYH7b9yMK0XMJgxN6zWcGo
	 LcnbarNE2u02V5MYaIakVAf4rRFLuDhWkptY7CoAeBZSwELtKnyw3lLzjm8qRv3Kim
	 XXvKfhiAOI0C0OcO2qZve9LPi0JqMPmM4PiDnlNCq+mFgYQFXU5nu7fDPzyH5nrF+4
	 v6bQnENzX5OtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Use %px to print unmodified unwinding address" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:46:53 -0500
Message-ID: <20260301014654.1709986-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-221982-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3B6911CE127
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 77403a06d845db1caf9a6b0867b43e9dd8de8e4a Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue, 10 Feb 2026 19:31:13 +0800
Subject: [PATCH] LoongArch: Use %px to print unmodified unwinding address

Currently, use %p to prevent leaking information about the kernel memory
layout when printing the PC address, but the kernel log messages are not
useful to debug problem if bt_address() returns 0. Given that the type of
"pc" variable is unsigned long, it should use %px to print the unmodified
unwinding address.

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unwind_orc.c
index 8a6e3429a860e..d6b3688a1ce97 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -494,7 +494,7 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	state->pc = bt_address(pc);
 	if (!state->pc) {
-		pr_err("cannot find unwind pc at %p\n", (void *)pc);
+		pr_err("cannot find unwind pc at %px\n", (void *)pc);
 		goto err;
 	}
 
-- 
2.51.0





