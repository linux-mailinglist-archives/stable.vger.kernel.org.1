Return-Path: <stable+bounces-217639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKmmMajgmWnMXAMAu9opvQ
	(envelope-from <stable+bounces-217639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 17:43:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1955116D4B4
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 17:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78653303FABA
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A92532D0DA;
	Sat, 21 Feb 2026 16:43:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51A32C929;
	Sat, 21 Feb 2026 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771692196; cv=none; b=L5XBrcIWSiiTAqsy2FKBwshU1kP+mpQHVMcxSiNDCR/38Kx+YnItI7rNcmBU/uOA8p2SdJhnko99D4kjzzesovYMsZBRszk7RDik699khb5yeqDmv5GMqKs7SigiB0HAPeLsh89FwFV7Mc6tR/NfikG+wIOEpiClhZwkMVup0zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771692196; c=relaxed/simple;
	bh=2RwwSpYJzY9wDIGz47H4HF/tmvM88PyXJxJxw1W2mUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mfdxZVhORGkEBcbtoCLxn/vCEGXEDqofLdw9TTjxI8Clvgcx1bItlAoAd4k3dKvjd+EfZMX8UnkaAIla+qmQKtXba789dco/uvLmhiYRqoUgKUQTYCXq4HllgE5500zK55lKLFZAMM8MRKnLvs81QQ+x3z+DVJZWzZNOcdha7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (213.87.162.13) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sat, 21 Feb
 2026 19:28:01 +0300
Message-ID: <8ea38fe5-12e4-4d24-8b2e-782cd9824e22@auroraos.dev>
Date: Sat, 21 Feb 2026 19:28:01 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "cpufreq: scmi: correct SCMI explanation" has been added to
 the 6.19-stable tree
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
CC: Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi
	<cristian.marussi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>
References: <20260221154210.4000258-1-sashal@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20260221154210.4000258-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[auroraos.dev : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,auroraos.dev:mid,auroraos.dev:email,linaro.org:email];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.shtylyov@auroraos.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217639-lists,stable=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 1955116D4B4
X-Rspamd-Action: no action

On 2/21/26 6:42 PM, Sasha Levin wrote:

> This is a note to let you know that I've just added the patch titled
> 
>     cpufreq: scmi: correct SCMI explanation
> 
> to the 6.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      cpufreq-scmi-correct-scmi-explanation.patch
> and it can be found in the queue-6.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit a7baeb022942223236bd64365d5045e9c5608f2f
> Author: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> Date:   Tue Jan 13 22:33:30 2026 +0300
> 
>     cpufreq: scmi: correct SCMI explanation
> 
>     [ Upstream commit 8c376f337a7e31c42949247e24eaad9a30d6c62c ]
> 
>     SCMI stands for System Control and Management Interface, not System Control
>     and Power Interface -- apparently, Sudeep Holla copied this line from his
>     SCPI driver and then just forgot to update the acronym explanation... :-)
> 
>     Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
>     Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
>     Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index d2a110079f5fd..e0e1756180b0c 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * System Control and Power Interface (SCMI) based CPUFreq Interface driver
> + * System Control and Management Interface (SCMI) based CPUFreq Interface driver

   Is the comment fix really worth pushing to stable? (I thought they were going
to remove the Fixes tag before applying...)

>   *
>   * Copyright (C) 2018-2021 ARM Ltd.
>   * Sudeep Holla <sudeep.holla@arm.com>

MBR, Sergey


