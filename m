Return-Path: <stable+bounces-224754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wADcEtjPsWmQFQAAu9opvQ
	(envelope-from <stable+bounces-224754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:26:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AE5269F52
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A86293021992
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE4D38D01D;
	Wed, 11 Mar 2026 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnX6G8lM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064D2F8BEE;
	Wed, 11 Mar 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260755; cv=none; b=DYOWoMzIIvq2EjEzRMRh4S1H4aNnTvTXpyqQJSt7qR3cIzjjpBPU4ZQhKRKqRytNu4y0nuXLwj/UUQ+p9pDRYuM4CA/lxm8+FgHgQpl2wks6YffbNQnav+fIs4svWdxfDk7yDqrL1KXSOwqzPnmYgP5Tlxyf0yiD1C+8mYlOVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260755; c=relaxed/simple;
	bh=NvaC1fFbBx9IUqO3UIQZiBuTUiy8td86hLAlj0aH1VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zq9Yz+XBIZd2Wr2B8S60/4nKS/p84xIwuj86GKOTIwmd7yPhTyPw7G+HdNIaZFDvPEWYoJZxxRj5O9a2L4UbwoCzY6Z/lx4iT1DX68wgKIfLJqTfbrFIPT+Zh3WzxXA41pD9RA5MWrm42l6LzQUrflj9PssV3J3SYYZBMeO2bG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnX6G8lM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773260753; x=1804796753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NvaC1fFbBx9IUqO3UIQZiBuTUiy8td86hLAlj0aH1VE=;
  b=PnX6G8lMZYBU6dsnIRkDUd3b5QYQhHC5LYMcLjZkoylXrT/YbboyGpt4
   NybjwhW8P7P4oH7wcfC7NyzmLg+Fyfr7ra4r3Qhwe1Duk0UT+r5FI83kn
   ttYwkL2Nv14YIN2ioUZeV3kWgdd2RD5VG4X39ZSluiyXR0Zox3DBdPGZ+
   cUTUmuQX246Ux/DAy1UGR2WSeZLb4Atc0upJZXRREaT9epUESznm6Jeo5
   iD55IQGALyo8/MdUcakjOE70Bp6pdivnbKAzGYB2eJ6r+iHYjYNpiKTF7
   1QsaxyXyO0l62+A3Wyg71+B0yu2EkFJXOB0qf1nTOeoFw+qIHZvdYdsD5
   w==;
X-CSE-ConnectionGUID: KkL7eLV7QRaDWUpWGeCc4g==
X-CSE-MsgGUID: CveKDpkWTy6ug7G376fWVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="99810399"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="99810399"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 13:25:52 -0700
X-CSE-ConnectionGUID: kSI054tHTXGshAWNH0vuTg==
X-CSE-MsgGUID: nz0RxcL/SAiuSgy4J7qTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220540294"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 13:25:50 -0700
Date: Wed, 11 Mar 2026 22:25:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Brian Mak <makb@juniper.net>
Cc: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mfd: core: Preserve OF node when ACPI handle is
 present
Message-ID: <abHPy8sQYWApqbmY@ashevche-desk.local>
References: <20260311190225.22426-1-makb@juniper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311190225.22426-1-makb@juniper.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224754-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0AE5269F52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:02:25PM -0700, Brian Mak wrote:
> Switch device_set_node to set_primary_fwnode, so that the ACPI fwnode
> does not overwrite the of_node with NULL.
> 
> This allows MFD children with both OF nodes and ACPI handles to have OF
> nodes again.

Haven't I given a tag already?

-- 
With Best Regards,
Andy Shevchenko



