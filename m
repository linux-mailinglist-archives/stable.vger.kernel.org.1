Return-Path: <stable+bounces-262498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A7LoOaVsKWqTWgMAu9opvQ
	(envelope-from <stable+bounces-262498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 15:54:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3E7669FC6
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 15:54:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=lCWmSlmu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262498-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262498-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84297306B079
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF1940DFDE;
	Wed, 10 Jun 2026 13:47:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5C408611;
	Wed, 10 Jun 2026 13:47:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099248; cv=none; b=AbeMfO9lJJxmcKogpsDTXT74iXKaQ4414r3/jjfAZ1XslEvK6C5yRAqacIwrhOyPch8dfAke9x78Y1cS36UP6i0G0+Bipv52rK5gbUDgD4U+K/P6Qez7wGG8uGEdcrR38sYDQDrVMTDiGxocTU/SIMRVgcUbDUnokA4AZJynRkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099248; c=relaxed/simple;
	bh=Ea83KZ783lvBj/Ret7iiyafUKqum0dPU67dCk61mhjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yu0dj5TJ54SJZN16NAvA8ZgwNbqhaoeHStp63wbZzWF+DJUiBFEpBtdtgLY1eFW3cBR037L/e5JfGKY+S4FZ7QtzBcwfh0ImmQlv3nLHnmZ8kvCjRkieVX7E6QSqcHENbdVU/gL2mdXSytrrUWj/dfr4tsichfR/YnIbkVIY26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCWmSlmu; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781099245; x=1812635245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ea83KZ783lvBj/Ret7iiyafUKqum0dPU67dCk61mhjY=;
  b=lCWmSlmuK4N2/m++frQHPobyq1gNIRP4zqK2iKrJ0Ujw2P9w40kKev1j
   VSvsXNvlhMOqMi5Nofbag2jqlY02Qt56+d4Qh0gY7VTVpEn8mIs/QK7vZ
   siPY6q0GSBm5sKpEU+qx6i5PsIAzIJ4tzGBHe1hogmIdb/KK1iqzmy6C8
   g989+BC7XMYLOQX0ut/RG8s6dLQY6kPv3CO+pX4Mfe62qMZQsI4/sGJ7X
   od2CflHcapCYcrCn1jRFDyP0747URTTYKCXVj9xR3vP5C0ruiYNjlrzbj
   qYrVtG8IuEUGISId7bvpIVt9N2JSjAaDuiY9DnYpRqTjFF6IyOQu4BGG5
   g==;
X-CSE-ConnectionGUID: JZikKhAqS4+l7zjr5qB7tA==
X-CSE-MsgGUID: MdpBU5nCRfiNTvvSS4Pg6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99310875"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="99310875"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:47:11 -0700
X-CSE-ConnectionGUID: Zb7UsNwFTTWnTi4lQ2t5Vw==
X-CSE-MsgGUID: Gq7jy467Qe6bSp5splVdOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="245043000"
Received: from krybak-mobl1.ger.corp.intel.com (HELO [10.245.246.32]) ([10.245.246.32])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:47:02 -0700
Message-ID: <ce9b7fa1-1c39-47a3-bad0-a4ab18e415e6@linux.intel.com>
Date: Wed, 10 Jun 2026 16:47:06 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: SOF: topology: fix memory leak in
 snd_sof_load_topology
To: Zhao Dongdong <winter91@foxmail.com>, lgirdwood@gmail.com,
 daniel.baluta@nxp.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhao Dongdong <zhaodongdong@kylinos.cn>, stable@vger.kernel.org
References: <tencent_3EED6D778DC52C3703A2D1EE8119372E8E08@qq.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <tencent_3EED6D778DC52C3703A2D1EE8119372E8E08@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262498-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:winter91@foxmail.com,m:lgirdwood@gmail.com,m:daniel.baluta@nxp.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhaodongdong@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[foxmail.com,gmail.com,nxp.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.intel.com:mid,linux.intel.com:from_mime,intel.com:dkim,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C3E7669FC6



On 10/06/2026 10:20, Zhao Dongdong wrote:
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> 
> When the topology filename contains "dummy" and tplg_cnt is 0, the
> function returns -EINVAL directly without freeing the tplg_files
> allocated by kcalloc() at line 2497. This leaks memory on every
> such topology load attempt.
> 
> Fix this by setting ret = -EINVAL and jumping to the out: label,
> which already handles the kfree(tplg_files) cleanup.
> 
> Fixes: 99c159279c6d ("ASoC: SOF: don't check the existence of dummy topology")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> ---
> v2: add kfree(tplg_files) before the return
> v1: https://lore.kernel.org/all/tencent_D87B6446BC0B517BEF9D4731C6CD8B288206@qq.com/
> ---
>  sound/soc/sof/topology.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
> index 63d582c65891..a368e257c459 100644
> --- a/sound/soc/sof/topology.c
> +++ b/sound/soc/sof/topology.c
> @@ -2534,6 +2534,8 @@ int snd_sof_load_topology(struct snd_soc_component *scomp, const char *file)
>  		if (strstr(file, "dummy")) {
>  			dev_err(scomp->dev,
>  				"Function topology is required, please upgrade sof-firmware\n");
> +
> +			kfree(tplg_files);
>  			return -EINVAL;
>  		}
>  		tplg_files[0] = file;

-- 
Péter


