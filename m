Return-Path: <stable+bounces-249614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGayC7Z1DGqihwUAu9opvQ
	(envelope-from <stable+bounces-249614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:37:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D7580AAD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE2B330E5823
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6052C348C40;
	Tue, 19 May 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AolN45es"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE6326D45;
	Tue, 19 May 2026 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201147; cv=none; b=ZyW9+ALKdqwpPKP55J415bXz0ZaprGLLbxfV7O7K4MbBMWTw7sxh6oI7NQNPnJRKhgwhVJ22+RDYPmFEWU7KwPfmxy8+9w7t57FfGJKTZCNj9fHoK2BmoT9YiWpdNEetQThtKduRVsSYozTnL4EJmRkoGumscL1hoX31xvKDzbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201147; c=relaxed/simple;
	bh=2PJptEChJaCA6iOrUEbZlahop1pl1YR76qbc3eR5LI0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EuTE9RtTknpk87xiyATOTonWDPXFh08AiGoyEgZWLFQhyxhnGc0KdkybopLII/q4p2SjpM1FBD3l5zJ4TFJOEJ5e5MhD/VEXxw2x2M/8eYfoPLhk/QaTuU3iys0dxht70eMy8qNGSZDhJAZwC3JuwOXsvDljq4Z3H20hHZm0afU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AolN45es; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779201146; x=1810737146;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2PJptEChJaCA6iOrUEbZlahop1pl1YR76qbc3eR5LI0=;
  b=AolN45escv27d/+zfHEcILJbABxw/m++IZtazzEOSM21IjhQlt0ePHGC
   1XojqrnUAHbTVv6OvX1T/692DToAc6BFSfN9z8QuxXcj9zqdEQAdor5px
   I7G/Ia8DqifW51PEcjF9k3EB1nPEa/il18Z8A2AMzdsqEki6FzCQXqwmD
   kIHfd5kNo8CvqMeX0CYIVwqHiGJLwtifviRgRJlfXJwDd1kQ/KFtd1FEL
   DaReQdkPYFs8Ga3zLzHhUoBgauw8fOgFaEzinO5rQtRlsCY424YuovIvu
   40MXhUJYTopDgL9sNoUjUFbVwxugHDOq/5YUSiUczIEj0NFlm0Z81TP1V
   w==;
X-CSE-ConnectionGUID: 6Kj1lv57QV+pX7ksasfPug==
X-CSE-MsgGUID: MVbHEtTqRfaWrt3imSK1lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="102757202"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="102757202"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:32:25 -0700
X-CSE-ConnectionGUID: xedhRpiMRS2e5I/krbvSDQ==
X-CSE-MsgGUID: GNsVSIvCTsSo0qnuQk/pIw==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:32:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 May 2026 17:32:19 +0300 (EEST)
To: ZhaoJinming <zhaojinming@uniontech.com>
cc: srinivas.pandruvada@linux.intel.com, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel/tpmi: Fix memory leak in mem_write()
 error path
In-Reply-To: <20260519082136.2999917-1-zhaojinming@uniontech.com>
Message-ID: <b1006ce4-f596-b2aa-421a-518fe3cfe1f0@linux.intel.com>
References: <20260519082136.2999917-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249614-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: D00D7580AAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026, ZhaoJinming wrote:

> In mem_write(), when the IS_ALIGNED() check fails, the function returns
> -EINVAL directly without freeing the 'array' allocated by
> parse_int_array_user(). This causes a memory leak.
> 
> Other error paths in the same function correctly use 'goto exit_write'
> to free the array before returning. Fix this inconsistency by using
> the same pattern for the alignment check.
> 
> Fixes: 8e0a2fc68ec3 ("platform/x86/intel/tpmi: Use 32 bit aligned address for debugfs mem write")
> Cc: stable@vger.kernel.org
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/platform/x86/intel/vsec_tpmi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
> index 16fd7aa41f20..2a428bfcb209 100644
> --- a/drivers/platform/x86/intel/vsec_tpmi.c
> +++ b/drivers/platform/x86/intel/vsec_tpmi.c
> @@ -495,8 +495,10 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
>  	addr = array[2];
>  	value = array[3];
>  
> -	if (!IS_ALIGNED(addr, sizeof(u32)))
> -		return -EINVAL;
> +	if (!IS_ALIGNED(addr, sizeof(u32))) {
> +		ret = -EINVAL;
> +		goto exit_write;
> +	}
>  
>  	if (punit >= pfs->pfs_header.num_entries) {
>  		ret = -EINVAL;

Hi,

Thanks for finding this problem. This function looks a prime candidate for 
cleanup.h conversion.

Please do this with a 2 patch series. The first patch converts kfree() to 
__free() and moves array declaration next to parse_int_array_user() (as 
instructed by the long comment in cleanup.h) and has fixes tag. The second 
patch should converyt the mutex lock/unlock to guard and doesn't need 
fixes tag. This way, we get rid of all gotos here.

-- 
 i.


