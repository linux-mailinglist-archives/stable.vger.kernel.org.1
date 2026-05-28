Return-Path: <stable+bounces-255289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGb2NzmgGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:06:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F175F7D23
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBEF331AA974
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D789F27A476;
	Thu, 28 May 2026 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WC4Km368"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC04A24677F;
	Thu, 28 May 2026 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998491; cv=none; b=tIlRSMlS/DyBKSOmoqV7JkHAwLl2+9coIk2qZIJT6PBRrdie3Mn8ZXUCqJSm7Xp1iLvkR3cj7sVaEaHNb324OIZS+/WQDyVCwQ3scgIynr6Ayo/Ke4/I0TLHSr9ZrGRBTog8S6xUGMbv1PAuINKaafCPRGOlMIFGaF5fz8AX2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998491; c=relaxed/simple;
	bh=cnop5FcPpQLtGoVL8ZJIJYdeI6v/2zUwZ4bg3lW1dE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/+Ps/oRWjOupkqjESlTGFfjyxkMiR8ZBGtFAQu70CVpAwHsT6/4hl9NFC6ihBAK4J9ZfCV7zlMI3tccfYhdTQGxuYTWOqd68kr88aZj+YtCpk7ms+ISA7fBh9SsiMvqpoi9jS3eaYAAGfXLxLaahJbAaLHchWZOb+8txYwvAmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WC4Km368; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8091F000E9;
	Thu, 28 May 2026 20:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998490;
	bh=TiAk9hmdjSmn1TnPlHreKyy0Hk8pHo7xWEDbZGcdYMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WC4Km368ZJbXXMUK7b9twKrJLVLP6TdLqzhpFFKhfTseZaI+CsHFuJ7605Dau/NVO
	 VaV7i23feckU4EH88opjwp2Ns1VyO6awIMSE2xUvMO5C2TQsE2ZB+4h+ujnkNOAlti
	 iVq+kdUYF3lUfIt5TzATPOfRuuGPCq57qZJsK++E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Neuling <mikey@neuling.org>,
	Paul Walmsley <pjw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 191/461] riscv: errata: Fix bitwise vs logical AND in MIPS errata patching
Date: Thu, 28 May 2026 21:45:20 +0200
Message-ID: <20260528194652.608903703@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255289-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,neuling.org:email,msgid.link:url]
X-Rspamd-Queue-Id: 40F175F7D23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

[ Upstream commit 4d2b03699460b8fd5df34408a03a84a1a7ff8aa1 ]

The condition checking whether a specific errata needs patching uses
logical AND (&&) instead of bitwise AND (&). Since logical AND only
checks that both operands are non-zero, this causes all errata patches
to be applied whenever any single errata is detected, rather than only
applying the matching one.

The SiFive errata implementation correctly uses bitwise AND for the same
check.

Fixes: 0b0ca959d206 ("riscv: errata: Fix the PAUSE Opcode for MIPS P8700")
Signed-off-by: Michael Neuling <mikey@neuling.org>
Assisted-by: Cursor:claude-4.6-opus-high-thinking
Link: https://patch.msgid.link/20260409091143.1348853-2-mikey@neuling.org
[pjw@kernel.org: fixed checkpatch warning]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/errata/mips/errata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/errata/mips/errata.c b/arch/riscv/errata/mips/errata.c
index e984a8152208c..2c3dc2259e93e 100644
--- a/arch/riscv/errata/mips/errata.c
+++ b/arch/riscv/errata/mips/errata.c
@@ -57,7 +57,7 @@ void mips_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 		}
 
 		tmp = (1U << alt->patch_id);
-		if (cpu_req_errata && tmp) {
+		if (cpu_req_errata & tmp) {
 			mutex_lock(&text_mutex);
 			patch_text_nosync(ALT_OLD_PTR(alt), ALT_ALT_PTR(alt),
 					  alt->alt_len);
-- 
2.53.0




