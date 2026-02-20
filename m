Return-Path: <stable+bounces-217545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEsKIgsWmGki/wIAu9opvQ
	(envelope-from <stable+bounces-217545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 09:06:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A72B3165832
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 09:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 090C730095DC
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89399335564;
	Fri, 20 Feb 2026 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUt/tXIM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1679231197A
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574789; cv=none; b=lms8KScgaJsymlqmS9Xip91Cjl8IhnN/6aD0llgpo0baJS2mhxukOXWKzH2ampqIp9waEuYxpZ14e63jA0/OeMYv7TkWR8sZ2JVgbJUXlPfGWS19eLXPjRd56wwBVtIODI53G6yEzASnmh7mkfIxRu/lxb/4mCd8dinm2MLpdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574789; c=relaxed/simple;
	bh=agtpy0zBRQH19MbljJyff70mXp7cKE3leYmZlja+h0E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rvS2UE8Ue5KeTdglB4kgroUW8mI67d1VeNMQoRy70pTPqQAtJsqFWtDIGdgiVw0XzU9C/ZTuCkkbzSPlc93tGY5WdljCJaxb/P6vt924PR+a86jqHuJENtB87h3Ij2w9OruTpcLs0YXzFDx89EWS24THH00GBr2Kws+Q5wOleGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUt/tXIM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771574788; x=1803110788;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=agtpy0zBRQH19MbljJyff70mXp7cKE3leYmZlja+h0E=;
  b=DUt/tXIMnXzpngRoDSfjnqDCN994S0vvmWekqwCIo/im1//BQcm0yNAG
   iByIFShuhuevw7jysMnd+T9uhTsSyu3x057WrcrC1l5EWca4BvDlMqPd2
   5Zi2QcwuLUt6YQ5KYzxipT3jpFRroiDW+Rcz+BmZMbbi6MoGxkvUoq9wb
   81SHU3DphgTD3rOClviflAZjXmVMcj1n4uQA7Pk0VwMY4vFQCuLAC/wcn
   xH7cLE5/d1PrMNeHvenDZN6LW92MDCYGxxv3vQLQif0zFIWbupNTT622n
   gl3u2HOgptppU289r9oei1i3wo6sfUKk8tgfLKYDaj6OoxZsSualpw9eP
   g==;
X-CSE-ConnectionGUID: FwORxN8KRPaDCQYAJ6UDWw==
X-CSE-MsgGUID: 5tcQgtgVTiW7X8HzpP0nzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="84028799"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="84028799"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 00:06:27 -0800
X-CSE-ConnectionGUID: YaRkZ0PAT2yVpRmxppKDTQ==
X-CSE-MsgGUID: +ZKggmGaQtKVVG2ZIOCR8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="212933048"
Received: from administrator-system-product-name.igk.intel.com ([10.91.214.181])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 00:06:26 -0800
Date: Fri, 20 Feb 2026 09:06:24 +0100 (CET)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: =?ISO-8859-15?Q?Jouni_H=F6gander?= <jouni.hogander@intel.com>
cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
    Animesh Manna <animesh.manna@intel.com>, 
    Jani Nikula <jani.nikula@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/alpm: ALPM disable fixes
In-Reply-To: <20260212062731.397801-1-jouni.hogander@intel.com>
Message-ID: <ad4e98ae-3a64-f570-fb1a-77355ecc431a@intel.com>
References: <20260212062731.397801-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1527428566-21081126-1771574787=:851205"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-217545-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.grzelak@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A72B3165832
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1527428566-21081126-1771574787=:851205
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 12 Feb 2026, Jouni Högander wrote:
> PORT_ALPM_CTL is supposed to be written only before link training. Remove
> writing it from ALPM disable.
>
> Also clearing ALPM_CTL_ALPM_AUX_LESS_ENABLE and is not about disabling ALPM
> but switching to AUX-Wake ALPM. Stop touching this bit on ALPM disable.
>
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7153
> Fixes: 1ccbf135862b ("drm/i915/psr: Enable ALPM on source side for eDP Panel replay")
> Cc: Animesh Manna <animesh.manna@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> Signed-off-by: Jouni Högander <jouni.hogander@intel.com>

Reviewed-by: Michał Grzelak <michal.grzelak@intel.com>

BR,
Michał
--1527428566-21081126-1771574787=:851205--

