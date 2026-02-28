Return-Path: <stable+bounces-221151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFrnCapdo2lxBQUAu9opvQ
	(envelope-from <stable+bounces-221151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:27:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A3F1C9117
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2EF533A9592
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F285537312E;
	Sat, 28 Feb 2026 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekRDqtxM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6037373128;
	Sat, 28 Feb 2026 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301504; cv=none; b=tpFdPehQ17fe0Wzwgwk1CH7IUtB1f2Icta4GfpE7rtxLthEWiuNkWseONNtCS5zDzd4dKv3KtZuSP5c/43hVO3aZptSksIytR7V2B89JSSaZfrWTDbzokf9HWpveVL5niM0tl7bDt6TtntWVPlV5AW4YKL7kfF85C/Drs18TOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301504; c=relaxed/simple;
	bh=z3wvK4vevx+RiBApNVeXD9smSPqYInnjaivREynm7TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixiD54aBO/uLS9W2eW8u/j+5fRN+HOVUXCjffEPAkkPGzBVpuGv/ijkrTG17OFasXiqghSP1kFSSmRDDHFvFoL1XjNvXd263GJv6xGm1V/MbCagXaiXdUJSfidVcPJOld8mJZN3SB/hs4qaI9KfB2Kb0o38TSwkwmzMYBQ+40Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekRDqtxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EE7C19423;
	Sat, 28 Feb 2026 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301504;
	bh=z3wvK4vevx+RiBApNVeXD9smSPqYInnjaivREynm7TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekRDqtxMbvEKvcTTXg0qCYQQLx8BCjKI9xt/YGBRe0bmasPd4ttQCGsBe9cAskXwi
	 96mEcFgNuMFqNGBZb+UOmTCYl4tgConw7NV9/JSpC+yXO4k2jAGgiGYrt6A4ey5chZ
	 pldG68xxy3ayzn91g9JC1repnuNOPQtPz1ZRNojseB2Tt8Py7S0PNTWelGLkxuBzIc
	 vHdPV0HwUPlE3tDlhe1++QIrvg9Io1fEVAdGeBeGBpRXLV8FBoEH8ZbyWQ68sLHUHJ
	 yonrwJesf9OJ7l4uWkxtwG516fJ4+DF3GSBSd0skptnJBXxqS3aSNFipNtcgcSb4II
	 sk3y1rcNbRjjQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 689/752] LoongArch: Use %px to print unmodified unwinding address
Date: Sat, 28 Feb 2026 12:46:40 -0500
Message-ID: <20260228174750.1542406-689-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221151-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: C8A3F1C9117
X-Rspamd-Action: no action

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 77403a06d845db1caf9a6b0867b43e9dd8de8e4a ]

Currently, use %p to prevent leaking information about the kernel memory
layout when printing the PC address, but the kernel log messages are not
useful to debug problem if bt_address() returns 0. Given that the type of
"pc" variable is unsigned long, it should use %px to print the unmodified
unwinding address.

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unwind_orc.c
index 0d5fa64a22252..e410048489c66 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -508,7 +508,7 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	state->pc = bt_address(pc);
 	if (!state->pc) {
-		pr_err("cannot find unwind pc at %p\n", (void *)pc);
+		pr_err("cannot find unwind pc at %px\n", (void *)pc);
 		goto err;
 	}
 
-- 
2.51.0


