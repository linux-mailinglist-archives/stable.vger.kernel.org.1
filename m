Return-Path: <stable+bounces-244116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJAcLvvZ+WnNEgMAu9opvQ
	(envelope-from <stable+bounces-244116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:52:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 616484CD092
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CBF1301F35C
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F1394496;
	Tue,  5 May 2026 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HI+UVGCH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B21DE8BE;
	Tue,  5 May 2026 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981719; cv=none; b=ACkd+U34wN0W6AnETeD+p4HSQ8eJ5fpzbXWDXL6DIGqOZd1pRZN00AwfKU3PGUFUnJbQTz6aPXYtfu6ztdS+Ifux52G+EJu4VlcZCBId5drOKPMXaPHlqvdwpfqQcC7PB48/FFRDXpjz2kOdKEJ29VTCnn72QLhbGPlKwZuxBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981719; c=relaxed/simple;
	bh=p0KpugfrsoW4skQiO9PRbA4jRoDNqkVJGeI1Cw7U0Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhIQZkB6Qqw54Js8gSxaeI45n93fK4MQCGuDP71F48mp0zTJr7EBMM53bZ/fDvTTfErefF0WrGV26BKAxzF8eG6MMr2rnHNjZt9u+FinAdJfyOFjKozJ06G+NxwDSDkTjxUA4+KmOiuHaP64DIn/4CC0WluiBCeZdBcdmzbqgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HI+UVGCH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777981717; x=1809517717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p0KpugfrsoW4skQiO9PRbA4jRoDNqkVJGeI1Cw7U0Os=;
  b=HI+UVGCHg2+SBjk8NJE4XqDggTWUy9Q7AXzFhcC0/Pe9Ke0qYm8G7Iqx
   NB1d2RgZbNJyTAOlPoeK9yhY1d2QNQ8GelCjUaftrkEks7G4DHlvUVlo/
   A0teZ0SHj0E96uvvG8hznvxPc9ufAzna6cwv/B0yaqIVvPm9vGk1kZ+/N
   uA80lpZDpI4YvyOOwAfllj4B/Yu3ghlc9ZbS+pOxUWXbM8PwGES83DGCm
   +px1EzsJFGc1XAKAkCewFMFLkaWksvoUhrnXhCa8lJONjrIqUy5VeFAMU
   fwaUkpmlPSh9sOWwaMCUoGX6MEnGT54IkQf1yk3jj9sMfMPjpmQYwRWHv
   Q==;
X-CSE-ConnectionGUID: 4VbUrrqYSy29IAvLeOsQ2w==
X-CSE-MsgGUID: Rh36akT/Q2iddWKBWa88Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="77871842"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77871842"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 04:48:36 -0700
X-CSE-ConnectionGUID: K8u4o84pQeS+DnD+7bspOg==
X-CSE-MsgGUID: PBezB5XST2amaLr3XmpQ5Q==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 05 May 2026 04:48:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8FB8195; Tue, 05 May 2026 13:48:33 +0200 (CEST)
Date: Tue, 5 May 2026 13:48:33 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-usb@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] thunderbolt: test: add KUnit regression tests for
 XDomain property parser
Message-ID: <20260505114833.GE6785@black.igk.intel.com>
References: <20260415123221.225149-1-michael.bommarito@gmail.com>
 <cover.1777817011.git.michael.bommarito@gmail.com>
 <5caddc2abbec9d4215dfc9041ab18f84eb7bbc58.1777817011.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5caddc2abbec9d4215dfc9041ab18f84eb7bbc58.1777817011.git.michael.bommarito@gmail.com>
X-Rspamd-Queue-Id: 616484CD092
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,linux.intel.com,intel.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-244116-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,black.igk.intel.com:mid]

Hi,

On Sun, May 03, 2026 at 10:15:08AM -0400, Michael Bommarito wrote:
> +/*
> + * Reproducers for three memory-safety defects in
> + * drivers/thunderbolt/property.c reached from a crafted XDomain
> + * PROPERTIES_RESPONSE payload.  Without the fix these trip KASAN or
> + * smash the kernel stack; with the fix each returns NULL cleanly.
> + *
> + * The on-wire entry layout mirrors struct tb_property_entry in
> + * property.c (private to that translation unit).
> + */
> +struct tb_test_property_entry {
> +	u32 key_hi, key_lo;
> +	u16 length;
> +	u8 reserved;
> +	u8 type;
> +	u32 value;
> +};

If possible, can you make the below just be u32 as we have root_directory
already? That way we don't need to duplicate this and I think with the AI
should not be a big deal.

[The other option is to move the structure into tb.h as that's internal but
I prefer the u32 array in tests].

> +static void tb_test_property_parse_u32_wrap(struct kunit *test)
> +{
> +	u32 *block = kunit_kzalloc(test, 500 * sizeof(u32), GFP_KERNEL);

This one is fine to be dynamic and just fill in below what is needed as
u32.

Otherwise this is good and I like the fact that you added the tests so I
can just first apply the test patch and see that it breaks left and right
and then apply fixes and expect it now passes :)

