Return-Path: <stable+bounces-230647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFvxB09yxmmkJwUAu9opvQ
	(envelope-from <stable+bounces-230647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:04:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F89343F1A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D76307C274
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A53914E3;
	Fri, 27 Mar 2026 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPFv4EpU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6F34A76A;
	Fri, 27 Mar 2026 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612856; cv=none; b=tSF2fPPJ4pvcIeYogIA+REPWa0qVLU3BQ0yeADvolRS0y1NJrH4g2F1H27WPl/sf14oIHWvJa2XfRzyBwRDUslTBG37H9iUt/rzY73tMX5lRz4pvFcma/GRupyea8YC88OTBUqoXX7Udk+fKXTBdOf1DKPMXnzhXdvfIvuU+BUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612856; c=relaxed/simple;
	bh=Tn+6/Eg6fMD1LTQm+kC2R1vcez04MAs/6MRtMXwKGz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HLJMttT48fU1BoA35BepUfaU+tjfs5FLoNTo1pD/S8E23ka3msM6WfZkPGzBS2tv7iXXgCkfx2CgiSW8IQp/zudvhqhJUH5fNj055DcLd9UkIRd1JJ1b5I6otV5/FaXLNXOlmhlCOaTns5HZk6uOXcE5xcVJxYX+zCnAAYplSy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPFv4EpU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774612856; x=1806148856;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Tn+6/Eg6fMD1LTQm+kC2R1vcez04MAs/6MRtMXwKGz4=;
  b=PPFv4EpURHaogWaBFXoEfjAerjCuqFTHABngslVyI45lJxLPwd/YtWeD
   5el/5xWuqyjSkrN6OZ9hIa7OAr8UBPI1x/ci/NTd1YD4ybc8OZjnO6SXW
   jZI4Hxs1H5+yOycJ3zJYXbcv/VsvHTBF/AtSqtritmiJDtFxeEa1ywy/E
   CN4XwuzGG8bd86kQIZR1dGZ+miZV6pfqnG/ShiqkpNy/Y+cTV0qIKngMg
   36ESgYq/7PBqwutSWt8vkv6y6LZaz9jq8DR9CGGs4kxngVihnwjU4IJh+
   Ulf3YQOr35M7cSf/H+lEMV8lv4CxQLZNlJvO/cnpVnvcJoPQd3DWmfN4B
   A==;
X-CSE-ConnectionGUID: JSjiieM1TIySWf7zlaSy/w==
X-CSE-MsgGUID: CYUzIWBtR2qZAJfsuAhFaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74715357"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="74715357"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:00:55 -0700
X-CSE-ConnectionGUID: Y/4KnuCERauGXa7sLfLosg==
X-CSE-MsgGUID: XkLKDRfySYuve/aJVJSBHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="248606988"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:00:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260325192909.3417322-1-srinivas.pandruvada@linux.intel.com>
References: <20260325192909.3417322-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Handle autonomous UFS
 status bit
Message-Id: <177461284772.7356.11131908408533608714.b4-ty@linux.intel.com>
Date: Fri, 27 Mar 2026 14:00:47 +0200
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230647-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71F89343F1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 12:29:09 -0700, Srinivas Pandruvada wrote:

> When the AUTONOMOUS_UFS_DISABLED bit is set in the header, the ELC
> (Efficiency Latency Control) feature is non-functional. Hence, return
> error for read or write to ELC attributes.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel-uncore-freq: Handle autonomous UFS status bit
      commit: 4ab604b3f3aa8dcccc7505f5d310016682a99d5f

--
 i.


