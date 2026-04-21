Return-Path: <stable+bounces-240224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH4SM1C+52kWAQIAu9opvQ
	(envelope-from <stable+bounces-240224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:13:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E42843E73D
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCE8A3046EA4
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE733A7598;
	Tue, 21 Apr 2026 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioGgAyj/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C9274B2B
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794937; cv=none; b=sPNIvM2SclNDm+RbeaqMs9aVIppZsX4t4jTZ2UCtrEzHyy4FJybyvDmv2YGepKScfd+nhrBBHm2UlOJB0vGBGzUXDdoBVcq81gm4/izagSP1R+73QSrR9CROU4fvBZkHU6mbaCSFtefWDYoRz0OrsinVjrzGPbpQnS3hYTVw/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794937; c=relaxed/simple;
	bh=sVSzqgFwl95RN9XCjXnl03ZFc6PsYjNOg2WCM71+tWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGCM10UcSA8x82uZFchjfLVa0r3FlnVTxhZYC3JqITlE+lNQXyK7AmwByl0n8jjWWy+6gp/CqzXdn4mt73F0ZYnagVL2CnbTwhsJHQFVBzYwAqPITQn4ibAP4YOFr+pKwiUO3NwcwpS6Q176FY+JHwes7ju6IvZVqTDcNxuCHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioGgAyj/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0046078so41925425e9.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776794934; x=1777399734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBaT1moCfqSmvJGAedFsvUx6VKJMRgXjG1EGszYK8JM=;
        b=ioGgAyj/GJRNfgNeEuMWo2uZ+1iX/+UhzUN/sNtdWNzGtXIAYUYuNeA1jQvxG7nvkl
         io2ERp8zsTdrv5oBkTBN5lYFKEcH2stHiRErDwWfXhKIq2bUbAppC1EqBYu6IPIALi9H
         qDMAVwDvGLkg7PbC1uKfWOGjAt3wuZhnnFgkYRZKXVW5MXR7ItnT31mUDj5PG0ec1jLI
         KK7xydIn2QrKr43kfhi29y6KdzqYd84FqTvsKfg3aa0rOzNooW1uUVAla7u/Wn1c4fxI
         NYOn4PluhgYyT4OWkjIFg5O2y4gULc7Fv0MDR7mq4Arj4IVfDWh4stab80+3yeQLlOLG
         UHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776794934; x=1777399734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBaT1moCfqSmvJGAedFsvUx6VKJMRgXjG1EGszYK8JM=;
        b=IihDC1gCvPSp4Xwu/CeiFruK2l5lXAkieY9gWhlbA/JSKT7IZEUwOaSqSjgOLU4V4+
         T6jGlChVGwmIli8+fAKclANiNxexW/SyUCrDUuNSky7fb2PLNABlq90j9sXeh1JyHY6j
         DMxATKNbbttDdbpQACmOIEmk+ds+REAM4WjIvsbLcOx/rgINy6Ki1BJk9NCd8Wx+CdJi
         aoah1Ndq57TGZO6IvHMB+IGdg5MaD2R1LgMOXVtS09tJO5ALcViCuZltF6PmmLX5nF4u
         f57i/ZwPlN9Mn2l+yITyBqrUPI5GbVgqXYUlMBgsGJvlBjU/7s8Lq4N+BbbLOirMQ8i4
         PMUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/a4kPZvextlKcX7LdcfEmmqIbaePrQH8uHq715GCLZWoQAE29p7ZFg5RumuMC+k5+m/EYLIBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzETQGiOgIZHhg4sF+jRzrntn+EzWp5qhSdckxi1TWlOVUm/+M7
	f6c3WPGQzR8T+eNXTw6LoMgWEZydw2MvMjMEgsTXE3drq2T/veedxgEa
X-Gm-Gg: AeBDieuwvsbVAh4PrV5gZ6w4SdENQsdBHIXVrC66nRIO4dUcy+GK9VYJIdEqoW/c7np
	08gZvbm0v53VyG6OUOxQaeV/lqnLDzdIOvPfw7u48brw7geYCw4Hy7dBCr5h7uQzoJW+OJ7LJ2R
	VcLebJ+FBR5yOrrqcrPVFmflORnSy1xn+Qim73ut7SLt8z61BFoxtYI7YnxBb9QPvdO2vUNlhTZ
	8IUOXTolecMsFYN732dgBJR3E+yIXMNqFkqLSCuaUlDLSXbg1+wE1UhYKsk2NqMJw0PZ4aKJ8Lg
	KdVWqQF36eacJW8g2PIROG7QjU21iOGcGEU0g/deiVulN4PqYzjC0cvkwdZu1ZPAh3P/Ebz9rit
	I66raWTcpKNjWi74Ymgusl9FLx4nTT0xnpznbgR6f9+Hzy92AkKL4FMSs9THC7vS/io/qphWiSt
	0U/DHHuLHIBWJ998l4yB2ug3kLUAaUVLwf0p098MZkGqGmje1z9V1lPt8Hv92QTaD6zoi8mu097
	l+KCOpwTruYcCRQ
X-Received: by 2002:a05:600c:1f94:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-4891c2d2213mr135259665e9.5.1776794934349;
        Tue, 21 Apr 2026 11:08:54 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879? ([2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm43681370f8f.37.2026.04.21.11.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 11:08:53 -0700 (PDT)
Message-ID: <902a1c9c-114e-46e3-bedb-acdd7458d6d8@gmail.com>
Date: Tue, 21 Apr 2026 20:08:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
To: David CARLIER <devnexen@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Harald Welte <laforge@gnumonks.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Weiming Shi <bestswngs@gmail.com>,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260417055408.4667-1-devnexen@gmail.com>
 <b44de581-9f41-4804-afb1-72c491d9443a@gmail.com>
 <CA+XhMqyN_fFptjA=8YJtXzyStQZ68xJiNSG464o4R-dQFLHt7w@mail.gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <CA+XhMqyN_fFptjA=8YJtXzyStQZ68xJiNSG464o4R-dQFLHt7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240224-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[netfilter.org,gnumonks.org,lunn.ch,google.com,kernel.org,redhat.com,gmail.com,lists.osmocom.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E42843E73D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 21:44, David CARLIER wrote:
> Hi Julian,
> 
> On Mon, 20 Apr 2026 at 20:02, Justin Iurman <justin.iurman@gmail.com> wrote:
>>
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
> Good point — your lwtunnel fix (c03a49f3093a) is a close parallel, and
>    a central fix would avoid chasing callers one by one (sctp was patched
>    last week, gtp is this one, and tipc/wireguard/ovpn genl paths look
>    similar).
> 
>    Happy to respin as v2 with local_bh_disable/enable moved into
>    iptunnel_xmit() (and ip6tunnel_xmit() for symmetry), and drop the
>    gtp-local hunk. That would also supersede Xin Long's recent sctp
> commit
>    (2cd7e6971fc2), so I'll make sure to Cc him.

Jakub merged it already, so no need to respin. I guess we could revisit 
later if required.

>    One thing I'd like your take on before I send: iptunnel_xmit() feels
>    like the natural home since it owns the recursion counter, but would
>    you rather see it in udp_tunnel_xmit_skb()? I don't want to pick the
>    wrong spot if you already have a preference.

Since udp_tunnel_xmit_skb() is just another caller, I'd definitely do it 
in iptunnel_xmit() to centralize things (same for v6).

