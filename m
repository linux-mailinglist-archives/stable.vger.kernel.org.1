Return-Path: <stable+bounces-235996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PfTEIfU3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:33:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFAC3EB57D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 546E2300DD49
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA5A3B4E9C;
	Mon, 13 Apr 2026 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="FNY5k7Dq"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6321CC51;
	Mon, 13 Apr 2026 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080004; cv=none; b=hVxMy9e8StHG+bA5CEc7L5Citf5Hk79Lfw0vQrvaecVJUqdkmwiPBXsewG+uvLIH6i3V7GIQk3BhIOBV70NZiQaHMu3jP/HCxRq4RpAoBBjhRo0jPzbC5WJdNdxEAY3xXsMKPKU1I0cEo1tAiJnwHGK16NIv4L/nbRUTjo5/NUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080004; c=relaxed/simple;
	bh=Hpyo/u8D/E8xEQLKMVTPnszwn5KDxIuSuQ2HYQiS9KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHJLpH0RUWajHBJSaZbZJapdQAirU+ji4zpz9UVbOcPw6aVkgymYPKxnxnpfYbHf2pjsA5uH/xyFq+W4ZAKmReJgAPl1PPp1hhDlGJU/aZP7WUEGrX3wG1xobZagO3hglTu0kGJUtqE4YVfvbQUpVYXE9LSehM350S4GTFrmwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=FNY5k7Dq; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fvQJc69pKz82FM;
	Mon, 13 Apr 2026 13:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776080000;
	bh=Hpyo/u8D/E8xEQLKMVTPnszwn5KDxIuSuQ2HYQiS9KI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FNY5k7Dq0byHKNPoCkXVoqmJWsWaNE+mZ02y5cFjQSK/nr4+VqdmL2M2T+4GV+tey
	 FwByfPC/9VNzFT7OGM5lN33bbdaB0yT0/6v0nFKu/hZw7xEYmZmwueSaeuOsTCeXWf
	 jTrIl0epv3W2xVWAhepQDN+GS0RVsBUS6/u8h0CjB3u9Zg5klFqRKzKBlfx7Afe3GI
	 MlnuNWFMGDjLLYVianFXzWkx3vKOL30cxykahQfhsj2K6pKFqpwf/lHhD50ZS58avS
	 pmRmiAPO6nY8bHSL7ixwtjj+i+QMnm+bVCZWMvfSTQ7eDn/dqI7q22VrohzRBYCNv0
	 6ARYWD7CtbDJg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fvQJc5TTzz82D4;
	Mon, 13 Apr 2026 13:33:20 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fvQJc0J4jz8sbB;
	Mon, 13 Apr 2026 13:33:19 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D5379635CE;
	Mon, 13 Apr 2026 13:33:18 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <c54a0b91-cfbf-463e-964d-bf9a2e524189@leemhuis.info>
Date: Mon, 13 Apr 2026 13:33:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] Re: Linux 6.12.75
To: Vitaly Chikunov <vt@altlinux.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 gregkh@linuxfoundation.org, regressions@lists.linux.dev,
 Matt Roper <matthew.d.roper@intel.com>, Sasha Levin <sashal@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20260304131402.83200-1-sashal@kernel.org>
 <20260304131402.83200-2-sashal@kernel.org> <ac4lw9tTNn4baO_h@altlinux.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <ac4lw9tTNn4baO_h@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177607999922.154774.8464502658480076344@mxe9fb.netcup.net>
X-NC-CID: x4vhjoCTUZtOF+sQi+5GpqwaXjuylIYfgpqhd5VyuMgYR06pl+8=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	TAGGED_FROM(0.00)[bounces-235996-lists,stable=lfdr.de];
	DMARC_NA(0.00)[leemhuis.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9DFAC3EB57D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 10:44, Vitaly Chikunov wrote:
> Sasha,
> 
> 1. I cannot find this commit posted on lore.kernel.org to report to
> exact patch.
> 
> | From: Matt Roper <matthew.d.roper@intel.com>
> | Date: Tue, 10 Sep 2024 16:47:29 -0700
> | Subject: [PATCH 6.12/sisyphus] drm/xe: Switch MMIO interface to take xe_mmio
> |  instead of xe_gt
> | 
> | [ Upstream commit a84590c5ceb354d2e9f7f6812cfb3a9709e14afa ]
> | 
> | Since much of the MMIO register access done by the driver is to non-GT
> | registers, use of 'xe_gt' in these interfaces has been a long-standing
> | design flaw that's been hard to disentangle.
> [...]
> 
> 2. After this patch applied to 6.12.75 there is kernel NULL pointer
> dereference BUG on MSI MAG H670 12th Gen Intel(R) Core(TM) i5-12600K
> with ASRock Intel Arc B580 Challenger [Alchemist], 12GB:
> [...]
> The commit is found not by a git bisect (since it's reported by end
> user and I cannot reproduce it on my hardware) but (by analyzing dmesg)
> with:
> [...]
> Then finding the suspecting commit:
> 
>   $ git log --oneline -G'XE_LUNARLAKE' v6.12.74..v6.12.75
>   26a40327c25c drm/xe: Switch MMIO interface to take xe_mmio instead of xe_gt
> 
> 6.18 and above are not affected by the bug. Also, they have another commit
> modifying the line which is not present in 6.12 branch:
> [...]
> Related drm/xe bug report https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7661
Nobody reacted to this and it seems the gitlab ticket is stalled, too.
So let me ask: can this be resolved by reverting 26a40327c25c in 6.12.y?

Ciao, Thorsten

