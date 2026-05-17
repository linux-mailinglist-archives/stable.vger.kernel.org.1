Return-Path: <stable+bounces-249058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jY1cK8RACWopRgQAu9opvQ
	(envelope-from <stable+bounces-249058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 06:15:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F1C55F2CE
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 06:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54446300647B
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 04:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE42F7EEA;
	Sun, 17 May 2026 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="NOVEVCXT"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE9405C55;
	Sun, 17 May 2026 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778991295; cv=none; b=WGfXnJw0XD6iB2B7VbGhYoFoYYQs6FfT/p/ixBdyM0CKI03rIfym8DlDav7+bXKxerR8HVViyNWIkLCFnthPBneqo3hmgYynG023SZOzfFdXZrJpNRlQ+if2Zzg9fdXFXyK5Lkj1cL1tMrSjzFWkXzAywNoDJcKlfsNF5RpKJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778991295; c=relaxed/simple;
	bh=HGkumJWNS9Ej6U7iitanw5ybQDQ/Vb3NEvzDetFF/Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F2Bd4xcPbiN8hlRW9h1p3itBozjZLTncuZWsOYbBUPe7/Qp0t0y1LPyPQIxuF+FsnI94fLgnACo0FVvEmBiGbZOuYqTETLXW9i/1Sma4ZyF1vzvN/n9ByROU55dsUoniXOGIZOnXHZ3R+JLsFTzAP5c41SHLwB1S5ql3RDH3aMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=NOVEVCXT; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 0736820112;
	Sun, 17 May 2026 04:14:46 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 175413EAB5;
	Sun, 17 May 2026 04:14:38 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 281AF40073;
	Sun, 17 May 2026 04:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1778991276; bh=HGkumJWNS9Ej6U7iitanw5ybQDQ/Vb3NEvzDetFF/Z0=;
	h=From:To:Cc:Subject:Date:From;
	b=NOVEVCXTSliONS2cYFmcJ/jhdQJURvY6pr3J1IjBKZqbgikpMT61/8kHEtaLK5J/O
	 lgtMIpecF94u1qzxdY/gG+fEDvJtkk/N1QjM0yziwtdy+pDdx89wiyfV7EW3h27Qyf
	 jfynIDkShyp+gsE8b9woomuVNE89XHcwHwJJ34YI=
Received: from JellyFocals.localdomain (flh2-133-200-255-32.tky.mesh.ad.jp [133.200.255.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id D2345405F3;
	Sun, 17 May 2026 04:14:30 +0000 (UTC)
From: Mingcong Bai <jeffbai@aosc.io>
To: linux-kernel@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Mingcong Bai <jeffbai@aosc.io>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: define __LITTLE_ENDIAN and __BIG_ENDIAN for math-emu
Date: Sun, 17 May 2026 12:14:21 +0800
Message-ID: <20260517041423.71243-1-jeffbai@aosc.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 37F1C55F2CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[aosc.io,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[aosc.io:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[xry111.site,aosc.io,vger.kernel.org,intel.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+];
	TAGGED_FROM(0.00)[bounces-249058-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffbai@aosc.io,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu"),
define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
warnings:

  ./include/math-emu/double.h:59:21: error: ‘__BIG_ENDIAN’ is not defined, evaluates to ‘0’ [-Werror=undef]
     59 | #if __BYTE_ORDER == __BIG_ENDIAN
        |

Cc: stable@vger.kernel.org
Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507301656.7FEX6J5W-lkp@intel.com/
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 arch/powerpc/include/asm/sfp-machine.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
index 8b957aabb826d..db8525605c026 100644
--- a/arch/powerpc/include/asm/sfp-machine.h
+++ b/arch/powerpc/include/asm/sfp-machine.h
@@ -319,10 +319,12 @@
 #define abort()								\
 	return 0
 
-#ifdef __BIG_ENDIAN
+#ifdef __BIG_ENDIAN__
 #define __BYTE_ORDER __BIG_ENDIAN
+#define __LITTLE_ENDIAN 0
 #else
 #define __BYTE_ORDER __LITTLE_ENDIAN
+#define __BIG_ENDIAN 0
 #endif
 
 /* Exception flags. */
-- 
2.52.0


