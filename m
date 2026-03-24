Return-Path: <stable+bounces-230037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK+BAMfcwWmJXQQAu9opvQ
	(envelope-from <stable+bounces-230037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:37:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9066E2FFC22
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A4AB302B800
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285701531C8;
	Tue, 24 Mar 2026 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="PbHKOaVQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E15155C97
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312460; cv=none; b=CpAsFe0IS1DL0jMeTZokHxnayuS5eMQO2xbNn/EhYHmL5ba+99u4f1weQ5sU3MZjk9FWqSopmVvWWtF8IcF5bDDdAjuG9SDM+jfgsQw/FLvSL/p4oI/LctSWPnCYCCX4pel2mY0kOFFy2+0aHoQxl2aAAey2JLqNdEJZuPCfNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312460; c=relaxed/simple;
	bh=e9cmT+8yC1HLkW4WiReOSEgL9/ZpjZtKaK9tTIx4JsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGDlEKcYiqgrzZe98xHq3Lt5LUB2Q0DBmep4EjLAgc4iW14sckXRfEg66O90ZmtS957pLM6w+7a0M4/sy9h65rNF+ni6w798yyMTMcCM8Gfga1ghyksJp1BCYIo94T0/erxgXxP8lzUvbIzQcIvRgNWna+SkNK7D8YR48t4nkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=PbHKOaVQ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb5c9ba82bso516453485a.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 17:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1774312457; x=1774917257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVGO6eoVEJAXwpiX89IpNWdNPL7kVxGIwYfKpBDgDJM=;
        b=PbHKOaVQObDnzKVl/NS1Crw/jcySg5JNe8PCPlfiUDU99qhKnhYOJ5zEgrDFoco+O4
         G867P+3tZTQ7LUOB6vfW8/75rEqXCHYR41JJcJpn2wEDTkFhqmTl25rUSJTXpz7BZu9b
         fwcDNm9km8GgyQS6Tm7eud46lMchI1Cg7zVHkFHKhGjACyahqBPonLRdKwPPUpyaH4wH
         cpw7RTZo2YiJhbxkYHYo6LATqaWuOc5lwbVampxlG6F1miHdX6Tug4A85s/mn0QbL/ox
         AXAeXAIOne+yEUVM5tAN9dwVgZBnroecL9/q8mn+8zTK2EL/E3LhzdQ3e3S+CxOV+FLb
         400Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312457; x=1774917257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVGO6eoVEJAXwpiX89IpNWdNPL7kVxGIwYfKpBDgDJM=;
        b=pZwQTUES1bwQ5EdYPQpSkrllS5FqIA+AwsOYBkDbAI+aF2CTaIYNCAc1deOAo8W0jZ
         3CCjTVKC5fbaepIlQBvDiMYs9uiB7ODCiIgcuiq0/ipDpe/c0IphhoSLSjjhEe+cetiM
         Tr3HQhOjB4UK+hXfRn6qlIttEKiUbXOaXTdWDR6vrPmcJZdsZU628eT3nss2Sws/sV8j
         7GMZNE0ETZI4BRHwYHL97IVYteIdwaizM8s/YMoy/K6SlRDziQ0vpgjuBIZrcDVRFN7O
         QDTQDUcUBgOQ6tI2gzXvkkr7Pk41SauIKfy1d/oQh3DJs4NdP85RI5ZFu/eL7seXLrs7
         pjzA==
X-Gm-Message-State: AOJu0YwkdpbGdzxL2yNmMSqSZTw6lUnGTeuOP8yy+BOwrQ4pZg+5gwnL
	NAYVkPzjrd8g6WhsjB+ZxzVfyFC6fWBeQ6DpiiHNdWmUmjimw7wUmb80lzUhRX+Ve50Z7Q+tjis
	MWr9+9t8kkel4qartbjcwI9INv0t6iHx/SD9I0IFfGMfgVXWF9K8Z
X-Gm-Gg: ATEYQzxKs6wMQmgLagXez/BxLbHlKwYfQths4fz2dOcO3CqwmmxBrEGlc5z2N6yz2W9
	DDpf+pls4sbjsUDIhWwBIoPrfQXjgWNnmMF5eIZ50QWNfPqq6XSXXgP333f9DpgwI+dGEgt2sHC
	84Kv88pZBMgDiA2vHjLTekfSzjOWzfqU9/fSLgpzTz8agVnCSmwS+eCijLbhyijCPA7gGtSkKuM
	bH+ChNW1WPGmtsfBehek1k0zJRBIy3hMXCvlQb13TPcQI7OR4/fCpBfVptbk2Fd7uPBCEDdyIUi
	hXZvRGrxVw/ORu/FvLPjjy6ZAee1+/sF04QlG/+c1ObpGjYH7JMX0Dy03npAdqYUK4yQR2opNo2
	nwGVl0HXdyTaNTKFu/s6iDNpMrKQWNRYai+CFoFoO0DYXWUxiwOQ3YQTVK35RZCeEMFhHLO6tOa
	l3VP7z+shG5O74syUbawYcJVsKYAF+E1dtt+7U0SUSZYisEM5Fcsj5jpVMAbROAU+Yvtir5toex
	g==
X-Received: by 2002:a05:622a:4294:b0:508:ff31:47f1 with SMTP id d75a77b69052e-50b3756f294mr208993621cf.50.1774312457107;
        Mon, 23 Mar 2026 17:34:17 -0700 (PDT)
Received: from ?IPV6:2600:2b00:7880:1d00:a5d2:a745:535f:7b72? ([2600:2b00:7880:1d00:a5d2:a745:535f:7b72])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36d04889sm99146351cf.9.2026.03.23.17.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 17:34:16 -0700 (PDT)
Message-ID: <4e772b69-9c46-4da8-8760-dc7db763c7e9@sladewatkins.com>
Date: Mon, 23 Mar 2026 20:34:14 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/567] 6.6.130-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20260323134533.749096647@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rogueport-AntispamServ: glowwhale.rogueportmedia.com
X-Rogueport-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sladewatkins.com,quarantine];
	R_DKIM_ALLOW(-0.20)[sladewatkins.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sladewatkins.com:+];
	TAGGED_FROM(0.00)[bounces-230037-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sr@sladewatkins.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9066E2FFC22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/23/26 09:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.130 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.

6.6.130-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X, 
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Cheers,
Slade

