Return-Path: <stable+bounces-262241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4bgdLwnjJ2o54AIAu9opvQ
	(envelope-from <stable+bounces-262241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 11:55:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1284A65E945
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 11:55:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="SZBW/p6L";
	dkim=pass header.d=redhat.com header.s=google header.b=Acm8YZW6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262241-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262241-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00CC23056630
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 09:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7053B38CFE5;
	Tue,  9 Jun 2026 09:42:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090393ACA77
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 09:42:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998133; cv=none; b=tSh6DTAIykAdQUv3tFvP8Wvx+P1agwEvzuWLX9DewNNnYROm1rOjwqIwTkZ4FAty49tr+rBMUipAHfpk3O0peAbaEszuXVsGtRjk9jscPVtIHPNxIpqgrctY0FiQNFeu56RkFx5M48zsvhzLUmonlOWaxKT6BUjvrAojfRXF6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998133; c=relaxed/simple;
	bh=Avkrtn01Ayj3T2TvNljnHS34gZQIlNdTbIwKa1EoWmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AE8i85/3FRRSeu0I67QK13cUUr7VqeiOh7ROEI4xYGUJyQpsgjJWKmSEUCUdeZy7UG9Da0R1f+DtzqF5x8JMlOWsoa+HJdcfLGQE9HFSpcTINSxyjpZNebPaPU7aZ8Fj8VlYUb4ID4hYk7uFyZ4KUksUG8LveceaVOvT5T61wR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZBW/p6L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Acm8YZW6; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780998131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRY8LqFb7Uf3uguI4UokjXxEYGkijilafTjvNmMtFxQ=;
	b=SZBW/p6L11XGEZMelcAVnVmUPxCKP93RzARY92fMrlStbcgy/xhSenOWH60sI62nq6ahij
	KFvsN3KV5uMvzuiNdHvDnwhF/1bDzylEmxYkf2Eta0icZF7klXb0ksRcNfi3lm7eZtoQtF
	McmV3CYV1DbD+b5i5Ryc1r4AQ7Y3wJI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-t1WufLLcM-mTIr9qcAFkNQ-1; Tue, 09 Jun 2026 05:41:39 -0400
X-MC-Unique: t1WufLLcM-mTIr9qcAFkNQ-1
X-Mimecast-MFC-AGG-ID: t1WufLLcM-mTIr9qcAFkNQ_1780998098
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b37e1f48so43602945e9.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780998098; x=1781602898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRY8LqFb7Uf3uguI4UokjXxEYGkijilafTjvNmMtFxQ=;
        b=Acm8YZW6lfcIzAMp2Z23UfeSBDJN8+9G8dNKmcppwoUysS9vf2J9DrIxtRa7zRa8xZ
         7C39L6ja+tfQNsK+Vz10qIfJkw66Ve9KdWb3zaDPrKcZk/Y6/aCjm3vCY9ad9pBbdMmN
         sOTvlfl/wlpAtoRa/nxwYVgwOcfRL44Rw2H6pOlXI64UclDNopPflXI3Ijj6d9sSbARS
         lQEHbTgDCYjE1tZCM4BtBgodae47N39KV6ig+6xIyLuSYibfV3WpwkU8fLoexkK2Lpiy
         9lH3wwqfwkwLhg63WmKd+vPv+RLsNZPPTutNX/LpMx/Hq18kPDE97qSyVPORL5FGj+c2
         9ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998098; x=1781602898;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRY8LqFb7Uf3uguI4UokjXxEYGkijilafTjvNmMtFxQ=;
        b=iCbaMZ1KMqOmbiAYx4om/CrXoHZAH3TjbnWPVV/RFiTDAeqIdjdTHoYN4T5vf9TCP7
         HXJo0dU6/I+SvhaPoRV6ju3MrqunAO50Z4lwHvhRk/mDS619XJ+Szki1hnZ3X7lkACv0
         kM2Tl6ctv+whh0zSeUkYMHuJ/dvoEc2KaV0m5x3WJP8JQQ/XB4tyV5ky13vyaALRTcJY
         oF/Aw11/W7nvFI+UmjxzjVbhDUeUcG4RPVQvPwtOK/vjgS9hPaEbhhO+o9xbwlXM4MH6
         4U3WgyznDtKUSX/AvD0h1t5+6OsYMTzzPLQngVdgRvvsaLcPSg9EOO68xiUlEjWVrmjz
         TQuA==
X-Forwarded-Encrypted: i=1; AFNElJ+gHksoepLJkEDOyjeJ4NFfcRfCxSg1IcHtqtLe06FmPSAt4hfErnzOGPUmr2Z5zKJueGDZB4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxN00CQVIDsXywF03rtKb+cSGDmZlZZbQ4tVTvcSFxBS4DhHqK
	Nm48F567hcbfuG1q5o1y4VhSbf86k0BBQf3T5wB8WGLglLyEM8DSrEGck/rFxOXXnb7OqEPHgdX
	OY2VLjhSavFEwpF0HATik+zB40e4aPDRPIOFlsx2x/W/Mz0lcQsCbyIyX/A==
X-Gm-Gg: Acq92OFW6UqmD+MlDWeXSdinXE8HBSeFDNxAwaigoFHoPIeEyGR/x0LPptXeIyLMqyC
	oZhmabYWeaphl6vrA3L2bJeH+o9QvOyT2vgI+/qw0bKIuahbEdJO1E5lcsiNpX3i2UlyTEKwtxU
	qImypJhO4MCGhme/Gyf9aR6ZAza9nGZewXqZrDq12wfItyCt8sbvvLLPlI2eH+hivNykxPj63nQ
	rFWY1qEelL3BpjNAl4qmTR+kBTXmsZ8OjlSHeoEJfocb0DXgKfVjeltKdvcYP0TX6CLprKaXacY
	9dtPosrUQXOCHRTOm+doQ+9vB9GpyvIk/PCTcwjFQM5GtcY+/LnDsONumkibYxmjnWH7bePzvc8
	CIr6m204eRwopXizv0c0pHiCzza7QNTQ8UcKSCAhMRymIE1VBgiXVxe+1DzInWYMCsg==
X-Received: by 2002:a05:600c:5488:b0:490:9d1b:f07f with SMTP id 5b1f17b1804b1-490c25b1277mr370753145e9.12.1780998098485;
        Tue, 09 Jun 2026 02:41:38 -0700 (PDT)
X-Received: by 2002:a05:600c:5488:b0:490:9d1b:f07f with SMTP id 5b1f17b1804b1-490c25b1277mr370752465e9.12.1780998098011;
        Tue, 09 Jun 2026 02:41:38 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm473121045e9.6.2026.06.09.02.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:41:37 -0700 (PDT)
Message-ID: <c9fe8a0c-51c7-4afa-8d2e-1a1d5730d693@redhat.com>
Date: Tue, 9 Jun 2026 11:41:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: require CAP_NET_ADMIN in the device netns for
 tunnel changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com
Cc: dsahern@kernel.org, kuniyu@google.com, shaw.leon@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604125055.3254652-1-maoyixie.tju@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260604125055.3254652-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262241-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:dsahern@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ip6_tnl.net:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1284A65E945

On 6/4/26 2:50 PM, Maoyi Xie wrote:
> A tunnel changelink mutates the tunnel state in the device's creation
> netns. After an IFLA_NET_NS_FD migration that creation netns differs
> from the caller's netns. The rtnl changelink path only checks
> CAP_NET_ADMIN against the caller's netns, so a caller with caps only in
> its current netns can rewrite a tunnel that lives in the creation netns.
> They pick the endpoint addresses. Commit 8b484efd5cb4 ("ip6: vti: Use
> ip6_tnl.net in vti6_siocdevprivate().") added the same check on the
> ioctl path. This adds it on the RTM_NEWLINK path.
> 
> Gate each tunnel changelink on ns_capable against the creation netns, at
> the top of the op before any attribute is parsed or applied. The ipv4
> types need it there because the parsers can update live tunnel fields
> before ip_tunnel_changelink() runs, for example ipgre_netlink_parms()
> sets t->collect_md. The check is skipped when the creation netns equals
> the device's current netns (net_eq), where the existing CAP_NET_ADMIN
> check already applies and no extra LSM hook is wanted.
> 
> The newlink path has long checked the capability in the link netns. The
> changelink path never did.
> 
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
> Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")
> Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces")
> Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
> Fixes: 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in vti6_changelink().")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Since the fix is not centralized in a single place, I think it would be
better to split this in a series addressing each tunnel individually.

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 169e2921a851..02328c9a3c07 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1457,6 +1457,10 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
>  	__u32 fwmark = t->fwmark;
>  	int err;
>  
> +	if (!net_eq(t->net, dev_net(dev)) &&
> +	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))

the above checks are replicated several times. I think it would be
better to place them in a new helper.

/P


