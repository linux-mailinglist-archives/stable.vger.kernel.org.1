Return-Path: <stable+bounces-222362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPVEEf2fo2noIgUAu9opvQ
	(envelope-from <stable+bounces-222362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:10:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 084BC1CD2D4
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FFB2304F6E0
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EF82FFFB5;
	Sun,  1 Mar 2026 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSB25Ppl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654D13D53C;
	Sun,  1 Mar 2026 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330691; cv=none; b=gtDjEocercQvT4EH+mo0TVckAhtRX5pC2QCIXZFYX0dl+nJVIanXmMziZD0CK6SFWz6mKZIcUYi7aORwQyLnt09vCwGOGGNvTzgdrId5YqFmg6w5Vczr0ROD2KeIks+ZR4Jt2X4aHfnbVuizIPe1F79iSxKiqd1SkA4xM9UD3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330691; c=relaxed/simple;
	bh=0GOx9MffM6mBIEN1M9kAVWJo1HQ88vbnH24yGUwyk5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKZQ4Ht6pK0mRU936pBOwOKDgRUFnroNvCCCbst/CbkPX06ZhU+/l0EUdMfWVSpLLT3LdaPkUUDAxqTOWfxRtJVhejcLN0TjRacI7lVZCRQSNChsy6b7+r6uPsfdr1U/xhZ4AVRAca+noFEtUxAAyPLWPuZ1qTVXidSqho0xjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSB25Ppl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59ADC19421;
	Sun,  1 Mar 2026 02:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330691;
	bh=0GOx9MffM6mBIEN1M9kAVWJo1HQ88vbnH24yGUwyk5o=;
	h=From:To:Cc:Subject:Date:From;
	b=JSB25PplzduDEaf6aCCtRqM4UnlYJ5wlI4W3ehcKWeJlvywqY07gB/UncFRQkfmGh
	 eBn+R4IwoeNlJ/7i0CGUfG/HDqfO6VhNsK83a9/sBXcDj1Y2CGoLX4C77Hw31Al33+
	 ziZPpPghYXPA0exHemenkS+Yt3FE+qURBW66GlL257jLD6n+ja9UVTIRru5j6WmvHn
	 Qo/LabviQaiUvfy78fKCo/RzF2qej9jdcZAklsjgiwT9S7VHlXV+QOmuwkxFVQU74s
	 NlcL/lqKYAaHHQiyMRmrFQyXkgyY7dN67wANc9o2hKmmqLpcwcOurwgxzFXPyn9qrT
	 GGCNLG56KFgtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Use %px to print unmodified unwinding address" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:04:49 -0500
Message-ID: <20260301020449.1733353-1-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222362-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: 084BC1CD2D4
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
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





