Return-Path: <stable+bounces-85085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747C699DD27
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 06:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9D0283778
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 04:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4862172BD5;
	Tue, 15 Oct 2024 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CROmfgCN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD04171E73;
	Tue, 15 Oct 2024 04:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728966153; cv=none; b=Bdo7fMdjopAA3g8IyHhEj0IxFCYUeAbtl7BTBKoHSx2Xp3MNT6Q9jCGw4dpTnBEtSCJm+CIYW0Ox9Wn1Veqczg40JSi4il1BosB77C6K2LuBzdbL2k6xTqmWmL4uQAEddcATtvLQ+sn3f1NPrXIFKXwYt17eV1DNsbJUwSq4dbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728966153; c=relaxed/simple;
	bh=61KFHvrvvfdW/zqcDP4tjMM0jeXhHyPuStkPQ6pN79I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvGgqDfn2N5FYg9FS3JKiaA32kro244rWtpO13vDQQqD5miVkeEB6u66Y8buvvP/HYpccu3NsBztzWZ3qYqqV2hnywf6bhptdyOlB7KuAiXmys7o4tn7UFza8uo5fD4Nhu1tPxYpa+DEOy0M6X0JS7wig0HEAcbg8JNTU5vT6nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CROmfgCN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so57830965e9.3;
        Mon, 14 Oct 2024 21:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728966150; x=1729570950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITw4CfbIcKJl5WiKfCPeay4AHZuW/oKHqtGIMSVy204=;
        b=CROmfgCNtQJ+jKSojYf2JqHSmtMKOo3mD7kjtPaDtMFCxpDjf2VyKkxdkOCrRvoa8f
         56/3KZlKJdsn9kg0zzQ4IcZHI/uovOjtLUGNJbaaGX4g/66G+w8UmuZuOSIkE9v8wBQo
         nzsgnAQNt8x9SQqzS4gc0L8Lzu0RtUVWiE2EnoJ0iLfl/jMM2fxTyrKNXvA3ugPUBwgc
         A3RQyG7WxhbLYgkMleyY5/UqEByQ8nQy4J98xTzmNtQJMnw/NP+/xqbMtmaCvac1p5c8
         0rV7fe6ylXI3YZiYldm/UE7F2uKYSNdwOQb+TljriMslpQaAwRecfU3gKy8Bwf1QqBRp
         VQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728966150; x=1729570950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITw4CfbIcKJl5WiKfCPeay4AHZuW/oKHqtGIMSVy204=;
        b=HJTeXX1FOGMDIS1Pbf9vWu33r+8iLYojKzCpzAxxwnI/3YHXKF8hX44zUtnS1vsGaN
         Qn9iauDfFKKbyitSV/TRL5/F0CkDhTOSWN770rqSMUW1eZeEj1N4ieOB3NvGHYg/uBfL
         BYOZiJXD2/jkswamhwGBjxeHNg8O6HdsG69epGx7xjtAAKEmaLTcCfRwQs4DLDozn39i
         lB1Gilp+lr1j5NAyUab3+Pavy/DwzH8YKvifvZo2VSxfzfJAza5QUsnnx+Vp6cj/Irwb
         oVLqG1A/HFWA7MjVCq2gZ/dB9YXxKR9bBAAqHX/A7hbU31yHQ/Munw+21A8LS2fHfH/y
         wpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8paKG/e3BIZ6ERVPAxcMwTEiJ/Vfg1L8yhqLDJRbcp5J6QYbPzL6y7b91V1Mxelw/TGHY84g4WY+GYmY=@vger.kernel.org, AJvYcCW+pxzK/i+IhYGrYCsEaaBqtbBHVg4I+Xlrg7Gx5ZdsQq6MaBOr2fGSn4U9s57TkKlYAf/JkRrB@vger.kernel.org
X-Gm-Message-State: AOJu0YxLv0CGVz5ACcfO+iBNQWV9oEmolIZFMPMHBjCKCIWowX1jCb+S
	LGfmLGQwb73snV/HDXYZ+8QvIxDNmAFsQQFh2gKlxBuMrafi7vA=
X-Google-Smtp-Source: AGHT+IEBV+mIguXbxqTL842Ev83rmJsOnrUq23Q4t56ITsC8zwy3n83uQmYy1f+nZWdQZj41O3ZG0A==
X-Received: by 2002:a05:600c:3b8e:b0:431:24c3:dbaa with SMTP id 5b1f17b1804b1-431255cea47mr104986945e9.2.1728966150110;
        Mon, 14 Oct 2024 21:22:30 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4546.dip0.t-ipconnect.de. [91.43.69.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f5698casm5533395e9.14.2024.10.14.21.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 21:22:29 -0700 (PDT)
Message-ID: <ce75d067-08ed-456d-ba57-60b7a595b7fc@googlemail.com>
Date: Tue, 15 Oct 2024 06:22:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/213] 6.6.57-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241014141042.954319779@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.10.2024 um 16:18 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.57 release.
> There are 213 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

