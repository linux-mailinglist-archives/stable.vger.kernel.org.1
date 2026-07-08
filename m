Return-Path: <stable+bounces-272635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 425OJBMwTmqqEwIAu9opvQ
	(envelope-from <stable+bounces-272635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 13:10:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A1A724ADC
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 13:10:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=T2Nb44Lg;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272635-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272635-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A6703033D0B
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 10:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9BB3E7BB6;
	Wed,  8 Jul 2026 10:58:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DBB41DEF0;
	Wed,  8 Jul 2026 10:58:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508331; cv=none; b=SoWOj4z+vdYxdxkLRcc+T5rn9SJfjjoL0pKCvFtkXbvgouzaoAep1dL0OuyNQ8miFXPMl2+6KlUV9+tF83il4/kcuzFXF/qvpqSFkdgiX8g6LCZsmmdI3NAOYingSxvUgk5+V2GBPw3du7F/Yu/kUcvXfZ7YZHKcHlS3agTYS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508331; c=relaxed/simple;
	bh=uLndf3XBF0EwMHiDPu+IFBtxvE/0mb5uTssIQTZs8ho=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aKEE2DeJPTBbKwKHjuZQEBRGd23fzJImOYJrmUL2QIWB4w55WQMl78KImfZpfA2TDQZPe77DI887AhjikDzjU+jWhubtEkFNkuYgZ1dkH7CuziAoVzisrL++ST+bd/1VKJ6eaZLdVx+igzJdncvsqJoDdqQwGb2BJg1y/+zpjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2Nb44Lg; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783508329; x=1815044329;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uLndf3XBF0EwMHiDPu+IFBtxvE/0mb5uTssIQTZs8ho=;
  b=T2Nb44Lgl2qOQFkrRkO6KjCZNlL/Ltf7wW95m2VVYV4aJB8MYDWlHPR7
   TSf1klkFo00Ef9tVjVRirrnBVdUxycuQ+n2a9u/XpT/eV5LUVqJ8neIEZ
   oFPYOQRk5Z1rB0MGDaWZPSYi9O1j8WtDOQpgm7MeCmBTTeaZtRZQ2SPc0
   IJ8rEqcfqluKQ/RZT8uLM4tS5n5xOJ+AQ1bjoVXeDxzW0coV9xxfQ8HCx
   rKoLEHb7AWPKWx5Sstzz4gGfkD0saC6DmMAdYQQFjKe1ZHLtpbCcIQkXA
   RJPGZvoCMEQZgopMJRLfhTV1E/W9hJln4AzZLYPDkFHnpMCOLUqo2qX8P
   w==;
X-CSE-ConnectionGUID: 5qJCsH5JSnKfz3Uw4zfaiw==
X-CSE-MsgGUID: 09zTzd9MQrahqUxDxE/mEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84041938"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84041938"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:58:45 -0700
X-CSE-ConnectionGUID: swcOwHujSMu2NgzEvec59Q==
X-CSE-MsgGUID: wwvxlwywQZWBpXcgm8ziWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="284369825"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.169])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:58:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Jul 2026 13:58:38 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    hdegoede@redhat.com, jorge.lopez2@hp.com, Thomas.Weissschuh@linutronix.de, 
    superm1@kernel.org, W_Armin@gmx.de, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/4] platform/x86: hp-bioscfg: bound ordered-list
 parsing by the package count
In-Reply-To: <20260707202111.35414-3-meatuni001@gmail.com>
Message-ID: <25a18f2d-ce84-ad42-a779-54cec281a89c@linux.intel.com>
References: <20260707202111.35414-1-meatuni001@gmail.com> <20260707202111.35414-3-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272635-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,hp.com,linutronix.de,kernel.org,gmx.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:meatuni001@gmail.com,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hdegoede@redhat.com,m:jorge.lopez2@hp.com,m:Thomas.Weissschuh@linutronix.de,m:superm1@kernel.org,m:W_Armin@gmx.de,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00A1A724ADC

On Wed, 8 Jul 2026, Muhammad Bilal wrote:

> hp_populate_ordered_list_elements_from_package() differs from the other
> per-type parsers: its main loop is bounded only by the fixed per-type
> count and never checks elem against the number of elements actually
> present in the package,
> 
>   for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT; elem++, eloc++)
> 
> whereas the string, integer, enumeration and password parsers bound
> their main loop with "elem < count" as well.
> 
> This is safe today because hp_init_bios_package_attribute() rejects any
> package with fewer than ORD_ELEM_CNT elements before the parser runs. A
> later patch relaxes that check to accept shorter packages; 

An upcoming change, however, relaxes ...

> once this
> loop can be handed fewer than ORD_ELEM_CNT elements it indexes
> order_obj[elem] past the end of the array - an out-of-bounds heap read.

I don't think we need this part of the explanation, it will never happen 
as you're fixing it beforehand. :-) So please drop it as unnecessary 
detail.

It's pretty obvious to kernel developers anyway if there's a runaway index 
so there's no big need in general to tell too simple basics like that.

> Bound the loop by the validated element count as well, so it stops at
> whichever comes first, the per-type count or the real package size,
> 
>   for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT && elem < order_obj_count;
>        elem++, eloc++)
> 
> order_obj_count is the validated count plumbed in by the previous
> patch. No functional change for packages that enumerate correctly
> today.
> 
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> index 83ddf99f93954..a50d074125268 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> @@ -145,7 +145,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
>  	if (!order_obj)
>  		return -EINVAL;
>  
> -	for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT; elem++, eloc++) {
> +	for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT && elem < order_obj_count; elem++, eloc++) {
>  
>  		switch (order_obj[elem].type) {
>  		case ACPI_TYPE_STRING:
> 

-- 
 i.


