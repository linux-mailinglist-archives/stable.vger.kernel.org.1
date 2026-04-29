Return-Path: <stable+bounces-241945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOV1B+Rw8mljrQEAu9opvQ
	(envelope-from <stable+bounces-241945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:58:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 393EC49A495
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4ECF300E4A8
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7563A9DAE;
	Wed, 29 Apr 2026 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2QzaP2U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD3301471;
	Wed, 29 Apr 2026 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496284; cv=none; b=QMp3uv3XomQf0Wopd6qZ65paZGYYuR2Od2EkvQBh1LydqKaL83qiJod37GYbobtZv25+mB3hG3ayIUKzQh/sDmgAGd3AYlqi3ZXOQa+Brz71d3AIZUlnk6uk+jLslxbt7KrT4XEiWs52OXfhPE93DGMRHE/4KVhXvRkZ5f353HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496284; c=relaxed/simple;
	bh=hn467ehO9BgfD2Pcd3HnYwXHHNGuKHVuop9PK4qRNiI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tBVPVPiW+XNyapU7AoYNdvIjzdnFzID0B5gYsBSn0jLDgA5k875HsOo36ik4kIRATL7CaXHMG0ayYPFyITxMbHsXTk3n6Ar4sjfA7ohZXXlI3Y3aFCK9dF1fjCqtUWmbwtmFFGzYsC+jlsO2HgA7fnE8SnlBOLJ7Kq9Xoq9n/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2QzaP2U; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777496283; x=1809032283;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=hn467ehO9BgfD2Pcd3HnYwXHHNGuKHVuop9PK4qRNiI=;
  b=a2QzaP2UT4JuJTFn+vWmCPG2v+wdM8P+0z713hRtPjCTpOcIU3AYmVCN
   cNG8GRYuDIIuwsDQzsZ5XIUEaYAW90VWWh3TZZNRjgYt4Hvu3q5GgQhCd
   Ut3mPGu39gEndgj++G7/fiWhXhYcigpRzxNq6BgwBY/Qaj2e+zxLJlJ+K
   sLk0XVgBwK82UVSHLEkJ/phZU3apof77mLdqEq89B4fkYkkOSu0Nvc6lY
   C/Q5arhqwyv3RrRjYpVbBplK/3D9ktHX4h5GppJ1r9G7MO9QWBJxX2ztz
   SuDmp+1xowlfIh3R/180fuudtkYKv+n7g2XFhsdxHnOS/827OA+gDzxCw
   w==;
X-CSE-ConnectionGUID: L6wGDCIFQvSX2xTKrPTVYg==
X-CSE-MsgGUID: Y2Kk//vUToOTYwmRqLQlig==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78330774"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78330774"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 13:58:02 -0700
X-CSE-ConnectionGUID: Jxrl+lH9QXmCTiEJVu7mDg==
X-CSE-MsgGUID: iIgzM1/+R2+/5NWRs7afCA==
X-ExtLoop1: 1
Received: from unknown (HELO [10.241.241.31]) ([10.241.241.31])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 13:58:02 -0700
Message-ID: <0b6dbecd-f3e1-40ca-97a2-e0df36a39704@intel.com>
Date: Wed, 29 Apr 2026 13:58:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Chen, Zide" <zide.chen@intel.com>
Subject: Re: [PATCH 1/2] perf/x86/intel: Fix redundant branch type check in
 intel_pmu_lbr_filter()
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
References: <20260414021440.928068-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260414021440.928068-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 393EC49A495
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-241945-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zide.chen@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]



On 4/13/2026 7:14 PM, Dapeng Mi wrote:
> In intel_pmu_lbr_filter(), the 'type' variable is bitwise ORed with
> 'to_plm' (which contains X86_BR_USER and/or X86_BR_KERNEL bits). Because
> of this, 'type' can never equal X86_BR_NONE (0) after the assignment.

Nit: In legacy LBR case, it could if get_branch_type() returns X86_BR_NONE.

> 
> As a result, the subsequent check 'if (type == X86_BR_NONE)' is dead code
> and the entries with X86_BR_NONE type would not be skipped eventually.
> 
> Correct this by masking out the X86_BR_KERNEL and X86_BR_USER bits
> before performing the X86_BR_NONE comparison.
> 
> Cc: stable@vger.kernel.org
> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/lbr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 72f2adcda7c6..16977e4c6f8a 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1245,7 +1245,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  		}
>  
>  		/* if type does not correspond, then discard */
> -		if (type == X86_BR_NONE || (br_sel & type) != type) {
> +		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type) {
>  			cpuc->lbr_entries[i].from = 0;
>  			compress = true;
>  		}


