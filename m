Return-Path: <stable+bounces-241639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPEhDP6i8Gl3WgEAu9opvQ
	(envelope-from <stable+bounces-241639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:07:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BA64848F1
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48B8F300133D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ECF3FBEDA;
	Tue, 28 Apr 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="U9W7I5qV"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9B3FBEAD
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378001; cv=none; b=X6bXz6Gxw45AZZkBhRWHr5bg+BZs2VTqXc1S7/wWngR352ak+z7MAiQezCgJCEoCZNdp9daAjQOYxtcdBN6mMEii31XU5ue5Kj+ZEgkvaTRLdncN8oNYxEV95jnqmWx2yWlizk8yTTkM3hQ6becc6MCNmOF/Nxkd4EJV7b5vz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378001; c=relaxed/simple;
	bh=dKXhLKaRM4wKyrhNReMGF3ffWzVR8acoRg0gRiOghns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7pmkzi9HlcXnlPk9gAC7rXTIvih8shmIDVUHEeOU9BiljjyaCe0pX8BdOF5HNRv+TvTQ499UD1kSA6Uo+UctOqTfX0MBy2LR+wdUcPTsRg/di04mMEv+yzlYoUjXKW0uG27HUNjmhh5DeM+/0R1n2LBF8gppWHy0ekndoRHW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=U9W7I5qV; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0720780815;
	Tue, 28 Apr 2026 15:06:24 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:116::1:0])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA id B6YlCK1L0W20-SmFf3tGS;
	Tue, 28 Apr 2026 15:06:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1777377983;
	bh=3YocfVgTP6xCZwtBYPCFFdS7rQbZimwxMmEJoUgrKYQ=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=U9W7I5qVktgIGRAVRXobhl6U/NGq7klS5vJO2hMae7JqXqFqJW95EvlH8GVATk6Nn
	 2FDc7I+XRhhlfLD8P5MXwCUuqqDS4iG7l3iC8ElV+uG+wES+YT5Cv4kwR56Ldn2MsA
	 rNYZqfzdSNlZn9E3EvmnxLBiEjFn+843dyri6du4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
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
Subject: [PATCH 6.6.y 4/5] x86/bugs: Fix handling when SRSO mitigation is disabled
Date: Tue, 28 Apr 2026 15:05:44 +0300
Message-Id: <20260428120545.1970058-5-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428120545.1970058-1-d-tatianin@yandex-team.ru>
References: <20260428120545.1970058-1-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4BA64848F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241639-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_NEQ_ENVFROM(0.00)[d-tatianin@yandex-team.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yandex-team.ru:email,yandex-team.ru:dkim,yandex-team.ru:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]

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


