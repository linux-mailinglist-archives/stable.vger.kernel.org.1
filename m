Return-Path: <stable+bounces-227529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GiWFp4yvWmI7QIAu9opvQ
	(envelope-from <stable+bounces-227529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:42:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E82D9BD5
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 414883012518
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECAC38A72C;
	Fri, 20 Mar 2026 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="H2++eJnU"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1C35DA6B
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006937; cv=none; b=N7dn8q5aq5/6ZF2S3Kb6vYowbuABvA2lK5k1yIsXxjK/eD47ZbFHdjR4TZkwgTyVQAG0qu6ssUDuDdHIgVayT9QREZOzICNmIdE01HfJyZclHltr0VtXSpvQuZ7kPFVN0Z8e8PZKEZ5u10hEVpIw4o8QPNtP94ldqDGGjMI9ipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006937; c=relaxed/simple;
	bh=0+ca3cHQLpjmlfk6qleoSFEopC8w9Hm7lXPlS8rBW1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPe+YzTo+X+XRE4y3sl/rvWANJ//AZPqwDOcMEGK6rzgeYamIGO3++xqhXiTwOgeca9xzKPIzgTFQZ1zK8zwCBrmlDOzAb7oDBD4tJrfm9oZnGu7cM2wrFxiuCkdZhswn0S0HZz3xbqq1WvrQX2wi62C5EDQvD18j0vJIBxb9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=H2++eJnU; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4fcgdq2YV9z6G9j;
	Fri, 20 Mar 2026 12:42:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1774006927;
	bh=0+ca3cHQLpjmlfk6qleoSFEopC8w9Hm7lXPlS8rBW1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H2++eJnUL/M9VDOwd04CaRNF11z5BErLlH+P35MckvOUK/QMZC4gO4b5oDEzv0VUS
	 vir4QRrPbnWrqt3xbs1k15yM7zDMVeJ4yYzWC/zMXTdLR+nofap3EZfGNs9bUq0xOi
	 m+qdH1VaYHI790iEfKeLE37Emf+gFY7nC4GOe355yISeK579A2yN7dm5MiE+8TC9P+
	 OV3y+62nMxh3ULYGR0bJJ/4eU7y0VPs8rLs9IUV5Ab75Q0tKaNZSv5Df1v26sl4UKk
	 dLJoSWSfQXMfinlpccywCDtVtH9+t83v2E0oyFE6UYD/PkpgZmMkUwf+hMgIGL5hSF
	 WVb7ERfYleP5Q==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4fcgdq1pCkz4xQm;
	Fri, 20 Mar 2026 12:42:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fcgdp1wmgz8tY1;
	Fri, 20 Mar 2026 12:42:06 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 7E963632CD;
	Fri, 20 Mar 2026 12:42:05 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <2fd785ce-bf37-4875-a9a4-92422870f5b5@leemhuis.info>
Date: Fri, 20 Mar 2026 12:42:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Unable to pass AMD RX 6400 GPU via VFIO
To: Mark Somerville <mark@qpok.net>, stable@vger.kernel.org
Cc: Mario Limonciello <superm1@kernel.org>, regressions@lists.linux.dev,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>
References: <1be114e1130ca59ee91fc5a73aaf43a912d408ea@qpok.net>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <1be114e1130ca59ee91fc5a73aaf43a912d408ea@qpok.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177400692587.1150909.1885195840544796591@mxe9fb.netcup.net>
X-NC-CID: xAorTU7poSEZ+2vuEciKHQdfbuR1iaQUcOCM5ArjW1sVlALa74c=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227529-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	DMARC_NA(0.00)[leemhuis.info];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EE9E82D9BD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

@greg/@sasha: I might be missing something, but looks like one patch
that was backported missed two series where it's needed (see below for
details):

On 3/20/26 10:28, Mark Somerville wrote:
> 
> I run Debian 13 stable (6.12 kernel) and have encountered a regression.
> 
> My machine has three GPUs, the iGPU that is part of my 7950X and two dGPUs - one NVIDIA 3090 and one AMD RX 6400. I use the iGPU for the host and only use the two dGPUs with virtual machines via VFIO with libvirt.
> 
> Although I have specified kernel parameters vfio_pci.ids for the GPUs, I have not blacklisted the amdgpu driver so that the host iGPU can operate.  Previously, starting a VM with the RX 6400 dGPU assigned to it (via VFIO) would work fine. However, doing this with more recent stable kernels causes the machine to hang immediately (and then, ultimately, reset after a while - ~30s). No errors are logged, at least as things are configured just now.
> 
> I can reliably reproduce this crash and a bisection revealed the commit that introducted the problem: 8140ac7c55e75093a01c6110a2c4025fe7177c57.

That is 28695ca09d3264 ("drm/amd: Clean up kfd node on surprise
disconnect") [v6.19-rc6, v6.18.7, v6.12.67 (as 8140ac7c55e750), v6.6.122].

A fix for that f7afda7fcd169a ("drm/amd: Fix hang on amdgpu unload by
using pci_dev_is_disconnected()") [v7.0-rc1, v6.18.17, v6.12.77].

@greg/@sasha: Wondering why it's not in 6.19.y and 6.6.y. It failed
there first, but later was applied to 6.18.y and 6.12.y:

https://lore.kernel.org/all/?q=%22Fix+hang+on+amdgpu+unload+by+using+pci_dev_is_disconnected%22+%28f%3Agreg+OR+f%3Asasha%29

> This is fixed in the mainline kernel, I have tested and verified my RX 6400 is working with VFIO under 7.0-rc4.
>
> I *think* this is still present in the 6.12.y branch but a second (currently ongoing) regression is preventing me checking this on the latest and greatest 6.12 release right now.

v6.12.77 contains a fix for that commit, so there is a decent chance
that it will fix your problem, unless it's a different kind of problem.

Ciao, Thorsten

