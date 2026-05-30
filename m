Return-Path: <stable+bounces-257535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPx6CQkdG2p3/QgAu9opvQ
	(envelope-from <stable+bounces-257535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:23:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A6060F89D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBCA130C85B0
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6583546F6;
	Sat, 30 May 2026 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fj1Y1Vnm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEEA39A4A4;
	Sat, 30 May 2026 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161331; cv=none; b=aA2GGNFvgu/OEVXPyzc/f0iM1v3BxgpgGXcnV5TLJe1+C7N0ZHBVoRcTubm84aut0EuoV3ksm4Dz31LvLElscoNw8alzaxjkK2W21t9l+vR0amfhCtKV9bUwknEqg0KASJsHAz9WKwapaFSZ4WdlU3VVyWZJS68lfpX2pp4V4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161331; c=relaxed/simple;
	bh=qHUE/1TFoZYD2TpOsaCDceb2039oxsmxh5CG5V1MOrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZsgvQR8L8bcEri7c4vw/DeA+01+n0UXN3/eR4wdcXbbdmUeWn6DaMyrTaHaLxecb74rLDU1GQRJ7Yogc/SVSuk21dsRT0dg1lUboe5Ae8qQ9mr4PFkQwGnlHAPG4n9/NstxHll9SUjNrMrlVQJLRKSLNVEHvuE7mS87CSPxSEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fj1Y1Vnm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B99A1F00893;
	Sat, 30 May 2026 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161329;
	bh=Z31vyFptaDP6H4LHIrX1Am4fsS2IKqwmHovDgzTQIMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fj1Y1VnmYs7097m08ajpV49d+qC3q7dPoa68ZZa+PXBJCPt5E7by1jGMwA+7RDUzn
	 C+PgxuyAhVWz95hwPy6RqfDZ/LS3rD8r3VuP/MBNhIZ3BFDouDIpvoIX03VQjwqNQw
	 sOSzZYaMyCGUDfjVl2zNxOzdgrtA61EcLpNVvvxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andreas Larsson <andreas@gaisler.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chris Mason <clm@fb.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Sterba <dsterba@suse.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	"Jason A. Donenfeld" <jason@zx2c4.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Li Nan <linan122@huawei.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ted Tso <tytso@mit.edu>,
	Vasily Gorbik <gor@linux.ibm.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 592/969] arm64/xor: fix conflicting attributes for xor_block_template
Date: Sat, 30 May 2026 18:01:56 +0200
Message-ID: <20260530160316.763476772@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257535-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,lst.de,kernel.org,eecs.berkeley.edu,linux.ibm.com,ghiti.fr,gaisler.com,cambridgegreys.com,arndb.de,alien8.de,arm.com,fb.com,intel.com,davemloft.net,suse.com,gondor.apana.org.au,zytor.com,redhat.com,zx2c4.com,sipsolutions.net,huawei.com,gmail.com,ellerman.id.au,dabbelt.com,linaro.org,nod.at,armlinux.org.uk,mit.edu,xen0n.name,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A0A6060F89D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 675a0dd596e712404557286d0a883b54ee28e4f4 ]

Commit 2c54b423cf85 ("arm64/xor: use EOR3 instructions when available")
changes the definition to __ro_after_init instead of const, but failed to
update the external declaration in xor.h.  This was not found because
xor-neon.c doesn't include <asm/xor.h>, and can't easily do that due to
current architecture of the XOR code.

Link: https://lkml.kernel.org/r/20260327061704.3707577-4-hch@lst.de
Fixes: 2c54b423cf85 ("arm64/xor: use EOR3 instructions when available")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Tested-by: Eric Biggers <ebiggers@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Mason <clm@fb.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: David Sterba <dsterba@suse.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Li Nan <linan122@huawei.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Magnus Lindholm <linmag7@gmail.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Song Liu <song@kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Ted Ts'o <tytso@mit.edu>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/xor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
index befcd8a7abc98..7c03207157196 100644
--- a/arch/arm64/include/asm/xor.h
+++ b/arch/arm64/include/asm/xor.h
@@ -13,7 +13,7 @@
 
 #ifdef CONFIG_KERNEL_MODE_NEON
 
-extern struct xor_block_template const xor_block_inner_neon;
+extern struct xor_block_template xor_block_inner_neon __ro_after_init;
 
 static void
 xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
-- 
2.53.0




