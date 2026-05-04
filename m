Return-Path: <stable+bounces-242957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMGuCplg+GnKtgIAu9opvQ
	(envelope-from <stable+bounces-242957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:02:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC124BAB50
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 088993072472
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AEF3491D6;
	Mon,  4 May 2026 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbxCgF/W"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB11318EEE;
	Mon,  4 May 2026 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885053; cv=none; b=U3tA9nyPBOHv4wvDzusV18fX+9c/Ypc70nEf9KdY7v3VkEdHn2f2x7rveWpTKQ335z+2eluYolXttUA1U/SuJYT6hDcrTMtWdH+EDVbJCz2PHBCHMAllcEMXgJ5cGciQwXABaTKYgqxKyw/1OHikq8711SSXfn79av1e0W7sCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885053; c=relaxed/simple;
	bh=DCB792sBP7heCFPmc4hb1oWEUUSwNd/IGJYThEbOIUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqPwnGMcK7N8AcwbRPMF0V6MGlihD5lFXD5rOGh/bDNMkCrxfQdjWoGEfnE3ans6FJjI72BIkegoxNVbkMWDK64TMbTND7T5aNYbTxvAhwyZjW236Or7MwMUbEi28TmI+wAn1kfLGPbl4cKIPeP6l8UyPkyYw6NSPauqh2O2qZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbxCgF/W; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777885053; x=1809421053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DCB792sBP7heCFPmc4hb1oWEUUSwNd/IGJYThEbOIUM=;
  b=XbxCgF/WnvLSLayWKKI+pYFsKeVDTQ10yvUBVCtYeQLvPDfHkYPFZMb4
   oTKWskrxtkR4M5AZR4JsYcJRTau/bG9SarUJKjJnF3nr1gqt+VeJw8EGR
   +ZPj06vzVpw8VV7NQhyWM12TdDVayK8NkQQXFTE/4vdB+M/8fvHwzzbqt
   GI16/5ABOtICQKVP65cDwLm7HqkRohKVKi3HW4JIo9wJMxSPiq2fi9pDF
   zoCFry5wTfUaLy1mcRM7sKwZICxy9YBRUcODdkumSBNulKxpAN7JvkF7/
   ni23hpofi4D6EJDMIm8Uv9kaknjyMVwxFicbrEMyXoDtcen2mkKtDfDD3
   w==;
X-CSE-ConnectionGUID: ocxmXy4oT5mOEqyJeAASpw==
X-CSE-MsgGUID: RkbBMY7QSlGUiB93EnnRoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78789423"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78789423"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:57:32 -0700
X-CSE-ConnectionGUID: /bmu3p2XQp2+uo/+vqVLPA==
X-CSE-MsgGUID: XB/y71JiRH2MlCGRyE4CBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="232814938"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:57:29 -0700
Date: Mon, 4 May 2026 11:57:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-usb@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] thunderbolt: property: reject u32 wrap in
 tb_property_entry_valid()
Message-ID: <afhfd76fx1b3tLup@ashevche-desk.local>
References: <20260415123221.225149-1-michael.bommarito@gmail.com>
 <cover.1777817011.git.michael.bommarito@gmail.com>
 <eeedf1e42fd71d3686b352b402466a70482f8b22.1777817011.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeedf1e42fd71d3686b352b402466a70482f8b22.1777817011.git.michael.bommarito@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 9FC124BAB50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242957-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,intel.com,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,ashevche-desk.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sun, May 03, 2026 at 10:15:05AM -0400, Michael Bommarito wrote:
> entry->value is u32 and entry->length is u16; the sum is performed in
> u32 and wraps.  A malicious XDomain peer can pick
> value = 0xffffff00, length = 0x100 so the sum 0x100000000 wraps to 0
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

...

> +		if (check_add_overflow(entry->value, (u32)entry->length, &end) ||

Why is casting needed?

> +		    end > block_len)
>  			return false;

-- 
With Best Regards,
Andy Shevchenko



