Return-Path: <stable+bounces-98772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC1F9E5254
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E628F18824A4
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006861A8F90;
	Thu,  5 Dec 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPvUYW0B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739212E5D;
	Thu,  5 Dec 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394733; cv=none; b=NvI8Ntks9TxvlUOnar46F6seSvTX0dvawHwaxnf7AUVCBgMc8NpiGAvgZouyC1Pnir8NApDmRUy+0ZkFiPJjuMatMKixrWbYsekBY4H5o44OBZTV1oa+FNT4bsdkobeB0edI0pdYmHMmVqFhfTMwY5p6t/AT47qn4rC0A6NQUNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394733; c=relaxed/simple;
	bh=COWoU+5gq4kVzIcTj/TZNF7z4BX1FKIUPkkuCC5RHwU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VRSW70EVh8d2tRotYWvM1I1/jc/BDCZ/FsFrIej3P6D0/hRRpbitSHzeMDBghHNI1YOfTpVra1M3c8UHPi/1BkuXuC6aIT0FEAj1d0zGujMvIJfmg6ai1TwY62p2OpYMc5q7xIljoP2jEipSb8Qot/fK3K/IgylhFmnPqX/jhEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPvUYW0B; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733394732; x=1764930732;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=COWoU+5gq4kVzIcTj/TZNF7z4BX1FKIUPkkuCC5RHwU=;
  b=lPvUYW0BvvrztN49hEn23ne4by8KvnVFgXKhZH/Fvbqi8xZrx1fz31UO
   LUeIfF8C3F4GIgcZ37k9Hx7yrIylEQiA0xB4dU2v6OUGMSzHkylqvYkod
   VIA3hJ/37wnOX4I81GftRi2eq5PqXD2Cr3OjbkmMvGeLbAFBoUL7XIdvM
   XeLz74ga/3N6Yv/6FKVFQXbGAGuw4Bv/1SpwX1oTbhFs7B9hFP3Pj5LXw
   HXe+uvcPbB13ezCv+CbFNPdbe4eMstuj+b9hX0AqtRZQRGGmiitGBlI5B
   0MxIc5vITBHKmPuyREEveKj4JsPLyVTsMIsDVZfrtE3geyyauNUF8ZfUQ
   g==;
X-CSE-ConnectionGUID: +a61cdM6SmaASz+C6t6PBA==
X-CSE-MsgGUID: hniRDpNQSXuSowrFamV1nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33835274"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33835274"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 02:32:11 -0800
X-CSE-ConnectionGUID: Uxbyj1fgTGOnP27UojRuVg==
X-CSE-MsgGUID: pT7hbOerRMmPFuJvydKEdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94244099"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 02:32:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 12:32:05 +0200 (EET)
To: Andy Shevchenko <andy@kernel.org>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v3 3/8] platform/x86: serdev_helpers: Check for
 serial_ctrl_uid == NULL
In-Reply-To: <Z1Fs4j8g7uC-Cc14@smile.fi.intel.com>
Message-ID: <d0a88f8f-dd53-c67d-b619-972000c23118@linux.intel.com>
References: <20241204204227.95757-1-hdegoede@redhat.com> <20241204204227.95757-4-hdegoede@redhat.com> <Z1Fs4j8g7uC-Cc14@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 5 Dec 2024, Andy Shevchenko wrote:

> On Wed, Dec 04, 2024 at 09:42:14PM +0100, Hans de Goede wrote:
> > dell_uart_bl_pdev_probe() calls get_serdev_controller() with the
> > serial_ctrl_uid parameter set to NULL.
> > 
> > In case of errors this NULL parameter then gets passed to pr_err()
> > as argument matching a "%s" conversion specification. This leads to
> > compiler warnings when building with "make W=1".
> > 
> > Check serial_ctrl_uid before passing it to pr_err() to avoid these.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> ...
> 
> > +		       serial_ctrl_hid, serial_ctrl_uid ?: "*");
> 
> Not sure about '*' as it would mean 'any', perhaps 'none', '-', or 'undefined'
> would be better, but since they are error messages, it's not so critical.

Isn't not checking _UID (in acpi_dev_get_first_match_dev()) same as "any" 
_UID?

-- 
 i.


