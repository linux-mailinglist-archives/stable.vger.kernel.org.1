Return-Path: <stable+bounces-230646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKx6CxpyxmmkJwUAu9opvQ
	(envelope-from <stable+bounces-230646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:03:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBAC343EF3
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC94C3051842
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810653914EC;
	Fri, 27 Mar 2026 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnW7hibB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068FF390CA6;
	Fri, 27 Mar 2026 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612850; cv=none; b=nMFbbMFu/aXc1v+w7KOYgqroKS5cenCq8yiV4SGXUwZve2z5MmVJ6tg3E2q4YsSP91DmGNNFLW//EykXuVNPfT0AMJ+DfBTvMI3SeoKwbOS9A1I+g80k6SZhk4T/kFnjvZajWu9PocIGNyskc4FwIghNF/s3ofkg756Vt3AOkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612850; c=relaxed/simple;
	bh=lJdYolBUwf9iihc/RlpVqecq7JJbg+PZltTgDV1AOic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j5FTi2bOqPqXPkNZUvldrZcs7M89opeWixoM437Trgalnf4zq6tf8uE0dXG2I2yFp/ONBLzCpVwaXrpQYZskvVHq0rWwdARaExbjJqcQNq9WaINP2uY7HJDk1RSKKO1QTvnBLbSnaNPOTBJEwY67+shwZeEw3T05y2YPA/QmAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnW7hibB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774612848; x=1806148848;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=lJdYolBUwf9iihc/RlpVqecq7JJbg+PZltTgDV1AOic=;
  b=LnW7hibBBpWSz0my3thd2FwQiCDx+Uia+6BtrbZZzd7asDrZGQo4MBXL
   IkqfWDTR8KYpYJu2BsqrvYefWDYj0mbnYJRaXkygVl5tMS898rt/8oln2
   OJ0bzMGpd8HUS0340e7B6TsDt2LjbpqUp+iAygLn9scD5rvEm7lChUzmB
   ybDqSZOrMLegfvs72c7zatiGuoNm/B0trHTXNnaYUwbZWPjUHH++RMeJM
   BPtqVFRB3E9eyRfGNpwVpvfLLEOk8egDC8kKIJ3xRuDyqMhLP1bcPIeku
   bGB+IW84zsuovAcGdeSH4VOaXku8Qkg6D+qZ59ts9fvfD5B2XeiuD3J2r
   A==;
X-CSE-ConnectionGUID: i8kOfTSuSxCaaTWmbuTB/A==
X-CSE-MsgGUID: bTycVV55Qj6O6BUPwdLS8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74715343"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="74715343"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:00:47 -0700
X-CSE-ConnectionGUID: SOvebYkORfev47wJPIgaNw==
X-CSE-MsgGUID: n+y5TK8oSh2QsUJRn0KOBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="248606972"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:00:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260325192638.3417281-1-srinivas.pandruvada@linux.intel.com>
References: <20260325192638.3417281-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] platform/x86: ISST: Reset core count to 0
Message-Id: <177461284037.7356.69559774075485472.b4-ty@linux.intel.com>
Date: Fri, 27 Mar 2026 14:00:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230646-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: BEBAC343EF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 12:26:38 -0700, Srinivas Pandruvada wrote:

> Based on feature revision, number of buckets can be less than the
> TRL_MAX_BUCKETS. In that case core counts in the remaining buckets
> can be set to some invalid values.
> 
> Hence reset core count to 0 for all buckets before assigning correct
> values.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: ISST: Reset core count to 0
      commit: e1415b9418eb22b4a7a1ef4b4aec9dd0a49e3fa7

--
 i.


