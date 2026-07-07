Return-Path: <stable+bounces-272473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DirHGzgzTWr2wQEAu9opvQ
	(envelope-from <stable+bounces-272473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 19:11:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 026CB71E25E
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 19:11:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=N2uwdSz4;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272473-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272473-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0FB33058F59
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292B743846E;
	Tue,  7 Jul 2026 17:08:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42E843787C;
	Tue,  7 Jul 2026 17:08:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783444106; cv=none; b=mcEhE5qip/W1pLb0xw7SK1vtn5b3MhH5FFRznFG1RzfonYF3t73F3xPEd1t1N0hZ/btpm+8XxHbxcN1dk9tqr8mEoSm/3S3h4VLR4BA4yT2MEdXgQXnWOcc3M4uw4C5uHtHEz3Rff4NK8XZq/DYoZ3pMDC0fzUsipuvnKfKWhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783444106; c=relaxed/simple;
	bh=rA3d5QgVZIIQxLV7WWUI7QtfddQ350YfIp8bmP7kuLM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nT7A4g82Nd3nOLc1VIDxr3zD6jLDLzkhPT5cYAUDUl2HQRVSbgCHm9jl5dUL1T6DSefWM9LgmLkgMepG3uPGbxzpBdA9U9a6M2BavJklGcZ4cxGpY5X3Xbw55HBEEYXJXrxCz682WfUaGJQm6rxaiLg2XthiaKzs8+UwSM/2IeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2uwdSz4; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783444106; x=1814980106;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=rA3d5QgVZIIQxLV7WWUI7QtfddQ350YfIp8bmP7kuLM=;
  b=N2uwdSz4EriQv9IrSO2sw6xQOkHXn0F6PuxJa78gpHxzQMcL3S9FRYkD
   b4g8VtFQzew2+FOsHduyTaSLTqYc5l2jR9oNgp+XPxXk17YmRvPvxV7fC
   J2glI83iiY1XaRBinR7W1eP6b8nVD4CdBumhHjiy+otC8iQK8jd6t7ytn
   g/RR0iYJGr4SnjpfxHe11BWKkQax4EoquVrGJwm/CCDeYNNogKIQdJqYX
   HN5l3hr5IE7YI95u8UjxfUbHU0WW36gtPbAdvqTbaN7n6nZZCR1zSnp5K
   AH4e/bu207KqVm8SuOhF8Lhrb6YtbCVMDLAI8KalxdwjBRdhMmMvi4SVg
   g==;
X-CSE-ConnectionGUID: 2eiVsC1jRI+K4jHkZycQpQ==
X-CSE-MsgGUID: yCV9uApGTVi+WEaYlkcxGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84217212"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84217212"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 10:08:25 -0700
X-CSE-ConnectionGUID: c1f3kLpsRPSJp6E1M+5nKA==
X-CSE-MsgGUID: DYdYtiRPRD6gih7gR7NsKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="247671141"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.226])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 10:08:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, Krishna Chomal <krishna.chomal108@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yahia Ahmed <yahmedd043@gmail.com>, stable@vger.kernel.org
In-Reply-To: <20260623141314.33947-1-krishna.chomal108@gmail.com>
References: <20260623141314.33947-1-krishna.chomal108@gmail.com>
Subject: Re: [PATCH] platform/x86: hp-wmi: Add support for OMEN MAX
 16-ak0xxx (8DD6)
Message-Id: <178344409637.17784.435700941911534714.b4-ty@b4>
Date: Tue, 07 Jul 2026 20:08:16 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hansg@kernel.org,m:krishna.chomal108@gmail.com,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yahmedd043@gmail.com,m:stable@vger.kernel.org,m:krishnachomal108@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272473-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 026CB71E25E

On Tue, 23 Jun 2026 19:43:14 +0530, Krishna Chomal wrote:

> The HP OMEN MAX 16-ak0xxx (board ID: 8DD6) has the same WMI interface
> as other Victus S boards, but requires quirks for correctly switching
> thermal profile.
> 
> After testing we know that (similar to another HP Omen Max 16 device,
> board ID 8D87), the embedded controller on this board does not expose
> thermal profile which means we have to intentionally disable EC readback.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] platform/x86: hp-wmi: Add support for OMEN MAX 16-ak0xxx (8DD6)
      commit: 44dc7fcb32791e9144a7024075af6cf999f81e81

--
 i.


