Return-Path: <stable+bounces-223246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICbQFvCmqWnwBgEAu9opvQ
	(envelope-from <stable+bounces-223246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:53:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0551214E41
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B533254119
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ED539D6F6;
	Thu,  5 Mar 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="lmoK3DN9"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58DA3CA480
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725408; cv=none; b=srLxm91p17qMx1HSaoiZ30oYbdodlI+CkwbJAN76sQyMqsvEbwdw1gwPxy4p/K3mDYmJEIIH8+nzFB+10FheF7VhYS+vNM0Js4ptxSfN2LD7u+O2UNSzLqhQoe2p6UPHalFBw1kWFwRHxL+6UROX/IqbtNuYRzExsFIe67yqU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725408; c=relaxed/simple;
	bh=v/P8Aoqnfv3/q/kRRumuH1ysaR16WNF9rRYlnfNN0dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXYz4Zevl1yEbyIKLM2csLmvuORrXfOplGv1Nf2HQNPaxpv+8s6YKsUzKrHxvKAG8pguTZ6poQUJpNvoJ/I0VaimFcPkbiU8slEhUyqRA+F7WdKFQ+BYikwdAKGTWpwA1Ixa8IbtfMfce1kDxaW9UBgtccwJud5PQ/R8xeT9bHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=lmoK3DN9; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fRYj76rPhz45fG;
	Thu,  5 Mar 2026 16:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1772725404;
	bh=v/P8Aoqnfv3/q/kRRumuH1ysaR16WNF9rRYlnfNN0dg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lmoK3DN9EHxkZaEOTJ+jZB5yilQ2KaX57GC58U63vew/96rncbSodTW9PazESnOCX
	 JPw30/08CbrdSTqxwBmckGxclAcNfasmC++ZFiLMXub2kRJkS6rCwLH8nYQR+5ArbB
	 DYuE2LNxVptrpFBhIRJjTR9dxDHQ2JE25YxqZXmfatbZOvsB54mJIIAeMwPqzF3I8+
	 iN4jZMw/YdEjLI7N5Ux8iFT7OqkwOY9hDFbaf9jyNCh6e70zB4BvIaeVlWP4b/EdU7
	 8xDaYs9zqg+Ar+8+7NFoDgFtbVdkDyj5Rr+QlBzrqdl9TlnnpaI+D/WlQ50m2Osmz6
	 SpQyz6Nkn2SPg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fRYj766Q7z7wrb;
	Thu,  5 Mar 2026 16:43:23 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fRYj61hRCz8sWT;
	Thu,  5 Mar 2026 16:43:22 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 768AE617A5;
	Thu,  5 Mar 2026 16:43:21 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <2d32f010-787c-4541-9217-9b08df32b1b9@leemhuis.info>
Date: Thu, 5 Mar 2026 16:43:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ REGRESSION v6.6.128 ] build failure on x86 because commit
 22e460b6333a
To: Wentao Guan <guanwentao@uniontech.com>,
 regressions <regressions@lists.linux.dev>
Cc: stable <stable@vger.kernel.org>, sashal <sashal@kernel.org>,
 gregkh <gregkh@linuxfoundation.org>
References: <tencent_1EDDBDC63EFAE9C27849E987@qq.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <tencent_1EDDBDC63EFAE9C27849E987@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177272540176.2496144.1261723391264038826@mxe9fb.netcup.net>
X-NC-CID: GoeqlWXdsziScIPSt/AAXKsXzgnkrUp2OLk2BzpNmU25McDjoJI=
X-Rspamd-Queue-Id: B0551214E41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223246-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,leemhuis.info:dkim,leemhuis.info:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/5/26 14:53, Wentao Guan wrote:
> Dear All,
> 
> upgrade to v6.6.128, build fail in x86 with our config with the commit:

kernel.org already offers 6.12.76 and 6.6.129, which from a quick look
should fix this error (and the other one you reported which is basically
the same problem afaics)

> git show 22e460b6333a5f818b042ac89201f8e735556f4a
> commit 22e460b6333a5f818b042ac89201f8e735556f4a
> Author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Date:   Tue Dec 30 22:16:09 2025 -0800
> 
>     x86/kexec: add a sanity check on previous kernel's ima kexec buffer
>     
>     [ Upstream commit c5489d04337b47e93c0623e8145fcba3f5739efd ]
> 
> BRs
> Wentao Guan
> 
> config:
> https://gist.github.com/opsiff/4343c07b55697837f816c706309510c1
> 
> Log:
> arch/x86/kernel/setup.c: In function ‘ima_get_kexec_buffer’:
> arch/x86/kernel/setup.c:380:15: error: implicit declaration of function ‘ima_validate_range’ [-Werror=implicit-function-declaration]
>   380 |         ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
>       |               ^~~~~~~~~~~~~~~~~~
>   CC [M]  fs/zonefs/file.o


