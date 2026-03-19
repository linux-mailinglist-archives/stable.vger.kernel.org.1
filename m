Return-Path: <stable+bounces-227381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N7jHQ9kvGmLxwIAu9opvQ
	(envelope-from <stable+bounces-227381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:01:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD62D2764
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5F7B300692D
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 21:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E136215A;
	Thu, 19 Mar 2026 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFWBoe6v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1492D0C94
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954055; cv=none; b=bySdvs6oCy1Hu2JCgH95/Z78ldSlTMRkmuOwxrfeXlmwrN7zX5UXVg/L4RJR7SIamVFQE69mXoe/kFrGO7y1md8jzkqLsF0CfwonF0/DCCuFDD/9c4YarIhlizxhivLoGeI8PoqAWjyz+KeSHPseE6UknyMAn8tQh/uyY2qwqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954055; c=relaxed/simple;
	bh=kH0cQHtD4Z7NPkXPsL4cUMXJnS1iYFiFT1dkndw02Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRpu0Nrhef9PscyhBkpYX5XZ+PobcD1gnJAN6bmWImTAQSBdopeZS3ryYYuIjZ2vrxGkBxYuRZsPD2/vAMdTnk3XDn/iKLCV3hzg8sUzSPEIYcqEFlpaOsyX1L6I0mx5XDONz/PcEUNR3AE2BZIbyUICrDdXUbjRDteVsqw7Jw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFWBoe6v; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773954054; x=1805490054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kH0cQHtD4Z7NPkXPsL4cUMXJnS1iYFiFT1dkndw02Ns=;
  b=CFWBoe6vZadkaBp2FEUS9ueiWxsCmMfSA5+X5fgTkJ8LWgMEYsgAwkWJ
   G/Tz1AlJsALbXbrtKkQikV9y6PNZRJwaFRY6DleYcg5csL+Q3atUXDCwN
   xtM9ndFQz5l/huBM8S2/+rkfqdCwGM1TFHWJVTie/A3n9DGcCMYxabZmt
   YCTnyOKVMKBP8my79UZlaetNm3cdEKwfbG+kLV8r++iNK5d1CDEpKOx2K
   VcpbYnioRsNWcAI2k7qwVD+inv9H3voXsxaAxggQATrSaK1aS+X9801kH
   348K52gDiBduWx3N+tHNi6vtqlFX/2xlC8YIYnTIlcONrUEuKAgBnI7Dz
   g==;
X-CSE-ConnectionGUID: 4RDFUKGBQXiyJyyaJ278uA==
X-CSE-MsgGUID: DilHaBZHTiuB295baFEONA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74217247"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74217247"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 14:00:54 -0700
X-CSE-ConnectionGUID: VFdQqlFjR+qbQmmyPtUF6g==
X-CSE-MsgGUID: 7+1izOE2SyyW+CusqitO+A==
X-ExtLoop1: 1
Received: from amilburn-desk.amilburn-desk (HELO kekkonen.fi.intel.com) ([10.245.245.3])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 14:00:52 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6B3B911F80C;
	Thu, 19 Mar 2026 23:00:52 +0200 (EET)
Date: Thu, 19 Mar 2026 23:00:52 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6.12.y 1/2] iio: light: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <abxkBLNmhGlxp9tm@kekkonen.localdomain>
References: <2026031706-gentile-unbalance-017b@gregkh>
 <20260319183438.2928887-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319183438.2928887-1-sashal@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227381-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakari.ailus@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 92FD62D2764
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sasha,

On Thu, Mar 19, 2026 at 02:34:37PM -0400, Sasha Levin wrote:
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> [ Upstream commit e15f23dd5305d123b571aeee56415d9e90f06ca4 ]
> 
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().

This is true from v6.17 onwards only; do not apply patches removing
"redundant" mark_last_busy() calls on earlier kernels as these calls are
needed there.

-- 
Regards,

Sakari Ailus

