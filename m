Return-Path: <stable+bounces-243893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EYsK1zf+GmU2gIAu9opvQ
	(envelope-from <stable+bounces-243893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 20:03:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFE14C2483
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 20:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07CCD301D971
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 18:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9183E51D5;
	Mon,  4 May 2026 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgakPb7t"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4C3E0C4A
	for <stable@vger.kernel.org>; Mon,  4 May 2026 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917774; cv=none; b=Nv5CwigknHBxRbA0uUWvqTPw+6NCLALrr/ke92psfw7o2j1WPqhy/E0G6ODG/xsj5hvpX/utrz4aDY1hvWCxklmm9WFQs4lpjlerlnRimU58MAntSVPOz94KMMpCK1zSU8PH0ER8RmSy6vFoTIXfjDLanTd0VigQPvJ8Vh0+8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917774; c=relaxed/simple;
	bh=b+6/rGO6hGfP2yHssh0BZSHnfmh6bMHtEyKCdstr0FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFk4njgOiBNwYReIEygtf3JBV5biWBgdBKkZbPfHT/xEM/iOozwIHB2CP7em4s3lfzari41uvCkY5Lve5Tc4MYHH99tMUvl6d25XR76CX0SxWyaOgSk9dexiMx597lSxvm4a+P0KwdKVadvCkfz+H+R70D7tGM1v4X+Cs2ZB0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgakPb7t; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so1448312eec.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777917772; x=1778522572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wu2ryVmmLae1CpmhJm2xyX8P/Bqv42shsFrJAWP/0s=;
        b=XgakPb7tVqK/qcBY7i3ezJawWdv1Z1w1EKJPTg9zZY8Q4b42J2lFS7Qziuu0QigLZI
         a3hdXGYa7M1B1xIX9RFAeYgcy0xqNzhnC7eIIresqVAwDZ1jgB7NP/ZkL6fxhus8f3Vt
         S58tfvcshX2pvg6uVWth6dlqY2oAVxSYH9dLAAdYxhQ2frPMAAyBtWLZF3rKAAIx/Sj4
         GTp4qvfvffY6bIBVrQqpcD3PZYdfAKVbUj5g/q4/vOIUriSnL5WjFeFbhq6TbKH4nLPR
         2n6dOBJLpY2hk/w4BCn49Lz2L2qE66kp1EjHpk7j/aVRGZOAOxudAN9KLyiBsZZ+YBO0
         ZQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777917772; x=1778522572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wu2ryVmmLae1CpmhJm2xyX8P/Bqv42shsFrJAWP/0s=;
        b=ITB3K7hwj54QFmvSO7eT1aV3zUsYMj4hKP7vRzjNFpPzvxkhPBxTS+utnT+PmP14zO
         qbZ5mZrWj0t+lBuYWCr9Jw4eo03jKbpGBTBc90GIsqDyZbZkMGGw5NtMqXVvdZoRmqis
         o3mgz/VN9is9CsYAVsCH7t1j9RwtBoULrzoy+ATwLnGqYbvlNhrhFP+8CArNQDxe8elb
         nd4ZsiipWDgPu8/gEmZK4cGGqeZ2FSp3BGKK/X6IEbU5QvY7tVQGEAzoR/MM91wmjAqf
         jqdSFIEMlNAGYD9FnRwkKzf59gaWcbzxNzbCbNVwUYQTRJZcI95T8B4u456TQVhYQSm7
         aeIw==
X-Forwarded-Encrypted: i=1; AFNElJ9ApL8neCT7fd3McK5/8E7cJOgAXVQfhUh2YM3jdyN5ogMt9eEgLZ7I+fb7EaKeFZk1LkiOccM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFDK4SKDHBfqmkcsDisTZveKj2IYSXXDopM1urOxs0d9kKWYpL
	ogDa1Ga1Xo8Chi6iDG68t6yQKibGrRgG+sJKy4VD59S5ieiE4bmLfIgM
X-Gm-Gg: AeBDiet1VfmNB2PlRzN99MUu7Y+QvQWwjTvvXVkOrY7h9/X2HSzFpKNu3HabwJJ/85v
	pKyFzv7yCjE0uEpKKVl2ZtbYfV3hnIaW41IuwEgaC36m6CTRbtE9CahH/ycY/rn/twV/Pwq4rJy
	7nz416UY9wgEIGc/9nPxEs6hrcTe3QWRqIKv2565K+IsGuD5M+f6ikh/DtRX9AgObTQqVx5qhNG
	X/A+DAMFArhRKaNV9Am1uGF7jKVTuxDj8r6uAZrHwUqzBi1HGAyDffnSCNS2gXtI7A75HzaYv6O
	bNyNuX6pLMGkeydrZKPjSjxfi0wfh9DPtyRho3iJLKRaDqX4BhVzsiaONzP9RBJH5rE2jtdiJGh
	u99IFVeT/fzfvP0eHCu5B9BeliDP8/EGbDyoyqUAPuYfFhVOMGQV7+yJSzXhhbpjqdCxCMRCgGx
	2CZteIXz/HRLCD8C/B5KlA8NfbMfRn4bXzSS44Hm4NzK+W4ZlOizMI4KUXwnMONJungT2YuLQ=
X-Received: by 2002:a05:7300:2d09:b0:2da:10f0:a8de with SMTP id 5a478bee46e88-2efb91b393emr5186705eec.8.1777917772145;
        Mon, 04 May 2026 11:02:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm16993427eec.4.2026.05.04.11.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 11:02:51 -0700 (PDT)
Message-ID: <14a1466e-688b-49e7-bbd1-8d1a87e1bf99@gmail.com>
Date: Mon, 4 May 2026 11:02:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/215] 6.12.86-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260504135130.169210693@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2AFE14C2483
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243893-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 5/4/26 06:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.86 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 May 2026 13:50:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.86-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

