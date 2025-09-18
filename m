Return-Path: <stable+bounces-165196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA64B159F1
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8165918C0E84
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94A81624EA;
	Wed, 30 Jul 2025 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOG3KB+D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FD290BCC;
	Wed, 30 Jul 2025 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861618; cv=none; b=QzH5bkg93d9sTzRnhXJ5/07t1f7wMFWI+z2CjX5qZ8o3ne9e8DnFpnolTM+o5GenDo43tUrUAmxUwz7Nm7ICzPucRJ88RrzmB8Efib/usQF+Y1bF0GVaw2wBpQkjyScBQr/OV3Ueyf6eEKFqY12jdQmxKeBgBybwlOaCy8K6xd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861618; c=relaxed/simple;
	bh=8Ejtt8ooS0vSndAsapFx2lVyqypvSA3mLRBaWU4MP4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J4olVoI3bm+fQNEI2tsGSe6F+R9ihYCM/G75lkriwagfhQiEvEuaX3B02tyCNkKGFCe8oqSKLhDYdD1efgKjVLXCtz3i/4HtTprT7YOvE2lsymQhwBCV6mZhzGNnIFbRS0M7I/uryrCuWoR4zTiVP+6DBRUevW/2eUtskL3qK/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOG3KB+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00D4C4CEE7;
	Wed, 30 Jul 2025 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753861618;
	bh=8Ejtt8ooS0vSndAsapFx2lVyqypvSA3mLRBaWU4MP4w=;
	h=From:To:Cc:Subject:Date:From;
	b=UOG3KB+DLc0tYBcMFpGYhb6jeYowzYZssBMGOdkJf/Fq5tSEaUEZqwHoHRgFCDQq2
	 P8Pkj84vQ+DUn4s4lXVIerauXddUDozgbYDssmcWSUUgNgTslWCBlS+RWzMcUEUXBq
	 psrxkYRUxYzO8+wWPHoPxUNresLQ2ejvhSm91U5ZkMnMSHPB9Wr3ym0gdQyDLT1YHX
	 pdf9soBiljiXr0R61LxVDcFo2n4slBmND2UJJzJdli9qsiyBN9+V/vB4TJC0rq29T7
	 ceAN4EE6qLXmpi9O+GTr209Z0/948t/ifXJJqSIae1DhA+hTv/zS6zZXiBhfI9Ues2
	 yNWv9JK3hMB1g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: "Alan J . Wylie" <alan@wylie.me.uk>,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86: XOP prefix instructions decoder support
Date: Wed, 30 Jul 2025 16:46:52 +0900
Message-ID: <175386161199.564247.597496379413236944.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Support decoding AMD's XOP prefix encoded instructions.

These instructions are introduced for Bulldozer micro architecture,
and not supported on Intel's processors. But when compiling kernel
with CONFIG_X86_NATIVE_CPU on some AMD processor (e.g. -march=bdver2),
these instructions can be used.

Reported-by: Alan J. Wylie <alan@wylie.me.uk>
Closes: https://lore.kernel.org/all/871pq06728.fsf@wylie.me.uk/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/include/asm/inat.h                        |   15 +++
 arch/x86/include/asm/insn.h                        |   51 +++++++++
 arch/x86/lib/inat.c                                |   13 ++
 arch/x86/lib/insn.c                                |   35 +++++-
 arch/x86/lib/x86-opcode-map.txt                    |  111 ++++++++++++++++++++
 arch/x86/tools/gen-insn-attr-x86.awk               |   44 ++++++++
 tools/arch/x86/include/asm/inat.h                  |   15 +++
 tools/arch/x86/include/asm/insn.h                  |   51 +++++++++
 tools/arch/x86/lib/inat.c                          |   13 ++
 tools/arch/x86/lib/insn.c                          |   35 +++++-
 tools/arch/x86/lib/x86-opcode-map.txt              |  111 ++++++++++++++++++++
 tools/arch/x86/tools/gen-insn-attr-x86.awk         |   44 ++++++++
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |    2 
 13 files changed, 513 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index 97f341777db5..1b3060a3425c 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -37,6 +37,8 @@
 #define INAT_PFX_EVEX	15	/* EVEX prefix */
 /* x86-64 REX2 prefix */
 #define INAT_PFX_REX2	16	/* 0xD5 */
+/* AMD XOP prefix */
+#define INAT_PFX_XOP	17	/* 0x8F */
 
 #define INAT_LSTPFX_MAX	3
 #define INAT_LGCPFX_MAX	11
@@ -77,6 +79,7 @@
 #define INAT_MOFFSET	(1 << (INAT_FLAG_OFFS + 3))
 #define INAT_VARIANT	(1 << (INAT_FLAG_OFFS + 4))
 #define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
+#define INAT_XOPOK	INAT_VEXOK
 #define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
 #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
@@ -111,6 +114,8 @@ extern insn_attr_t inat_get_group_attribute(insn_byte_t modrm,
 extern insn_attr_t inat_get_avx_attribute(insn_byte_t opcode,
 					  insn_byte_t vex_m,
 					  insn_byte_t vex_pp);
+extern insn_attr_t inat_get_xop_attribute(insn_byte_t opcode,
+					  insn_byte_t map_select);
 
 /* Attribute checking functions */
 static inline int inat_is_legacy_prefix(insn_attr_t attr)
@@ -164,6 +169,11 @@ static inline int inat_is_vex3_prefix(insn_attr_t attr)
 	return (attr & INAT_PFX_MASK) == INAT_PFX_VEX3;
 }
 
+static inline int inat_is_xop_prefix(insn_attr_t attr)
+{
+	return (attr & INAT_PFX_MASK) == INAT_PFX_XOP;
+}
+
 static inline int inat_is_escape(insn_attr_t attr)
 {
 	return attr & INAT_ESC_MASK;
@@ -229,6 +239,11 @@ static inline int inat_accept_vex(insn_attr_t attr)
 	return attr & INAT_VEXOK;
 }
 
+static inline int inat_accept_xop(insn_attr_t attr)
+{
+	return attr & INAT_XOPOK;
+}
+
 static inline int inat_must_vex(insn_attr_t attr)
 {
 	return attr & (INAT_VEXONLY | INAT_EVEXONLY);
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 7152ea809e6a..091f88c8254d 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -71,7 +71,10 @@ struct insn {
 					 * prefixes.bytes[3]: last prefix
 					 */
 	struct insn_field rex_prefix;	/* REX prefix */
-	struct insn_field vex_prefix;	/* VEX prefix */
+	union {
+		struct insn_field vex_prefix;	/* VEX prefix */
+		struct insn_field xop_prefix;	/* XOP prefix */
+	};
 	struct insn_field opcode;	/*
 					 * opcode.bytes[0]: opcode1
 					 * opcode.bytes[1]: opcode2
@@ -135,6 +138,17 @@ struct insn {
 #define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_P(vex)	((vex) & 0x03)		/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_M_MAX	0x1f			/* VEX3.M Maximum value */
+/* XOP bit fields */
+#define X86_XOP_R(xop)	((xop) & 0x80)	/* XOP Byte2 */
+#define X86_XOP_X(xop)	((xop) & 0x40)	/* XOP Byte2 */
+#define X86_XOP_B(xop)	((xop) & 0x20)	/* XOP Byte2 */
+#define X86_XOP_M(xop)	((xop) & 0x1f)	/* XOP Byte2 */
+#define X86_XOP_W(xop)	((xop) & 0x80)	/* XOP Byte3 */
+#define X86_XOP_V(xop)	((xop) & 0x78)	/* XOP Byte3 */
+#define X86_XOP_L(xop)	((xop) & 0x04)	/* XOP Byte3 */
+#define X86_XOP_P(xop)	((xop) & 0x03)	/* XOP Byte3 */
+#define X86_XOP_M_MIN	0x08	/* Min of XOP.M */
+#define X86_XOP_M_MAX	0x1f	/* Max of XOP.M */
 
 extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
 extern int insn_get_prefixes(struct insn *insn);
@@ -178,7 +192,7 @@ static inline insn_byte_t insn_rex2_m_bit(struct insn *insn)
 	return X86_REX2_M(insn->rex_prefix.bytes[1]);
 }
 
-static inline int insn_is_avx(struct insn *insn)
+static inline int insn_is_avx_or_xop(struct insn *insn)
 {
 	if (!insn->prefixes.got)
 		insn_get_prefixes(insn);
@@ -192,6 +206,22 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes == 4);
 }
 
+/* If we already know this is AVX/XOP encoded */
+static inline int avx_insn_is_xop(struct insn *insn)
+{
+	insn_attr_t attr = inat_get_opcode_attribute(insn->vex_prefix.bytes[0]);
+
+	return inat_is_xop_prefix(attr);
+}
+
+static inline int insn_is_xop(struct insn *insn)
+{
+	if (!insn_is_avx_or_xop(insn))
+		return 0;
+
+	return avx_insn_is_xop(insn);
+}
+
 static inline int insn_has_emulate_prefix(struct insn *insn)
 {
 	return !!insn->emulate_prefix_size;
@@ -222,11 +252,26 @@ static inline insn_byte_t insn_vex_w_bit(struct insn *insn)
 	return X86_VEX_W(insn->vex_prefix.bytes[2]);
 }
 
+static inline insn_byte_t insn_xop_map_bits(struct insn *insn)
+{
+	if (insn->xop_prefix.nbytes < 3)	/* XOP is 3 bytes */
+		return 0;
+	return X86_XOP_M(insn->xop_prefix.bytes[1]);
+}
+
+static inline insn_byte_t insn_xop_p_bits(struct insn *insn)
+{
+	return X86_XOP_P(insn->vex_prefix.bytes[2]);
+}
+
 /* Get the last prefix id from last prefix or VEX prefix */
 static inline int insn_last_prefix_id(struct insn *insn)
 {
-	if (insn_is_avx(insn))
+	if (insn_is_avx_or_xop(insn)) {
+		if (avx_insn_is_xop(insn))
+			return insn_xop_p_bits(insn);
 		return insn_vex_p_bits(insn);	/* VEX_p is a SIMD prefix id */
+	}
 
 	if (insn->prefixes.bytes[3])
 		return inat_get_last_prefix_id(insn->prefixes.bytes[3]);
diff --git a/arch/x86/lib/inat.c b/arch/x86/lib/inat.c
index b0f3b2a62ae2..a5cafd402cfd 100644
--- a/arch/x86/lib/inat.c
+++ b/arch/x86/lib/inat.c
@@ -81,3 +81,16 @@ insn_attr_t inat_get_avx_attribute(insn_byte_t opcode, insn_byte_t vex_m,
 	return table[opcode];
 }
 
+insn_attr_t inat_get_xop_attribute(insn_byte_t opcode, insn_byte_t map_select)
+{
+	const insn_attr_t *table;
+
+	if (map_select < X86_XOP_M_MIN || map_select > X86_XOP_M_MAX)
+		return 0;
+	map_select -= X86_XOP_M_MIN;
+	/* At first, this checks the master table */
+	table = inat_xop_tables[map_select];
+	if (!table)
+		return 0;
+	return table[opcode];
+}
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 149a57e334ab..225af1399c9d 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -200,12 +200,15 @@ int insn_get_prefixes(struct insn *insn)
 	}
 	insn->rex_prefix.got = 1;
 
-	/* Decode VEX prefix */
+	/* Decode VEX/XOP prefix */
 	b = peek_next(insn_byte_t, insn);
-	attr = inat_get_opcode_attribute(b);
-	if (inat_is_vex_prefix(attr)) {
+	if (inat_is_vex_prefix(attr) || inat_is_xop_prefix(attr)) {
 		insn_byte_t b2 = peek_nbyte_next(insn_byte_t, insn, 1);
-		if (!insn->x86_64) {
+
+		if (inat_is_xop_prefix(attr) && X86_MODRM_REG(b2) == 0) {
+			/* Grp1A.0 is always POP Ev */
+			goto vex_end;
+		} else if (!insn->x86_64) {
 			/*
 			 * In 32-bits mode, if the [7:6] bits (mod bits of
 			 * ModRM) on the second byte are not 11b, it is
@@ -226,13 +229,13 @@ int insn_get_prefixes(struct insn *insn)
 			if (insn->x86_64 && X86_VEX_W(b2))
 				/* VEX.W overrides opnd_size */
 				insn->opnd_bytes = 8;
-		} else if (inat_is_vex3_prefix(attr)) {
+		} else if (inat_is_vex3_prefix(attr) || inat_is_xop_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
 			insn_set_byte(&insn->vex_prefix, 2, b2);
 			insn->vex_prefix.nbytes = 3;
 			insn->next_byte += 3;
 			if (insn->x86_64 && X86_VEX_W(b2))
-				/* VEX.W overrides opnd_size */
+				/* VEX.W/XOP.W overrides opnd_size */
 				insn->opnd_bytes = 8;
 		} else {
 			/*
@@ -288,9 +291,22 @@ int insn_get_opcode(struct insn *insn)
 	insn_set_byte(opcode, 0, op);
 	opcode->nbytes = 1;
 
-	/* Check if there is VEX prefix or not */
-	if (insn_is_avx(insn)) {
+	/* Check if there is VEX/XOP prefix or not */
+	if (insn_is_avx_or_xop(insn)) {
 		insn_byte_t m, p;
+
+		/* XOP prefix has different encoding */
+		if (unlikely(avx_insn_is_xop(insn))) {
+			m = insn_xop_map_bits(insn);
+			insn->attr = inat_get_xop_attribute(op, m);
+			if (!inat_accept_xop(insn->attr)) {
+				insn->attr = 0;
+				return -EINVAL;
+			}
+			/* XOP has only 1 byte for opcode */
+			goto end;
+		}
+
 		m = insn_vex_m_bits(insn);
 		p = insn_vex_p_bits(insn);
 		insn->attr = inat_get_avx_attribute(op, m, p);
@@ -383,7 +399,8 @@ int insn_get_modrm(struct insn *insn)
 			pfx_id = insn_last_prefix_id(insn);
 			insn->attr = inat_get_group_attribute(mod, pfx_id,
 							      insn->attr);
-			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
+			if (insn_is_avx_or_xop(insn) && !inat_accept_vex(insn->attr) &&
+			    !inat_accept_xop(insn->attr)) {
 				/* Bad insn */
 				insn->attr = 0;
 				return -EINVAL;
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 262f7ca1fb95..2a4e69ecc2de 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -27,6 +27,11 @@
 #  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
 #  (v): this opcode requires VEX prefix.
 #  (v1): this opcode only supports 128bit VEX.
+#  (xop): this opcode accepts XOP prefix.
+#
+# XOP Superscripts
+#  (W=0): this opcode requires XOP.W == 0
+#  (W=1): this opcode requires XOP.W == 1
 #
 # Last Prefix Superscripts
 #  - (66): the last prefix is 0x66
@@ -194,7 +199,7 @@ AVXcode:
 8c: MOV Ev,Sw
 8d: LEA Gv,M
 8e: MOV Sw,Ew
-8f: Grp1A (1A) | POP Ev (d64)
+8f: Grp1A (1A) | POP Ev (d64) | XOP (Prefix)
 # 0x90 - 0x9f
 90: NOP | PAUSE (F3) | XCHG r8,rAX
 91: XCHG rCX/r9,rAX
@@ -1106,6 +1111,84 @@ AVXcode: 7
 f8: URDMSR Rq,Id (F2),(v1),(11B) | UWRMSR Id,Rq (F3),(v1),(11B)
 EndTable
 
+# From AMD64 Architecture Programmer's Manual Vol3, Appendix A.1.5
+Table: XOP map 8h
+Referrer:
+XOPcode: 0
+85: VPMACSSWW Vo,Ho,Wo,Lo
+86: VPMACSSWD Vo,Ho,Wo,Lo
+87: VPMACSSDQL Vo,Ho,Wo,Lo
+8e: VPMACSSDD Vo,Ho,Wo,Lo
+8f: VPMACSSDQH Vo,Ho,Wo,Lo
+95: VPMACSWW Vo,Ho,Wo,Lo
+96: VPMACSWD Vo,Ho,Wo,Lo
+97: VPMACSDQL Vo,Ho,Wo,Lo
+9e: VPMACSDD Vo,Ho,Wo,Lo
+9f: VPMACSDQH Vo,Ho,Wo,Lo
+a2: VPCMOV Vx,Hx,Wx,Lx (W=0) | VPCMOV Vx,Hx,Lx,Wx (W=1)
+a3: VPPERM Vo,Ho,Wo,Lo (W=0) | VPPERM Vo,Ho,Lo,Wo (W=1)
+a6: VPMADCSSWD Vo,Ho,Wo,Lo
+b6: VPMADCSWD Vo,Ho,Wo,Lo
+c0: VPROTB Vo,Wo,Ib
+c1: VPROTW Vo,Wo,Ib
+c2: VPROTD Vo,Wo,Ib
+c3: VPROTQ Vo,Wo,Ib
+cc: VPCOMccB Vo,Ho,Wo,Ib
+cd: VPCOMccW Vo,Ho,Wo,Ib
+ce: VPCOMccD Vo,Ho,Wo,Ib
+cf: VPCOMccQ Vo,Ho,Wo,Ib
+ec: VPCOMccUB Vo,Ho,Wo,Ib
+ed: VPCOMccUW Vo,Ho,Wo,Ib
+ee: VPCOMccUD Vo,Ho,Wo,Ib
+ef: VPCOMccUQ Vo,Ho,Wo,Ib
+EndTable
+
+Table: XOP map 9h
+Referrer:
+XOPcode: 1
+01: GrpXOP1
+02: GrpXOP2
+12: GrpXOP3
+80: VFRCZPS Vx,Wx
+81: VFRCZPD Vx,Wx
+82: VFRCZSS Vq,Wss
+83: VFRCZSD Vq,Wsd
+90: VPROTB Vo,Wo,Ho (W=0) | VPROTB Vo,Ho,Wo (W=1)
+91: VPROTW Vo,Wo,Ho (W=0) | VPROTB Vo,Ho,Wo (W=1)
+92: VPROTD Vo,Wo,Ho (W=0) | VPROTB Vo,Ho,Wo (W=1)
+93: VPROTQ Vo,Wo,Ho (W=0) | VPROTB Vo,Ho,Wo (W=1)
+94: VPSHLB Vo,Wo,Ho (W=0) | VPSHLB Vo,Ho,Wo (W=1)
+95: VPSHLW Vo,Wo,Ho (W=0) | VPSHLW Vo,Ho,Wo (W=1)
+96: VPSHLD Vo,Wo,Ho (W=0) | VPSHLD Vo,Ho,Wo (W=1)
+97: VPSHLQ Vo,Wo,Ho (W=0) | VPSHLQ Vo,Ho,Wo (W=1)
+98: VPSHAB Vo,Wo,Ho (W=0) | VPSHAB Vo,Ho,Wo (W=1)
+99: VPSHAW Vo,Wo,Ho (W=0) | VPSHAW Vo,Ho,Wo (W=1)
+9a: VPSHAD Vo,Wo,Ho (W=0) | VPSHAD Vo,Ho,Wo (W=1)
+9b: VPSHAQ Vo,Wo,Ho (W=0) | VPSHAQ Vo,Ho,Wo (W=1)
+c1: VPHADDBW Vo,Wo
+c2: VPHADDBD Vo,Wo
+c3: VPHADDBQ Vo,Wo
+c6: VPHADDWD Vo,Wo
+c7: VPHADDWQ Vo,Wo
+cb: VPHADDDQ Vo,Wo
+d1: VPHADDUBWD Vo,Wo
+d2: VPHADDUBD Vo,Wo
+d3: VPHADDUBQ Vo,Wo
+d6: VPHADDUWD Vo,Wo
+d7: VPHADDUWQ Vo,Wo
+db: VPHADDUDQ Vo,Wo
+e1: VPHSUBBW Vo,Wo
+e2: VPHSUBWD Vo,Wo
+e3: VPHSUBDQ Vo,Wo
+EndTable
+
+Table: XOP map Ah
+Referrer:
+XOPcode: 2
+10: BEXTR Gy,Ey,Id
+12: GrpXOP4
+EndTable
+
 GrpTable: Grp1
 0: ADD
 1: OR
@@ -1320,3 +1403,29 @@ GrpTable: GrpRNG
 4: xcrypt-cfb
 5: xcrypt-ofb
 EndTable
+
+# GrpXOP1-4 is shown in AMD APM Vol.3 Appendix A as XOP group #1-4
+GrpTable: GrpXOP1
+1: BLCFILL By,Ey (xop)
+2: BLSFILL By,Ey (xop)
+3: BLCS By,Ey (xop)
+4: TZMSK By,Ey (xop)
+5: BLCIC By,Ey (xop)
+6: BLSIC By,Ey (xop)
+7: T1MSKC By,Ey (xop)
+EndTable
+
+GrpTable: GrpXOP2
+1: BLCMSK By,Ey (xop)
+6: BLCI By,Ey (xop)
+EndTable
+
+GrpTable: GrpXOP3
+0: LLWPCB Ry (xop)
+1: SLWPCB Ry (xop)
+EndTable
+
+GrpTable: GrpXOP4
+0: LWPINS By,Ed,Id (xop)
+1: LWPVAL By,Ed,Id (xop)
+EndTable
diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index 2c19d7fc8a85..7ea1b75e59b7 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -21,6 +21,7 @@ function clear_vars() {
 	eid = -1 # escape id
 	gid = -1 # group id
 	aid = -1 # AVX id
+	xopid = -1 # XOP id
 	tname = ""
 }
 
@@ -39,9 +40,11 @@ BEGIN {
 	ggid = 1
 	geid = 1
 	gaid = 0
+	gxopid = 0
 	delete etable
 	delete gtable
 	delete atable
+	delete xoptable
 
 	opnd_expr = "^[A-Za-z/]"
 	ext_expr = "^\\("
@@ -61,6 +64,7 @@ BEGIN {
 	imm_flag["Ob"] = "INAT_MOFFSET"
 	imm_flag["Ov"] = "INAT_MOFFSET"
 	imm_flag["Lx"] = "INAT_MAKE_IMM(INAT_IMM_BYTE)"
+	imm_flag["Lo"] = "INAT_MAKE_IMM(INAT_IMM_BYTE)"
 
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
@@ -87,6 +91,8 @@ BEGIN {
 	evexonly_expr = "\\(ev\\)"
 	# (es) is the same as (ev) but also "SCALABLE" i.e. W and pp determine operand size
 	evex_scalable_expr = "\\(es\\)"
+	# All opcodes in XOP table or with (xop) superscript accept XOP prefix
+	xopok_expr = "\\(xop\\)"
 
 	prefix_expr = "\\(Prefix\\)"
 	prefix_num["Operand-Size"] = "INAT_PFX_OPNDSZ"
@@ -106,6 +112,7 @@ BEGIN {
 	prefix_num["VEX+2byte"] = "INAT_PFX_VEX3"
 	prefix_num["EVEX"] = "INAT_PFX_EVEX"
 	prefix_num["REX2"] = "INAT_PFX_REX2"
+	prefix_num["XOP"] = "INAT_PFX_XOP"
 
 	clear_vars()
 }
@@ -147,6 +154,7 @@ function array_size(arr,   i,c) {
 	if (NF != 1) {
 		# AVX/escape opcode table
 		aid = $2
+		xopid = -1
 		if (gaid <= aid)
 			gaid = aid + 1
 		if (tname == "")	# AVX only opcode table
@@ -156,6 +164,20 @@ function array_size(arr,   i,c) {
 		tname = "inat_primary_table"
 }
 
+/^XOPcode:/ {
+	if (NF != 1) {
+		# XOP opcode table
+		xopid = $2
+		aid = -1
+		if (gxopid <= xopid)
+			gxopid = xopid + 1
+		if (tname == "")	# XOP only opcode table
+			tname = sprintf("inat_xop_table_%d", $2)
+	}
+	if (xopid == -1 && eid == -1)	# primary opcode table
+		tname = "inat_primary_table"
+}
+
 /^GrpTable:/ {
 	print "/* " $0 " */"
 	if (!($2 in group))
@@ -206,6 +228,8 @@ function print_table(tbl,name,fmt,n)
 			etable[eid,0] = tname
 			if (aid >= 0)
 				atable[aid,0] = tname
+			else if (xopid >= 0)
+				xoptable[xopid] = tname
 		}
 		if (array_size(lptable1) != 0) {
 			print_table(lptable1,tname "_1[INAT_OPCODE_TABLE_SIZE]",
@@ -347,6 +371,8 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			flags = add_flags(flags, "INAT_VEXOK | INAT_VEXONLY")
 		else if (match(ext, vexok_expr) || match(opcode, vexok_opcode_expr))
 			flags = add_flags(flags, "INAT_VEXOK")
+		else if (match(ext, xopok_expr) || xopid >= 0)
+			flags = add_flags(flags, "INAT_XOPOK")
 
 		# check prefixes
 		if (match(ext, prefix_expr)) {
@@ -413,6 +439,14 @@ END {
 				print "	["i"]["j"] = "atable[i,j]","
 	print "};\n"
 
+	print "/* XOP opcode map array */"
+	print "const insn_attr_t * const inat_xop_tables[X86_XOP_M_MAX - X86_XOP_M_MIN + 1]" \
+	      " = {"
+	for (i = 0; i < gxopid; i++)
+		if (xoptable[i])
+			print "	["i"] = "xoptable[i]","
+	print "};"
+
 	print "#else /* !__BOOT_COMPRESSED */\n"
 
 	print "/* Escape opcode map array */"
@@ -430,6 +464,10 @@ END {
 	      "[INAT_LSTPFX_MAX + 1];"
 	print ""
 
+	print "/* XOP opcode map array */"
+	print "static const insn_attr_t *inat_xop_tables[X86_XOP_M_MAX - X86_XOP_M_MIN + 1];"
+	print ""
+
 	print "static void inat_init_tables(void)"
 	print "{"
 
@@ -455,6 +493,12 @@ END {
 			if (atable[i,j])
 				print "\tinat_avx_tables["i"]["j"] = "atable[i,j]";"
 
+	print ""
+	print "\t/* Print XOP opcode map array */"
+	for (i = 0; i < gxopid; i++)
+		if (xoptable[i])
+			print "\tinat_xop_tables["i"] = "xoptable[i]";"
+
 	print "}"
 	print "#endif"
 }
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 183aa662b165..099e926595bd 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -37,6 +37,8 @@
 #define INAT_PFX_EVEX	15	/* EVEX prefix */
 /* x86-64 REX2 prefix */
 #define INAT_PFX_REX2	16	/* 0xD5 */
+/* AMD XOP prefix */
+#define INAT_PFX_XOP	17	/* 0x8F */
 
 #define INAT_LSTPFX_MAX	3
 #define INAT_LGCPFX_MAX	11
@@ -77,6 +79,7 @@
 #define INAT_MOFFSET	(1 << (INAT_FLAG_OFFS + 3))
 #define INAT_VARIANT	(1 << (INAT_FLAG_OFFS + 4))
 #define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
+#define INAT_XOPOK	INAT_VEXOK
 #define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
 #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
@@ -111,6 +114,8 @@ extern insn_attr_t inat_get_group_attribute(insn_byte_t modrm,
 extern insn_attr_t inat_get_avx_attribute(insn_byte_t opcode,
 					  insn_byte_t vex_m,
 					  insn_byte_t vex_pp);
+extern insn_attr_t inat_get_xop_attribute(insn_byte_t opcode,
+					  insn_byte_t map_select);
 
 /* Attribute checking functions */
 static inline int inat_is_legacy_prefix(insn_attr_t attr)
@@ -164,6 +169,11 @@ static inline int inat_is_vex3_prefix(insn_attr_t attr)
 	return (attr & INAT_PFX_MASK) == INAT_PFX_VEX3;
 }
 
+static inline int inat_is_xop_prefix(insn_attr_t attr)
+{
+	return (attr & INAT_PFX_MASK) == INAT_PFX_XOP;
+}
+
 static inline int inat_is_escape(insn_attr_t attr)
 {
 	return attr & INAT_ESC_MASK;
@@ -229,6 +239,11 @@ static inline int inat_accept_vex(insn_attr_t attr)
 	return attr & INAT_VEXOK;
 }
 
+static inline int inat_accept_xop(insn_attr_t attr)
+{
+	return attr & INAT_XOPOK;
+}
+
 static inline int inat_must_vex(insn_attr_t attr)
 {
 	return attr & (INAT_VEXONLY | INAT_EVEXONLY);
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 0e5abd896ad4..c683d609934b 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -71,7 +71,10 @@ struct insn {
 					 * prefixes.bytes[3]: last prefix
 					 */
 	struct insn_field rex_prefix;	/* REX prefix */
-	struct insn_field vex_prefix;	/* VEX prefix */
+	union {
+		struct insn_field vex_prefix;	/* VEX prefix */
+		struct insn_field xop_prefix;	/* XOP prefix */
+	};
 	struct insn_field opcode;	/*
 					 * opcode.bytes[0]: opcode1
 					 * opcode.bytes[1]: opcode2
@@ -135,6 +138,17 @@ struct insn {
 #define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_P(vex)	((vex) & 0x03)		/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_M_MAX	0x1f			/* VEX3.M Maximum value */
+/* XOP bit fields */
+#define X86_XOP_R(xop)	((xop) & 0x80)	/* XOP Byte2 */
+#define X86_XOP_X(xop)	((xop) & 0x40)	/* XOP Byte2 */
+#define X86_XOP_B(xop)	((xop) & 0x20)	/* XOP Byte2 */
+#define X86_XOP_M(xop)	((xop) & 0x1f)	/* XOP Byte2 */
+#define X86_XOP_W(xop)	((xop) & 0x80)	/* XOP Byte3 */
+#define X86_XOP_V(xop)	((xop) & 0x78)	/* XOP Byte3 */
+#define X86_XOP_L(xop)	((xop) & 0x04)	/* XOP Byte3 */
+#define X86_XOP_P(xop)	((xop) & 0x03)	/* XOP Byte3 */
+#define X86_XOP_M_MIN	0x08	/* Min of XOP.M */
+#define X86_XOP_M_MAX	0x1f	/* Max of XOP.M */
 
 extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
 extern int insn_get_prefixes(struct insn *insn);
@@ -178,7 +192,7 @@ static inline insn_byte_t insn_rex2_m_bit(struct insn *insn)
 	return X86_REX2_M(insn->rex_prefix.bytes[1]);
 }
 
-static inline int insn_is_avx(struct insn *insn)
+static inline int insn_is_avx_or_xop(struct insn *insn)
 {
 	if (!insn->prefixes.got)
 		insn_get_prefixes(insn);
@@ -192,6 +206,22 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes == 4);
 }
 
+/* If we already know this is AVX/XOP encoded */
+static inline int avx_insn_is_xop(struct insn *insn)
+{
+	insn_attr_t attr = inat_get_opcode_attribute(insn->vex_prefix.bytes[0]);
+
+	return inat_is_xop_prefix(attr);
+}
+
+static inline int insn_is_xop(struct insn *insn)
+{
+	if (!insn_is_avx_or_xop(insn))
+		return 0;
+
+	return avx_insn_is_xop(insn);
+}
+
 static inline int insn_has_emulate_prefix(struct insn *insn)
 {
 	return !!insn->emulate_prefix_size;
@@ -222,11 +252,26 @@ static inline insn_byte_t insn_vex_w_bit(struct insn *insn)
 	return X86_VEX_W(insn->vex_prefix.bytes[2]);
 }
 
+static inline insn_byte_t insn_xop_map_bits(struct insn *insn)
+{
+	if (insn->xop_prefix.nbytes < 3)	/* XOP is 3 bytes */
+		return 0;
+	return X86_XOP_M(insn->xop_prefix.bytes[1]);
+}
+
+static inline insn_byte_t insn_xop_p_bits(struct insn *insn)
+{
+	return X86_XOP_P(insn->vex_prefix.bytes[2]);
+}
+
 /* Get the last prefix id from last prefix or VEX prefix */
 static inline int insn_last_prefix_id(struct insn *insn)
 {
-	if (insn_is_avx(insn))
+	if (insn_is_avx_or_xop(insn)) {
+		if (avx_insn_is_xop(insn))
+			return insn_xop_p_bits(insn);
 		return insn_vex_p_bits(insn);	/* VEX_p is a SIMD prefix id */
+	}
 
 	if (insn->prefixes.bytes[3])
 		return inat_get_last_prefix_id(insn->prefixes.bytes[3]);
diff --git a/tools/arch/x86/lib/inat.c b/tools/arch/x86/lib/inat.c
index dfbcc6405941..ffcb0e27453b 100644
--- a/tools/arch/x86/lib/inat.c
+++ b/tools/arch/x86/lib/inat.c
@@ -81,3 +81,16 @@ insn_attr_t inat_get_avx_attribute(insn_byte_t opcode, insn_byte_t vex_m,
 	return table[opcode];
 }
 
+insn_attr_t inat_get_xop_attribute(insn_byte_t opcode, insn_byte_t map_select)
+{
+	const insn_attr_t *table;
+
+	if (map_select < X86_XOP_M_MIN || map_select > X86_XOP_M_MAX)
+		return 0;
+	map_select -= X86_XOP_M_MIN;
+	/* At first, this checks the master table */
+	table = inat_xop_tables[map_select];
+	if (!table)
+		return 0;
+	return table[opcode];
+}
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index bce69c6bfa69..1d1c57c74d1f 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -200,12 +200,15 @@ int insn_get_prefixes(struct insn *insn)
 	}
 	insn->rex_prefix.got = 1;
 
-	/* Decode VEX prefix */
+	/* Decode VEX/XOP prefix */
 	b = peek_next(insn_byte_t, insn);
-	attr = inat_get_opcode_attribute(b);
-	if (inat_is_vex_prefix(attr)) {
+	if (inat_is_vex_prefix(attr) || inat_is_xop_prefix(attr)) {
 		insn_byte_t b2 = peek_nbyte_next(insn_byte_t, insn, 1);
-		if (!insn->x86_64) {
+
+		if (inat_is_xop_prefix(attr) && X86_MODRM_REG(b2) == 0) {
+			/* Grp1A.0 is always POP Ev */
+			goto vex_end;
+		} else if (!insn->x86_64) {
 			/*
 			 * In 32-bits mode, if the [7:6] bits (mod bits of
 			 * ModRM) on the second byte are not 11b, it is
@@ -226,13 +229,13 @@ int insn_get_prefixes(struct insn *insn)
 			if (insn->x86_64 && X86_VEX_W(b2))
 				/* VEX.W overrides opnd_size */
 				insn->opnd_bytes = 8;
-		} else if (inat_is_vex3_prefix(attr)) {
+		} else if (inat_is_vex3_prefix(attr) || inat_is_xop_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
 			insn_set_byte(&insn->vex_prefix, 2, b2);
 			insn->vex_prefix.nbytes = 3;
 			insn->next_byte += 3;
 			if (insn->x86_64 && X86_VEX_W(b2))
-				/* VEX.W overrides opnd_size */
+				/* VEX.W/XOP.W overrides opnd_size */
 				insn->opnd_bytes = 8;
 		} else {
 			/*
@@ -288,9 +291,22 @@ int insn_get_opcode(struct insn *insn)
 	insn_set_byte(opcode, 0, op);
 	opcode->nbytes = 1;
 
-	/* Check if there is VEX prefix or not */
-	if (insn_is_avx(insn)) {
+	/* Check if there is VEX/XOP prefix or not */
+	if (insn_is_avx_or_xop(insn)) {
 		insn_byte_t m, p;
+
+		/* XOP prefix has different encoding */
+		if (unlikely(avx_insn_is_xop(insn))) {
+			m = insn_xop_map_bits(insn);
+			insn->attr = inat_get_xop_attribute(op, m);
+			if (!inat_accept_xop(insn->attr)) {
+				insn->attr = 0;
+				return -EINVAL;
+			}
+			/* XOP has only 1 byte for opcode */
+			goto end;
+		}
+
 		m = insn_vex_m_bits(insn);
 		p = insn_vex_p_bits(insn);
 		insn->attr = inat_get_avx_attribute(op, m, p);
@@ -383,7 +399,8 @@ int insn_get_modrm(struct insn *insn)
 			pfx_id = insn_last_prefix_id(insn);
 			insn->attr = inat_get_group_attribute(mod, pfx_id,
 							      insn->attr);
-			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
+			if (insn_is_avx_or_xop(insn) && !inat_accept_vex(insn->attr) &&
+			    !inat_accept_xop(insn->attr)) {
 				/* Bad insn */
 				insn->attr = 0;
 				return -EINVAL;
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 262f7ca1fb95..2a4e69ecc2de 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -27,6 +27,11 @@
 #  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
 #  (v): this opcode requires VEX prefix.
 #  (v1): this opcode only supports 128bit VEX.
+#  (xop): this opcode accepts XOP prefix.
+#
+# XOP Superscripts
+#  (W=0): this opcode requires XOP.W == 0
+#  (W=1): this opcode requires XOP.W == 1
 #
 # Last Prefix Superscripts
 #  - (66): the last prefix is 0x66
@@ -194,7 +199,7 @@ AVXcode:
 8c: MOV Ev,Sw
 8d: LEA Gv,M
 8e: MOV Sw,Ew
-8f: Grp1A (1A) | POP Ev (d64)
+8f: Grp1A (1A) | POP Ev (d64) | XOP (Prefix)
 # 0x90 - 0x9f
 90: NOP | PAUSE (F3) | XCHG r8,rAX
 91: XCHG rCX/r9,rAX
@@ -1106,6 +1111,84 @@ AVXcode: 7
 f8: URDMSR Rq,Id (F2),(v1),(11B) | UWRMSR Id,Rq (F3),(v1),(11B)
 EndTable
 
+# From AMD64 Architecture Programmer's Manual Vol3, Appendix A.1.5
+Table: XOP map 8h
+Referrer:
+XOPcode: 0
+85: VPMACSSWW Vo,Ho,Wo,Lo
+86: VPMACSSWD Vo,Ho,Wo,Lo
+87: VPMACSSDQL Vo,Ho,Wo,Lo
+8e: VPMACSSDD Vo,Ho,Wo,Lo
+8f: VPMACSSDQH Vo,Ho,Wo,Lo
+95: VPMACSWW Vo,Ho,Wo,Lo
+96: VPMACSWD Vo,Ho,Wo,Lo
+97: VPMACSDQL Vo,Ho,Wo,Lo
+9e: VPMACSDD Vo,Ho,Wo,Lo
+9f: VPMACSDQH Vo,Ho,Wo,Lo
+a2: VPCMOV Vx,Hx,Wx,Lx (W=0) | VPCMOV Vx,Hx,Lx,Wx (W=1)
+a3: VPPERM Vo,Ho,Wo,Lo (W=0) | VPPERM Vo,Ho,Lo,Wo (W=1)
+a6: VPMADCSSWD Vo,Ho,Wo,Lo
+b6: VPMADCSWD Vo,Ho,Wo,Lo
+c0: VPROTB Vo,Wo,Ib
+c1: VPROTW Vo,Wo,Ib
+c2: VPROTD Vo,Wo,Ib
+c3: VPROTQ Vo,Wo,Ib
+cc: VPCOMccB Vo,Ho,Wo,Ib
+cd: VPCOMccW Vo,Ho,Wo,Ib
+ce: VPCOMccD Vo,Ho,Wo,Ib
+cf: VPCOMccQ Vo,Ho,Wo,Ib
+ec: VPCOMccUB Vo,Ho,Wo,Ib
+ed: VPCOMccUW Vo,Ho,Wo,Ib
+ee: VPCOMccUD Vo,Ho,Wo,Ib
+ef: VPCOMccUQ Vo,Ho,Wo,Ib
+EndTable
+
+Table: XOP map 9h
+Referrer:
+XOPcode: 1
+01: GrpXOP1
+02: GrpXOP2
+12: GrpXOP3
+80: VFRCZPS Vx,Wx
+81: VFRCZPD Vx,Wx
+82: VFRCZSS Vq,Wss
+83: VFRCZSD Vq,Wsd
+90: VPROTB Vo,Wo,Ho (W=0) | VPROTB Vo,Ho,Wo (W=1)
+91: VPROTW Vo,Wo,Ho (W=0) | VPROTB Vo,Ho,Wo (W=1)
+92: VPROTD Vo,Wo,Ho (W=0) | VPROTB Vo,Ho,Wo (W=1)
+93: VPROTQ Vo,Wo,Ho (W=0) | VPROTB Vo,Ho,Wo (W=1)
+94: VPSHLB Vo,Wo,Ho (W=0) | VPSHLB Vo,Ho,Wo (W=1)
+95: VPSHLW Vo,Wo,Ho (W=0) | VPSHLW Vo,Ho,Wo (W=1)
+96: VPSHLD Vo,Wo,Ho (W=0) | VPSHLD Vo,Ho,Wo (W=1)
+97: VPSHLQ Vo,Wo,Ho (W=0) | VPSHLQ Vo,Ho,Wo (W=1)
+98: VPSHAB Vo,Wo,Ho (W=0) | VPSHAB Vo,Ho,Wo (W=1)
+99: VPSHAW Vo,Wo,Ho (W=0) | VPSHAW Vo,Ho,Wo (W=1)
+9a: VPSHAD Vo,Wo,Ho (W=0) | VPSHAD Vo,Ho,Wo (W=1)
+9b: VPSHAQ Vo,Wo,Ho (W=0) | VPSHAQ Vo,Ho,Wo (W=1)
+c1: VPHADDBW Vo,Wo
+c2: VPHADDBD Vo,Wo
+c3: VPHADDBQ Vo,Wo
+c6: VPHADDWD Vo,Wo
+c7: VPHADDWQ Vo,Wo
+cb: VPHADDDQ Vo,Wo
+d1: VPHADDUBWD Vo,Wo
+d2: VPHADDUBD Vo,Wo
+d3: VPHADDUBQ Vo,Wo
+d6: VPHADDUWD Vo,Wo
+d7: VPHADDUWQ Vo,Wo
+db: VPHADDUDQ Vo,Wo
+e1: VPHSUBBW Vo,Wo
+e2: VPHSUBWD Vo,Wo
+e3: VPHSUBDQ Vo,Wo
+EndTable
+
+Table: XOP map Ah
+Referrer:
+XOPcode: 2
+10: BEXTR Gy,Ey,Id
+12: GrpXOP4
+EndTable
+
 GrpTable: Grp1
 0: ADD
 1: OR
@@ -1320,3 +1403,29 @@ GrpTable: GrpRNG
 4: xcrypt-cfb
 5: xcrypt-ofb
 EndTable
+
+# GrpXOP1-4 is shown in AMD APM Vol.3 Appendix A as XOP group #1-4
+GrpTable: GrpXOP1
+1: BLCFILL By,Ey (xop)
+2: BLSFILL By,Ey (xop)
+3: BLCS By,Ey (xop)
+4: TZMSK By,Ey (xop)
+5: BLCIC By,Ey (xop)
+6: BLSIC By,Ey (xop)
+7: T1MSKC By,Ey (xop)
+EndTable
+
+GrpTable: GrpXOP2
+1: BLCMSK By,Ey (xop)
+6: BLCI By,Ey (xop)
+EndTable
+
+GrpTable: GrpXOP3
+0: LLWPCB Ry (xop)
+1: SLWPCB Ry (xop)
+EndTable
+
+GrpTable: GrpXOP4
+0: LWPINS By,Ed,Id (xop)
+1: LWPVAL By,Ed,Id (xop)
+EndTable
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index 2c19d7fc8a85..7ea1b75e59b7 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -21,6 +21,7 @@ function clear_vars() {
 	eid = -1 # escape id
 	gid = -1 # group id
 	aid = -1 # AVX id
+	xopid = -1 # XOP id
 	tname = ""
 }
 
@@ -39,9 +40,11 @@ BEGIN {
 	ggid = 1
 	geid = 1
 	gaid = 0
+	gxopid = 0
 	delete etable
 	delete gtable
 	delete atable
+	delete xoptable
 
 	opnd_expr = "^[A-Za-z/]"
 	ext_expr = "^\\("
@@ -61,6 +64,7 @@ BEGIN {
 	imm_flag["Ob"] = "INAT_MOFFSET"
 	imm_flag["Ov"] = "INAT_MOFFSET"
 	imm_flag["Lx"] = "INAT_MAKE_IMM(INAT_IMM_BYTE)"
+	imm_flag["Lo"] = "INAT_MAKE_IMM(INAT_IMM_BYTE)"
 
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
@@ -87,6 +91,8 @@ BEGIN {
 	evexonly_expr = "\\(ev\\)"
 	# (es) is the same as (ev) but also "SCALABLE" i.e. W and pp determine operand size
 	evex_scalable_expr = "\\(es\\)"
+	# All opcodes in XOP table or with (xop) superscript accept XOP prefix
+	xopok_expr = "\\(xop\\)"
 
 	prefix_expr = "\\(Prefix\\)"
 	prefix_num["Operand-Size"] = "INAT_PFX_OPNDSZ"
@@ -106,6 +112,7 @@ BEGIN {
 	prefix_num["VEX+2byte"] = "INAT_PFX_VEX3"
 	prefix_num["EVEX"] = "INAT_PFX_EVEX"
 	prefix_num["REX2"] = "INAT_PFX_REX2"
+	prefix_num["XOP"] = "INAT_PFX_XOP"
 
 	clear_vars()
 }
@@ -147,6 +154,7 @@ function array_size(arr,   i,c) {
 	if (NF != 1) {
 		# AVX/escape opcode table
 		aid = $2
+		xopid = -1
 		if (gaid <= aid)
 			gaid = aid + 1
 		if (tname == "")	# AVX only opcode table
@@ -156,6 +164,20 @@ function array_size(arr,   i,c) {
 		tname = "inat_primary_table"
 }
 
+/^XOPcode:/ {
+	if (NF != 1) {
+		# XOP opcode table
+		xopid = $2
+		aid = -1
+		if (gxopid <= xopid)
+			gxopid = xopid + 1
+		if (tname == "")	# XOP only opcode table
+			tname = sprintf("inat_xop_table_%d", $2)
+	}
+	if (xopid == -1 && eid == -1)	# primary opcode table
+		tname = "inat_primary_table"
+}
+
 /^GrpTable:/ {
 	print "/* " $0 " */"
 	if (!($2 in group))
@@ -206,6 +228,8 @@ function print_table(tbl,name,fmt,n)
 			etable[eid,0] = tname
 			if (aid >= 0)
 				atable[aid,0] = tname
+			else if (xopid >= 0)
+				xoptable[xopid] = tname
 		}
 		if (array_size(lptable1) != 0) {
 			print_table(lptable1,tname "_1[INAT_OPCODE_TABLE_SIZE]",
@@ -347,6 +371,8 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			flags = add_flags(flags, "INAT_VEXOK | INAT_VEXONLY")
 		else if (match(ext, vexok_expr) || match(opcode, vexok_opcode_expr))
 			flags = add_flags(flags, "INAT_VEXOK")
+		else if (match(ext, xopok_expr) || xopid >= 0)
+			flags = add_flags(flags, "INAT_XOPOK")
 
 		# check prefixes
 		if (match(ext, prefix_expr)) {
@@ -413,6 +439,14 @@ END {
 				print "	["i"]["j"] = "atable[i,j]","
 	print "};\n"
 
+	print "/* XOP opcode map array */"
+	print "const insn_attr_t * const inat_xop_tables[X86_XOP_M_MAX - X86_XOP_M_MIN + 1]" \
+	      " = {"
+	for (i = 0; i < gxopid; i++)
+		if (xoptable[i])
+			print "	["i"] = "xoptable[i]","
+	print "};"
+
 	print "#else /* !__BOOT_COMPRESSED */\n"
 
 	print "/* Escape opcode map array */"
@@ -430,6 +464,10 @@ END {
 	      "[INAT_LSTPFX_MAX + 1];"
 	print ""
 
+	print "/* XOP opcode map array */"
+	print "static const insn_attr_t *inat_xop_tables[X86_XOP_M_MAX - X86_XOP_M_MIN + 1];"
+	print ""
+
 	print "static void inat_init_tables(void)"
 	print "{"
 
@@ -455,6 +493,12 @@ END {
 			if (atable[i,j])
 				print "\tinat_avx_tables["i"]["j"] = "atable[i,j]";"
 
+	print ""
+	print "\t/* Print XOP opcode map array */"
+	for (i = 0; i < gxopid; i++)
+		if (xoptable[i])
+			print "\tinat_xop_tables["i"] = "xoptable[i]";"
+
 	print "}"
 	print "#endif"
 }
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 8fabddc1c0da..72c7a4e15d61 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -32,7 +32,7 @@ static void intel_pt_insn_decoder(struct insn *insn,
 	intel_pt_insn->rel = 0;
 	intel_pt_insn->emulated_ptwrite = false;
 
-	if (insn_is_avx(insn)) {
+	if (insn_is_avx_or_xop(insn)) {
 		intel_pt_insn->op = INTEL_PT_OP_OTHER;
 		intel_pt_insn->branch = INTEL_PT_BR_NO_BRANCH;
 		intel_pt_insn->length = insn->length;


