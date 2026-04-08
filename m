Return-Path: <stable+bounces-234834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIVOMx6i1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:44:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 982443C1693
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01484302C486
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8083D4134;
	Wed,  8 Apr 2026 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l+PO/iYl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5321A285;
	Wed,  8 Apr 2026 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673884; cv=none; b=Rrk35G1GGvyQlPv2xdKKgUQvzIIo1d9DLrvDZetWwc+v+xq9qNrlID8CRXB8fTnRnnDN5Xh3Qggduv5Ow5IAAdH28Xm/yGBVYHQbgOp9+OLk83ww04ZjvVc6QodA5IsjxITyDsVfNhCJ+MViZQUVDPCujHGTn4UpEIDxBQNfFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673884; c=relaxed/simple;
	bh=UFSubLCLYrQERRLFvtCFg0Ez1BRg3M+HVvug7eqXCgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVSYfXmzvyF0Q2a1f2t22dOoSuOLSy/h+alyW6Anf/u15nJPxAimFbaBNkS6quvPgheoNiWmy4yf6BnIR9bywI+mngxcBAaalT0dpHd/rlRYLVHhUnp8thRCEicDpK9RhogluVIqOTBvj0mE9V7Vk3KabYk7t1xSzBFCmbdW6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l+PO/iYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADFDC19421;
	Wed,  8 Apr 2026 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673884;
	bh=UFSubLCLYrQERRLFvtCFg0Ez1BRg3M+HVvug7eqXCgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+PO/iYlEfi7CmqbCuzDh6tgCyravygB7CZqlYK0guok/Hk00hhF0q7Ew2hNk8wo8
	 Ajcwz7eINShyc1D8pardl8eGn2ElvhQt+ouUFVIcW2CnNO20avMkL3z68k10g2B3aw
	 97cbxAdi7sun2LslYuPzhWPC4EZ/rS1Vz4oLp/34=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 6.12 126/242] MIPS: Fix the GCC version check for `__multi3 workaround
Date: Wed,  8 Apr 2026 20:02:46 +0200
Message-ID: <20260408175931.804321693@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234834-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,orcam.me.uk:email,franken.de:email,intel.com:email,gnu.org:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 982443C1693
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@orcam.me.uk>

commit ec8bf18814915460d9c617b556bf024efef26613 upstream.

It was only GCC 10 that fixed a MIPS64r6 code generation issue with a
`__multi3' libcall inefficiently produced to perform 64-bit widening
multiplication while suitable machine instructions exist to do such a
calculation.  The fix went in with GCC commit 48b2123f6336 ("re PR
target/82981 (unnecessary __multi3 call for mips64r6 linux kernel)").

Adjust our code accordingly, removing build failures such as:

mips64-linux-ld: lib/math/div64.o: in function `mul_u64_add_u64_div_u64':
div64.c:(.text+0x84): undefined reference to `__multi3'

with the GCC versions affected.

Fixes: ebabcf17bcd7 ("MIPS: Implement __multi3 for GCC7 MIPS64r6 builds")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601140146.hMLODc6v-lkp@intel.com/
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v4.15+
Reviewed-by: David Laight <david.laight.linux@gmail.com.
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/lib/multi3.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/lib/multi3.c
+++ b/arch/mips/lib/multi3.c
@@ -4,12 +4,12 @@
 #include "libgcc.h"
 
 /*
- * GCC 7 & older can suboptimally generate __multi3 calls for mips64r6, so for
+ * GCC 9 & older can suboptimally generate __multi3 calls for mips64r6, so for
  * that specific case only we implement that intrinsic here.
  *
  * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82981
  */
-#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ < 8)
+#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ < 10)
 
 /* multiply 64-bit values, low 64-bits returned */
 static inline long long notrace dmulu(long long a, long long b)
@@ -51,4 +51,4 @@ ti_type notrace __multi3(ti_type a, ti_t
 }
 EXPORT_SYMBOL(__multi3);
 
-#endif /* 64BIT && CPU_MIPSR6 && GCC7 */
+#endif /* 64BIT && CPU_MIPSR6 && GCC9 */



