Return-Path: <stable+bounces-224632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOxLOQbRsGmLnQIAu9opvQ
	(envelope-from <stable+bounces-224632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:18:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FEE25ADD0
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FC30305A204
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4752C15B5;
	Wed, 11 Mar 2026 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SSh/KMpS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1229C35A
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195514; cv=none; b=n90aZFb0RKJJj0HB5mjoE5FetCh0j7CkQJrVvZwecXi7buMRZnV+7BuuZkd7RFgqd3shIZUYWCe5YPrC5J+YvWPmzu/GThlcfuQ43YtEfuH8SCW0gDVHMrzkJut2f5mmIHEwm65V3o0XeXcRmlFGRzmZI9Ptqx90+TtbwHy57rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195514; c=relaxed/simple;
	bh=C64KbYJW+ftJBYI+Ni7BGoCwcOuELdDrOYXeUU/HaHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlgJVEF0hcrJdZUdavaiIIECNZcSmStFrmoxyXdhWsDnhjGf1GeuyMlSXOkkeU00FE6mfsbThIMp8NdFsezGGrUIj6UfjYDFd1j+HXSt6I7JoJztjB72xZtLATrzM/36hXo9Z+hCC2KQMeDo4sjPNC4s52Tr5oBG6awP7yUXuws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SSh/KMpS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b9b190easo6895648f8f.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 19:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773195512; x=1773800312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/s/1pmy/Fni8Cotjp/F4qQ5X9Gx9X8u9ReccvcLKD38=;
        b=SSh/KMpSr5aGuzNeLay8MsjL1/Kh/Zq3QNe+4PL8Qg3vHsYFzFxQemIkAOoKq8VgYy
         /A0NLnSk1bOL0yjIDzKimvQqR/dy4ugR0/a7nrKHOJYB5IHWd6FlbsR9TbPfhthb6bjT
         OTAjlP4wAaFK5fJVm6zq0QqCt2aTurW71D3M2/e0f0ddaJyHFhAWuuyLSjJYaIc9zGjZ
         Jd1RsZesKm0byDb29co9W6d2K5E0isWbKlwXtpml9jsdbXYZ8mzlkpaXE/QYKHB8/tlv
         y9WR6EGHIZdkw4Qquw+0w8E04fa9RRRk7o6WDLReysYJLnfz7fh8T+ntfD/hp/CgbemR
         Ufew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773195512; x=1773800312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/s/1pmy/Fni8Cotjp/F4qQ5X9Gx9X8u9ReccvcLKD38=;
        b=w+tZUTxXJyxNNxByym5U1iQKht7cA2p94QmaleHusd5LegBFEqlFdiMpKbW3x1K5o3
         XmGZi4CGoKlwHKS6GTNRHz3VYMgocX7YIdcNYU/I1kYQA4s//RhpOcIpbTSkkfRcTUs9
         1OiXWdIBotttgaDhXIjU9oLvf5uM6i2MhDlQhT6UPOOA/BbPRsQiJD5ps0NxdbmDpP7p
         3QLzsbmLtEb07LYWStW75Ct09ZrzNC2AYhaikFjBKPc7zS9tu5Ii14lmNHZaFodfxGZE
         8iFPWoyqM4aiYWxww4KwkjzhOWI3ScH1TDuy9PJDzj05FscbdAahXEqnMN7DD2G3S++W
         dqug==
X-Forwarded-Encrypted: i=1; AJvYcCXio0VVCghK1z4k/Ckv9LFic0N+sYmB0fg9wNWdDaL0NFRsmOR9LPRP1vjQYRfNrgO87/KxCjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIX+xbSVkDX+x3OoP0PRc3MThAUAaOubBwUcELR2N9ABTYAMn+
	HKR2KjTXF7U1CCQXNWCPVeFtyMavTvHJEpgX1aR/KnfKjTOgaHBt8zo=
X-Gm-Gg: ATEYQzyympgmV+WgMWgAJDeNq3FF/LQT7OZhdR+dgnxz8/yO8YLYeF2K7QIfhBATEpm
	jXMXZPQVN5pFsqMAHctStsrgzFxcdQk+4Kskhhh5Vek84vgqDanShvMdiXIWA+8ST5ok1rEeoUC
	TPJNLMSc6P/hkzlmcafx2MO4G8geJ6ee1+FCLtUeJ9z1Hx0jDVPWfQyod3hqKKWSNky36N4k8l8
	OliFZi6HhVpEGK1SZZ6iwqOcioBa6Ks+umyyyGYrqCxMOY8IyGn0GHknMQF46COHhFCJMny7m+X
	tqR31u4Sa85mY6usqzViYEF6ddiXijP/LFXfz5IbWcAytJ9c2jUpocPmzWl6RlpxNBi+2wZjdte
	VkA+R4OkipwAhKuEfojDT/78q3RLgKflCqKm1BdYU3VNBO/V5IlFejjF7WxE4KZQp2UCcH73lP0
	jIdjrBNjEkmPuJWVWSHw/bV2o943OH55aEBNBL6DCou4UcPM8BeRL600Bysb2rHsRneoUIwMk6q
	ds=
X-Received: by 2002:a05:6000:290b:b0:439:b8e7:8f75 with SMTP id ffacd0b85a97d-439f81f1651mr1663537f8f.3.1773195511809;
        Tue, 10 Mar 2026 19:18:31 -0700 (PDT)
Received: from [192.168.1.3] (p5b057cc4.dip0.t-ipconnect.de. [91.5.124.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818d4c8sm2852213f8f.7.2026.03.10.19.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 19:18:31 -0700 (PDT)
Message-ID: <3a64e77d-d314-4f0d-b4ea-2e290809bf93@googlemail.com>
Date: Wed, 11 Mar 2026 03:18:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/314] 6.18.17-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <cover.1773141554.git.sashal@kernel.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 84FEE25ADD0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224632-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.727];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:dkim,googlemail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mailvelope.com:url]
X-Rspamd-Action: no action

Am 10.03.2026 um 12:19 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.18.17 release.
> There are 314 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

