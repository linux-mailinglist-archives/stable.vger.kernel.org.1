Return-Path: <stable+bounces-215556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bEWLFUZFimlaJAAAu9opvQ
	(envelope-from <stable+bounces-215556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 21:36:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9840E1147BE
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 21:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 394CE301C167
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 20:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876B22D5C8E;
	Mon,  9 Feb 2026 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LEil2U9m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A72D8364
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770669379; cv=none; b=oW6GvT9qIbc6av/zHE5gNol7pLZq8pV+NaF0PMpvL4OYaaGYkw9RgqMiqgueTifOygCYlWUxWAutrt6FRuNcoHy5ktxap+TzIgF4h7szg9on2si7n9YBmwit2exoP8rESC+dA2lDoC5cFJ5qB8cyQVExlIXdny2Yeh14oAvkjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770669379; c=relaxed/simple;
	bh=G5yAthuLMlj5VcCwLatzjyaRHf58IhoSZgi7XXRpJHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6cbWtnxHBMWiAKcxBJZLazA9AnbmfF7dPG/OL/f8gzI47Ph4bNsPp81tv8/IsG709KwZPgalbQygTt+9ju3ZKGwFbrk9xThePnWu51wXcLZyR7woe/kCzlwG7S/8tqPj7DGa2AD/RGTk8MQnd7Nzr3rjcAXjNOgNzDrlL5HcQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LEil2U9m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so1422785e9.2
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 12:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770669376; x=1771274176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xp5mIgo85m3cPl5hAY6Tpwi0IhuWF4UQl9PiK/lWB3s=;
        b=LEil2U9mnhQ1icOIAK73O/30ISqMQClPjDxpqvhSgXsGdypQHhQfvqObPsDanlZcgC
         IfpZDD2QoMmvnD021VSNFdIN2iBXkPDM2azHkCLIlH9zwwOhQPrmGchTY4NlndbC6bB2
         gGJpHlh1T9gsGDrRf5aQh1IA5VC0v+e5hn0UW/aHHC5hSUmqHWAz3mI/wVmA9x1KKbNg
         l3juWE4DuTW9SW4DBsqxNXUMSpT/nsgr7MRGQ4yT7PZoTaLDtnZzGdZYm5GPp9q6sDKi
         cHQ97zh3yey7O6N3+1KQ2KekCN/g5g8cIrmOZpS2xQqPRBst/Yvgbo/ZGeRzzOvg63Rw
         TlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770669376; x=1771274176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp5mIgo85m3cPl5hAY6Tpwi0IhuWF4UQl9PiK/lWB3s=;
        b=iSP0fJvyhjaYWypghkjZt6bJMEkWPMgzX9tOBPY3QXqL6Sve1ueNl1WoaA+QAtcTLN
         SAfZvqMprZdXZR/x/Sz+N2V0Aus6PabtKBMpWDr/rQGpUJ4Qv7NXXULbBKck1dm7nV8R
         GN1tSBhz61+/PU3VmDS6tImChJpIoos7NPyHSoBHh5IXvQ+revKa/vUo4uQi9LIESy0/
         RLG0uLpZ/vd/CqGkTgl3/OWGG4rvtzpm47WhtdV5vXzkKMCKfNObes1YmzLlsDRR7yDi
         xirpUhLMwT3Qf392vxVbeyuh9wPPp81GyiF7VNJG1/ZWcGKf1RTDEuc6X1xDSo0yBT5R
         Y59Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBwGcKbggF0rDJIjnNtV8tdXK8l5K96B1+qc6IJPWmWxC2QJn1+FqFBhj2d7ntTl8TOiZ6v5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKSPRidp8kM6urmTU2AJ+1ctGbYtyYw5Zy+yaa3o5kSxH9tfT
	TLUFEkNIX1yE/8DpZmnU1XiP5XXi9THH+6TJI/8nJkFJ8LAi5CoV4ug=
X-Gm-Gg: AZuq6aKFVW0Ls5hVZZNFj09fkGZCplfA0IUHoLw2ualz7Wc9eepxO7nGYvsbGHit1Lg
	xUtzLhahL8qLiQdDAUOTznp8t98+QlqiKMVW9BhqyKvpisXHiUzeoRBglYmNGfnY1SoGxWaSbPI
	D17lAm11Mge0ysLyohk23jkNniKWg3mPCKJrsa1LAxA0lmxpJmjmTkMQhpUFvezA3NRagq6VTfs
	j4QzlXKjsU6ZsjUW7JvErLBvLIH+n3ynHWGpuYfYyi9BRcBsFpce+dqlK9n6rqwoLDRrlLPNhUw
	Hd8+bfPy2ny4JDyL4Rm/u9V/iLl6e6VtNjBmp/Lv6OcSNE8Ci0xZBxq/BsqT+iEfyF7giZPKL7p
	9UiSJ1BdtZXN3MbrsJYmaYJ8m4L2H5/PCh7XLR7kqFvH7EnCmoo9aooapNnIs9EnK+/+npFwOyB
	B6juNvicTWTxvKt3apYOlxBIH6hcVVN4JoG0tQfiKmogMG/+LapoWlILlogW1u018ssImZtvXwt
	A==
X-Received: by 2002:a05:600c:c05a:b0:483:456a:514b with SMTP id 5b1f17b1804b1-483456a51dbmr36417475e9.12.1770669376163;
        Mon, 09 Feb 2026 12:36:16 -0800 (PST)
Received: from [192.168.1.3] (p5b2b41e3.dip0.t-ipconnect.de. [91.43.65.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c12d74sm179764475e9.2.2026.02.09.12.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 12:36:15 -0800 (PST)
Message-ID: <8fdd9182-1aeb-43c6-ae90-3452f1a69722@googlemail.com>
Date: Mon, 9 Feb 2026 21:36:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/113] 6.12.70-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260209142310.204833231@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215556-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,peters-netzplatz.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: 9840E1147BE
X-Rspamd-Action: no action

Am 09.02.2026 um 15:22 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.70 release.
> There are 113 patches in this series, all will be posted as a response
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

