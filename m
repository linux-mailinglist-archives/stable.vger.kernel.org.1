Return-Path: <stable+bounces-226537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DtSCPKPuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:31:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1FB2AFC00
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84FB5306C478
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34EA3A4F46;
	Tue, 17 Mar 2026 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F/VbMP7O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6F2FFDEA;
	Tue, 17 Mar 2026 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767129; cv=none; b=smrb+VAf9lAj3HReExgoGZs9xPt9Vtu0GStGDrDp+nKbObjsuZ8JKCiia15kBQpliOPFeylaqwBMS0qoEfxwyIklh0Tmb//rmcEZQfnBw1QT2J4hQ55ZT9V+FHfPAMgNIREuN48EDv65tAHpyC+FL2CClGDJos44enOt8md96Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767129; c=relaxed/simple;
	bh=ab4P6mz3cP5Mt54lrdtbHTnFWB3KpbPa+sbiQT11+Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyWtkmmJovCg8D21NprGl+MqUSlrJpzRjLO75JncQPgXlte2rlz62ksIO9/Qb48Rv+cfZsiARj2RQhHeD24vsDajWDe/SfcjB9CJt1JjUysLWn45jpqMyuvdoqBaDkqnpMZBDPzxgKhyuxcojo0R1ayv2FvJo7u2jp3TSTBPxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F/VbMP7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D4DC4CEF7;
	Tue, 17 Mar 2026 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767129;
	bh=ab4P6mz3cP5Mt54lrdtbHTnFWB3KpbPa+sbiQT11+Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/VbMP7OhyYLpGu57+lQrw+MiRo35axvcCZdnS/Fd40QevaG0Qs5CLZjEPzLI74RB
	 Okhk94Bsemm/l7bmY7JjUNT2RDw2T0R1podnRM81evplrYDdV7h3tXD0XSo0gpxmfX
	 qmPrCoqcFsCa5/mM7azMuUA7EcIbOXojwhnhu9Gk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 020/333] powerpc/kexec/core: use big-endian types for crash variables
Date: Tue, 17 Mar 2026 17:30:49 +0100
Message-ID: <20260317163000.110109090@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226537-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F1FB2AFC00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sourabh Jain <sourabhjain@linux.ibm.com>

[ Upstream commit 20197b967a6a29dab81495f25a988515bda84cfe ]

Use explicit word-sized big-endian types for kexec and crash related
variables. This makes the endianness unambiguous and avoids type
mismatches that trigger sparse warnings.

The change addresses sparse warnings like below (seen on both 32-bit
and 64-bit builds):

CHECK   ../arch/powerpc/kexec/core.c
sparse:    expected unsigned int static [addressable] [toplevel] [usertype] crashk_base
sparse:    got restricted __be32 [usertype]
sparse: warning: incorrect type in assignment (different base types)
sparse:    expected unsigned int static [addressable] [toplevel] [usertype] crashk_size
sparse:    got restricted __be32 [usertype]
sparse: warning: incorrect type in assignment (different base types)
sparse:    expected unsigned long long static [addressable] [toplevel] mem_limit
sparse:    got restricted __be32 [usertype]
sparse: warning: incorrect type in assignment (different base types)
sparse:    expected unsigned int static [addressable] [toplevel] [usertype] kernel_end
sparse:    got restricted __be32 [usertype]

No functional change intended.

Fixes: ea961a828fe7 ("powerpc: Fix endian issues in kexec and crash dump code")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512221405.VHPKPjnp-lkp@intel.com/
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20251224151257.28672-1-sourabhjain@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kexec/core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index cf803d09c8e51..f86a6fc11e91c 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -23,6 +23,7 @@
 #include <asm/firmware.h>
 
 #define cpu_to_be_ulong __PASTE(cpu_to_be, BITS_PER_LONG)
+#define __be_word __PASTE(__be, BITS_PER_LONG)
 
 #ifdef CONFIG_CRASH_DUMP
 void machine_crash_shutdown(struct pt_regs *regs)
@@ -138,25 +139,25 @@ int __init overlaps_crashkernel(unsigned long start, unsigned long size)
 }
 
 /* Values we need to export to the second kernel via the device tree. */
-static phys_addr_t crashk_base;
-static phys_addr_t crashk_size;
-static unsigned long long mem_limit;
+static __be_word crashk_base;
+static __be_word crashk_size;
+static __be_word mem_limit;
 
 static struct property crashk_base_prop = {
 	.name = "linux,crashkernel-base",
-	.length = sizeof(phys_addr_t),
+	.length = sizeof(__be_word),
 	.value = &crashk_base
 };
 
 static struct property crashk_size_prop = {
 	.name = "linux,crashkernel-size",
-	.length = sizeof(phys_addr_t),
+	.length = sizeof(__be_word),
 	.value = &crashk_size,
 };
 
 static struct property memory_limit_prop = {
 	.name = "linux,memory-limit",
-	.length = sizeof(unsigned long long),
+	.length = sizeof(__be_word),
 	.value = &mem_limit,
 };
 
@@ -185,11 +186,11 @@ static void __init export_crashk_values(struct device_node *node)
 }
 #endif /* CONFIG_CRASH_RESERVE */
 
-static phys_addr_t kernel_end;
+static __be_word kernel_end;
 
 static struct property kernel_end_prop = {
 	.name = "linux,kernel-end",
-	.length = sizeof(phys_addr_t),
+	.length = sizeof(__be_word),
 	.value = &kernel_end,
 };
 
-- 
2.51.0




