Return-Path: <stable+bounces-222731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBikKa8VpmnZKAAAu9opvQ
	(envelope-from <stable+bounces-222731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:56:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 131AB1E6010
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82A5E3106B4A
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C3B1A681E;
	Mon,  2 Mar 2026 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SOmXLrLY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1941A6817
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488723; cv=none; b=jHmDSMh65NkFigJePJfJYv/NrygQPz/lVtgzu9xWKxYywytWkt33LZEYvd4x6ovhzFKNrTddYDoo0mmtOoEAAKjBA/VahaqoLXOGsVwdU5HanCuLyV4LOjqDsY3RyKFGIz7vbKB7Xq+5fhXNdJbe5sQEckKwQODkvSK8YiywMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488723; c=relaxed/simple;
	bh=CzRhtzAd4wU4VveBi/RJwRJWeNd6LX+/wDJfvIcFaHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqqDtPs5/fWe14yo5QbZFyZX29CFrXH+x2ZXdFS3rQhNhqH3c9HEQ2Kofj/6R7k+dYDv0vx6U3EuusF55jKciApA5A42k9BFk8ignMka+zh7ICK3kv61V5Z57Jj2dXCz/HoRRuyg/JeMV6fhYSCMGQtJXW3WEBYVMgPNH6+eU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SOmXLrLY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48372efa020so43130735e9.2
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772488720; x=1773093520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNalNLjzL3C4qV4uaBCLeqrBYe/xVSNW5g5EuTk6psY=;
        b=SOmXLrLYEN/rTE/RLi+BbNwft7ayO58N67B6QKdULIE115FKTXQgYfnADAgh6mYUHB
         zqVdAp6qKmVRg8XV4twyG6Y+pCozG+bxjscev9bqRDuZYL3Bws21yj9+6OPnviAE7bGP
         vcwB0eMZprQs+gnXcF8B7qVLCLsVUhDpWutjsLDwXZUGZDmRBCyq4iFrOPuVbQ69ppl+
         0sCdWvdVHB0QPnVAZqvTMwg8f8G699keOsA+uRICwcU5kpit84aghnvp5wI2YxNcVnVV
         GNZvBOK8tyZPscTm93xdP9QbRCCzNp3cxQqiZTdOoz8QOf0woyhspqy5SNUX4tQQH7I3
         gpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772488720; x=1773093520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNalNLjzL3C4qV4uaBCLeqrBYe/xVSNW5g5EuTk6psY=;
        b=H5iHN29eBhs7fHj4V3xRm19oqsZoFvi+JnTzwSl40gWOqXsdRKvRiGxj3z/HWyhZj9
         RgYSW5AdYVo0+f+SMc39sVDro0tvHscqQRP9qUHXOKeN5Q5s+qKF4iFp+RDsTr3pnjej
         Oez9SS6o7RGGWKNYZeJtwKdOuEr8Y63k4W3ocLnfPL4wzjo6bAJnRcmkU7kdJGToHf7V
         zbflu28TSrOGlcZPQL7Hxiql7r0ifS5gbC6B1R1GdK46q3kzNRdPSRErr/npUh0f1u32
         NQtSgYQyrIIxTyuSYwuaSUf+NWfhIvcsMXRgC+Nnor9m2lISqdQmnJAiY5kOp571VjFc
         atNg==
X-Forwarded-Encrypted: i=1; AJvYcCWdKJx5MeOy3ptPlrBBJiRTDWXoPfrUOOF7uvShgcrOrSj4Dcqz2I/Y6ZPVY8zn82vccllFjUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPuBPBMiT7x0+BXGbpH0UCYfpiCineFbxHVgj6D74zKrCQiTB
	sq2pMAGjabZMnMAoLOWYUzMRzJf6v7ZUd3+IKYplkpbcOrIWl8HeFq9gNn4G
X-Gm-Gg: ATEYQzyNVNFy5z5VH9+MJvYD12FDvookdN6WnV5P8NLu5zojGX8z6AIabQ8R0BGQAKY
	aep+dT6q1o1JRG9GxG25LNht7Z54J/yiUio0YqIeVoT/w8L93N8OHPTkYukXArl9Xz5imQqtpIH
	1fLE7qK88RzA6dZWQdf64gj6L8lo7CBAoTMtY79V17MGGjntdI7EI+2kmz4dJXo724F08f6uei1
	5Yu1kn8TBTlR8LMGRaq91SmC0bILR270Cqc+KbzMAFZobQsOR4o75+j+C78cMrlguQGFkz3RCBE
	oGcSMmXRdEuny4spCaPdeUhrcVJomccq5U31diUq7aRgn3IdyqmyMUONPgbefzi+H+dO61flzn4
	noNAFidYQWNWDzvJXzhK/9mOYgOG0NUltqDeGSjn/RCHkIeCabLXQsQcsE5w+hQCmJcmnP3WQxV
	KZStXARq14ev7WNkGr1RlnTdIEU8Uz1G0gshsB5hOE9OlxC5xhy7gNO2lsJYuN02qfYwe17O565
	2jNL5A2aCtF
X-Received: by 2002:a05:600c:1c22:b0:483:b2a8:33ff with SMTP id 5b1f17b1804b1-483c9bb1d21mr260809065e9.4.1772488720068;
        Mon, 02 Mar 2026 13:58:40 -0800 (PST)
Received: from [192.168.1.3] (p5b2b433d.dip0.t-ipconnect.de. [91.43.67.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485125e845fsm4942785e9.1.2026.03.02.13.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 13:58:39 -0800 (PST)
Message-ID: <923892c0-8b6b-4e5a-a3ee-4b8cdb5a9674@googlemail.com>
Date: Mon, 2 Mar 2026 22:58:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/684] 6.6.128-rc2 review
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
References: <20260302160934.2521545-1-sashal@kernel.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260302160934.2521545-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 131AB1E6010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222731-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,peters-netzplatz.de:url,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Action: no action

Am 02.03.2026 um 17:09 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.6.128 release.
> There are 684 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found. I 
didn't observe any issues with poweroff on this machine (it has an onboard ASpeed AST2300 VGA chip).

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

