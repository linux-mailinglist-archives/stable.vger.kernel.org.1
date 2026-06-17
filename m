Return-Path: <stable+bounces-266644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y43+OVo6MmpmxAUAu9opvQ
	(envelope-from <stable+bounces-266644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:10:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D9696C4B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:10:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=Ykmj+LP5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266644-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266644-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 985CB308592A
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799673B1EDB;
	Wed, 17 Jun 2026 06:09:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E33B19D2
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 06:09:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676592; cv=none; b=OxSrmsL4MlLdJCDSBQVkEBWkHvhtFPsx8IyDEtwiznt8wKVKt3QXztB/AZiXounUcJpTkuSUIA1L5/S8iTfmgUK2vTf8FBox7M+Heq5oMtrDSRAN3ShRnZSxFAzEvVWGKe6LhEWyy991Ezbys+Lntbcw/E68VXNKcRzx+xeHDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676592; c=relaxed/simple;
	bh=qNq2Np2owAOATAEvweRdUBgEUHLpklaQw2z58nEY6JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5YpfZi2qw6NxC3OJHvE2hgjVAuHH+B9Z4wDr+ahpkytHSPDzuFLkH1d/KCrwjMYVraKPIe1U2zeiuFcu+89V/rf2jrFOvWbFXbx/mhuXNL3QvfZJjhwR2wev2Rfgx77/b8fRzlw8EIwytQEMYvpj99tckFn1QMvBLZKhSDnnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ykmj+LP5; arc=none smtp.client-ip=185.125.188.122
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E33CE3F62F
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 06:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781676587;
	bh=qNq2Np2owAOATAEvweRdUBgEUHLpklaQw2z58nEY6JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Ykmj+LP5FdcVz5e00/BDxa1RCIJBOVkaECMng0PQQssl1UeQ5iRjvmdPSJLELX8Um
	 pEMpS04S0TF4M9Md5dkJRMM46uv07xiLlGbyJGC2OhFbQaKAiLvKbykX0WcR5bHMcw
	 6fwkuMOy1NdNvINENLntAU92irmCg5H6zLJL7UhQ3qImY0pPjsAAPwUw6EoPq7JUS3
	 /uFCdEbec9prSc/eUHL0Ezfne6TApcPjTkgYwG2Ze0oZkvb8umZJ1EDPQVSoFi/2pV
	 akLwbIShOFcFGji7bGttM10L3iZCPWeIyzQjCqqYsHFcmlX/nhPz3CbTB2bhWCIX/P
	 KNip2k5kl14pQMAOj2i0VmCU4m5eg6vurrlYKoGE+uQyCe5RJ/9ITLZt0wMkpclxWr
	 vCWvZhKPJqCpx/AKa3WYAaMRGgLgQOtE95guyTEzM+pizIFZIJkzB7uKhA2i9zb4Uy
	 7/g6M1O+asIDeZWpBbSjJxytPHksMgnM7gKdkrr9X+LYFn315m3K3EDLHS12Rfneap
	 0eaEXvptcqmPSb1jkjNwOZSGGJpE3Dx9IyPey45pvJMb6V9JM5CQQDj5Cd7uic68gk
	 LbqXR+pVnEEk74iU3ZKuOo5hQ1Bhp7SmipD9IRgNftiBbvJ1i4fAEoYdUG9TuJfGrC
	 /65T78Wz0Kc3PBTfucB0zGtk=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490bde3d239so35225585e9.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 23:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781676587; x=1782281387;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNq2Np2owAOATAEvweRdUBgEUHLpklaQw2z58nEY6JQ=;
        b=FBVflk3kFFVymGMzGfTrrsCYMjgzqpSo2l73uDDrwu2hpqc7W24BPKrc0UscwPeaNE
         0aLsbLtpBWPHhsuv12VnZYfxPP88QiMh26LNpC0Z3dT+6lLRbFqxoZP3u46Kda65/4rJ
         iumcD4F30l4vnnBHSNDVsokWVpTmb9O53vR8GGaQCkJQ8axHrRZxj21lL/tSkxni3N46
         VrFUSDzsXl34V+uAnwOmBuOX3dT6d1kSBu2S6O4h7Bah68+hBS+FmAKuHK2F5PfgZ5uH
         ROsj7ExDHmPia61wsv0DWT/t8lfZB6JQvSTlYv6CcJp566MMJGGCGyW+tK9lvQhbojsu
         W97A==
X-Forwarded-Encrypted: i=1; AFNElJ8nHvwkD5HbsRIkeOBBLl3nI/7Nsa3sMoybdVXSonznn2Q5pBBT7wNy/CMffnwmXNDzqfBWj4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhoi8QG2xM1ayDvNNYTJ0/qB4pdjFQZZiKaGuH0NiHJNZaL4y4
	h5gLsgPfWs4P0oic1FGOQyJD9zk27HAHvgNnJ3NV4vlb/MzmUA05+UgaX3RZvnXimGy0cHBkbjr
	c1zmb7qrVEusacC/6ySFzRCH4J92RDiMuh9z4usTbIJLFpoNaMGQjYMqwT517DUKZ9JtwvAhTog
	==
X-Gm-Gg: Acq92OGqKWC5NFY2Xn6U3B2jGer+pVdlVGnhV9p2KDZr8AoXwcb+dRPwovfO3HyED+m
	ZibVsgDXDMXI8GfpKWGmAyQLoM4OsmXsagwk+nDWFNiAo78a6Eq7ELo4eS0w3ew8buOrvaio3Uo
	lm8gkr4Ux+DIksQldyp+kxrW06bVYhAwtQAvqVLBHszt1KAP9n5ulZYt7Ml/SWzeHky5wwCUwIo
	czEPvOHGrtXYSVXipmL04kLxHjmq5ikdlpEdjxvvMa3tbO5a2J4TR3rUYLCn/VmwzN5El1d31of
	CViLHHILJwtVn7MYdU3xW/F7PhwXSqerFoWOWUdqzUtkRD9Hj7jZkTCHbF4PfPCL1Eh85ncddFo
	GZOlEg/hC2iNP91FiFKzgmcC2sdejcGcyLLvkSPRa
X-Received: by 2002:a05:600c:1553:b0:490:d354:d15b with SMTP id 5b1f17b1804b1-492334282b7mr37259915e9.29.1781676587606;
        Tue, 16 Jun 2026 23:09:47 -0700 (PDT)
X-Received: by 2002:a05:600c:1553:b0:490:d354:d15b with SMTP id 5b1f17b1804b1-492334282b7mr37259505e9.29.1781676587312;
        Tue, 16 Jun 2026 23:09:47 -0700 (PDT)
Received: from ?IPV6:2001:67c:1562:8007::aac:41a0? ([2001:67c:1562:8007::aac:41a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c5266sm57092036f8f.29.2026.06.16.23.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 23:09:46 -0700 (PDT)
Message-ID: <0265091e-3722-4b93-a644-e9b3dbd57a3e@canonical.com>
Date: Wed, 17 Jun 2026 18:09:38 +1200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] selftests: net: fix file owner for
 broadcast_ether_dst test
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, edoardo.canepa@canonical.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 oscmaes92@gmail.com, bacs@librecast.net, linux-kernel@vger.kernel.org
References: <20260610062230.71573-2-ross.porter@canonical.com>
 <20260613213254.174421-1-kuba@kernel.org>
From: Ross Porter <ross.porter@canonical.com>
Content-Language: en-US
In-Reply-To: <20260613213254.174421-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266644-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,canonical.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,librecast.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ross.porter@canonical.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:edoardo.canepa@canonical.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:oscmaes92@gmail.com,m:bacs@librecast.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ross.porter@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:mid,canonical.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F1D9696C4B

On 14/06/2026 09:32, Jakub Kicinski wrote:
> Could the -Z root argument be moved before the icmp filter expression?
That's a good catch, I'll resubmit a v2.

Thanks,
Ross

