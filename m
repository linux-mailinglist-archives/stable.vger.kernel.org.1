Return-Path: <stable+bounces-237763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIXSFNAB3mkRmAkAu9opvQ
	(envelope-from <stable+bounces-237763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:58:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B16CB3F795A
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 181CA308D276
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB333B6C07;
	Tue, 14 Apr 2026 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6BnGz8g"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822D3B6C11
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776156941; cv=none; b=ACK3dTo9TmzC03tEHanhAC/DecqNzIVYksJuwaJi6exI7eGwFPJi1DcKOsAxNmyhaiIAmp9gsKxIyXoXujZf6WqKjKnaAjFH7mDQEUpau67KjLSGu5v2JHqutPGNRuPVUvNr8Xo9QDH4AQQdWLGNnc5tt10VDI1jdkt+ZmFDfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776156941; c=relaxed/simple;
	bh=kudLCTIITmlAZjTqgthhq39P8xFZprhHZarcmmvo6PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTZ1IEe4elZ7Khp5u0fUu01gjQF/lyuxW7Jrz72JZYXOPovaAhJ2UnvwFLsLM1r0jNrQH6M1wDures+BImRHiwTPeDAYX742DmIzJt5e7RHwF2UHjj/O//6gixhMDMDUSQRGYkPlTbxZofg6Ed6ImhOg1LCACqPBhhdFuacKsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6BnGz8g; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776156940; x=1807692940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kudLCTIITmlAZjTqgthhq39P8xFZprhHZarcmmvo6PU=;
  b=G6BnGz8gRgEXMOHnj34Y6V13yBNXBe2FlFMKNUiiuEOStA7bEdEKB4yH
   7AuhhywqZZbhj8IZ5uK2n3faLsJlu5zR/w/nAcp0pPJSbJ2bSDFVJrX99
   VGLCZQq3w3pIXt/Ahin1Gw1FMyPTfYDibiQxS84YwOFMqboqdqYX+WTpW
   jAvz+DfpV6111HNWmNdjtTXYVIHLKRi+tam4aswlWD8x9mc6+ZaXCDgFY
   reRQu6Tn1vw6RI1zwXSdeVUOSNRjPadBKb05KU9eyddo/TFDJjO9qB5b1
   XOCTrOlqvlN0koA3wp/ovPImgA9hsrBzM1QQckbolmtK5P9ocu/1krMRR
   g==;
X-CSE-ConnectionGUID: PtmR2NJHQl6hEWNC6VGVIg==
X-CSE-MsgGUID: P1VE0U6/Q9a+4d3p2zd4Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="88186417"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88186417"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:55:40 -0700
X-CSE-ConnectionGUID: rfAdmeYfT7OQFopcDKEkiA==
X-CSE-MsgGUID: Aoc23v+fREy3t9eodGYHEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="223535662"
Received: from avbakuno-mobl.ccr.corp.intel.com (HELO [10.246.16.61]) ([10.246.16.61])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:55:37 -0700
Message-ID: <01cee873-23d7-43f5-96eb-29826d1c157c@linux.intel.com>
Date: Tue, 14 Apr 2026 10:55:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] e1000e: Unroll PTP in probe
 error handling
To: Matt Vollrath <tactii@gmail.com>, intel-wired-lan@osuosl.org
Cc: stable@vger.kernel.org, Avigail Dahan <avigailx.dahan@intel.com>
References: <20260413000325.33379-1-tactii@gmail.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260413000325.33379-1-tactii@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237763-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,osuosl.org];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: B16CB3F795A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-13 2:03 AM, Matt Vollrath wrote:

Hey Matt,

Thanks for the patch!

Apologies but it seems I didn't explain fully where the changelog should 
go, same goes for the Cc: stable as it should be inserted into the 
commit msg as a tag, see example below.

> If probe fails after registering the PTP clock and its delayed work,
> these resources must be released.
> 
> This was not an issue until a 2016 fix moved the e1000e_ptp_init() call
> before the jump to err_register.
> 
> Fixes: aa524b66c5ef ("e1000e: don't modify SYSTIM registers during SIOCSHWTSTAMP ioctl")
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
> ---

Changelog should go _here_, not below the:

-- 
2.43.0

and should also have the --- afterwards. So using this patch submission 
as an example your commit msg + changelog should look like the following:

If probe fails after registering the PTP clock and its delayed work,
these resources must be released.

This was not an issue until a 2016 fix moved the e1000e_ptp_init() call
before the jump to err_register.

Fixes: aa524b66c5ef ("e1000e: don't modify SYSTIM registers during 
SIOCSHWTSTAMP ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
---
Changes:
v2:
* Apply the correct Fixes tag
* Target iwl-net
* Cc stable
---

  drivers/net/ethernet/intel/e1000e/netdev.c | 1 +
  1 file changed, 1 insertion(+)

<snip of the rest of the diff/>

Once again sorry for not saying it more clearly before.

Best regards
~Dawid

