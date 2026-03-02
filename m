Return-Path: <stable+bounces-222743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIkDNNocpmmeKQAAu9opvQ
	(envelope-from <stable+bounces-222743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 00:27:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADFF1E6A34
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 00:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA382300F109
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 23:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8930330B514;
	Mon,  2 Mar 2026 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h4SK9/mL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144CB320A34
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 23:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494040; cv=none; b=aeW+5S1tZV88+kwerx0xpCL02SqaDr1myNE0X+ouqszdN3l3cN10N8xAtF7kLtUg4e+NaIAioERPHe4/IIa0isDJqu9El2W61XADmA6KHi3C0aqAj+1Dv/MRng2OKR9VuESXLYVX4bnmP3XOgrSjxH19TMM645w2F2hI95++B2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494040; c=relaxed/simple;
	bh=U6V8Fel0bOcVeEQxtM0YpeXdQsoLB2uGqs2/i7w22d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZoYRv+3Q4pQpFFe/9xtoPqR4dJLu8G3q5VCiU974AgApdRyzd/Ab3elbk3KyeX0CIkGa0VB713UEcyPjdEwjQ1Pk7QnlUJleYp81DgxfxqqH/jGk/HVizq0oToCpyzvhNjCpYlUqdFsz9P19fuD/tCslhgfNbbwKXKQ50fcCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=h4SK9/mL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b5d78592so1461681f8f.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 15:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772494037; x=1773098837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyT50lSq/TxPs3SvD7hUAadU9vPIFJe9pUjPzmdxzjU=;
        b=h4SK9/mLvai0LRu9gg5mqlZlG08tDrIk5wEUiyVaehYMP/SNuNfJOtRlAIT8eHI2NG
         /BJIDUW9BtUfn3USyFHs/wm8nAdh8iFC3kSz3G7ysXnPvyraX8vuPu09oyDMzw5T7zYD
         grw1BWTSSCCjS2XG+azqr/V5mSA8Fajq0Nb7uSymYWEkvmaxJBhcFyT9jiLLmmVGOEs7
         Fu0Fgx1hvHSY5osZ5u8v54kk5G1Zg3QQRe+Hv+n7J8zWRhCxrudrKyYYHrmurxyfxfdR
         2tNaNeo+mydcc0Uv6NT3vuT5tZeLb9GYDPQsRFhoU9IBXkXeZPnoEwjUX3S+bjMpAaRg
         fzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772494037; x=1773098837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyT50lSq/TxPs3SvD7hUAadU9vPIFJe9pUjPzmdxzjU=;
        b=KjAUBXrHoXf2iv5W8ySsUC83cCbVkT8L1Ilo5WBs1UIqHUC7Oq6RQ4qPOMEc2HyX8b
         1ljAMCFGnIX9C7wW4tVGPVgCRk9tRZlEBg+vP0NUyOWer0k6YUAa3pjHBAQhaoE04+SF
         yKFfbLpDzqEPiWHKd95MpP4bvzhgZubRlVjFbTV0IVlxmn3qgv5H4ttA2fj2MirxZvEQ
         LzZJuJVoHcROyWBZNuakheHUnbV2kxtX9QyLP48zIR75OwVN3HtjnLIL4cwZTbp8Dtls
         KBIuUeyCh/NM20+pqxnIWNyQhPpcpBsNyAmRqfkjPQVQ+kDBlJZEeey+dghYC8gouszx
         aZKw==
X-Forwarded-Encrypted: i=1; AJvYcCW3CUMC7bBjjmemSFVh1YeKiNNiVBmTW2Uoxm0KOXMPv1LtlQ49Zw5edPtOpEiLnNj8vtPiMQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIwEWn48cOaUM0B/j0dghqn6pb+mUFTtO32qExxto/GlK1bzF
	8AlEkJAuSCUv9VwBRrfHl2D8aGgGJu9w5PpPwK2Pq5PMHEBB/56et1M=
X-Gm-Gg: ATEYQzy8dE6smMD3OkwNBUiK3U8nnY0uwapf1j0l2oaOWE1P2UQunRt2m/CAtYEAbXk
	i3pRmdnpp1d3a1IjTRaQ5Dw+gHJp/FA1hQngT+g6eEzOUXuVKnancaN2nUCaa3jv06rWBgZkua1
	QrNhJqebiiNvds2hWfIU/Wzn8ab3qg1psHh8481dPkxdYuftHBV/c1f5LUpAa7NZFSHL2wQvfIy
	rXcrtTQ68GfJIvyeqwt7GAIDQ74kPIpgPhuHnauGUxUcg7mWm5gaPdUFKHy1JQMhR67XsOTCjdL
	dHzhui+T2gZvzsQkIcXAc5aKRGYQV/NoGXXzW3VDr8GEinoLjLUj50e+REHwXqxXTdY8AZGLxC3
	BNDdI8SYGMC/PvW4MIaxW5CK0NLxdz8aJ4I7ONpkUCogIDVqdiB2msWs5oYWzdOsbcr9TBQW108
	m5HhWRt3HnrcC0uI0zxLVxBDBVE0nFyp+2t93GbX6fUJgGsiAva+IVkeVz1aklvyV0gdhltdlWy
	Q==
X-Received: by 2002:a05:6000:26c6:b0:439:b79d:b9ac with SMTP id ffacd0b85a97d-439b79dbc35mr8579811f8f.45.1772494037115;
        Mon, 02 Mar 2026 15:27:17 -0800 (PST)
Received: from [192.168.1.3] (p5b2b433d.dip0.t-ipconnect.de. [91.43.67.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f764sm31130437f8f.3.2026.03.02.15.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 15:27:16 -0800 (PST)
Message-ID: <eab01aee-cf11-414b-b9d0-fec2dc2126f0@googlemail.com>
Date: Tue, 3 Mar 2026 00:27:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/956] 6.12.75-rc2 review
Content-Language: de-DE
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260302160918.2520730-1-sashal@kernel.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260302160918.2520730-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7ADFF1E6A34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222743-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mailvelope.com:url,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Action: no action

Am 02.03.2026 um 17:09 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.12.75 release.
> There are 956 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found. Again, 
no issues with poweroff on this machine.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

