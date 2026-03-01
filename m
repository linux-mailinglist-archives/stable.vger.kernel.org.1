Return-Path: <stable+bounces-221804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Y8zzLPmZo2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:44:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 836ED1CB80A
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92716307717F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5493F2EBBA9;
	Sun,  1 Mar 2026 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgkmEovb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5F2E06E6
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329178; cv=none; b=CfYGNSpKp83hHJWPPMBxiaiYfHBYnAN6y8uyppOEp6zNicXc6BLi+pRZ6E3f3C5BhGXr7KGTP0sFlyigC+nojHKIEgZCiUnoS1kNA7+QZtwx3IOkOOlbGfzeSKFmZRNA/YerJGyYcn6PwNWWvmm2pJw5WtkfiYCVDnzYUzuGYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329178; c=relaxed/simple;
	bh=GzDfd01aK8P5swVuGIAGZhn3hhR2nehCFykj2Jutx8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UW0xfJb81UkBfa8o/obwAUBij611/bZy1y6ja/1rM+FKxufEJ+4hEYhy8fYTz2K6GWEsBLPrQhX80U/LrRmMhc9VId6afOYH02PiVAbZIAkUWert1mfwKisti9ncrIIV+QxJ6heQ1em68lfYJ3QLyIAIMXsPyyNKGPAAbQtVidg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgkmEovb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4738EC19424;
	Sun,  1 Mar 2026 01:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329178;
	bh=GzDfd01aK8P5swVuGIAGZhn3hhR2nehCFykj2Jutx8M=;
	h=From:To:Cc:Subject:Date:From;
	b=BgkmEovbedVlMtvmhX0G33U6BcF45cjrwkDBHyTF6QzpxKFVaSbtJGNoy3kXfXyWA
	 YPgu1Kcb5sQHatn3/zjs0PzscKwGZHq6bixCzQm9orC8hX2v/Y/8DPxVuclmQ/giuY
	 wsdbiDlyJVC393/xfvWk5A2jBlG8ivKnlh2HvzrUtkp0grsFcZqcwZXARo2LDtLc9C
	 Wparbpt6g7CF2SEwCXmt+Q919v1n5f9TqXRPKU/2rbaAB3SkgmMolleFsnZhhxy+mf
	 CagDmMa7UEvmbM095/xLg+oLQJYyH7lbCDZNgdD1wxkV3ostmF3AKEFEV0qg1+uwo/
	 dRJtkNNF5zwAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	maz@kernel.org
Cc: Hyesoo Yu <hyesoo.yu@samsung.com>,
	Quentin Perret <qperret@google.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "arm64: Force the use of CNTVCT_EL0 in __delay()" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:39:35 -0500
Message-ID: <20260301013936.1700644-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221804-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 836ED1CB80A
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 29cc0f3aa7c64d3b3cb9d94c0a0984ba6717bf72 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Fri, 13 Feb 2026 14:16:19 +0000
Subject: [PATCH] arm64: Force the use of CNTVCT_EL0 in __delay()

Quentin forwards a report from Hyesoo Yu, describing an interesting
problem with the use of WFxT in __delay() when a vcpu is loaded and
that KVM is *not* in VHE mode (either nVHE or hVHE).

In this case, CNTVOFF_EL2 is set to a non-zero value to reflect the
state of the guest virtual counter. At the same time, __delay() is
using get_cycles() to read the counter value, which is indirected to
reading CNTPCT_EL0.

The core of the issue is that WFxT is using the *virtual* counter,
while the kernel is using the physical counter, and that the offset
introduces a really bad discrepancy between the two.

Fix this by forcing the use of CNTVCT_EL0, making __delay() consistent
irrespective of the value of CNTVOFF_EL2.

Reported-by: Hyesoo Yu <hyesoo.yu@samsung.com>
Reported-by: Quentin Perret <qperret@google.com>
Reviewed-by: Quentin Perret <qperret@google.com>
Fixes: 7d26b0516a0d ("arm64: Use WFxT for __delay() when possible")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/ktosachvft2cgqd5qkukn275ugmhy6xrhxur4zqpdxlfr3qh5h@o3zrfnsq63od
Cc: stable@vger.kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/lib/delay.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index cb2062e7e2340..d02341303899e 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -23,9 +23,20 @@ static inline unsigned long xloops_to_cycles(unsigned long xloops)
 	return (xloops * loops_per_jiffy * HZ) >> 32;
 }
 
+/*
+ * Force the use of CNTVCT_EL0 in order to have the same base as WFxT.
+ * This avoids some annoying issues when CNTVOFF_EL2 is not reset 0 on a
+ * KVM host running at EL1 until we do a vcpu_put() on the vcpu. When
+ * running at EL2, the effective offset is always 0.
+ *
+ * Note that userspace cannot change the offset behind our back either,
+ * as the vcpu mutex is held as long as KVM_RUN is in progress.
+ */
+#define __delay_cycles()	__arch_counter_get_cntvct_stable()
+
 void __delay(unsigned long cycles)
 {
-	cycles_t start = get_cycles();
+	cycles_t start = __delay_cycles();
 
 	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT)) {
 		u64 end = start + cycles;
@@ -35,17 +46,17 @@ void __delay(unsigned long cycles)
 		 * early, use a WFET loop to complete the delay.
 		 */
 		wfit(end);
-		while ((get_cycles() - start) < cycles)
+		while ((__delay_cycles() - start) < cycles)
 			wfet(end);
 	} else 	if (arch_timer_evtstrm_available()) {
 		const cycles_t timer_evt_period =
 			USECS_TO_CYCLES(ARCH_TIMER_EVT_STREAM_PERIOD_US);
 
-		while ((get_cycles() - start + timer_evt_period) < cycles)
+		while ((__delay_cycles() - start + timer_evt_period) < cycles)
 			wfe();
 	}
 
-	while ((get_cycles() - start) < cycles)
+	while ((__delay_cycles() - start) < cycles)
 		cpu_relax();
 }
 EXPORT_SYMBOL(__delay);
-- 
2.51.0





