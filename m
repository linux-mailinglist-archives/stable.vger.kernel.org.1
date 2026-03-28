Return-Path: <stable+bounces-230770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMUzJvGXx2mFZgUAu9opvQ
	(envelope-from <stable+bounces-230770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 09:57:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5926F34DE0A
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 09:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76E6B303B5EC
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0763F361DC8;
	Sat, 28 Mar 2026 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XtmmmnhZ"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4342036E9;
	Sat, 28 Mar 2026 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774688235; cv=none; b=cOjVJxGuD6b6KZWgLB7YvxEd+mqRjiahszw54IekI2UwowrnX693p8BQT9C6niBxCWjFywkzwVn+pTJtaywX6++Hzaiq0SshMMrxVc10YSPEagsTmqlXk7+ega9IEsT2EqgLNvaknapPXPBGuEW6PupP8eApWCwBI0DLRNOo5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774688235; c=relaxed/simple;
	bh=ds8PC2h0Rg1zfoGUZk8kOBd5/jJuEBt+G3kqJ0lwdcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqI1Ohn8wrIPHaeDUQqFa+e7qRmPCcfk9LHr263OnnI86/L4MLqjJar8Pq1Wivl4us+khgp/4g7IsakQrEVjZ8gfaa1yNLgi2pH/+3ZIbgU7mFxjrt2xfNPXM4MJUyxPdUooI2v9nvuOmQmL1Rq3nAOFmuxculM4waDHX1DFjm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XtmmmnhZ; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fjWNp42rCz8B5H;
	Sat, 28 Mar 2026 09:47:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1774687658;
	bh=ds8PC2h0Rg1zfoGUZk8kOBd5/jJuEBt+G3kqJ0lwdcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XtmmmnhZRqzEcCW8rjoDVtAHUX/6fu8P+/B8kIVC8Y8T3/2wScN3GOxQJaVb0XWAD
	 ADgOoXhyLBPiqnTx2RLkFddwaDRNBqGCOrliz1eci4Vk+ap4Y6PzaKWP1c9MbllWAK
	 Jr3jMm4ZRcNpsoVE8/VrlUNViVicj1qvCMJr+KU/2bWF4ewKjlJN5RqCyTbuBS+4K6
	 8ThG2QWDaXXcz9SbwqK2CLiZcl63AaeBjY5YO52mccFIAyu7kmufHVWz6pvOs/i6MQ
	 6KMokaXWIwB2RPOpYaRhYfK1irQoEAe7K76XQcEnRSAVZ65Vs7rSq7eH8MkN+HCfWi
	 2VjTamx9/4kyA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fjWN403QRz84qk;
	Sat, 28 Mar 2026 09:47:00 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fjWN331L1z8sbs;
	Sat, 28 Mar 2026 09:46:59 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id C9DFA61741;
	Sat, 28 Mar 2026 09:46:58 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <5fb8c589-60cd-4ab6-a305-abefc6e5c043@leemhuis.info>
Date: Sat, 28 Mar 2026 09:46:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since new
 bridge window alignment calculation code
To: =?UTF-8?Q?Jonas_H=C3=B6glund?= <firefly@firefly.nu>
Cc: linux-pci@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177468761908.2518298.1045275361796132583@mxe9fb.netcup.net>
X-NC-CID: b6swR56vKjt4tnHxZTapnlFYUapxOva9kjO74UmGY08QWqrrs/E=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	TAGGED_FROM(0.00)[bounces-230770-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lkml.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5926F34DE0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/28/26 00:02, Jonas Höglund wrote:
> 
> I have an AMD GPU in an external Thunderbolt enclosure that recently
> stopped working with the latest longterm kernel release.  The GPU in
> question is an AMD RX 6750 XT.

Thx for the report. One important information is missing afaics: Does
the problem happen with latest mainline (say 7.0-rc5) as well? The
answer determines how this will be dealt with.

Ciao, Thorsten

>     [...]
>     amdgpu 0000:3e:00.0: amdgpu: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
>     amdgpu 0000:3e:00.0: BAR 2 [mem 0x74200000-0x743fffff 64bit pref]: releasing
>     amdgpu 0000:3e:00.0: amdgpu: Problem resizing BAR0 (-16).
>     amdgpu 0000:3e:00.0: BAR 2 [mem 0x74200000-0x743fffff 64bit pref]: assigned
>     amdgpu 0000:3e:00.0: amdgpu: VRAM: 12272M 0x0000008000000000 - 0x00000082FEFFFFFF (12272M used)
>     amdgpu 0000:3e:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
>     resource: resource sanity check: requesting [mem 0x0000000000000000-0xffffffffffffffff], which spans more than PCI Bus 0000:00 [mem 0x000a0000-0x000bffff window]
>     ------------[ cut here ]------------
>     WARNING: CPU: 7 PID: 2260 at arch/x86/mm/pat/memtype.c:720 memtype_reserve_io+0xfd/0x110
>     [...]
> 
> Searching for the issue I found this very similar report from last year:
> https://lkml.org/lkml/2025/6/9/88
> 
> so I suppose this might be a re-regression of the same issue(?).
> 
> 
> I checked out latest longterm (v6.18.20) and bisected, which took me to
> commit b855d99 (upstream commit 3958bf16), which is
> "PCI: Stop over-estimating bridge window size".
> 
> 
> After the bisect I tried reverting the commit on top of v6.18.20 (going
> back to the old way of calculating alignment), and this is sufficient
> for the eGPU to dock properly again.
> 
> I've attached a longer excerpt of the kernel logs from a failing boot
> (let me know if a full dmesg would be helpful and I can find somewhere
> to upload it).  I've also attached an excerpt when connecting the eGPU
> in a "good" case, since I figured the memory adress ranges could be
> useful.
> 
> 
> Hardware:
>   Machine: Dell XPS 13 9310 (0991)
>   GPU: AMD RX 6750 XT
>   Dock: EXP GDC TH3P4G3
> 
> Distribution: NixOS
> Architecture: x86-64
> 
> #regzbot introduced: b855d99
> 
> Let me know if any additional information would be helpful.
> 
> Thanks,
> Jonas


