Return-Path: <stable+bounces-211202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOnPOZfIcWknMAAAu9opvQ
	(envelope-from <stable+bounces-211202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 07:49:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AAC6258D
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 07:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28A7E461C75
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 06:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA29C357A28;
	Thu, 22 Jan 2026 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WetCRo7q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575D221721;
	Thu, 22 Jan 2026 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769064536; cv=none; b=jDYvvRjjkAKkvDvO2kCN7P1J8sChU1Qig++VIvmo51YUHs/255vHrThOay01ACfnvxfGfdIFX+7MkRsOoL16NG3W3hNkXID51Lt2H3gigZDJXVkC4e5whpTQ4syN/wXRu82eA2HW0EMfg59E3+1QWlm7lREgz/ieGk75PO+7Or8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769064536; c=relaxed/simple;
	bh=qwNoa7aIuLdLhgsBIJT8FObNDoDVllGzZQLQKAW+5/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rgk44DgA3sc3zgG6VlRX4ITwx1K/ayORWJmuZe6UH7eO4YUtVnwyq1y6+d/D+rlUtepie5BsfjuX2vdEHNhKWfycV0PMcYUhlNcKp8W8Vq/fgAtr9xekpQwa3/AWwRz+ilYFSIA2gAfKvKyoPmtW2SSQ+AjOqGLscptYhQS/Mds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WetCRo7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72518C116C6;
	Thu, 22 Jan 2026 06:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769064536;
	bh=qwNoa7aIuLdLhgsBIJT8FObNDoDVllGzZQLQKAW+5/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WetCRo7q5qMHfPTpCXrxhfsVfOLMhgZxo6PVbL16x+iVyUpopXWxHuiZjbmhAVevY
	 X6LMYkzhxzY73i0r/t3hPzIlIsxJ6N6jz6wxgtfiTsZPqbSEyG/1nHupb5ERv9ibuf
	 lpl1QKoDmZ0flSoT4282CRFAFHNIKlIJJdZ1YzGk=
Date: Thu, 22 Jan 2026 07:48:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Subject: Re: [PATCH] perf/x86/amd/uncore: Use Node ID to identify DF and UMC
 domains
Message-ID: <2026012245-endless-botanist-207d@gregkh>
References: <f337ed92d3e3d519ce4b5d4f23616053ca8a1726.1769063941.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f337ed92d3e3d519ce4b5d4f23616053ca8a1726.1769063941.git.sandipan.das@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-211202-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: 99AAC6258D
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 12:15:05PM +0530, Sandipan Das wrote:
> For DF and UMC PMUs, a single context is shared across all CPUs that are
> connected to the same Data Fabric (DF) instance. Currently, Socket ID is
> used to identify DF instances. This approach works for configurations
> having a single IO Die (IOD) but fails in the following cases.
>   * Older Zen 1 processors, where each chiplet has its own DF instance
>     instead of a single IOD.
>   * Any configurations with multiple IODs in a single socket.
> 
> Address this by using the Node ID available in ECX[7:0] of CPUID leaf
> 0x8000001e which is already provided by topology_amd_node_id(). Replace
> the use of topology_logical_package_id() with topology_amd_node_id() in
> order to correctly identify domains for context sharing.
> 
> Fixes: 07888daa056e ("perf/x86/amd/uncore: Move discovery and registration")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/events/amd/uncore.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 9293ce50574d..9a13a9f21d2f 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -700,7 +700,7 @@ void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
>  	info.split.aux_data = 0;
>  	info.split.num_pmcs = NUM_COUNTERS_NB;
>  	info.split.gid = 0;
> -	info.split.cid = topology_logical_package_id(cpu);
> +	info.split.cid = topology_amd_node_id(cpu);
>  
>  	if (pmu_version >= 2) {
>  		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
> @@ -999,8 +999,8 @@ void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
>  	cpuid(EXT_PERFMON_DEBUG_FEATURES, &eax, &ebx.full, &ecx, &edx);
>  	info.split.aux_data = ecx;	/* stash active mask */
>  	info.split.num_pmcs = ebx.split.num_umc_pmc;
> -	info.split.gid = topology_logical_package_id(cpu);
> -	info.split.cid = topology_logical_package_id(cpu);
> +	info.split.gid = topology_amd_node_id(cpu);
> +	info.split.cid = topology_amd_node_id(cpu);
>  	*per_cpu_ptr(uncore->info, cpu) = info;
>  }
>  
> -- 
> 2.43.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

