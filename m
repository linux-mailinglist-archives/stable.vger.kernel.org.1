Return-Path: <stable+bounces-229971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJjNHFRzwWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:07:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1072F9783
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3ACE23039D18
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717C83BE63D;
	Mon, 23 Mar 2026 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CLWKeSYv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCC3C1403
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283979; cv=none; b=kzZdDxZBdqe54EYau9BYbn5lLqlzSMaO+PUziWmbcBDFdYSe26wl1KXyUguJhrIMrD6yYsLeZxZuQiO4U3eD9jRq/S9BXpoHTQv9VhwxETGyLwDpRvXhmWB30tDBEdwcjg+XFIv1qKMcfJ4dRynhz0tDU6+k2hTdcVPpVS97yHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283979; c=relaxed/simple;
	bh=hpomdIyEmcLoNEW+bhzA7cXmRz2UPLKT5/32f1yhUgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4Yk3XCOmC3UdB2490w+8lcyxXORlvUu5Ybx4kTB6ACsBQlgXBE5nigEVJp38WLk5o7c8fK9xg468V2CAN1S/SnN/iX1ClYtmeniJtHmFf5VMK3jDECDfU9lRQTP+3yco+4Tbt9kIO70Ez0VwSUeeQb/rYOQaHqCT75M0h9joqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CLWKeSYv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b7ff8fe92so213756f8f.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1774283976; x=1774888776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5Zcfh2OwyV8FCOamDdeLKjIsk6HQadA+491pqNHkzk=;
        b=CLWKeSYvBamKsGFuJAnidAlGVRepq0L2KhxrYLsso145+CR32l9D9lY2zbnWAQQg28
         BixcwN3LzKikyik2NpKHP9+vyzQpRxmaWaXKKpegQw1Jkkq6/wbqCAZACmWEH6OlQIqS
         4dbc3H7GXEfYJ3AQ7tHHURD5/MZ0dW0hX7GltMqRPIrhgIbF+EXP7e3XD9pW3sUGfAIz
         C3SxFM9XxdB+5S8A6oDLEs8Vl+NIf1CYylKk1rIjA+wZ+EABRnZAuo9bobELQs+Ai79f
         BgC4G4laOFhsPwj+3sxmTWxaqcyaRDHVVL6SUfwrl1JGTCgjcsqXaB3XQ2tjhayzOet6
         5M3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774283976; x=1774888776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5Zcfh2OwyV8FCOamDdeLKjIsk6HQadA+491pqNHkzk=;
        b=IPXJlLpiLgMwTXmDJYzVir6kASit55eTrSEusQah3H536b0nKFTuG3Z5YYpWscHvse
         T1KCPvwekIKQU7wEx+OKgwT0qISh4PyyoTc19JgU1YXHU9LJ6De5IjXTC0K+3pfGVATf
         bZnsdahU9ORk56ECqHo7hII/jQt4ZUuxMddrCo5h87Bu5nz+GMHGss9aPi4bmASYKCoN
         sTCxUJ72wywZkfDaGyD9GUBFrI6zz1SN+LUz/NUohBLChEw1RslJe/626gEwhUVc+98I
         p914Ic9c3G9wtcJI9hnvDrx8fADK8E+HhUQhyH9nbpwGKNMBAPCsv26VX6SIDTfrNKu7
         kY6A==
X-Forwarded-Encrypted: i=1; AJvYcCW+mRElSiIkBCGVv+Z5Qds4sjz0iS9DtAmWBn0b8Lokimj5qEIDFYkpTDdMApxft/LVlDE3V+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjodL3KGYcAGHGwqcK8A7k+P/zmPZBds9ARPb7wkSf/LWxmkJ
	pTtiev6mE1N+fEP83iffyu0L96JPc7eBHTgwOu50sKE4rmCNR2i5dm4=
X-Gm-Gg: ATEYQzwaNUBIeKsNNhRfJ5OmA2OQNAZ/O9UOdSyxt7zFHTmWz2uI9eirHDby5HC/PT3
	2oQu1aGRx2gkFLZfHyRPJsYYUfXawu0U9O97cRDzrnaiK6vc7kJmAexeRR/jsmKyivZcLs4fALI
	W2sOHw/KOnE6V5OOoyt/89VKxQoVTjP2FpGNs/s0W9htN5nBGJ7BpfFfROpOElTkbhPhf8j3bBN
	44V/xGV8wfEqj8ejoEv17dZdRVcQ2MJxbprlFFs21YbI+jdYsBIsp705mIwRQpoj8YnMpHP9rB1
	s+WppAq2AaisvlR3V1hj2DxaX6tCK8CNyJUfv8MnUQVSJ005klSiWZayq9fViPb4PJjajj8tEdh
	YbOyvP14WmmsNe+JuZ5/rtNiCpTkmQIdO6GN2+dehUJNkXIM4LloUX0EcficGj3Wm//WeCmStMM
	NtYcaIvr7rsxR/mSL2xbe4cSxo9Yqj3WIzVls6SlQEbju5/JAhXCLKA1cDZpjlxCgkdYR2r5zyD
	g==
X-Received: by 2002:a05:6000:290d:b0:43b:4757:cc5 with SMTP id ffacd0b85a97d-43b6424bae2mr20507702f8f.19.1774283975494;
        Mon, 23 Mar 2026 09:39:35 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b444d.dip0.t-ipconnect.de. [91.43.68.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714e2esm33046860f8f.32.2026.03.23.09.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 09:39:35 -0700 (PDT)
Message-ID: <d3bc6886-012c-439f-a5d4-82f2d67f41cc@googlemail.com>
Date: Mon, 23 Mar 2026 17:39:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/481] 6.1.167-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260323134525.256603107@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-229971-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1A1072F9783
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 23.03.2026 um 14:39 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.167 release.
> There are 481 patches in this series, all will be posted as a response
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

