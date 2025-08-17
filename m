Return-Path: <stable+bounces-169870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD34B29113
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 03:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C522A2657
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D327016E863;
	Sun, 17 Aug 2025 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Q7Ss1maH"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3D38DD8;
	Sun, 17 Aug 2025 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755394642; cv=none; b=vEmTWekRoSJHhkgrQnMFuC9rzHjjB9A0jI71dUqL/8C1FY9pV2cVeR0KIpozFg+c2NThMv6PQ5T+BbvdHDTjSZr8R1wd5a9/yVG4xa/zGMEurbmZmyqUy2a3pG4hW5UAkjSZ8ApJOo5wucdWEgYkGB9Slhq/62llTWTBjdL7pi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755394642; c=relaxed/simple;
	bh=nRVK02M+O9dLXprQVSqvmb+VhQ+xYWcJBd59qM5GXyI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jPU8k/8usENRPz/dNPaMiXN3T0qL2rPXR71Ymgr4s/dUjk3gXr4cQGYhEt5agkQ2ytIYyYSB63tpTOe0+cK4Zc/iDWbylCb5y4uo80LPRqNuwL2Ee/xKdMBrYVUjfZompR0uSHLSPvbvio+ci99+378Y0Q1aYXPZ8YtA+SkCTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Q7Ss1maH; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57H1aI8S923363
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 16 Aug 2025 18:36:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57H1aI8S923363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1755394580;
	bh=1/oJePT4VLmIM93mhvZ1/FvsbzIO/f/fNEs46an5cDk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Q7Ss1maHctbvubbpCnAPvKYqb7LvAIYaJwCc1fnCLC8JyGW79/LKKKIf4x5xgzNZ6
	 AJ/QxkNPnAXNPeV9847uC6SrCEEpmioVRToB/blAhYu31uQlLYH+AErSynR4PW89Th
	 o9XSt9Nn1eTkckJm9u+j1DC7HEwIjXmaTZ+ofMdypGAk55ymS2LuqlVzSUeYyPfEk8
	 pdhIal9L2gXop/c2++oHnoa/eRpJLuzryqnoQcOM3H5Q8LKp9eegbxxlSGnxfvnZPp
	 b+vv2oDB7/tAjJ8HaZj/tKgQZuXN98ayQZedp73N0O3VyXKvOuwSgb5SYtnGM+2/QC
	 OkrTeluiODdYQ==
Date: Sat, 16 Aug 2025 18:36:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
        "Alan J . Wylie" <alan@wylie.me.uk>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        x86@kernel.org
Subject: Re: [PATCH] x86: XOP prefix instructions decoder support
User-Agent: K-9 Mail for Android
In-Reply-To: <20250817093240.527825424989e5e2337b5775@kernel.org>
References: <175386161199.564247.597496379413236944.stgit@devnote2> <20250817093240.527825424989e5e2337b5775@kernel.org>
Message-ID: <F5D549B0-F8F7-467A-8F8D-7ED5EE4369D3@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 16, 2025 5:32:40 PM PDT, Masami Hiramatsu <mhiramat@kernel=2Eorg>=
 wrote:
>Hi Alan,=20
>
>Can you test this with our cros-compile build?
>
>Thank you,
>
>On Wed, 30 Jul 2025 16:46:52 +0900
>"Masami Hiramatsu (Google)" <mhiramat@kernel=2Eorg> wrote:
>
>> From: Masami Hiramatsu (Google) <mhiramat@kernel=2Eorg>
>>=20
>> Support decoding AMD's XOP prefix encoded instructions=2E
>>=20
>> These instructions are introduced for Bulldozer micro architecture,
>> and not supported on Intel's processors=2E But when compiling kernel
>> with CONFIG_X86_NATIVE_CPU on some AMD processor (e=2Eg=2E -march=3Dbdv=
er2),
>> these instructions can be used=2E
>>=20
>> Reported-by: Alan J=2E Wylie <alan@wylie=2Eme=2Euk>
>> Closes: https://lore=2Ekernel=2Eorg/all/871pq06728=2Efsf@wylie=2Eme=2Eu=
k/
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel=2Eorg>
>> ---
>>  arch/x86/include/asm/inat=2Eh                        |   15 +++
>>  arch/x86/include/asm/insn=2Eh                        |   51 +++++++++
>>  arch/x86/lib/inat=2Ec                                |   13 ++
>>  arch/x86/lib/insn=2Ec                                |   35 +++++-
>>  arch/x86/lib/x86-opcode-map=2Etxt                    |  111 ++++++++++=
++++++++++
>>  arch/x86/tools/gen-insn-attr-x86=2Eawk               |   44 ++++++++
>>  tools/arch/x86/include/asm/inat=2Eh                  |   15 +++
>>  tools/arch/x86/include/asm/insn=2Eh                  |   51 +++++++++
>>  tools/arch/x86/lib/inat=2Ec                          |   13 ++
>>  tools/arch/x86/lib/insn=2Ec                          |   35 +++++-
>>  tools/arch/x86/lib/x86-opcode-map=2Etxt              |  111 ++++++++++=
++++++++++
>>  tools/arch/x86/tools/gen-insn-attr-x86=2Eawk         |   44 ++++++++
>>  =2E=2E=2E/util/intel-pt-decoder/intel-pt-insn-decoder=2Ec  |    2=20
>>  13 files changed, 513 insertions(+), 27 deletions(-)
>>=20
>> diff --git a/arch/x86/include/asm/inat=2Eh b/arch/x86/include/asm/inat=
=2Eh
>> index 97f341777db5=2E=2E1b3060a3425c 100644
>> --- a/arch/x86/include/asm/inat=2Eh
>> +++ b/arch/x86/include/asm/inat=2Eh
>> @@ -37,6 +37,8 @@
>>  #define INAT_PFX_EVEX	15	/* EVEX prefix */
>>  /* x86-64 REX2 prefix */
>>  #define INAT_PFX_REX2	16	/* 0xD5 */
>> +/* AMD XOP prefix */
>> +#define INAT_PFX_XOP	17	/* 0x8F */
>> =20
>>  #define INAT_LSTPFX_MAX	3
>>  #define INAT_LGCPFX_MAX	11
>> @@ -77,6 +79,7 @@
>>  #define INAT_MOFFSET	(1 << (INAT_FLAG_OFFS + 3))
>>  #define INAT_VARIANT	(1 << (INAT_FLAG_OFFS + 4))
>>  #define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
>> +#define INAT_XOPOK	INAT_VEXOK
>>  #define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
>>  #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
>>  #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
>> @@ -111,6 +114,8 @@ extern insn_attr_t inat_get_group_attribute(insn_by=
te_t modrm,
>>  extern insn_attr_t inat_get_avx_attribute(insn_byte_t opcode,
>>  					  insn_byte_t vex_m,
>>  					  insn_byte_t vex_pp);
>> +extern insn_attr_t inat_get_xop_attribute(insn_byte_t opcode,
>> +					  insn_byte_t map_select);
>> =20
>>  /* Attribute checking functions */
>>  static inline int inat_is_legacy_prefix(insn_attr_t attr)
>> @@ -164,6 +169,11 @@ static inline int inat_is_vex3_prefix(insn_attr_t =
attr)
>>  	return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_VEX3;
>>  }
>> =20
>> +static inline int inat_is_xop_prefix(insn_attr_t attr)
>> +{
>> +	return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_XOP;
>> +}
>> +
>>  static inline int inat_is_escape(insn_attr_t attr)
>>  {
>>  	return attr & INAT_ESC_MASK;
>> @@ -229,6 +239,11 @@ static inline int inat_accept_vex(insn_attr_t attr=
)
>>  	return attr & INAT_VEXOK;
>>  }
>> =20
>> +static inline int inat_accept_xop(insn_attr_t attr)
>> +{
>> +	return attr & INAT_XOPOK;
>> +}
>> +
>>  static inline int inat_must_vex(insn_attr_t attr)
>>  {
>>  	return attr & (INAT_VEXONLY | INAT_EVEXONLY);
>> diff --git a/arch/x86/include/asm/insn=2Eh b/arch/x86/include/asm/insn=
=2Eh
>> index 7152ea809e6a=2E=2E091f88c8254d 100644
>> --- a/arch/x86/include/asm/insn=2Eh
>> +++ b/arch/x86/include/asm/insn=2Eh
>> @@ -71,7 +71,10 @@ struct insn {
>>  					 * prefixes=2Ebytes[3]: last prefix
>>  					 */
>>  	struct insn_field rex_prefix;	/* REX prefix */
>> -	struct insn_field vex_prefix;	/* VEX prefix */
>> +	union {
>> +		struct insn_field vex_prefix;	/* VEX prefix */
>> +		struct insn_field xop_prefix;	/* XOP prefix */
>> +	};
>>  	struct insn_field opcode;	/*
>>  					 * opcode=2Ebytes[0]: opcode1
>>  					 * opcode=2Ebytes[1]: opcode2
>> @@ -135,6 +138,17 @@ struct insn {
>>  #define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1=
 */
>>  #define X86_VEX_P(vex)	((vex) & 0x03)		/* VEX3 Byte2, VEX2 Byte1 */
>>  #define X86_VEX_M_MAX	0x1f			/* VEX3=2EM Maximum value */
>> +/* XOP bit fields */
>> +#define X86_XOP_R(xop)	((xop) & 0x80)	/* XOP Byte2 */
>> +#define X86_XOP_X(xop)	((xop) & 0x40)	/* XOP Byte2 */
>> +#define X86_XOP_B(xop)	((xop) & 0x20)	/* XOP Byte2 */
>> +#define X86_XOP_M(xop)	((xop) & 0x1f)	/* XOP Byte2 */
>> +#define X86_XOP_W(xop)	((xop) & 0x80)	/* XOP Byte3 */
>> +#define X86_XOP_V(xop)	((xop) & 0x78)	/* XOP Byte3 */
>> +#define X86_XOP_L(xop)	((xop) & 0x04)	/* XOP Byte3 */
>> +#define X86_XOP_P(xop)	((xop) & 0x03)	/* XOP Byte3 */
>> +#define X86_XOP_M_MIN	0x08	/* Min of XOP=2EM */
>> +#define X86_XOP_M_MAX	0x1f	/* Max of XOP=2EM */
>> =20
>>  extern void insn_init(struct insn *insn, const void *kaddr, int buf_le=
n, int x86_64);
>>  extern int insn_get_prefixes(struct insn *insn);
>> @@ -178,7 +192,7 @@ static inline insn_byte_t insn_rex2_m_bit(struct in=
sn *insn)
>>  	return X86_REX2_M(insn->rex_prefix=2Ebytes[1]);
>>  }
>> =20
>> -static inline int insn_is_avx(struct insn *insn)
>> +static inline int insn_is_avx_or_xop(struct insn *insn)
>>  {
>>  	if (!insn->prefixes=2Egot)
>>  		insn_get_prefixes(insn);
>> @@ -192,6 +206,22 @@ static inline int insn_is_evex(struct insn *insn)
>>  	return (insn->vex_prefix=2Enbytes =3D=3D 4);
>>  }
>> =20
>> +/* If we already know this is AVX/XOP encoded */
>> +static inline int avx_insn_is_xop(struct insn *insn)
>> +{
>> +	insn_attr_t attr =3D inat_get_opcode_attribute(insn->vex_prefix=2Ebyt=
es[0]);
>> +
>> +	return inat_is_xop_prefix(attr);
>> +}
>> +
>> +static inline int insn_is_xop(struct insn *insn)
>> +{
>> +	if (!insn_is_avx_or_xop(insn))
>> +		return 0;
>> +
>> +	return avx_insn_is_xop(insn);
>> +}
>> +
>>  static inline int insn_has_emulate_prefix(struct insn *insn)
>>  {
>>  	return !!insn->emulate_prefix_size;
>> @@ -222,11 +252,26 @@ static inline insn_byte_t insn_vex_w_bit(struct i=
nsn *insn)
>>  	return X86_VEX_W(insn->vex_prefix=2Ebytes[2]);
>>  }
>> =20
>> +static inline insn_byte_t insn_xop_map_bits(struct insn *insn)
>> +{
>> +	if (insn->xop_prefix=2Enbytes < 3)	/* XOP is 3 bytes */
>> +		return 0;
>> +	return X86_XOP_M(insn->xop_prefix=2Ebytes[1]);
>> +}
>> +
>> +static inline insn_byte_t insn_xop_p_bits(struct insn *insn)
>> +{
>> +	return X86_XOP_P(insn->vex_prefix=2Ebytes[2]);
>> +}
>> +
>>  /* Get the last prefix id from last prefix or VEX prefix */
>>  static inline int insn_last_prefix_id(struct insn *insn)
>>  {
>> -	if (insn_is_avx(insn))
>> +	if (insn_is_avx_or_xop(insn)) {
>> +		if (avx_insn_is_xop(insn))
>> +			return insn_xop_p_bits(insn);
>>  		return insn_vex_p_bits(insn);	/* VEX_p is a SIMD prefix id */
>> +	}
>> =20
>>  	if (insn->prefixes=2Ebytes[3])
>>  		return inat_get_last_prefix_id(insn->prefixes=2Ebytes[3]);
>> diff --git a/arch/x86/lib/inat=2Ec b/arch/x86/lib/inat=2Ec
>> index b0f3b2a62ae2=2E=2Ea5cafd402cfd 100644
>> --- a/arch/x86/lib/inat=2Ec
>> +++ b/arch/x86/lib/inat=2Ec
>> @@ -81,3 +81,16 @@ insn_attr_t inat_get_avx_attribute(insn_byte_t opcod=
e, insn_byte_t vex_m,
>>  	return table[opcode];
>>  }
>> =20
>> +insn_attr_t inat_get_xop_attribute(insn_byte_t opcode, insn_byte_t map=
_select)
>> +{
>> +	const insn_attr_t *table;
>> +
>> +	if (map_select < X86_XOP_M_MIN || map_select > X86_XOP_M_MAX)
>> +		return 0;
>> +	map_select -=3D X86_XOP_M_MIN;
>> +	/* At first, this checks the master table */
>> +	table =3D inat_xop_tables[map_select];
>> +	if (!table)
>> +		return 0;
>> +	return table[opcode];
>> +}
>> diff --git a/arch/x86/lib/insn=2Ec b/arch/x86/lib/insn=2Ec
>> index 149a57e334ab=2E=2E225af1399c9d 100644
>> --- a/arch/x86/lib/insn=2Ec
>> +++ b/arch/x86/lib/insn=2Ec
>> @@ -200,12 +200,15 @@ int insn_get_prefixes(struct insn *insn)
>>  	}
>>  	insn->rex_prefix=2Egot =3D 1;
>> =20
>> -	/* Decode VEX prefix */
>> +	/* Decode VEX/XOP prefix */
>>  	b =3D peek_next(insn_byte_t, insn);
>> -	attr =3D inat_get_opcode_attribute(b);
>> -	if (inat_is_vex_prefix(attr)) {
>> +	if (inat_is_vex_prefix(attr) || inat_is_xop_prefix(attr)) {
>>  		insn_byte_t b2 =3D peek_nbyte_next(insn_byte_t, insn, 1);
>> -		if (!insn->x86_64) {
>> +
>> +		if (inat_is_xop_prefix(attr) && X86_MODRM_REG(b2) =3D=3D 0) {
>> +			/* Grp1A=2E0 is always POP Ev */
>> +			goto vex_end;
>> +		} else if (!insn->x86_64) {
>>  			/*
>>  			 * In 32-bits mode, if the [7:6] bits (mod bits of
>>  			 * ModRM) on the second byte are not 11b, it is
>> @@ -226,13 +229,13 @@ int insn_get_prefixes(struct insn *insn)
>>  			if (insn->x86_64 && X86_VEX_W(b2))
>>  				/* VEX=2EW overrides opnd_size */
>>  				insn->opnd_bytes =3D 8;
>> -		} else if (inat_is_vex3_prefix(attr)) {
>> +		} else if (inat_is_vex3_prefix(attr) || inat_is_xop_prefix(attr)) {
>>  			b2 =3D peek_nbyte_next(insn_byte_t, insn, 2);
>>  			insn_set_byte(&insn->vex_prefix, 2, b2);
>>  			insn->vex_prefix=2Enbytes =3D 3;
>>  			insn->next_byte +=3D 3;
>>  			if (insn->x86_64 && X86_VEX_W(b2))
>> -				/* VEX=2EW overrides opnd_size */
>> +				/* VEX=2EW/XOP=2EW overrides opnd_size */
>>  				insn->opnd_bytes =3D 8;
>>  		} else {
>>  			/*
>> @@ -288,9 +291,22 @@ int insn_get_opcode(struct insn *insn)
>>  	insn_set_byte(opcode, 0, op);
>>  	opcode->nbytes =3D 1;
>> =20
>> -	/* Check if there is VEX prefix or not */
>> -	if (insn_is_avx(insn)) {
>> +	/* Check if there is VEX/XOP prefix or not */
>> +	if (insn_is_avx_or_xop(insn)) {
>>  		insn_byte_t m, p;
>> +
>> +		/* XOP prefix has different encoding */
>> +		if (unlikely(avx_insn_is_xop(insn))) {
>> +			m =3D insn_xop_map_bits(insn);
>> +			insn->attr =3D inat_get_xop_attribute(op, m);
>> +			if (!inat_accept_xop(insn->attr)) {
>> +				insn->attr =3D 0;
>> +				return -EINVAL;
>> +			}
>> +			/* XOP has only 1 byte for opcode */
>> +			goto end;
>> +		}
>> +
>>  		m =3D insn_vex_m_bits(insn);
>>  		p =3D insn_vex_p_bits(insn);
>>  		insn->attr =3D inat_get_avx_attribute(op, m, p);
>> @@ -383,7 +399,8 @@ int insn_get_modrm(struct insn *insn)
>>  			pfx_id =3D insn_last_prefix_id(insn);
>>  			insn->attr =3D inat_get_group_attribute(mod, pfx_id,
>>  							      insn->attr);
>> -			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
>> +			if (insn_is_avx_or_xop(insn) && !inat_accept_vex(insn->attr) &&
>> +			    !inat_accept_xop(insn->attr)) {
>>  				/* Bad insn */
>>  				insn->attr =3D 0;
>>  				return -EINVAL;
>> diff --git a/arch/x86/lib/x86-opcode-map=2Etxt b/arch/x86/lib/x86-opcod=
e-map=2Etxt
>> index 262f7ca1fb95=2E=2E2a4e69ecc2de 100644
>> --- a/arch/x86/lib/x86-opcode-map=2Etxt
>> +++ b/arch/x86/lib/x86-opcode-map=2Etxt
>> @@ -27,6 +27,11 @@
>>  #  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
>>  #  (v): this opcode requires VEX prefix=2E
>>  #  (v1): this opcode only supports 128bit VEX=2E
>> +#  (xop): this opcode accepts XOP prefix=2E
>> +#
>> +# XOP Superscripts
>> +#  (W=3D0): this opcode requires XOP=2EW =3D=3D 0
>> +#  (W=3D1): this opcode requires XOP=2EW =3D=3D 1
>>  #
>>  # Last Prefix Superscripts
>>  #  - (66): the last prefix is 0x66
>> @@ -194,7 +199,7 @@ AVXcode:
>>  8c: MOV Ev,Sw
>>  8d: LEA Gv,M
>>  8e: MOV Sw,Ew
>> -8f: Grp1A (1A) | POP Ev (d64)
>> +8f: Grp1A (1A) | POP Ev (d64) | XOP (Prefix)
>>  # 0x90 - 0x9f
>>  90: NOP | PAUSE (F3) | XCHG r8,rAX
>>  91: XCHG rCX/r9,rAX
>> @@ -1106,6 +1111,84 @@ AVXcode: 7
>>  f8: URDMSR Rq,Id (F2),(v1),(11B) | UWRMSR Id,Rq (F3),(v1),(11B)
>>  EndTable
>> =20
>> +# From AMD64 Architecture Programmer's Manual Vol3, Appendix A=2E1=2E5
>> +Table: XOP map 8h
>> +Referrer:
>> +XOPcode: 0
>> +85: VPMACSSWW Vo,Ho,Wo,Lo
>> +86: VPMACSSWD Vo,Ho,Wo,Lo
>> +87: VPMACSSDQL Vo,Ho,Wo,Lo
>> +8e: VPMACSSDD Vo,Ho,Wo,Lo
>> +8f: VPMACSSDQH Vo,Ho,Wo,Lo
>> +95: VPMACSWW Vo,Ho,Wo,Lo
>> +96: VPMACSWD Vo,Ho,Wo,Lo
>> +97: VPMACSDQL Vo,Ho,Wo,Lo
>> +9e: VPMACSDD Vo,Ho,Wo,Lo
>> +9f: VPMACSDQH Vo,Ho,Wo,Lo
>> +a2: VPCMOV Vx,Hx,Wx,Lx (W=3D0) | VPCMOV Vx,Hx,Lx,Wx (W=3D1)
>> +a3: VPPERM Vo,Ho,Wo,Lo (W=3D0) | VPPERM Vo,Ho,Lo,Wo (W=3D1)
>> +a6: VPMADCSSWD Vo,Ho,Wo,Lo
>> +b6: VPMADCSWD Vo,Ho,Wo,Lo
>> +c0: VPROTB Vo,Wo,Ib
>> +c1: VPROTW Vo,Wo,Ib
>> +c2: VPROTD Vo,Wo,Ib
>> +c3: VPROTQ Vo,Wo,Ib
>> +cc: VPCOMccB Vo,Ho,Wo,Ib
>> +cd: VPCOMccW Vo,Ho,Wo,Ib
>> +ce: VPCOMccD Vo,Ho,Wo,Ib
>> +cf: VPCOMccQ Vo,Ho,Wo,Ib
>> +ec: VPCOMccUB Vo,Ho,Wo,Ib
>> +ed: VPCOMccUW Vo,Ho,Wo,Ib
>> +ee: VPCOMccUD Vo,Ho,Wo,Ib
>> +ef: VPCOMccUQ Vo,Ho,Wo,Ib
>> +EndTable
>> +
>> +Table: XOP map 9h
>> +Referrer:
>> +XOPcode: 1
>> +01: GrpXOP1
>> +02: GrpXOP2
>> +12: GrpXOP3
>> +80: VFRCZPS Vx,Wx
>> +81: VFRCZPD Vx,Wx
>> +82: VFRCZSS Vq,Wss
>> +83: VFRCZSD Vq,Wsd
>> +90: VPROTB Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
>> +91: VPROTW Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
>> +92: VPROTD Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
>> +93: VPROTQ Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
>> +94: VPSHLB Vo,Wo,Ho (W=3D0) | VPSHLB Vo,Ho,Wo (W=3D1)
>> +95: VPSHLW Vo,Wo,Ho (W=3D0) | VPSHLW Vo,Ho,Wo (W=3D1)
>> +96: VPSHLD Vo,Wo,Ho (W=3D0) | VPSHLD Vo,Ho,Wo (W=3D1)
>> +97: VPSHLQ Vo,Wo,Ho (W=3D0) | VPSHLQ Vo,Ho,Wo (W=3D1)
>> +98: VPSHAB Vo,Wo,Ho (W=3D0) | VPSHAB Vo,Ho,Wo (W=3D1)
>> +99: VPSHAW Vo,Wo,Ho (W=3D0) | VPSHAW Vo,Ho,Wo (W=3D1)
>> +9a: VPSHAD Vo,Wo,Ho (W=3D0) | VPSHAD Vo,Ho,Wo (W=3D1)
>> +9b: VPSHAQ Vo,Wo,Ho (W=3D0) | VPSHAQ Vo,Ho,Wo (W=3D1)
>> +c1: VPHADDBW Vo,Wo
>> +c2: VPHADDBD Vo,Wo
>> +c3: VPHADDBQ Vo,Wo
>> +c6: VPHADDWD Vo,Wo
>> +c7: VPHADDWQ Vo,Wo
>> +cb: VPHADDDQ Vo,Wo
>> +d1: VPHADDUBWD Vo,Wo
>> +d2: VPHADDUBD Vo,Wo
>> +d3: VPHADDUBQ Vo,Wo
>> +d6: VPHADDUWD Vo,Wo
>> +d7: VPHADDUWQ Vo,Wo
>> +db: VPHADDUDQ Vo,Wo
>> +e1: VPHSUBBW Vo,Wo
>> +e2: VPHSUBWD Vo,Wo
>> +e3: VPHSUBDQ Vo,Wo
>> +EndTable
>> +
>> +Table: XOP map Ah
>> +Referrer:
>> +XOPcode: 2
>> +10: BEXTR Gy,Ey,Id
>> +12: GrpXOP4
>> +EndTable
>> +
>>  GrpTable: Grp1
>>  0: ADD
>>  1: OR
>> @@ -1320,3 +1403,29 @@ GrpTable: GrpRNG
>>  4: xcrypt-cfb
>>  5: xcrypt-ofb
>>  EndTable
>> +
>> +# GrpXOP1-4 is shown in AMD APM Vol=2E3 Appendix A as XOP group #1-4
>> +GrpTable: GrpXOP1
>> +1: BLCFILL By,Ey (xop)
>> +2: BLSFILL By,Ey (xop)
>> +3: BLCS By,Ey (xop)
>> +4: TZMSK By,Ey (xop)
>> +5: BLCIC By,Ey (xop)
>> +6: BLSIC By,Ey (xop)
>> +7: T1MSKC By,Ey (xop)
>> +EndTable
>> +
>> +GrpTable: GrpXOP2
>> +1: BLCMSK By,Ey (xop)
>> +6: BLCI By,Ey (xop)
>> +EndTable
>> +
>> +GrpTable: GrpXOP3
>> +0: LLWPCB Ry (xop)
>> +1: SLWPCB Ry (xop)
>> +EndTable
>> +
>> +GrpTable: GrpXOP4
>> +0: LWPINS By,Ed,Id (xop)
>> +1: LWPVAL By,Ed,Id (xop)
>> +EndTable
>> diff --git a/arch/x86/tools/gen-insn-attr-x86=2Eawk b/arch/x86/tools/ge=
n-insn-attr-x86=2Eawk
>> index 2c19d7fc8a85=2E=2E7ea1b75e59b7 100644
>> --- a/arch/x86/tools/gen-insn-attr-x86=2Eawk
>> +++ b/arch/x86/tools/gen-insn-attr-x86=2Eawk
>> @@ -21,6 +21,7 @@ function clear_vars() {
>>  	eid =3D -1 # escape id
>>  	gid =3D -1 # group id
>>  	aid =3D -1 # AVX id
>> +	xopid =3D -1 # XOP id
>>  	tname =3D ""
>>  }
>> =20
>> @@ -39,9 +40,11 @@ BEGIN {
>>  	ggid =3D 1
>>  	geid =3D 1
>>  	gaid =3D 0
>> +	gxopid =3D 0
>>  	delete etable
>>  	delete gtable
>>  	delete atable
>> +	delete xoptable
>> =20
>>  	opnd_expr =3D "^[A-Za-z/]"
>>  	ext_expr =3D "^\\("
>> @@ -61,6 +64,7 @@ BEGIN {
>>  	imm_flag["Ob"] =3D "INAT_MOFFSET"
>>  	imm_flag["Ov"] =3D "INAT_MOFFSET"
>>  	imm_flag["Lx"] =3D "INAT_MAKE_IMM(INAT_IMM_BYTE)"
>> +	imm_flag["Lo"] =3D "INAT_MAKE_IMM(INAT_IMM_BYTE)"
>> =20
>>  	modrm_expr =3D "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
>>  	force64_expr =3D "\\([df]64\\)"
>> @@ -87,6 +91,8 @@ BEGIN {
>>  	evexonly_expr =3D "\\(ev\\)"
>>  	# (es) is the same as (ev) but also "SCALABLE" i=2Ee=2E W and pp dete=
rmine operand size
>>  	evex_scalable_expr =3D "\\(es\\)"
>> +	# All opcodes in XOP table or with (xop) superscript accept XOP prefi=
x
>> +	xopok_expr =3D "\\(xop\\)"
>> =20
>>  	prefix_expr =3D "\\(Prefix\\)"
>>  	prefix_num["Operand-Size"] =3D "INAT_PFX_OPNDSZ"
>> @@ -106,6 +112,7 @@ BEGIN {
>>  	prefix_num["VEX+2byte"] =3D "INAT_PFX_VEX3"
>>  	prefix_num["EVEX"] =3D "INAT_PFX_EVEX"
>>  	prefix_num["REX2"] =3D "INAT_PFX_REX2"
>> +	prefix_num["XOP"] =3D "INAT_PFX_XOP"
>> =20
>>  	clear_vars()
>>  }
>> @@ -147,6 +154,7 @@ function array_size(arr,   i,c) {
>>  	if (NF !=3D 1) {
>>  		# AVX/escape opcode table
>>  		aid =3D $2
>> +		xopid =3D -1
>>  		if (gaid <=3D aid)
>>  			gaid =3D aid + 1
>>  		if (tname =3D=3D "")	# AVX only opcode table
>> @@ -156,6 +164,20 @@ function array_size(arr,   i,c) {
>>  		tname =3D "inat_primary_table"
>>  }
>> =20
>> +/^XOPcode:/ {
>> +	if (NF !=3D 1) {
>> +		# XOP opcode table
>> +		xopid =3D $2
>> +		aid =3D -1
>> +		if (gxopid <=3D xopid)
>> +			gxopid =3D xopid + 1
>> +		if (tname =3D=3D "")	# XOP only opcode table
>> +			tname =3D sprintf("inat_xop_table_%d", $2)
>> +	}
>> +	if (xopid =3D=3D -1 && eid =3D=3D -1)	# primary opcode table
>> +		tname =3D "inat_primary_table"
>> +}
>> +
>>  /^GrpTable:/ {
>>  	print "/* " $0 " */"
>>  	if (!($2 in group))
>> @@ -206,6 +228,8 @@ function print_table(tbl,name,fmt,n)
>>  			etable[eid,0] =3D tname
>>  			if (aid >=3D 0)
>>  				atable[aid,0] =3D tname
>> +			else if (xopid >=3D 0)
>> +				xoptable[xopid] =3D tname
>>  		}
>>  		if (array_size(lptable1) !=3D 0) {
>>  			print_table(lptable1,tname "_1[INAT_OPCODE_TABLE_SIZE]",
>> @@ -347,6 +371,8 @@ function convert_operands(count,opnd,       i,j,imm=
,mod)
>>  			flags =3D add_flags(flags, "INAT_VEXOK | INAT_VEXONLY")
>>  		else if (match(ext, vexok_expr) || match(opcode, vexok_opcode_expr))
>>  			flags =3D add_flags(flags, "INAT_VEXOK")
>> +		else if (match(ext, xopok_expr) || xopid >=3D 0)
>> +			flags =3D add_flags(flags, "INAT_XOPOK")
>> =20
>>  		# check prefixes
>>  		if (match(ext, prefix_expr)) {
>> @@ -413,6 +439,14 @@ END {
>>  				print "	["i"]["j"] =3D "atable[i,j]","
>>  	print "};\n"
>> =20
>> +	print "/* XOP opcode map array */"
>> +	print "const insn_attr_t * const inat_xop_tables[X86_XOP_M_MAX - X86_=
XOP_M_MIN + 1]" \
>> +	      " =3D {"
>> +	for (i =3D 0; i < gxopid; i++)
>> +		if (xoptable[i])
>> +			print "	["i"] =3D "xoptable[i]","
>> +	print "};"
>> +
>>  	print "#else /* !__BOOT_COMPRESSED */\n"
>> =20
>>  	print "/* Escape opcode map array */"
>> @@ -430,6 +464,10 @@ END {
>>  	      "[INAT_LSTPFX_MAX + 1];"
>>  	print ""
>> =20
>> +	print "/* XOP opcode map array */"
>> +	print "static const insn_attr_t *inat_xop_tables[X86_XOP_M_MAX - X86_=
XOP_M_MIN + 1];"
>> +	print ""
>> +
>>  	print "static void inat_init_tables(void)"
>>  	print "{"
>> =20
>> @@ -455,6 +493,12 @@ END {
>>  			if (atable[i,j])
>>  				print "\tinat_avx_tables["i"]["j"] =3D "atable[i,j]";"
>> =20
>> +	print ""
>> +	print "\t/* Print XOP opcode map array */"
>> +	for (i =3D 0; i < gxopid; i++)
>> +		if (xoptable[i])
>> +			print "\tinat_xop_tables["i"] =3D "xoptable[i]";"
>> +
>>  	print "}"
>>  	print "#endif"
>>  }
>> diff --git a/tools/arch/x86/include/asm/inat=2Eh b/tools/arch/x86/inclu=
de/asm/inat=2Eh
>> index 183aa662b165=2E=2E099e926595bd 100644
>> --- a/tools/arch/x86/include/asm/inat=2Eh
>> +++ b/tools/arch/x86/include/asm/inat=2Eh
>> @@ -37,6 +37,8 @@
>>  #define INAT_PFX_EVEX	15	/* EVEX prefix */
>>  /* x86-64 REX2 prefix */
>>  #define INAT_PFX_REX2	16	/* 0xD5 */
>> +/* AMD XOP prefix */
>> +#define INAT_PFX_XOP	17	/* 0x8F */
>> =20
>>  #define INAT_LSTPFX_MAX	3
>>  #define INAT_LGCPFX_MAX	11
>> @@ -77,6 +79,7 @@
>>  #define INAT_MOFFSET	(1 << (INAT_FLAG_OFFS + 3))
>>  #define INAT_VARIANT	(1 << (INAT_FLAG_OFFS + 4))
>>  #define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
>> +#define INAT_XOPOK	INAT_VEXOK
>>  #define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
>>  #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
>>  #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
>> @@ -111,6 +114,8 @@ extern insn_attr_t inat_get_group_attribute(insn_by=
te_t modrm,
>>  extern insn_attr_t inat_get_avx_attribute(insn_byte_t opcode,
>>  					  insn_byte_t vex_m,
>>  					  insn_byte_t vex_pp);
>> +extern insn_attr_t inat_get_xop_attribute(insn_byte_t opcode,
>> +					  insn_byte_t map_select);
>> =20
>>  /* Attribute checking functions */
>>  static inline int inat_is_legacy_prefix(insn_attr_t attr)
>> @@ -164,6 +169,11 @@ static inline int inat_is_vex3_prefix(insn_attr_t =
attr)
>>  	return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_VEX3;
>>  }
>> =20
>> +static inline int inat_is_xop_prefix(insn_attr_t attr)
>> +{
>> +	return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_XOP;
>> +}
>> +
>>  static inline int inat_is_escape(insn_attr_t attr)
>>  {
>>  	return attr & INAT_ESC_MASK;
>> @@ -229,6 +239,11 @@ static inline int inat_accept_vex(insn_attr_t attr=
)
>>  	return attr & INAT_VEXOK;
>>  }
>> =20
>> +static inline int inat_accept_xop(insn_attr_t attr)
>> +{
>> +	return attr & INAT_XOPOK;
>> +}
>> +
>>  static inline int inat_must_vex(insn_attr_t attr)
>>  {
>>  	return attr & (INAT_VEXONLY | INAT_EVEXONLY);
>> diff --git a/tools/arch/x86/include/asm/insn=2Eh b/tools/arch/x86/inclu=
de/asm/insn=2Eh
>> index 0e5abd896ad4=2E=2Ec683d609934b 100644
>> --- a/tools/arch/x86/include/asm/insn=2Eh
>> +++ b/tools/arch/x86/include/asm/insn=2Eh
>> @@ -71,7 +71,10 @@ struct insn {
>>  					 * prefixes=2Ebytes[3]: last prefix
>>  					 */
>>  	struct insn_field rex_prefix;	/* REX prefix */
>> -	struct insn_field vex_prefix;	/* VEX prefix */
>> +	union {
>> +		struct insn_field vex_prefix;	/* VEX prefix */
>> +		struct insn_field xop_prefix;	/* XOP prefix */
>> +	};
>>  	struct insn_field opcode;	/*
>>  					 * opcode=2Ebytes[0]: opcode1
>>  					 * opcode=2Ebytes[1]: opcode2
>> @@ -135,6 +138,17 @@ struct insn {
>>  #define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1=
 */
>>  #define X86_VEX_P(vex)	((vex) & 0x03)		/* VEX3 Byte2, VEX2 Byte1 */
>>  #define X86_VEX_M_MAX	0x1f			/* VEX3=2EM Maximum value */
>> +/* XOP bit fields */
>> +#define X86_XOP_R(xop)	((xop) & 0x80)	/* XOP Byte2 */
>> +#define X86_XOP_X(xop)	((xop) & 0x40)	/* XOP Byte2 */
>> +#define X86_XOP_B(xop)	((xop) & 0x20)	/* XOP Byte2 */
>> +#define X86_XOP_M(xop)	((xop) & 0x1f)	/* XOP Byte2 */
>> +#define X86_XOP_W(xop)	((xop) & 0x80)	/* XOP Byte3 */
>> +#define X86_XOP_V(xop)	((xop) & 0x78)	/* XOP Byte3 */
>> +#define X86_XOP_L(xop)	((xop) & 0x04)	/* XOP Byte3 */
>> +#define X86_XOP_P(xop)	((xop) & 0x03)	/* XOP Byte3 */
>> +#define X86_XOP_M_MIN	0x08	/* Min of XOP=2EM */
>> +#define X86_XOP_M_MAX	0x1f	/* Max of XOP=2EM */
>> =20
>>  extern void insn_init(struct insn *insn, const void *kaddr, int buf_le=
n, int x86_64);
>>  extern int insn_get_prefixes(struct insn *insn);
>> @@ -178,7 +192,7 @@ static inline insn_byte_t insn_rex2_m_bit(struct in=
sn *insn)
>>  	return X86_REX2_M(insn->rex_prefix=2Ebytes[1]);
>>  }
>> =20
>> -static inline int insn_is_avx(struct insn *insn)
>> +static inline int insn_is_avx_or_xop(struct insn *insn)
>>  {
>>  	if (!insn->prefixes=2Egot)
>>  		insn_get_prefixes(insn);
>> @@ -192,6 +206,22 @@ static inline int insn_is_evex(struct insn *insn)
>>  	return (insn->vex_prefix=2Enbytes =3D=3D 4);
>>  }
>> =20
>> +/* If we already know this is AVX/XOP encoded */
>> +static inline int avx_insn_is_xop(struct insn *insn)
>> +{
>> +	insn_attr_t attr =3D inat_get_opcode_attribute(insn->vex_prefix=2Ebyt=
es[0]);
>> +
>> +	return inat_is_xop_prefix(attr);
>> +}
>> +
>> +static inline int insn_is_xop(struct insn *insn)
>> +{
>> +	if (!insn_is_avx_or_xop(insn))
>> +		return 0;
>> +
>> +	return avx_insn_is_xop(insn);
>> +}
>> +
>>  static inline int insn_has_emulate_prefix(struct insn *insn)
>>  {
>>  	return !!insn->emulate_prefix_size;
>> @@ -222,11 +252,26 @@ static inline insn_byte_t insn_vex_w_bit(struct i=
nsn *insn)
>>  	return X86_VEX_W(insn->vex_prefix=2Ebytes[2]);
>>  }
>> =20
>> +static inline insn_byte_t insn_xop_map_bits(struct insn *insn)
>> +{
>> +	if (insn->xop_prefix=2Enbytes < 3)	/* XOP is 3 bytes */
>> +		return 0;
>> +	return X86_XOP_M(insn->xop_prefix=2Ebytes[1]);
>> +}
>> +
>> +static inline insn_byte_t insn_xop_p_bits(struct insn *insn)
>> +{
>> +	return X86_XOP_P(insn->vex_prefix=2Ebytes[2]);
>> +}
>> +
>>  /* Get the last prefix id from last prefix or VEX prefix */
>>  static inline int insn_last_prefix_id(struct insn *insn)
>>  {
>> -	if (insn_is_avx(insn))
>> +	if (insn_is_avx_or_xop(insn)) {
>> +		if (avx_insn_is_xop(insn))
>> +			return insn_xop_p_bits(insn);
>>  		return insn_vex_p_bits(insn);	/* VEX_p is a SIMD prefix id */
>> +	}
>> =20
>>  	if (insn->prefixes=2Ebytes[3])
>>  		return inat_get_last_prefix_id(insn->prefixes=2Ebytes[3]);
>> diff --git a/tools/arch/x86/lib/inat=2Ec b/tools/arch/x86/lib/inat=2Ec
>> index dfbcc6405941=2E=2Effcb0e27453b 100644
>> --- a/tools/arch/x86/lib/inat=2Ec
>> +++ b/tools/arch/x86/lib/inat=2Ec
>> @@ -81,3 +81,16 @@ insn_attr_t inat_get_avx_attribute(insn_byte_t opcod=
e, insn_byte_t vex_m,
>>  	return table[opcode];
>>  }
>> =20
>> +insn_attr_t inat_get_xop_attribute(insn_byte_t opcode, insn_byte_t map=
_select)
>> +{
>> +	const insn_attr_t *table;
>> +
>> +	if (map_select < X86_XOP_M_MIN || map_select > X86_XOP_M_MAX)
>> +		return 0;
>> +	map_select -=3D X86_XOP_M_MIN;
>> +	/* At first, this checks the master table */
>> +	table =3D inat_xop_tables[map_select];
>> +	if (!table)
>> +		return 0;
>> +	return table[opcode];
>> +}
>> diff --git a/tools/arch/x86/lib/insn=2Ec b/tools/arch/x86/lib/insn=2Ec
>> index bce69c6bfa69=2E=2E1d1c57c74d1f 100644
>> --- a/tools/arch/x86/lib/insn=2Ec
>> +++ b/tools/arch/x86/lib/insn=2Ec
>> @@ -200,12 +200,15 @@ int insn_get_prefixes(struct insn *insn)
>>  	}
>>  	insn->rex_prefix=2Egot =3D 1;
>> =20
>> -	/* Decode VEX prefix */
>> +	/* Decode VEX/XOP prefix */
>>  	b =3D peek_next(insn_byte_t, insn);
>> -	attr =3D inat_get_opcode_attribute(b);
>> -	if (inat_is_vex_prefix(attr)) {
>> +	if (inat_is_vex_prefix(attr) || inat_is_xop_prefix(attr)) {
>>  		insn_byte_t b2 =3D peek_nbyte_next(insn_byte_t, insn, 1);
>> -		if (!insn->x86_64) {
>> +
>> +		if (inat_is_xop_prefix(attr) && X86_MODRM_REG(b2) =3D=3D 0) {
>> +			/* Grp1A=2E0 is always POP Ev */
>> +			goto vex_end;
>> +		} else if (!insn->x86_64) {
>>  			/*
>>  			 * In 32-bits mode, if the [7:6] bits (mod bits of
>>  			 * ModRM) on the second byte are not 11b, it is
>> @@ -226,13 +229,13 @@ int insn_get_prefixes(struct insn *insn)
>>  			if (insn->x86_64 && X86_VEX_W(b2))
>>  				/* VEX=2EW overrides opnd_size */
>>  				insn->opnd_bytes =3D 8;
>> -		} else if (inat_is_vex3_prefix(attr)) {
>> +		} else if (inat_is_vex3_prefix(attr) || inat_is_xop_prefix(attr)) {
>>  			b2 =3D peek_nbyte_next(insn_byte_t, insn, 2);
>>  			insn_set_byte(&insn->vex_prefix, 2, b2);
>>  			insn->vex_prefix=2Enbytes =3D 3;
>>  			insn->next_byte +=3D 3;
>>  			if (insn->x86_64 && X86_VEX_W(b2))
>> -				/* VEX=2EW overrides opnd_size */
>> +				/* VEX=2EW/XOP=2EW overrides opnd_size */
>>  				insn->opnd_bytes =3D 8;
>>  		} else {
>>  			/*
>> @@ -288,9 +291,22 @@ int insn_get_opcode(struct insn *insn)
>>  	insn_set_byte(opcode, 0, op);
>>  	opcode->nbytes =3D 1;
>> =20
>> -	/* Check if there is VEX prefix or not */
>> -	if (insn_is_avx(insn)) {
>> +	/* Check if there is VEX/XOP prefix or not */
>> +	if (insn_is_avx_or_xop(insn)) {
>>  		insn_byte_t m, p;
>> +
>> +		/* XOP prefix has different encoding */
>> +		if (unlikely(avx_insn_is_xop(insn))) {
>> +			m =3D insn_xop_map_bits(insn);
>> +			insn->attr =3D inat_get_xop_attribute(op, m);
>> +			if (!inat_accept_xop(insn->attr)) {
>> +				insn->attr =3D 0;
>> +				return -EINVAL;
>> +			}
>> +			/* XOP has only 1 byte for opcode */
>> +			goto end;
>> +		}
>> +
>>  		m =3D insn_vex_m_bits(insn);
>>  		p =3D insn_vex_p_bits(insn);
>>  		insn->attr =3D inat_get_avx_attribute(op, m, p);
>> @@ -383,7 +399,8 @@ int insn_get_modrm(struct insn *insn)
>>  			pfx_id =3D insn_last_prefix_id(insn);
>>  			insn->attr =3D inat_get_group_attribute(mod, pfx_id,
>>  							      insn->attr);
>> -			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
>> +			if (insn_is_avx_or_xop(insn) && !inat_accept_vex(insn->attr) &&
>> +			    !inat_accept_xop(insn->attr)) {
>>  				/* Bad insn */
>>  				insn->attr =3D 0;
>>  				return -EINVAL;
>> diff --git a/tools/arch/x86/lib/x86-opcode-map=2Etxt b/tools/arch/x86/l=
ib/x86-opcode-map=2Etxt
>> index 262f7ca1fb95=2E=2E2a4e69ecc2de 100644
>> --- a/tools/arch/x86/lib/x86-opcode-map=2Etxt
>> +++ b/tools/arch/x86/lib/x86-opcode-map=2Etxt
>> @@ -27,6 +27,11 @@
>>  #  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
>>  #  (v): this opcode requires VEX prefix=2E
>>  #  (v1): this opcode only supports 128bit VEX=2E
>> +#  (xop): this opcode accepts XOP prefix=2E
>> +#
>> +# XOP Superscripts
>> +#  (W=3D0): this opcode requires XOP=2EW =3D=3D 0
>> +#  (W=3D1): this opcode requires XOP=2EW =3D=3D 1
>>  #
>>  # Last Prefix Superscripts
>>  #  - (66): the last prefix is 0x66
>> @@ -194,7 +199,7 @@ AVXcode:
>>  8c: MOV Ev,Sw
>>  8d: LEA Gv,M
>>  8e: MOV Sw,Ew
>> -8f: Grp1A (1A) | POP Ev (d64)
>> +8f: Grp1A (1A) | POP Ev (d64) | XOP (Prefix)
>>  # 0x90 - 0x9f
>>  90: NOP | PAUSE (F3) | XCHG r8,rAX
>>  91: XCHG rCX/r9,rAX
>> @@ -1106,6 +1111,84 @@ AVXcode: 7
>>  f8: URDMSR Rq,Id (F2),(v1),(11B) | UWRMSR Id,Rq (F3),(v1),(11B)
>>  EndTable
>> =20
>> +# From AMD64 Architecture Programmer's Manual Vol3, Appendix A=2E1=2E5
>> +Table: XOP map 8h
>> +Referrer:
>> +XOPcode: 0
>> +85: VPMACSSWW Vo,Ho,Wo,Lo
>> +86: VPMACSSWD Vo,Ho,Wo,Lo
>> +87: VPMACSSDQL Vo,Ho,Wo,Lo
>> +8e: VPMACSSDD Vo,Ho,Wo,Lo
>> +8f: VPMACSSDQH Vo,Ho,Wo,Lo
>> +95: VPMACSWW Vo,Ho,Wo,Lo
>> +96: VPMACSWD Vo,Ho,Wo,Lo
>> +97: VPMACSDQL Vo,Ho,Wo,Lo
>> +9e: VPMACSDD Vo,Ho,Wo,Lo
>> +9f: VPMACSDQH Vo,Ho,Wo,Lo
>> +a2: VPCMOV Vx,Hx,Wx,Lx (W=3D0) | VPCMOV Vx,Hx,Lx,Wx (W=3D1)
>> +a3: VPPERM Vo,Ho,Wo,Lo (W=3D0) | VPPERM Vo,Ho,Lo,Wo (W=3D1)
>> +a6: VPMADCSSWD Vo,Ho,Wo,Lo
>> +b6: VPMADCSWD Vo,Ho,Wo,Lo
>> +c0: VPROTB Vo,Wo,Ib
>> +c1: VPROTW Vo,Wo,Ib
>> +c2: VPROTD Vo,Wo,Ib
>> +c3: VPROTQ Vo,Wo,Ib
>> +cc: VPCOMccB Vo,Ho,Wo,Ib
>> +cd: VPCOMccW Vo,Ho,Wo,Ib
>> +ce: VPCOMccD Vo,Ho,Wo,Ib
>> +cf: VPCOMccQ Vo,Ho,Wo,Ib
>> +ec: VPCOMccUB Vo,Ho,Wo,Ib
>> +ed: VPCOMccUW Vo,Ho,Wo,Ib
>> +ee: VPCOMccUD Vo,Ho,Wo,Ib
>> +ef: VPCOMccUQ Vo,Ho,Wo,Ib
>> +EndTable
>> +
>> +Table: XOP map 9h
>> +Referrer:
>> +XOPcode: 1
>> +01: GrpXOP1
>> +02: GrpXOP2
>> +12: GrpXOP3
>> +80: VFRCZPS Vx,Wx
>> +81: VFRCZPD Vx,Wx
>> +82: VFRCZSS Vq,Wss
>> +83: VFRCZSD Vq,Wsd
>> +90: VPROTB Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
>> +91: VPROTW Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
>> +92: VPROTD Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
>> +93: VPROTQ Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
>> +94: VPSHLB Vo,Wo,Ho (W=3D0) | VPSHLB Vo,Ho,Wo (W=3D1)
>> +95: VPSHLW Vo,Wo,Ho (W=3D0) | VPSHLW Vo,Ho,Wo (W=3D1)
>> +96: VPSHLD Vo,Wo,Ho (W=3D0) | VPSHLD Vo,Ho,Wo (W=3D1)
>> +97: VPSHLQ Vo,Wo,Ho (W=3D0) | VPSHLQ Vo,Ho,Wo (W=3D1)
>> +98: VPSHAB Vo,Wo,Ho (W=3D0) | VPSHAB Vo,Ho,Wo (W=3D1)
>> +99: VPSHAW Vo,Wo,Ho (W=3D0) | VPSHAW Vo,Ho,Wo (W=3D1)
>> +9a: VPSHAD Vo,Wo,Ho (W=3D0) | VPSHAD Vo,Ho,Wo (W=3D1)
>> +9b: VPSHAQ Vo,Wo,Ho (W=3D0) | VPSHAQ Vo,Ho,Wo (W=3D1)
>> +c1: VPHADDBW Vo,Wo
>> +c2: VPHADDBD Vo,Wo
>> +c3: VPHADDBQ Vo,Wo
>> +c6: VPHADDWD Vo,Wo
>> +c7: VPHADDWQ Vo,Wo
>> +cb: VPHADDDQ Vo,Wo
>> +d1: VPHADDUBWD Vo,Wo
>> +d2: VPHADDUBD Vo,Wo
>> +d3: VPHADDUBQ Vo,Wo
>> +d6: VPHADDUWD Vo,Wo
>> +d7: VPHADDUWQ Vo,Wo
>> +db: VPHADDUDQ Vo,Wo
>> +e1: VPHSUBBW Vo,Wo
>> +e2: VPHSUBWD Vo,Wo
>> +e3: VPHSUBDQ Vo,Wo
>> +EndTable
>> +
>> +Table: XOP map Ah
>> +Referrer:
>> +XOPcode: 2
>> +10: BEXTR Gy,Ey,Id
>> +12: GrpXOP4
>> +EndTable
>> +
>>  GrpTable: Grp1
>>  0: ADD
>>  1: OR
>> @@ -1320,3 +1403,29 @@ GrpTable: GrpRNG
>>  4: xcrypt-cfb
>>  5: xcrypt-ofb
>>  EndTable
>> +
>> +# GrpXOP1-4 is shown in AMD APM Vol=2E3 Appendix A as XOP group #1-4
>> +GrpTable: GrpXOP1
>> +1: BLCFILL By,Ey (xop)
>> +2: BLSFILL By,Ey (xop)
>> +3: BLCS By,Ey (xop)
>> +4: TZMSK By,Ey (xop)
>> +5: BLCIC By,Ey (xop)
>> +6: BLSIC By,Ey (xop)
>> +7: T1MSKC By,Ey (xop)
>> +EndTable
>> +
>> +GrpTable: GrpXOP2
>> +1: BLCMSK By,Ey (xop)
>> +6: BLCI By,Ey (xop)
>> +EndTable
>> +
>> +GrpTable: GrpXOP3
>> +0: LLWPCB Ry (xop)
>> +1: SLWPCB Ry (xop)
>> +EndTable
>> +
>> +GrpTable: GrpXOP4
>> +0: LWPINS By,Ed,Id (xop)
>> +1: LWPVAL By,Ed,Id (xop)
>> +EndTable
>> diff --git a/tools/arch/x86/tools/gen-insn-attr-x86=2Eawk b/tools/arch/=
x86/tools/gen-insn-attr-x86=2Eawk
>> index 2c19d7fc8a85=2E=2E7ea1b75e59b7 100644
>> --- a/tools/arch/x86/tools/gen-insn-attr-x86=2Eawk
>> +++ b/tools/arch/x86/tools/gen-insn-attr-x86=2Eawk
>> @@ -21,6 +21,7 @@ function clear_vars() {
>>  	eid =3D -1 # escape id
>>  	gid =3D -1 # group id
>>  	aid =3D -1 # AVX id
>> +	xopid =3D -1 # XOP id
>>  	tname =3D ""
>>  }
>> =20
>> @@ -39,9 +40,11 @@ BEGIN {
>>  	ggid =3D 1
>>  	geid =3D 1
>>  	gaid =3D 0
>> +	gxopid =3D 0
>>  	delete etable
>>  	delete gtable
>>  	delete atable
>> +	delete xoptable
>> =20
>>  	opnd_expr =3D "^[A-Za-z/]"
>>  	ext_expr =3D "^\\("
>> @@ -61,6 +64,7 @@ BEGIN {
>>  	imm_flag["Ob"] =3D "INAT_MOFFSET"
>>  	imm_flag["Ov"] =3D "INAT_MOFFSET"
>>  	imm_flag["Lx"] =3D "INAT_MAKE_IMM(INAT_IMM_BYTE)"
>> +	imm_flag["Lo"] =3D "INAT_MAKE_IMM(INAT_IMM_BYTE)"
>> =20
>>  	modrm_expr =3D "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
>>  	force64_expr =3D "\\([df]64\\)"
>> @@ -87,6 +91,8 @@ BEGIN {
>>  	evexonly_expr =3D=20
The easiest way to think of XOP is as a VEX3 supporting a different set of=
 map numbers (VEX3 supports maps 0-31, XOP maps are 8-31 but separate); how=
ever, the encoding format is the same=2E 

