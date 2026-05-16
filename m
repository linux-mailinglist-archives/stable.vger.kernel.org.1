Return-Path: <stable+bounces-249042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p5EVOgPhCGqE9gMAu9opvQ
	(envelope-from <stable+bounces-249042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 23:26:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5354355DE5A
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 23:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 991823011799
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F237DEB2;
	Sat, 16 May 2026 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BCDGmSn2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055037646B
	for <stable@vger.kernel.org>; Sat, 16 May 2026 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778966784; cv=none; b=XPApMOKNRdHruayyanmTx5ycQ7F/QOtkUhRTOowaXDqG8QtBUOG2EhBJBAvK6Ymb1Tpz1dgUHVon05Fc3ecRfB054TDRfuPVbJVhr4z+OZUdieZ4dGTtg3QpMEQGGmr6EFPhtYm65y2vxdzT6GyLnzALBgBSMNF5f0IOuD/h1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778966784; c=relaxed/simple;
	bh=DZi5scrotk+VzCgoggHRCvfMYji/o7bbV7H6h77ID3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXt6yvcngOzGQF+4xho/0NlizkG/Bk1EQiKgYNDLs/sHttdNDN6dX9A5qsePqWJE5DdzKE2q2jdgtJZT5f6+kWQAfoWNl8IzcHQXzSAvhgIb+55C1urjnKeQajUw63tvg1xEZsL++y9IEQoLaU6h83rK6osgAIqumXYjhKDfRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BCDGmSn2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-448528f4e69so506216f8f.3
        for <stable@vger.kernel.org>; Sat, 16 May 2026 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778966781; x=1779571581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5swWv+ewNOWZXjeGYieof7efRBZ0EKwIg5DXna6RSk=;
        b=BCDGmSn2YUiUeAz7L6dIuQy1TTA/xR/tYJrZyb8zNussNRax/ol9edwUF7pq8qWuNi
         vcm6hNMDggAVvyaEvuT5yjjagmetIVOQwe6IlHvmy21/knmEvbwFnzEsb7hjOTpIvv0H
         p76TPlph7EMOnk4sa2H6dOnpr0U3ALbVqxMwT9vbgn9OqRT3BAnNZ/zXZHEr5XBn6OBV
         A5iXUDtaWiDSeqwbu3vzBCXSklYgxCtmW2U8pLlXBYcofFtgiBlYrgjd3IP/gTzSRLB0
         e11hGPFJJutkoFbirEyoMUovSPosfovV/4gx/qc1AGwKK1M5fLjDJAhSsaq9fqshxOn0
         /QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778966781; x=1779571581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5swWv+ewNOWZXjeGYieof7efRBZ0EKwIg5DXna6RSk=;
        b=CmOI3OWaOMWfPM+si7+UGFaOpxHze+9LHlPBcPetZH/sB1VEVOHkn/ESoA5hw51T19
         LgdsDddsMeO21aVwJAKEPNdiu2r5rr/15KhwLTBfHAddL7wvwGiFFAi1E9+WUoqyOeIh
         vBMmAulDaZwVgDinZ0koEPXDlm3NMWpFnwGZCnNDyqNCQ8+7MYdFxEoMarkRj+irO3wq
         4XT7Zhx1R0j3fJhC6RhOudgobxwiItXCcE6nivLr0GdSXo0CZ/XRkfxLZBX72NIDFk2D
         tipugXT+AIDACFhtMNw0TTr/DlIOOdKEhGwtoShbmiJaS8H0TlG6fF9/SGJFJ6Kr3jgq
         gfug==
X-Forwarded-Encrypted: i=1; AFNElJ+sjJq/0dXlAsFeyOQexo/GYb1ifSYDW7pjz4JSC6Fl4AlyGz/YkfzeLD0YP8q/WTrr70Yq1oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymTTNYB0+KRjShWyB0iG3mMFKdoc98QJO098kM0z2SROKysChr
	4tSGJMwnQF26OP2kovjA+UT5babZcVjsyfOXGqJXqUKd/zjA/ThF0aI=
X-Gm-Gg: Acq92OFsypfedXzqYaCA8PJfCcAvQ7fOa/9RVdGCMVvqtpxTR49/CbrPg3dTPOFyZoE
	tGYKbnGHbnfL5VlUTzHLY0+WFXF3+BNQRapOYqVu478iyvqpM8UOp3M5Pkx/PBbP6ulqWGm60Wv
	hnTjoymwkWzgxxpkQwqEavl3PDEiafbM0M/cQLpei8QFluQCJpinqtpO4hJGy5ouDuqgm4GZNBf
	f5xjN3TCwyFtsKMq9Xsc7B0dxZ51NqEy8Ywi8XHRhfIkOrdvpH+sufGqBWMip2IDj2/IMDh+fLk
	zbG+FFiM/XdnVmlAfPAK9Uyb9CSSfoo/JFS7FLxaEWLQ/5tiZXBWYftn7GmYZjSyfYNS82jhZRP
	U9PEMjlMUmHvaCmayQkDjrFgCym5Ogmuah3sKFvBVvP8WVOCjMNpkor5kRAANw84z8WizjwZW0e
	8zFpj3FPp67O5YF4CjVgw/8rhF6iZ9DCwyx6QKire69wOrPxgH8r/pjWAr3NvmeLSxbNdpP+ikV
	eE=
X-Received: by 2002:a05:6000:24c5:b0:43f:dd40:bbc8 with SMTP id ffacd0b85a97d-45e5c5bf9c9mr14343287f8f.24.1778966780739;
        Sat, 16 May 2026 14:26:20 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4b92.dip0.t-ipconnect.de. [91.43.75.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17a22sm25852485f8f.22.2026.05.16.14.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 14:26:20 -0700 (PDT)
Message-ID: <9ce16528-b20a-4241-a607-3f891cc4ae2a@googlemail.com>
Date: Sat, 16 May 2026 23:26:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/143] 6.12.90-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260516102210.570453769@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260516102210.570453769@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5354355DE5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249042-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url,mailvelope.com:url]
X-Rspamd-Action: no action

Am 16.05.2026 um 12:30 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.90 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found. And 
this time, I have tested with both CONFIG_SCHED_CLASS_EXT=y and CONFIG_SCHED_CLASS_EXT not set.

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

