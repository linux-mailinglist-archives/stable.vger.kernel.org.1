Return-Path: <stable+bounces-236167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCGoC9wT3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:03:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E53EE466
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E4FE301D940
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0586A258EF3;
	Mon, 13 Apr 2026 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nk7cYdN3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9DC25332E;
	Mon, 13 Apr 2026 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096217; cv=none; b=hbbCml07f6T/PWcoZh+IMW+Jt5xRAAklfcr4QEwhtIe9XJl28G/kK9X1RX9Nbbh6pn37lmzA7SCl4EpVVJgcoGb6wvT6p+Ei1Uin7qdqS/tY6pilGNqWBEQPZHwe/RggrsgQC/LT3SjdkHf2LDQNJwkeckZF93Jgojoc6RUI2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096217; c=relaxed/simple;
	bh=j4gWz/bcNxV9BofQZfSBLmYxuPDTnSbLawkcXHB90OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q23NCCkR+NjOw7WDkNPUAMhmHv8zWe7nENCO/JQigZHNHwwZEOx0CtCf694n7sjJAGlRGaax3yXTWDUvMh+mIipYpHum8NldU9qJ1UZarSO+l6TVLqTxErttKhUHN3wA6SHISWDgAsNwAK0pRiUP2qaiyMgvu0/VwAFchSytixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nk7cYdN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220FAC2BCAF;
	Mon, 13 Apr 2026 16:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096217;
	bh=j4gWz/bcNxV9BofQZfSBLmYxuPDTnSbLawkcXHB90OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nk7cYdN3RGwjgaTrpdhLOcM5YeEhzf7mlc91e7B2c59CrIKKPcY3BlT0/tfmUS3mF
	 YY3NuAFilXgABOPTeh6pWzx3Sq1B/G2RnuDQUlJuF2DfmZBMAF9klni1+FLTai8Lo0
	 EeCuA8j7029sYd3M7atTNPVLKJ+pqcD2Bvus1l2M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 13/86] MIPS: mm: Suppress TLB uniquification on EHINV hardware
Date: Mon, 13 Apr 2026 17:59:20 +0200
Message-ID: <20260413155732.069045212@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236167-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,orcam.me.uk:email,franken.de:email]
X-Rspamd-Queue-Id: 544E53EE466
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@orcam.me.uk>

commit 74283cfe216392c7b776ebf6045b5b15ed9dffcd upstream.

Hardware that supports the EHINV feature, mandatory for R6 ISA and FTLB
implementation, lets software mark TLB entries invalid, which eliminates
the need to ensure no duplicate matching entries are ever created.  This
feature is already used by local_flush_tlb_all(), via the UNIQUE_ENTRYHI
macro, making the preceding call to r4k_tlb_uniquify() superfluous.

The next change will also modify uniquification code such that it'll
become incompatible with the FTLB and MMID features, as well as MIPSr6
CPUs that do not implement 4KiB pages.

Therefore prevent r4k_tlb_uniquify() from being used on EHINV hardware,
as denoted by `cpu_has_tlbinv'.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/mm/tlb-r4k.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 645f77e09d5b8..65f0357958fc7 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -640,7 +640,8 @@ static void r4k_tlb_configure(void)
 	temp_tlb_entry = current_cpu_data.tlbsize - 1;
 
 	/* From this point on the ARC firmware is dead.	 */
-	r4k_tlb_uniquify();
+	if (!cpu_has_tlbinv)
+		r4k_tlb_uniquify();
 	local_flush_tlb_all();
 
 	/* Did I tell you that ARC SUCKS?  */
-- 
2.53.0




