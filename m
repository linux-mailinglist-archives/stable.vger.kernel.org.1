Return-Path: <stable+bounces-238029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOL8AKwZ32ktOwAAu9opvQ
	(envelope-from <stable+bounces-238029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:53:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FB1400425
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C350F30A9528
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F20137107E;
	Wed, 15 Apr 2026 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jB32vQg4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6728DB54;
	Wed, 15 Apr 2026 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776228773; cv=none; b=APwOSskTY0dEFVPjnbLyQrqJwkGKRd1RgkfvLQtU/8VpGKw7gVvSn3p4JfqoAtAQm+1oOUVQZjW+wPttNoBxJoaTSWz/y8oXJDRr4KDoAHtvRiWFCp3g5E+fkrdnH9YKbrH2majEOgZjL2EN6G80NTuUKrQnVOBhzEcdWyvmQzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776228773; c=relaxed/simple;
	bh=VwRGnFnq12GSc6F4jVy/VyVmWEFhu2WpEnnQtocc/qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSpZD0BMFM+wMqMXKJtCvHlgxJBbZ1MfdJCWkQ5Budi5aboYe0fGy9ciLM0de15t5eZlthv3wmVEo8052sPmniwQBGp9w1LbDa8BOmmcXafKJf4D1X5i6bnAgpnm/Q9KMtrQdOK1rsvQ1f1VeMZbIwphp40dmlpvHHTJXx4JlqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jB32vQg4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776228771; x=1807764771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VwRGnFnq12GSc6F4jVy/VyVmWEFhu2WpEnnQtocc/qY=;
  b=jB32vQg4XjKvKOb1YSoFoGN7vWz18Upwjh2uUZD3JhUD7EjIWJlD4INx
   4EmTrKF0y2xIav8+KusFHcKPldS9sp/VwwJpdHgrisxGOnQtKH6JRs6dz
   AiGuVLaOEtyz0CWIVjk+I4uG4lKdlyMaz0hs2z7Vl9iDUVUnS+6o63Pzm
   /ueUY9hpsxPfiDb/y99dBBDyoRR26I9EzlrSV88GGNwTIXOZ49XH5hvFd
   grMJVEUwgxoiF17r8aeB0Soa6l5+piFpyVo9WaP9TVonXkkiRtWPwnwcb
   FXRdWWrtca4gW6eRMyxndAfRQV+69oEfKTQ3quhFnYC2Z+xegDqwhBQ7E
   g==;
X-CSE-ConnectionGUID: F0D4Ni0zQ8i2JITocfvujQ==
X-CSE-MsgGUID: JlCGbq3STg6M8YEwG3L10Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77102282"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77102282"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 21:52:50 -0700
X-CSE-ConnectionGUID: Wt+27YzwRxOu6eVZEMkgMQ==
X-CSE-MsgGUID: TT13w7WGRNGHhJ9KI8i7yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230151825"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 14 Apr 2026 21:52:48 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id E3D0E95; Wed, 15 Apr 2026 06:52:46 +0200 (CEST)
Date: Wed, 15 Apr 2026 06:52:46 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-usb@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] thunderbolt: property: harden XDomain property
 parser against crafted peer
Message-ID: <20260415045246.GR3552@black.igk.intel.com>
References: <20260415032335.2826412-1-michael.bommarito@gmail.com>
 <20260415032335.2826412-2-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260415032335.2826412-2-michael.bommarito@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-238029-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: 57FB1400425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, Apr 14, 2026 at 11:23:34PM -0400, Michael Bommarito wrote:
> Three independent memory-safety defects in
> drivers/thunderbolt/property.c are reachable when an untrusted
> Thunderbolt/USB4 XDomain peer responds to a PROPERTIES_REQUEST
> during host-to-host discovery.  The peer supplies up to
> TB_XDP_PROPERTIES_MAX_LENGTH (500) dwords of attacker-controlled
> property block which the local host passes to tb_property_parse_dir()
> before PCIe tunnel authorization.

There is no PCIe tunnel authorization happening here.

> Bug A - u32 overflow in tb_property_entry_valid() (property.c:61).
> 
>     if (entry->value + entry->length > block_len)
>             return false;

Please split this patch into 3 patches that all deal with one issue at the
time.

> 
> entry->value is u32, entry->length is u16.  The sum is computed in
> u32 and wraps.  With block_len = 500 an attacker picks
> value = 0xFFFFFF00, length = 0x100; the u32 sum 0x100000000 wraps
> to 0, passing the > block_len check.  tb_property_parse() then
> runs
> 
>     parse_dwdata(property->value.data, block + entry->value,
>                  entry->length);
> 
> where block is const u32 * and entry->value is promoted to size_t
> for the pointer arithmetic.  The read source is block +
> (u64)value * 4, tens of GiB past the property-block allocation.
> Up to entry->length * 4 bytes are read from there into a freshly
> kcalloc'd property->value.data or property->value.text buffer.
> 
> Exfiltration path for TB_PROPERTY_TYPE_TEXT on the "deviceid" or
> "vendorid" keys: populate_properties() (xdomain.c:1157,1162) runs
> kstrdup(p->value.text, ...) into xd->device_name / xd->vendor_name,
> which are read back via the per-XDomain device_name and vendor_name
> sysfs attributes (xdomain.c:1730, 1763).  kstrdup stops at the
> first NUL byte in the OOB region, so the usable leak is the prefix
> up to the first zero byte at an attacker-chosen offset past the
> property block.  The attacker does not know block's KASLR/slab
> placement, so the read is untargeted in absolute terms - they pick
> a delta, not an address.  There is no generic "properties" sysfs
> blob; DATA-typed properties are parsed into property->value.data
> but never generically surfaced to userspace, so only the TEXT path
> with the two named keys is exfil-reachable.  NUL-bounded,
> untargeted, but still an attacker-directed OOB read.
> 
> Replace the u32 addition with check_add_overflow() so a wrapped
> sum is rejected.
> 
> Bug B - unbounded recursion in __tb_property_parse_dir().
> 
> A DIRECTORY entry's value field is used as dir_offset for a
> recursive call with no depth counter.  A peer that crafts a back-
> reference chain drives the parser until the 16 KiB kernel stack
> is exhausted and the guard page fires - pre-authentication remote
> DoS.  Bound the recursion to TB_PROPERTY_MAX_DEPTH = 8,
> comfortably larger than any legitimate XDomain property layout.
> 
> Bug C - size_t underflow on dir_len - 4 (property.c:184).
> 
>     content_offset = dir_offset + 4;
>     content_len = dir_len - 4; /* Length includes UUID */
> 
> dir_len arrives as a size_t sourced from entry->length (u16) on
> the non-root path.  If entry->length < 4, the subtraction
> underflows size_t to ~SIZE_MAX, nentries becomes SIZE_MAX / 4,
> and the loop walks entries past the property block on each
> iteration, reading OOB until either an entry fails validation or
> the kernel oopses on an unmapped page.  Reject dir_len < 4
> explicitly on the non-root path.
> 
> Additional hardening: move INIT_LIST_HEAD(&dir->properties) to
> immediately after dir allocation so every error-return path that
> calls tb_property_free_dir() (including the new dir_len path and
> the pre-existing dir->uuid alloc-failure path at property.c:180)
> sees a walkable empty list rather than the zero-initialized NULL
> next/prev that would oops list_for_each_entry_safe().
> 
> All three defects are OOB-read plus DoS class.  No controlled OOB
> write is reachable through the parser; parse_dwdata's destination
> is a freshly kcalloc'd buffer sized by entry->length.
> 
> Attacker model: malicious Thunderbolt/USB4 XDomain peer (cable,
> dock, in-line inspector, adjacent host).  Discovery runs as soon
> as the link is trained; PCIe tunnel authorization does not gate
> the control-plane PROPERTIES_REQUEST/RESPONSE path, and the host
> IOMMU does not mitigate because the data arrives as a control-
> plane payload the driver willingly copies into its own buffer
> before parsing.

Here too there is not PCIe tunnel. It's a tunnel but not PCIe.

Also you can disable whole XDomain stuff with passing "xdomain=0" in the
kernel command line.

> Reproduced on v7.0-rc7 + CONFIG_KASAN=y + CONFIG_USB4_KUNIT_TEST=y
> via the companion KUnit suite in the sibling patch.  Pre-fix, each
> of the three cases oopses inside __tb_property_parse_dir (Bug A
> hits a KASAN shadow-memory fault, Bug B trips the stack guard,
> Bug C OOB-reads past the property block).  Post-fix, all three
> tests return NULL cleanly and pass.
> 
> The parser sites fixed here have not been touched since the
> initial 2017 XDomain landing, per git log -p.  property.c has had
> three prior fixes by Kangjie Lu in 2019 (106204b56f60,
> e4dfdd5804cc, 6183d5a51866) for NULL-check omissions on
> kzalloc/kmemdup returns, and a 2025 documentation cleanup by Alan
> Borzeszkowski (d015642ad36d); none of those touch the bounds /
> arithmetic / recursion sites this patch addresses.  Verified via
> lei queries against lore.kernel.org/linux-usb/ for
> dfn:drivers/thunderbolt/property.c,
> dfhh:tb_property_parse_dir, dfhh:tb_property_entry_valid (0 hits
> beyond the doc cleanup); Patchwork linux-usb "thunderbolt
> property" query (0 in-flight patches); and Mika Westerberg's
> westeri/thunderbolt.git next/fixes/master branches (no pending
> bounds work on this file).

Also please tune the commit messages you get from the AI. This one is easy
to read from running git log so no need to duplicate here.

> Fixes: e69b6c02b4c3 ("thunderbolt: Add functions for parsing and creating XDomain property blocks")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  drivers/thunderbolt/property.c | 67 +++++++++++++++++++++++++++++-----
>  1 file changed, 58 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
> index 50cbfc92fe65..57ec742ed210 100644
> --- a/drivers/thunderbolt/property.c
> +++ b/drivers/thunderbolt/property.c
> @@ -8,11 +8,21 @@
>   */
>  
>  #include <linux/err.h>
> +#include <linux/overflow.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uuid.h>
>  #include <linux/thunderbolt.h>
>  
> +/*
> + * Bounds recursion depth when parsing a malicious XDomain property
> + * block whose DIRECTORY entries are crafted to self-refer.  The
> + * XDomain spec gives no hard limit; 8 is comfortably larger than any
> + * legitimate property layout observed in practice and leaves the
> + * kernel stack headroom.
> + */
> +#define TB_PROPERTY_MAX_DEPTH	8
> +
>  struct tb_property_entry {
>  	u32 key_hi;
>  	u32 key_lo;
> @@ -37,7 +47,7 @@ struct tb_property_dir_entry {
>  
>  static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
>  	size_t block_len, unsigned int dir_offset, size_t dir_len,
> -	bool is_root);
> +	bool is_root, unsigned int depth);
>  
>  static inline void parse_dwdata(void *dst, const void *src, size_t dwords)
>  {
> @@ -52,13 +62,23 @@ static inline void format_dwdata(void *dst, const void *src, size_t dwords)
>  static bool tb_property_entry_valid(const struct tb_property_entry *entry,
>  				  size_t block_len)
>  {
> +	u32 end;
> +
>  	switch (entry->type) {
>  	case TB_PROPERTY_TYPE_DIRECTORY:
>  	case TB_PROPERTY_TYPE_DATA:
>  	case TB_PROPERTY_TYPE_TEXT:
>  		if (entry->length > block_len)
>  			return false;
> -		if (entry->value + entry->length > block_len)
> +		/*
> +		 * entry->value is u32 and entry->length is u16; the sum is
> +		 * performed in u32 and wraps for crafted inputs.  Use an
> +		 * overflow-aware check so a wrapped sum is rejected instead
> +		 * of appearing to satisfy the bound.
> +		 */

Also please tidy up this comment.

> +		if (check_add_overflow(entry->value, (u32)entry->length, &end))
> +			return false;
> +		if (end > block_len)
>  			return false;
>  		break;
>  
> @@ -93,7 +113,8 @@ tb_property_alloc(const char *key, enum tb_property_type type)
>  }
>  
>  static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
> -					const struct tb_property_entry *entry)
> +					const struct tb_property_entry *entry,
> +					unsigned int depth)
>  {
>  	char key[TB_PROPERTY_KEY_SIZE + 1];
>  	struct tb_property *property;
> @@ -114,7 +135,8 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
>  	switch (property->type) {
>  	case TB_PROPERTY_TYPE_DIRECTORY:
>  		dir = __tb_property_parse_dir(block, block_len, entry->value,
> -					      entry->length, false);
> +					      entry->length, false,
> +					      depth + 1);
>  		if (!dir) {
>  			kfree(property);
>  			return NULL;
> @@ -159,16 +181,33 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
>  }
>  
>  static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
> -	size_t block_len, unsigned int dir_offset, size_t dir_len, bool is_root)
> +	size_t block_len, unsigned int dir_offset, size_t dir_len, bool is_root,
> +	unsigned int depth)
>  {
>  	const struct tb_property_entry *entries;
>  	size_t i, content_len, nentries;
>  	unsigned int content_offset;
>  	struct tb_property_dir *dir;
>  
> +	/*
> +	 * A malicious XDomain peer can craft DIRECTORY entries whose
> +	 * offsets point back at their own container, making the recursion
> +	 * unbounded without this gate.
> +	 */

This comment is useless.

> +	if (depth > TB_PROPERTY_MAX_DEPTH)
> +		return NULL;
> +
>  	dir = kzalloc_obj(*dir);
>  	if (!dir)
>  		return NULL;
> +	/*
> +	 * Initialize the list head immediately so every error-return path
> +	 * that calls tb_property_free_dir() (the new dir_len reject and
> +	 * the existing uuid-alloc failure path) sees a walkable empty
> +	 * list rather than the zero-initialized NULL next/prev that
> +	 * would oops list_for_each_entry_safe().
> +	 */

So is this.

> +	INIT_LIST_HEAD(&dir->properties);
>  
>  	if (is_root) {
>  		content_offset = dir_offset + 2;
> @@ -181,18 +220,28 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
>  			return NULL;
>  		}
>  		content_offset = dir_offset + 4;
> +		/*
> +		 * dir_len arrives here as the u16 entry->length widened to
> +		 * size_t; values below 4 underflow size_t on the subtraction
> +		 * below and produce a gigantic content_len, driving the
> +		 * nentries loop off the block with OOB reads on each
> +		 * iteration.
> +		 */

and this.

> +		if (dir_len < 4) {
> +			tb_property_free_dir(dir);
> +			return NULL;
> +		}
>  		content_len = dir_len - 4; /* Length includes UUID */
>  	}
>  
>  	entries = (const struct tb_property_entry *)&block[content_offset];
>  	nentries = content_len / (sizeof(*entries) / 4);
>  
> -	INIT_LIST_HEAD(&dir->properties);
> -
>  	for (i = 0; i < nentries; i++) {
>  		struct tb_property *property;
>  
> -		property = tb_property_parse(block, block_len, &entries[i]);
> +		property = tb_property_parse(block, block_len, &entries[i],
> +					     depth);
>  		if (!property) {
>  			tb_property_free_dir(dir);
>  			return NULL;
> @@ -231,7 +280,7 @@ struct tb_property_dir *tb_property_parse_dir(const u32 *block,
>  		return NULL;
>  
>  	return __tb_property_parse_dir(block, block_len, 0, rootdir->length,
> -				       true);
> +				       true, 0);
>  }
>  
>  /**
> -- 
> 2.53.0

