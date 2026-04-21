Return-Path: <stable+bounces-240222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOJVOl+752mu/wEAu9opvQ
	(envelope-from <stable+bounces-240222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:01:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C4D43E502
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05B55301BDAF
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20063A4501;
	Tue, 21 Apr 2026 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kywc/0DQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DE39DBD9
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794342; cv=none; b=Tg2LhmvorQDwzVShjgLlhxwO7pDxOaWbxosDQQiV1IxLmNMLfkRm5IZQETFyuf0DVqlFMH0hEZ71msxSgZ9NLQGc0wzSNLYKTUGPUmjKb9UWRRxcC6BSjN3M+YChNduhZZJf+zQori37dRfiLLhBvcxxTdd2DbrI7s7SZuihyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794342; c=relaxed/simple;
	bh=UNWzQoiJLHZsycgSGADwufVDpldfq3IAxUjRrKn9GJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBtCe3Vh8g752cKqz62nnCxlErvAZt6JEggPTZcxClJ+WSxeTIRgDR0+OhreOY94RYKDp900oEuBMpi0psqZLctQNcQ/IAjx5fjIi1mlEKol7PVofIWFE+whG5H0hzzeJi3pjarknPqoPlLSQcfUftfGJE6vCFeP5n6WjS9PT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kywc/0DQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso35710055e9.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776794340; x=1777399140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlQuH9I8d8JGzpXuro5Nk2tmErbsbCQw/sXQZA/3BQc=;
        b=kywc/0DQIDli2z5hBKxQMHAFgK0HdLvpD1ZsQGeOs/+ucadM4/LyOwtmKJ/ONXlJnN
         MBCrgMdA6BGV3TsXKiDra+rxOf3RfvMqTsSBfVNgmjVv0PUL/Anr3vVOFbldg5CzATdz
         1ySJfpaoJMulpYdFqkZThamEhG9tJVP2pKePdL9kKH/uFU/GMZ3SGm4jLfG4XDoIy0Fd
         KJh0D9GQkRH+LOIDj3caUrQi9rrb2+fMacqbtSS33bWI4teXuJRUB8XaOkYm8+CmVp9j
         hjH94X0jEjqCV5Z4yF6nsAAa2OMkKGN2/5Rmp+n9I6qmey0ZU7H2K/Sh+pSPTXCxJM3U
         xV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776794340; x=1777399140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlQuH9I8d8JGzpXuro5Nk2tmErbsbCQw/sXQZA/3BQc=;
        b=OaA4xKj2Rj9eDHhN+oveHXmssooEpaKc4aGIVYxMwqK8/yCYCbFP1WoPPy44J5Xx9y
         er1h/r/GOcgyX2DxKSRhwneCigF/fjD0ifbvXeN5gXzAisXp7swQwPtYNHbHKNx805rw
         ycm0+6whNhqZOvorIsp1NEylHQw0nbdZAN6SxaWQxnGZBxCiJ2wWY+nzDN67teB6gvqe
         zK7kgInsF6ULMIuA6/cYZFsjpIE5sMn/g7UGu7zwV6mIzXuOfidMamSzowTig2xecFY3
         Vqwv6BJUSOsg3AbzGrRvv1tPoUzP7cjqdp3S3fKcUMrmFEDsl2qa0X/BGkuIqWXTWZz+
         YMDw==
X-Forwarded-Encrypted: i=1; AFNElJ8dJaOgYfSSMeJ7/n1e2OJcXyQ8xMZebzZKDL1DuuhxsMcU4aAFQl/ZaYX2hhaZQ1xADyd76hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1saDweIziAp3rw1UPcPv3+aaBDHkbjS8QwiYLPuIH9DIE/Kq
	oMVWAda/R4CVJiQp2vpVOmm90wZZss5AfG/m7ZFQRxenUxtKgJeifuLW
X-Gm-Gg: AeBDietPx4NenHtli762crxaytnQ//YwfW0U2I2qPoZOGPw3Kgkjiqf6dgYpBZ6bBd3
	u+aiAehaE8eylq4/cOrYUjb/5trAhHB3ABXRxJf2ZWpcHgjnw2subfebJyvrD4DF369febhjctD
	Ysreu0UnP2v+8hZ6KMMyStN7PhZsboO+7TGqTLlQyMFTQHoLvzd07aB1TPffOBS8WD/rw3uPpzt
	wGrl/33wDx2gVx+EqO/cNfUOM8tUtEbyUJGzau8WDdtbZpm426KH2Uv7O9MuhYoOaD9D8FS2TR+
	A3LKmnIv0ehCFzD+4++HxLgSxyDu3Xxit9ATdfjgkfs9AQptB3tJ+RYMuwMYMmpTZaF6njvP0A0
	ZSbieruh2e8ho5zAIc6D6gaBXqfP+Asg2b5cJ5Z1u8nLgNE0lIVjZ6tlFkUfR0k4F7Ty26sWJcX
	9dgjduuUUHlW4q5+owjJ0f6Z3xsFY138dbsLlbhON43SdRIH+f6c7M/r179UPCquUdkKKBGvaTO
	d5Z3RNsePEuIECfEsyMUCZADgU=
X-Received: by 2002:a05:600d:b:b0:48a:56de:d63c with SMTP id 5b1f17b1804b1-48a56dedadfmr32847085e9.27.1776794339439;
        Tue, 21 Apr 2026 10:58:59 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879? ([2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm121049875e9.11.2026.04.21.10.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:58:58 -0700 (PDT)
Message-ID: <db82f89f-0811-46e8-bf81-f3ef1db646cb@gmail.com>
Date: Tue, 21 Apr 2026 19:58:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Carlier <devnexen@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte
 <laforge@gnumonks.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Weiming Shi <bestswngs@gmail.com>, osmocom-net-gprs@lists.osmocom.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260417055408.4667-1-devnexen@gmail.com>
 <b44de581-9f41-4804-afb1-72c491d9443a@gmail.com>
 <20260420125815.3a920d9a@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260420125815.3a920d9a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240222-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,netfilter.org,gnumonks.org,lunn.ch,google.com,redhat.com,lists.osmocom.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1C4D43E502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 21:58, Jakub Kicinski wrote:
> On Mon, 20 Apr 2026 21:02:55 +0200 Justin Iurman wrote:
>> On 4/17/26 07:54, David Carlier wrote:
>>> gtp_genl_send_echo_req() runs as a generic netlink doit handler in
>>> process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
>>> which eventually invokes iptunnel_xmit() — that uses __this_cpu_inc/dec
>>> on softnet_data.xmit.recursion to track the tunnel xmit recursion level.
>>>
>>> Without local_bh_disable(), the task may migrate between
>>> dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
>>> per-CPU counter pairing. The result is stale or negative recursion
>>> levels that can later produce false-positive
>>> SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.
>>>
>>> The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
>>> the data path runs under ndo_start_xmit and the echo response handlers
>>> run from the UDP encap rx softirq, both with BH already disabled.
>>>
>>> Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
>>> commit 2cd7e6971fc2 ("sctp: disable BH before calling
>>> udp_tunnel_xmit_skb()").
>>
>> Why not fix iptunnel_xmit() directly, rather than fixing all possible
>> callers? Basically, jut like we did for lwtunnel_{output|xmit}(). The
>> advantage would be that we no longer have to worry about BHs in the
>> callers, and BHs would only be disabled when necessary.
> 
> Oops, I pushed this already. The bot hasn't caught up yet.
> Let's revisit this if we find another caller in process context?

No worries, works for me!

