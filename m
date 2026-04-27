Return-Path: <stable+bounces-241212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EkYAfP27mnS2AAAu9opvQ
	(envelope-from <stable+bounces-241212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:41:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEE546D489
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B9EA3000B0F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 05:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576936604B;
	Mon, 27 Apr 2026 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpHG8tlt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73A367F31;
	Mon, 27 Apr 2026 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268462; cv=none; b=vC+ILb/368+XfPtRTRpz1JV3Pdg6vkqgYdEg1Cb0TStk2B4wKNK/ULWzReOfX94VC9OSJN2r40ldX9aylYV06f16UFD8l/8P2Tp4od3oMaBB/TEtxML6ldpq+MHEKvYlkP+aWk+a6ke+BtbxnOJQ7suoc0NQiRni1QbiNb6aKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268462; c=relaxed/simple;
	bh=dUPf/X9No1sq9njMsSwhAAxQEorToDmrXCtKtn3sOBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqQhSISmm4AeJIS5p3HenEtwOkMV41KsVblRm8L78x30Yb6Di1dsT2AHon9UUrg+EH7BRgsuj+IZG6CjoZfe5z1kCOSfobqd8298vQliZC5eatgfBOeGnTFtrSZ3rQrXsY6jsiwMAtlb91wrj8iTiEQjELLAnPW5B80RSvSJ5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpHG8tlt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777268460; x=1808804460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dUPf/X9No1sq9njMsSwhAAxQEorToDmrXCtKtn3sOBY=;
  b=VpHG8tltuzsBPmr4MtVtobSaOr2D6iHPziAFUcmvT+rNY7dznh+A4vBo
   hyRXu0JtCL4S/mEJrOGTQAzUGsw5b1rLkRK3DScGEMahjRoYycO0YNkjY
   2tkzUqFycICdCB5+MoFE3U/pEdFt6YbwHPmC0eSdVBbZRUR1Iikk+oH57
   7SKxGCrJL+SoZsXuKC4Bjw+ouzchCTnRObwgLPVPKdkGePyflbqDhChUl
   7pO56xn+FhriOIs9QVV26oBpMCmRXknb2E1WrqZpVkPyiW08VBeu3TPgh
   tNrnxXaUggOnA5SuFsFqFDISWomfgIkiNMBCfKWGVFhWr4MkiF52Xw+Uq
   g==;
X-CSE-ConnectionGUID: 36O9zWppRXKDN7uuzvu2GA==
X-CSE-MsgGUID: v2GqHLLHSmOZHN0O3hDCQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="89528069"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="89528069"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 22:40:59 -0700
X-CSE-ConnectionGUID: 3n3IXWR+Q1KZMfnb1TTmDQ==
X-CSE-MsgGUID: buhYigEkQ9GVVzmojM+6xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="235313399"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 26 Apr 2026 22:40:57 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 65C4F95; Mon, 27 Apr 2026 07:40:56 +0200 (CEST)
Date: Mon, 27 Apr 2026 07:40:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-usb@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] thunderbolt: test: add KUnit regression tests for
 XDomain property parser
Message-ID: <20260427054056.GL557136@black.igk.intel.com>
References: <20260415032335.2826412-1-michael.bommarito@gmail.com>
 <20260415045246.GR3552@black.igk.intel.com>
 <20260415123221.225149-1-michael.bommarito@gmail.com>
 <20260415123221.225149-5-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260415123221.225149-5-michael.bommarito@gmail.com>
X-Rspamd-Queue-Id: 8BEE546D489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-241212-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]

On Wed, Apr 15, 2026 at 08:32:20AM -0400, Michael Bommarito wrote:
> Add three KUnit cases that exercise the defects fixed by the sibling
> commits in this series by feeding crafted XDomain property blocks to
> tb_property_parse_dir():
> 
>   tb_test_property_parse_u32_wrap - entry->value = 0xFFFFFF00 and
>     entry->length = 0x100 so their u32 sum 0x100000000 wraps to 0
>     under the block_len guard; without the fix the subsequent
>     parse_dwdata() reads attacker-directed OOB memory.
> 
>   tb_test_property_parse_recursion - two DIRECTORY entries pointing
>     at each other, driving __tb_property_parse_dir() recursion;
>     without the fix the kernel stack is exhausted.
> 
>   tb_test_property_parse_dir_len_underflow - a DIRECTORY entry with
>     length < 4 so non-root content_len = dir_len - 4 wraps size_t;
>     without the fix nentries is huge and the entry walk runs OOB.
> 
> Each test asserts tb_property_parse_dir() returns NULL on the
> crafted input.  With CONFIG_KASAN=y, running these on the pre-fix
> kernel reproduces an oops inside __tb_property_parse_dir (KASAN
> shadow-memory fault for the u32_wrap case, stack-guard trip for
> recursion, OOB read past block for dir_len underflow).  Post-fix
> they pass cleanly.
> 
> Run with:
>   ./tools/testing/kunit/kunit.py run --arch=x86_64 \\
>     --kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_NVMEM=y \\
>     --kconfig_add CONFIG_USB4=y --kconfig_add CONFIG_USB4_KUNIT_TEST=y \\
>     --kconfig_add CONFIG_KASAN=y 'thunderbolt.tb_test_property_parse_*'
> 
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  drivers/thunderbolt/test.c | 127 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
> 
> diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
> index 1f4318249c22..22f4107fcb8d 100644
> --- a/drivers/thunderbolt/test.c
> +++ b/drivers/thunderbolt/test.c
> @@ -2852,7 +2852,134 @@ static void tb_test_property_copy(struct kunit *test)
>  	tb_property_free_dir(src);
>  }
>  
> +/*
> + * Reproducers for three memory-safety defects in
> + * drivers/thunderbolt/property.c reached from a crafted XDomain
> + * PROPERTIES_RESPONSE payload.  Without the fix these trip KASAN or
> + * smash the kernel stack; with the fix each returns NULL cleanly.
> + */
> +static void tb_test_property_parse_u32_wrap(struct kunit *test)
> +{
> +	u32 *block = kunit_kzalloc(test, 500 * sizeof(u32), GFP_KERNEL);
> +	struct tb_property_dir *dir;
> +	struct {
> +		u32 key_hi, key_lo;
> +		u16 length;
> +		u8 reserved;
> +		u8 type;
> +		u32 value;
> +	} *e;

This is same as tb_property_entry so probably should use that or better do
it like we have in that root_directory as array of u32.

At least do not duplicate it all over.

> +
> +	/* Root header: magic + length=6 (single entry body of 4 dwords +
> +	 * 2 slack, keeps walk within block[]). */

The block comment format is

	/*
	 * ..
	 * ..
	 */

Ditto everywhre.


> +	block[0] = 0x55584401;
> +	block[1] = 6;
> +
> +	/* Crafted DATA entry at block[2..5]: value = 0xFFFFFF00 and
> +	 * length = 0x100 are u32/u16 such that the u32 sum 0x100000000
> +	 * wraps to 0, passing the sum <= block_len guard even though
> +	 * the real offset is block + 0xFFFFFF00 * 4 (~16 GiB past the
> +	 * block).  The subsequent parse_dwdata() at property.c:132
> +	 * copies entry->length*4 = 1024 bytes from that wild address
> +	 * into a fresh kcalloc buffer.
> +	 */
> +	e = (void *)&block[2];
> +	e->key_hi = 0x61616161;
> +	e->key_lo = 0x61616161;
> +	e->length = 0x100;
> +	e->type   = 0x64;		/* TB_PROPERTY_TYPE_DATA */

This can use TB_PROPERtY_TYPE_DATA.

> +	e->value  = 0xFFFFFF00;
> +
> +	dir = tb_property_parse_dir(block, 500);
> +	/* With the fix this returns NULL; without it, KASAN splats in
> +	 * be32_to_cpu_array() / memcpy reading block + value*4 out of
> +	 * bounds.  Assert on the safe outcome: a NULL dir. */
> +	KUNIT_EXPECT_NULL(test, dir);
> +	tb_property_free_dir(dir);
> +}
> +
> +static void tb_test_property_parse_recursion(struct kunit *test)
> +{
> +	u32 *block = kunit_kzalloc(test, 500 * sizeof(u32), GFP_KERNEL);
> +	struct tb_property_dir *dir;
> +	struct entry {
> +		u32 key_hi, key_lo;
> +		u16 length;
> +		u8 reserved;
> +		u8 type;
> +		u32 value;
> +	} *e, *child_e;
> +
> +	block[0] = 0x55584401;
> +	block[1] = 4;		/* rootdir length = one entry */
> +
> +	/* DIRECTORY entry pointing at dir_offset=2 with length=16.
> +	 * When parsed as non-root: content_offset = 6, content_len = 12,
> +	 * nentries = 3.  The child's first entry at block[6] is also
> +	 * DIRECTORY pointing at 2, so the recursion oscillates between
> +	 * two dir_offsets until the kernel stack is exhausted.
> +	 */
> +	e = (void *)&block[2];
> +	e->key_hi = 0x61616161;
> +	e->key_lo = 0x61616161;
> +	e->length = 16;
> +	e->type   = 0x44;		/* TB_PROPERTY_TYPE_DIRECTORY */

This can use TB_PROPERTY_TYPE_DIRECTORY.

> +	e->value  = 2;
> +
> +	child_e = (void *)&block[6];
> +	child_e->key_hi = 0x62626262;
> +	child_e->key_lo = 0x62626262;
> +	child_e->length = 16;
> +	child_e->type   = 0x44;
> +	child_e->value  = 2;
> +
> +	dir = tb_property_parse_dir(block, 500);
> +	/* With the fix this returns NULL at TB_PROPERTY_MAX_DEPTH (8).
> +	 * Without it, the kernel stack-guard fires ~50-80 frames in
> +	 * and the kunit thread oopses. */
> +	KUNIT_EXPECT_NULL(test, dir);
> +	tb_property_free_dir(dir);
> +}
> +
> +static void tb_test_property_parse_dir_len_underflow(struct kunit *test)
> +{
> +	u32 *block = kunit_kzalloc(test, 500 * sizeof(u32), GFP_KERNEL);
> +	struct tb_property_dir *dir;
> +	struct entry {
> +		u32 key_hi, key_lo;
> +		u16 length;
> +		u8 reserved;
> +		u8 type;
> +		u32 value;
> +	} *e;
> +
> +	block[0] = 0x55584401;
> +	block[1] = 4;
> +
> +	/* DIRECTORY entry with length=3.  When parsed as non-root,
> +	 * content_len = dir_len - 4 underflows size_t to ~SIZE_MAX,
> +	 * nentries = SIZE_MAX/4.  The for-loop walks entries past the
> +	 * block, reading OOB on each iteration.
> +	 */
> +	e = (void *)&block[2];
> +	e->key_hi = 0x61616161;
> +	e->key_lo = 0x61616161;
> +	e->length = 3;
> +	e->type   = 0x44;

Thi can use TB_PROPERTY_TYPE_DIRECTORY.

> +	e->value  = 6;
> +
> +	dir = tb_property_parse_dir(block, 500);
> +	/* With the fix: NULL.  Without: KASAN splat on
> +	 * block[content_offset + i*4] for i > 124 (past the 500-dword
> +	 * block). */
> +	KUNIT_EXPECT_NULL(test, dir);
> +	tb_property_free_dir(dir);
> +}
> +
>  static struct kunit_case tb_test_cases[] = {
> +	KUNIT_CASE(tb_test_property_parse_u32_wrap),
> +	KUNIT_CASE(tb_test_property_parse_recursion),
> +	KUNIT_CASE(tb_test_property_parse_dir_len_underflow),
>  	KUNIT_CASE(tb_test_path_basic),
>  	KUNIT_CASE(tb_test_path_not_connected_walk),
>  	KUNIT_CASE(tb_test_path_single_hop_walk),
> -- 
> 2.53.0

