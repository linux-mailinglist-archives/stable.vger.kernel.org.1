Return-Path: <stable+bounces-220169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKw7BlUto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FF91C5531
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03DB83108E8A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712A4A2E0D;
	Sat, 28 Feb 2026 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSoMNi6K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589BA496903;
	Sat, 28 Feb 2026 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300077; cv=none; b=CwTTgbK8AqZi7KEePoSflmA63/0tyDivOHF5imp5PCQmne7ncTccHjOEEXi3F1UEHLzNRuRO9b7vgkVgDiMExpkSY68ML0oabwj6yj0dR4aHsH6RXM3kWrnS7/O+6dyvZmg+h15RFLwk46sXqdBraKZttkCSWA55J/dHIxCeZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300077; c=relaxed/simple;
	bh=36eFDMC+F8u+wuAGtj38JKzg3v6qAA/eyc8rh47FPEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TB2l1/ASPPihMF5AcuoCTWJU36qjr685YDe6tKT113950hUDT/IOsBqCjiKmfblj0MWGJoNqLIJsBXmGoh1TydkMN8cVV9PYP7iuWvgWvDaO42pi+IYdsCxulPOyFrLnBZhhZHZ6VSK922H0sE5JyqtnVvUlkTDCXNlHSePPjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSoMNi6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F04C116D0;
	Sat, 28 Feb 2026 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300077;
	bh=36eFDMC+F8u+wuAGtj38JKzg3v6qAA/eyc8rh47FPEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BSoMNi6KS/cTVQdWyCs2RuYzRf6QPhZBriAUCrxD+BSnXgrL4bBBfNkpdAxjdIzil
	 JGADP0XYhKf/Kpq56Z4cTz3gU5tYNA+zojYow9WXbdVsfhPf5EJG8+1LH3Ov6DpYKk
	 pkk6AdwO4BYWEpzNow9BfdySPonCe+G86VwmNGwf/+jXRT5gBnlFIHsOvKYkkjgAHB
	 xvcX74aPjIqV9SS7gCCRTBDNJZVuu00K/wWBbeEPN19iOVvOPlnVVov8b4kZU0ZVh/
	 aKhOiT+jTmSOC3miotva4o/lDRXh5YSUaAPQuih/kBJkqOMuRerzy7wp30FfTVozRK
	 HWT/yX0ULLD7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
	Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Faust <david.faust@oracle.com>,
	Jose Marchesi <jose.marchesi@oracle.com>,
	Elena Zannoni <elena.zannoni@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 091/844] bpf: verifier improvement in 32bit shift sign extension pattern
Date: Sat, 28 Feb 2026 12:20:04 -0500
Message-ID: <20260228173244.1509663-92-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,oss.qualcomm.com,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220169-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,gnu.org:url]
X-Rspamd-Queue-Id: 97FF91C5531
X-Rspamd-Action: no action

From: Cupertino Miranda <cupertino.miranda@oracle.com>

[ Upstream commit d18dec4b8990048ce75f0ece32bb96b3fbd3f422 ]

This patch improves the verifier to correctly compute bounds for
sign extension compiler pattern composed of left shift by 32bits
followed by a sign right shift by 32bits.  Pattern in the verifier was
limitted to positive value bounds and would reset bound computation for
negative values.  New code allows both positive and negative values for
sign extension without compromising bound computation and verifier to
pass.

This change is required by GCC which generate such pattern, and was
detected in the context of systemd, as described in the following GCC
bugzilla: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=119731

Three new tests were added in verifier_subreg.c.

Signed-off-by: Cupertino Miranda  <cupertino.miranda@oracle.com>
Signed-off-by: Andrew Pinski  <andrew.pinski@oss.qualcomm.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
Link: https://lore.kernel.org/r/20251202180220.11128-2-cupertino.miranda@oracle.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fe01edfcc34c6..7069e9f527eaa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15305,21 +15305,17 @@ static void __scalar64_min_max_lsh(struct bpf_reg_state *dst_reg,
 				   u64 umin_val, u64 umax_val)
 {
 	/* Special case <<32 because it is a common compiler pattern to sign
-	 * extend subreg by doing <<32 s>>32. In this case if 32bit bounds are
-	 * positive we know this shift will also be positive so we can track
-	 * bounds correctly. Otherwise we lose all sign bit information except
-	 * what we can pick up from var_off. Perhaps we can generalize this
-	 * later to shifts of any length.
+	 * extend subreg by doing <<32 s>>32. smin/smax assignments are correct
+	 * because s32 bounds don't flip sign when shifting to the left by
+	 * 32bits.
 	 */
-	if (umin_val == 32 && umax_val == 32 && dst_reg->s32_max_value >= 0)
+	if (umin_val == 32 && umax_val == 32) {
 		dst_reg->smax_value = (s64)dst_reg->s32_max_value << 32;
-	else
-		dst_reg->smax_value = S64_MAX;
-
-	if (umin_val == 32 && umax_val == 32 && dst_reg->s32_min_value >= 0)
 		dst_reg->smin_value = (s64)dst_reg->s32_min_value << 32;
-	else
+	} else {
+		dst_reg->smax_value = S64_MAX;
 		dst_reg->smin_value = S64_MIN;
+	}
 
 	/* If we might shift our top bit out, then we know nothing */
 	if (dst_reg->umax_value > 1ULL << (63 - umax_val)) {
-- 
2.51.0


