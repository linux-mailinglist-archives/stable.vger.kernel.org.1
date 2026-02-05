Return-Path: <stable+bounces-214501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MUhEau/hGnG4wMAu9opvQ
	(envelope-from <stable+bounces-214501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:04:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A06AEF4F10
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 985913031314
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039342DFFA;
	Thu,  5 Feb 2026 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCFCzBVD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928B243951;
	Thu,  5 Feb 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307175; cv=none; b=FXeUFxhQWGeIGwFLp8HinfcoVtooNSd9byXVJIfZ2KaTa/jvYKRZ63I00WFsmYyMBkPcpLojkSWYS6Fsdba3BwoRDmJQGmL+5xNS7KDOyN+sEtl3593UFr7AJFkzA6XYCTxu5fW/eq26g0HjzINdLXvnVc4GPGS3on3Hlo9272g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307175; c=relaxed/simple;
	bh=P8ZSlzF8zoFJprfglbou2waU99w2SXYldEzFSEjzX50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kvl/6zXfSdm43RtDxri+gngUYlv274c5QjWhq0cQEEK7aXW8TovXDWJmVb0xGKecDn+jJ0r1VMjAu9IoTqqzZ/TyR7LY5AzLPu6JjW59G9qi5yiAENxAS7BzPABbjg9G+vuaEEh1rPgMi1+WfMBzQyttcQKIQiLdz5C+IlZVcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCFCzBVD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770307176; x=1801843176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=P8ZSlzF8zoFJprfglbou2waU99w2SXYldEzFSEjzX50=;
  b=HCFCzBVDL5ML+Y+pl9quVyt1dCKxbn5P6LaozS457faTY+DWKdDL2ADi
   TMr87AGiElcc8b3QtGTZ07oMgKX8+Tx9c0iEohSX6Q625galRobCywked
   CGx2JLaUwIUL4waLbOG99ui4HW2/c/JsNR54fELtoHuI71UO8DWUIfrSA
   WIW672TSW3lssNzX+bD1KFXZ/PbQ7736zf3Ds6CIH58pCxo8dr2FTYreg
   KS563sodXtOxa2nVl09P91+/ItcanxCqUGuYInhYplWePSS8KzORzc93b
   0f0P0DrAQYoTLDwietB/z29e4Lu1bEXX8V5D67NEJlRtsB6OQS0J3nQvy
   w==;
X-CSE-ConnectionGUID: 2PrS/QR/Rve41swSOf13FQ==
X-CSE-MsgGUID: glRS6Js2RU2qaq8QEEsEug==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71408552"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71408552"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 07:59:35 -0800
X-CSE-ConnectionGUID: WbSgYJxQQIy92njLYCUtLw==
X-CSE-MsgGUID: f9tbAM3fQuamc+8Az6yD4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="215542146"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 07:59:32 -0800
Date: Thu, 5 Feb 2026 17:59:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Remi Buisson <Remi.Buisson@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm45600: fix INT1 drive bit inverted
Message-ID: <aYS-Yb-Sey84CX9y@smile.fi.intel.com>
References: <20260205-inv-icm45600-fix-int1-drive-bit-v1-1-72a78cd07150@tdk.com>
 <CAHp75VdmVP45+3r6HoC-Gf7FfXMJdmfTV739LLDAtdX_f_xu7Q@mail.gmail.com>
 <FR3P281MB1757F7C3B3820FF1568F4001CE99A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FR3P281MB1757F7C3B3820FF1568F4001CE99A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,tdk.com,kernel.org,baylibre.com,analog.com,huawei.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214501-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_WP_URI(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: A06AEF4F10
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:29:32PM +0000, Jean-Baptiste Maneyrol wrote:
> >From: Andy Shevchenko <andy.shevchenko@gmail.com>
> >Sent: Thursday, February 5, 2026 12:32
> >On Thu, Feb 5, 2026 at 11:55 AM Jean-Baptiste Maneyrol via B4 Relay
> ><devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:
> >>
> >> Drive bit must be set for open-drain mode and be cleared for push-pull
> >> mode.
> >
> >Any pointers to the datasheet? (to the particular section / table that
> >explains this bit)
> 
> here is a link to the datasheet:
> https://invensense.tdk.com/wp-content/uploads/documentation/DS-000576_ICM-45605.pdf
> 
> The register bits are described in section 17.23 (page 72).

Yes, please add this reference to the commit message
(URL might not be needed, though; just free text).

-- 
With Best Regards,
Andy Shevchenko



