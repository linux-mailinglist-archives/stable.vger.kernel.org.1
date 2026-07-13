Return-Path: <stable+bounces-273651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J1xqD1PNVGoTfAAAu9opvQ
	(envelope-from <stable+bounces-273651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:34:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBBC74A666
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:34:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="RzT1SR/T";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273651-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273651-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D1E63016B8B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE563E024F;
	Mon, 13 Jul 2026 11:34:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B1381E8F;
	Mon, 13 Jul 2026 11:34:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942479; cv=none; b=Uw2gpvEQKHa9rrdmViAIH0WD/UwU7KtXUrfpTuMb5hsUDRUxrNc5riwo+fp5TtQChDNwMPPi4b/cH33mv7jCQkBPmlNJnRsJjh1yFAnazwDlbB/BwZb5l0HUUnkloIYa+6qDf0B3QMX6YTLDgWVfPbR9lWbwd1hK6DFm4bTL9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942479; c=relaxed/simple;
	bh=M84iIkDz2qoCIceHYB5sFpzZWTMnU6n74p+J5ddZ3hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdWYo2jN7EQhoToRNm6NvJV1caA0ipzr0U4p1nvfrZTIGSgk1+dCnNfZ5RSzmfS5tDCXlNm2Nkaql3+N/RVoEOXE7uwDou2YBCkA8uoZyEiNosfdPeE2Nh650jGkQNeDAGjg1bMyvec46H8xULaJ5pX3BQs2ARCw4xpY6V5SxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzT1SR/T; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783942478; x=1815478478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M84iIkDz2qoCIceHYB5sFpzZWTMnU6n74p+J5ddZ3hU=;
  b=RzT1SR/T5cR73OGaoTuYy2lWggVq8OG6z/0AV4DolR0YVTcI+TnzSYfr
   WN6YU3GyfVcXw8DmF+Smfqc5eh6skkTgE5e+HXPpvOnsXsM1xHSGEVlMu
   V8Ep26/EkvUuukzZjkZn6GNhPQhmS6ot1gOJfZm9FVk7aoOR3ULzqkqRb
   hd7cXv1/T7+KrK/tBUmewj7R/trPyI5XfO8ALXQujaWpusRxCQSlEIxta
   A4B9eNKkOhfIGWDOUa6mOZwZjrETb3Lfg76FaIpiFrWaoiIPjCi24Jevz
   CDzi9d3unMQxf4HbS7LAQp02BTPRXJYaRGBZKnT+ftYu8Ivk1+nIqo5j9
   Q==;
X-CSE-ConnectionGUID: aqWwbW88TMemIXYm3h696w==
X-CSE-MsgGUID: t8Pn2/T4Qw2kJki81t+uQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84664882"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84664882"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:34:37 -0700
X-CSE-ConnectionGUID: a5JbNem3TnCc+rYpJUMWGg==
X-CSE-MsgGUID: d5/VchwyRRe7Nv4ET0q/LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="285611198"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:34:35 -0700
Date: Mon, 13 Jul 2026 14:34:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: proximity: hx9023s: validate firmware size
Message-ID: <alTNSJODSTsPWyAF@ashevche-desk.local>
References: <CAMyXUJnsV1GD0VmK_n25hqr_=A5Z=u_gCXV=oACgKuP3dSgwnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMyXUJnsV1GD0VmK_n25hqr_=A5Z=u_gCXV=oACgKuP3dSgwnQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273651-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:acharyalaxman8848@gmail.com,m:jic23@kernel.org,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:joshua.crofts1@gmail.com,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,analog.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFBBC74A666

On Mon, Jul 13, 2026 at 10:31:30AM +0545, Laxman Acharya Padhya wrote:
> hx9023s_send_cfg() copies the firmware into a counted flexible array and
> then reads fixed offsets from the copied data before walking register/value
> pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
> make the driver read past the copied buffer during probe-time configuration
> loading.
> 
> Reject firmware images that cannot contain the fixed header, reject images
> too large for the u16 fw_size field, and validate that the advertised
> register count fits in the remaining payload.

> Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file
> parsing functionality")

This has to be a single line.

> Cc: stable@vger.kernel.org
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

...

> v3:
> - Resend once in plain-text format after the duplicate v2 messages.
> - Keep each commit trailer on one complete line.

None of these is being addressed.

...

>  static int hx9023s_send_cfg(const struct firmware *fw, struct
> hx9023s_data *data)
>  {
> + /* fw_size is u16 in struct hx9023s_bin, so reject truncation. */
> + if (fw->size < FW_DATA_OFFSET || fw->size > U16_MAX)
> + return -EINVAL;

The patch is mangled. Please, conduct an investigation before sending any new
versions or other patches to the kernel mailing lists.

>   struct hx9023s_bin *bin __free(kfree) =
>    kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
>   if (!bin)

Compare the above to

	struct hx9023s_bin *bin __free(kfree) =
		kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
	if (!bin)
		return -ENOMEM;

	bin->fw_size = fw->size;
	memcpy(bin->data, fw->data, bin->fw_size);

-- 
With Best Regards,
Andy Shevchenko



