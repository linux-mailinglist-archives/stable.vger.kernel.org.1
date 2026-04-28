Return-Path: <stable+bounces-241782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMN1AdEq8WkJeQEAu9opvQ
	(envelope-from <stable+bounces-241782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 23:46:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B848C651
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 23:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE051302260F
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 21:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF212A1CF;
	Tue, 28 Apr 2026 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="gSE5cfrK"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D601862A
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777412804; cv=none; b=nEFplzhsHPx5W3tuh6AtEDqeYa0QvuFxTlABmy2AZsq2mRcgENefQsgzBdHtjfG25ptBOOEcBATBS9VdL+jJUNj7Bqy52Bamc8p5GjVrUd7xkVoBBtNRO9NgxFV5122wO9WG3NXyhVdNN/gMJy/9cMDJelNO5q2fVQZCMxMr4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777412804; c=relaxed/simple;
	bh=dKXhLKaRM4wKyrhNReMGF3ffWzVR8acoRg0gRiOghns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sW4ImBWmCs4PqGQ1JivxqtZo6J526Ovf4XnOOZ/SQ0cvGt6uf4qiyE2NXUj+qEt3bA+/6i9y7zpEN/qxu58ScruoHbaHOPA3dNkPWXAOWr7h74dPVveN+dxXwf+62/YT5tTyyyT6vp7pciDh+akYk94l8BCsLNpdkb/wvxkXJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=gSE5cfrK; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9BB05C0267;
	Wed, 29 Apr 2026 00:46:40 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:761::1:11])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA id TkhkmZ1L4iE0-Qrayf1Eu;
	Wed, 29 Apr 2026 00:46:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1777412800;
	bh=3YocfVgTP6xCZwtBYPCFFdS7rQbZimwxMmEJoUgrKYQ=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=gSE5cfrKI1TNyLIkEPPnZMbkLtxU71Gf2eeFHS4+8w37kr0fNh+b0V65p7KvjhZbc
	 xBGHFBam756pbQBclGRmBDtUqMAgQaPRoAao1xLMjj9EJtO87acpTgJBWYrTK5qC9P
	 TtYCDe2WofiyGWAkZT8ypnaqGX9eIVBOb01GI2/Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: stable@vger.kernel.org
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	David Kaplan <david.kaplan@amd.com>
Subject: [PATCH 6.6.y v1 4/6] x86/bugs: Fix handling when SRSO mitigation is disabled
Date: Wed, 29 Apr 2026 00:46:08 +0300
Message-Id: <20260428214610.2138600-5-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428214610.2138600-1-d-tatianin@yandex-team.ru>
References: <20260428214610.2138600-1-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 334B848C651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241782-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_NEQ_ENVFROM(0.00)[d-tatianin@yandex-team.ru,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yandex-team.ru:email,yandex-team.ru:dkim,yandex-team.ru:mid]

[ Upstream commit 1dbb6b1495d472806fef1f4c94f5b3e4c89a3c1d ]

When the SRSO mitigation is disabled, either via mitigations=off or
spec_rstack_overflow=off, the warning about the lack of IBPB-enhancing
microcode is printed anyway.

This is unnecessary since the user has turned off the mitigation.

  [ bp: Massage, drop SBPB rationale as it doesn't matter because when
    mitigations are disabled x86_pred_cmd is not being used anyway. ]

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240904150711.193022-1-david.kaplan@amd.com
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 arch/x86/kernel/cpu/bugs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1fce8077de5f8..916f36e23724d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2757,10 +2757,9 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (cpu_mitigations_off())
-		return;
-
-	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
+	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
+	    cpu_mitigations_off() ||
+	    srso_cmd == SRSO_CMD_OFF) {
 		if (boot_cpu_has(X86_FEATURE_SBPB))
 			x86_pred_cmd = PRED_CMD_SBPB;
 		return;
@@ -2791,11 +2790,6 @@ static void __init srso_select_mitigation(void)
 	}
 
 	switch (srso_cmd) {
-	case SRSO_CMD_OFF:
-		if (boot_cpu_has(X86_FEATURE_SBPB))
-			x86_pred_cmd = PRED_CMD_SBPB;
-		return;
-
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
 			srso_mitigation = SRSO_MITIGATION_MICROCODE;
-- 
2.34.1


