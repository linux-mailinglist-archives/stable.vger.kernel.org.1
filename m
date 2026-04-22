Return-Path: <stable+bounces-240369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPglKI8B6Wl5SgIAu9opvQ
	(envelope-from <stable+bounces-240369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:12:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AC2449304
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C6CA3091C83
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3B9383C97;
	Wed, 22 Apr 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWosdQvS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD735C190;
	Wed, 22 Apr 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877654; cv=none; b=e3rx1rJnBv2+Bh1I4k+n04/Ut7TMwFb+/d3Re9Y6xw7tqD1p5yBKpDc+Eqqt0KvDluZvpg2HRn1B5PK9M6MEr3pCIGl1O2AxVyYrMNfE+7G/TUdDdnmXB//XxJ2sQYA6WuCtwP9/W1GnMnquJmF4I4gRz4Z6AXapedUmdHwmA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877654; c=relaxed/simple;
	bh=zJd4/g8VBCdh8xvZ0oZIhR50cxWuszu1ZS6WcfY+oHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJmqqTqGHkJSI8zyRrt0xj7rPDFkPEQpzjxvjem8vmjYBr8aFa89nncBj74a0aKK8M5/+3MYWHs2j2ILq4OFaYLVuP2dSWIIc6zaTTH5JHSIC2xe9zeQrCnfgYMeKybw7CBv+DlFF/ePfIOufsQn4XQxD9s3/NwvRNgpFbCff1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWosdQvS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776877652; x=1808413652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zJd4/g8VBCdh8xvZ0oZIhR50cxWuszu1ZS6WcfY+oHQ=;
  b=aWosdQvSteUxToFPFHXTKinvwALRyQCkYgQZuzhxZ+xLPgrdPoexMZmE
   zvWOuYaIvL0F5L7NC1FUVaQk2HtQviMRHG8ifwz4byvcBp5idvZePwa07
   qHA2u/VGNRUAgmrz1cLe6sjfZZnUSoYIr80A1bcIUv1wEkbxH/aR8uELE
   mc3/MuGrFBfeZRGCAUb92ZM0fsbxbDuoz5PZvE5c8rBaR7g1vfFsTJEhz
   whshuIhRmRli5GWNcdyiXrD7zC0ivTPW3VDxJGv1iY0dgATLUtUBH1yd3
   TMPBvK/I3xXkCijxP0IMDRq2v+rlnxrvKudbs14qm1+VLCiiDPKKr9WRa
   g==;
X-CSE-ConnectionGUID: PjoKBMHtTsC42k+55umVoA==
X-CSE-MsgGUID: KgStBRWHQEWH5X4sz9Hn8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77001905"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77001905"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 10:07:31 -0700
X-CSE-ConnectionGUID: V/yY5WyeR+qFdSzGdYEPow==
X-CSE-MsgGUID: 4jK5+xNWTIeLZC5k34gU8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="232723852"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 10:07:31 -0700
Date: Wed, 22 Apr 2026 10:07:29 -0700
From: Andi Kleen <ak@linux.intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
Subject: Re: [Patch v2 2/4] perf/x86/intel: Disable PMI for self-reloaded ACR
 events
Message-ID: <aekAUXkbHfOfPxX1@tassilo>
References: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
 <20260420024528.2130065-3-dapeng1.mi@linux.intel.com>
 <aef8InBGlZaXNuPk@tassilo>
 <f1cb6c84-d8ff-46a0-a062-816fce9fc164@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1cb6c84-d8ff-46a0-a062-816fce9fc164@linux.intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240369-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ak@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11AC2449304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > Are you sure this doesn't conflict with some other non ACR usage of config1?
> 
> Yes, currently hw.config1 is only used to store ACR  event indices.

Thanks. Should probably rename the field to make that clear.

-Andi

