Return-Path: <stable+bounces-241211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMzREbP17mn+1wAAu9opvQ
	(envelope-from <stable+bounces-241211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:35:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8AB46D3F0
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C0ED300B626
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 05:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1784935F602;
	Mon, 27 Apr 2026 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+j+TwKa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081540DFA5;
	Mon, 27 Apr 2026 05:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268141; cv=none; b=eQ3gN/RFHpilo9it5YBdYJ66Ats9oJAHWCOHu/ZBZl4mJkq1EQUnNOADgdiTmNBsyQOqXMCZkEoTJU+LcHrTgn5726ihjBzXy9KdP6Xm4dFAmWSRHNppOxkCZsFsSjIVQChCI13KBcUunQwYwLCtQJDobawQIlNRC+HfaIgKDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268141; c=relaxed/simple;
	bh=lNv1nbPdKh0thPmuFLok2MMvvcm8qm2jhpG+oU8cwIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+04u4TSdCmGtgnqKJN2mIFxHVKfp3KFLlGsPvQJfv8xrib9RlUH3w68f2AytJ2hPiBj6kRwaryTnj2l9c3ZjMbt5IG/zcQwxuK0Gbf8xhqFpYtCtYlyfdAyhYBWqGj80Nx+D3oTOPn8YBz+jcRHJANw6v4gV61+QwM5Qg/+dU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+j+TwKa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777268141; x=1808804141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lNv1nbPdKh0thPmuFLok2MMvvcm8qm2jhpG+oU8cwIc=;
  b=P+j+TwKabXQJIfL64t0la4Ws7LJS3bE5OTRtW3Qho5aZzMz+BRnVAjSw
   AUH1vi+yu5mmLAd4bOti2tB6T3vcBJC0bk0U9JESA9Is0lLgisYIqc1XZ
   jIyJX68JvQJ1zRqeOxAWQH7nACrj7QhTgEaVaESusLVjgI0Vm35bhhSum
   Sj9hsNnABu5zpuzIMuelTsvDUqqLIQ9IRKb4TBtC8BIaJT1zD2gb4xacd
   Egnl8rj68v2WEJfXFX8WKAczTEyusY+XB45xP9T0j1/03/oQ/YEIEOcSS
   dNqyl7ZfkiVmUOQg3GpluoHi58z2q5A9Yx5252pHn3LTZ+fshIMA99Off
   A==;
X-CSE-ConnectionGUID: uoekMu5oR9mvpadEPoMstg==
X-CSE-MsgGUID: 46GnkRL4RueqvhczEej3OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="77853113"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="77853113"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 22:35:40 -0700
X-CSE-ConnectionGUID: f2g9jQPmS+K0rRjzE1LhHg==
X-CSE-MsgGUID: yigKp4+sTBSD5G5eCW1yog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="229214199"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 26 Apr 2026 22:35:38 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 10F5C95; Mon, 27 Apr 2026 07:35:37 +0200 (CEST)
Date: Mon, 27 Apr 2026 07:35:37 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-usb@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] thunderbolt: property: reject u32 wrap in
 tb_property_entry_valid()
Message-ID: <20260427053537.GK557136@black.igk.intel.com>
References: <20260415032335.2826412-1-michael.bommarito@gmail.com>
 <20260415045246.GR3552@black.igk.intel.com>
 <20260415123221.225149-1-michael.bommarito@gmail.com>
 <20260415123221.225149-2-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260415123221.225149-2-michael.bommarito@gmail.com>
X-Rspamd-Queue-Id: AA8AB46D3F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-241211-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Michael,

I was about to apply these but noticed few stylistic issues so can you fix
those and send v3?

On Wed, Apr 15, 2026 at 08:32:17AM -0400, Michael Bommarito wrote:
> entry->value is u32 and entry->length is u16; the sum is performed in
> u32 and wraps.  A malicious XDomain peer can pick
> value = 0xFFFFFF00, length = 0x100 so the sum 0x100000000 wraps to 0

It's 0xffffff00 (e.g lower case).

Ditto everywhere.

> and passes the > block_len check.  tb_property_parse() then passes
> entry->value to parse_dwdata() as a dword offset into the property
> block, reading attacker-directed memory far past the allocation.
> 
> For TEXT-typed entries with the "deviceid" or "vendorid" keys this
> lands in xd->device_name / xd->vendor_name and is readable back via
> the per-XDomain device_name / vendor_name sysfs attributes; the leak
> is NUL-bounded (kstrdup() stops at the first zero byte) and
> untargeted (the attacker picks a delta, not an absolute address).
> DATA-typed entries are parsed into property->value.data but not
> generically surfaced to userspace.
> 
> Use check_add_overflow() so a wrapped sum is rejected.
> 
> Fixes: e69b6c02b4c3 ("thunderbolt: Add functions for parsing and creating XDomain property blocks")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  drivers/thunderbolt/property.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
> index 50cbfc92fe65..f5ee8f531300 100644
> --- a/drivers/thunderbolt/property.c
> +++ b/drivers/thunderbolt/property.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/err.h>
> +#include <linux/overflow.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uuid.h>
> @@ -52,13 +53,16 @@ static inline void format_dwdata(void *dst, const void *src, size_t dwords)
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
> +		if (check_add_overflow(entry->value, (u32)entry->length, &end) ||
> +		    end > block_len)
>  			return false;
>  		break;
>  
> -- 
> 2.53.0

