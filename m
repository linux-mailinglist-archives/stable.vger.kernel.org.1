Return-Path: <stable+bounces-222676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGH8HADcpWkvHgAAu9opvQ
	(envelope-from <stable+bounces-222676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:50:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E651DE7AF
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C963055129
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E1F375ABA;
	Mon,  2 Mar 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FflhTRuT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129437C108
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477196; cv=none; b=aZS92ZQiP1gckT5nF2q3TbOap7FBgqUe+kqBgdbe9i0klwoqw1Je0ce5fAnhjJeA7yHmQuxNvsvwzeYWOJpG03mtLVGodZaiDa1WFwI+Eym8xSZfQZ/xkdiQR2BVnqZU39c7jClGtzEyap3xJ9GiqomP8vaFFL226gRWVO3BoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477196; c=relaxed/simple;
	bh=Lry8ExSeWB9EpusoHkxojQVZihp63rGi1LQPnn8u6D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkKmlJIIzfz3TwXPn6uXFTWcNxR/gWikY49aQCui43DDpuBpcJguNw+wo9M0pUFOHzebcdwIY2F0qlmbLR02/oaOjdbGEL1wkPCxpLqhFqZiF3mJmv/M2y9rvhENFRtiaZfx9ZXC+ukulDJw0xVaef8gJ1DKyyvOl5RIvDSx5DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FflhTRuT; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb40277a8bso499038685a.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772477192; x=1773081992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/fCL0PVbWZ+CTSzMuw98+KycxkLtqaDaxlUz1qwLO8=;
        b=FflhTRuTnn6ufGaneIT4/4ZgMWdyN8cqZJgSuoV7MjPDVOVSldkZTkEEGAjnuLomcJ
         wKMA5i1CMpQBJPlPo3GvZrSGmpPP2IueD9bKDXp1O9hyzYTf0XKPirWG8HZYIpNZKMIj
         AarhcybGl6F6G0+VKPwLt7BwNdywAt91eJE3hpqvTwnPzYA1ZruoLXWlLDioSo2Dt0es
         xMPfRX8529YMrvncnVptT6slyCC/U1cG7TCDQr4cKnEwcOyHcfGTI0qE0jgGGYgQ2Eyg
         5tmIT/D2uc9NXqgsGYhUwyY8Nn+69CuhZbyWQwRAwJ1UYXUf0NhQrsWnlIaA6VboBCr2
         /U6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772477192; x=1773081992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/fCL0PVbWZ+CTSzMuw98+KycxkLtqaDaxlUz1qwLO8=;
        b=tUqqJN1dG5dSEvEjzhWLnqDnM5U5qA4Y6Dx3vMdRG8GFiD8/OOvLF/kysRKVufcA0I
         YpXmptFKwKH4UvOQSKQmlejvZTd1MF+Yh+fQN3JRGJN0KqisbfhGw6RgHWaRXH4KeE3H
         3DEPq1DnS2rjn84I7zQd8Pj72VohAYK2l+rPVkMe/ISajcom0PEWJWl1QXxjdXqpqJOn
         UuKXHOjKiuzF0ThrCbVnwg0QCiGnqYca6AM1Sr5Nx8RPXBBfDjv8S18OGRRlmK+HoSoz
         jMoczA/U88ph2BhYgNRO3TKGZxOgqGMsWJGnUWzVy7s6mrs5qGMjiX5/KCdYryKQHGCw
         nmtA==
X-Forwarded-Encrypted: i=1; AJvYcCV87/BfuCQuRGaqTSCIUnA+2NVxQuSTOgh7yDDzTLBXVPww8Idm8CArBinNuukAOQ3f6wlVXsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/c6XNmvj9KpwIlf8vTkiOwvBU1FBCBvBR7Ign50+8QvP7o+9
	IqNehWGUWRLjifGHVBWGFzW2tWS15NIwStGpUIIXOxxRN++Kc84uaqAb
X-Gm-Gg: ATEYQzye7jqF/3wSO1H5i6SjahyLw9DPXBkdjUr8Y2asyD0WlpPwlG16rFrA2a0zjZ4
	O3SA6cfV+OZpMylXD1Md1BcIOp/qnWtk/v+Sd34VretY2xLN6ThL+UQArO+yKAo2ZF2jW92UZ2y
	hpHdNgRij1CgUQDqRCAMgzni+iAgdLDXzymNvpisEoRffRqpq4uDSCsYzi6WFwyaTBl8TVeKL6T
	kasvHqT0EEvCwyHu4CQc5j8M0aoCEkyfd/bOGWn1vDEabV9emZ/utIKxF8JVGEy8a+mVYmiCCKW
	N06v71DkqWBVuOBXx2we5UEeRYYAj8t16yInOJYCL3f7PEwIeId7ianyHQPYWDuaEXYzC9PYZY7
	SuCHuKThVZpMwBlYA/bNa3bt3XTTUy7bI2UK8TYlnwjdsBm8bowqYNgX2adUso0mcrBWDtMY455
	MOe0AOnMf3A7f6ZceW+dpWjqkuZ6Tv1MzUH6f0FbLrbdlObH3tlw==
X-Received: by 2002:a05:620a:4141:b0:8c7:19f4:b585 with SMTP id af79cd13be357-8cbc8e4b595mr1721232985a.43.1772477191900;
        Mon, 02 Mar 2026 10:46:31 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf717301sm1199062585a.36.2026.03.02.10.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 10:46:31 -0800 (PST)
Message-ID: <a2baa254-0b3f-4514-846d-e905f1fefb10@gmail.com>
Date: Mon, 2 Mar 2026 10:46:26 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/410] 5.15.202-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260302160955.2522727-1-sashal@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260302160955.2522727-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C7E651DE7AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222676-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Action: no action

On 3/2/26 08:09, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.15.202 release.
> There are 410 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:09:54 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.201
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 
> -------------

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

