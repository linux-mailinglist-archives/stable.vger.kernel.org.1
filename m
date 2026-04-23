Return-Path: <stable+bounces-240398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMnRB4tv6WkzZgIAu9opvQ
	(envelope-from <stable+bounces-240398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 03:02:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E57B44BFF3
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 03:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B57833034C8C
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 01:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E258D239E75;
	Thu, 23 Apr 2026 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpfRo9qp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCF21EA7DB;
	Thu, 23 Apr 2026 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906115; cv=none; b=g15BjVpWrfhupMa2TQP/TufJy/iO2JIuJl3At81SzV7gyfWN1KTLz9PA9bBGNEUKaJwqOW92fzz7qUD8+CX360TomcmEReXfrj0EYrNB2P1TsLRQQZArRDUyfDK5KGVrIv0RZLwEBAm79Hbilijgio2CB7iX919ic0ms3fYfVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906115; c=relaxed/simple;
	bh=ZajkLdH7FPlb0ve9ZZsUaSGNURY+PaxiTDW2Cwm2L8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S84ELXhmxrj+NDHRtoTWnVkPo2srN9fjJzyqMAe6DgAvuv5dLS8YVa2UTgRdjPJ0Dc3KioXKd2HHvQLrYl1yMq2QXD2aO7WGVqfZNC15bphaAoIWF8yFgUd1Kw68BiQVN1n3YZT79KK8/NQRKHbtrLUB/5VTQmjq5X+ydBT29A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpfRo9qp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776906114; x=1808442114;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZajkLdH7FPlb0ve9ZZsUaSGNURY+PaxiTDW2Cwm2L8M=;
  b=GpfRo9qph5CjzH1m6ucTGe2L6tvi9ZgnpaO/7c2W8eRY1PIvFFwTnBlB
   LK6Le/MpH+8YUJxgg7roLZvIJped2H5OCffjsSkQe8Eo2mfyZgB9TVZOI
   shtVvS0GNIyxx0j03DWPWvrbRH6j0L7OnMV3WQA9T/CfNLyk+ap5YPI+H
   LaoAwjCd6lL9Eqpt+QRZibijXYzkk9zLQhcmxWvFm+Oom7jokgDdYBb7N
   YVfiibgdjzz4yF6ZW8vB1xsb4CD3djeYLMZg5sXmyUocoiDod0ait3xIp
   UCEMxbJNlKCEdRgPFf3jJlcLlBISTpzP/TKCf40fKUM+3W/5Pa8h3xtP1
   g==;
X-CSE-ConnectionGUID: 88yeoL+fSz6fV8dRwuzaDw==
X-CSE-MsgGUID: l6kVZ/jETlCKRY56sQorHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77986790"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77986790"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 18:01:53 -0700
X-CSE-ConnectionGUID: 6Z4pNhzJSAq2levA+TZYWQ==
X-CSE-MsgGUID: 2jSxGEBtSTm915hrKTKWig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="227943026"
Received: from unknown (HELO [10.238.3.127]) ([10.238.3.127])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 18:01:45 -0700
Message-ID: <4b7e6df6-3a9c-45c2-84ae-f738e5741bb6@linux.intel.com>
Date: Thu, 23 Apr 2026 09:01:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/4] perf/x86/intel: Disable PMI for self-reloaded ACR
 events
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
References: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
 <20260420024528.2130065-3-dapeng1.mi@linux.intel.com>
 <aef8InBGlZaXNuPk@tassilo>
 <f1cb6c84-d8ff-46a0-a062-816fce9fc164@linux.intel.com>
 <aekAUXkbHfOfPxX1@tassilo>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aekAUXkbHfOfPxX1@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-240398-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 8E57B44BFF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/23/2026 1:07 AM, Andi Kleen wrote:
>>> Are you sure this doesn't conflict with some other non ACR usage of config1?
>> Yes, currently hw.config1 is only used to store ACR  event indices.
> Thanks. Should probably rename the field to make that clear.

Yeah, would do. Thanks.


>
> -Andi
>

