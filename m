Return-Path: <stable+bounces-215685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB4THDdpi2k1UQAAu9opvQ
	(envelope-from <stable+bounces-215685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 18:21:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C5711DD2A
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 18:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D143305244D
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B7A3816FA;
	Tue, 10 Feb 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh3SftyH"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901C22154B
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744100; cv=none; b=LODvUCAbAtYQJ+QY5ZZuk3hfiLd01UhHUfP7Cyy/39NJLWjT0EvbRVuAyEwBFk7HjxOg1FMYsoUulCI24wonbb6JYiWyR9hNF80iGS2OwJ1vfU1/a0ZToX3cyRvuWjgD9li02aFw1pjnwSvwfzjeskPMqHyFVVVrivcSlj+INAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744100; c=relaxed/simple;
	bh=Fchyxwe1YCStwrCTGj0/89DFgWyZkWddoy+Il0hGT90=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bjMouHFAvsFqMQNfDTSbFwrXxlevbsTgUhNjnOgvhwwV9J+3rqJT1F5J76TBLBc/orf5/NNpdaA51gydE7zhh4RphRMRVVrOP86R8PDV6KSPIhn7jkkn/Z5AZ7DYkrFdZPV+y6PugH/spcrjjfnrU6hqugf49mLH2ARjKf1Kmh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh3SftyH; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba68df3687so4223420eec.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 09:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770744097; x=1771348897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tnmAkUpXUH0Ee5kDeEWiVscqxpkfBtmb3REZzA8njk8=;
        b=jh3SftyHFoBb+wSi+wZRqFWjtYXAGhnRNsrcqs0AUgynMig0CS5jMUuucu3xD4aedt
         Q2tJC3krcEh+Xs700quYtXkdzLAaa9+w/khn9izO2YcpNRERpdw55RC4z/IUNnXYH0Yd
         61g5zBUBVbkPRRD11plSvneiwyFM7FVEixuNupOkobrHjSpguELVS6V+bwUMheklf6yC
         Ist3EgkWoXswvnZtxYJItueReDJo92W7pB/6uH1lZyJZQ7/RE6qJe+SCzjVeCx4Yejwa
         ny6L+p6NMAX3bFF1bQtn+PV8bZUSvkYvhGcqXxmUxUCbWsV/DloEGmdkH9lUGrbki80P
         TFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770744097; x=1771348897;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnmAkUpXUH0Ee5kDeEWiVscqxpkfBtmb3REZzA8njk8=;
        b=QzOqlSdKATDUz/33gTyBZdfqowBN9X9lCr1VZH1q0zgXpm0I/sYMae6p4auTxdYAnK
         SZIGwOAyuMhhnFub2jxkQJBDFVsnm2A8tazsCv5vj+QinqGtFJAMm4ilCHHuKgtu3YXU
         P95g0yccnYVNvrDCiPQwoTmFmHMZdri2ZyW0PRk30tOV1L80GYQCgt78F8xM2g2K1HED
         vl5lzg6I68+k4iu8gOTxoZjEuBznrDkKmb0gAzhcggsJ2xdrpBYwnoekv+s93Q+gfUpj
         k1VjrypSEQyQGWawY48iLcdgTguOB/LLXAfaX4Xx/fpnqQrbArCrshWQWj/6OKdr4hUc
         UoQA==
X-Forwarded-Encrypted: i=1; AJvYcCWfUG5ILuOrZnk1DjLzLDG7l0uC/yJV31A17bXc4L6O4oVDkHNUjQaFPldzu4t9Nr/Y20AUeWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6xiOHU4uGkIloRU4YPXb1ARKzSQKq47FMVI+ncw9xjZn3If7
	KNZvZwTMvquE18IotSCcvkCY9WfLeKCK26+VF8CEVJ36A5n7uFuGPHIb
X-Gm-Gg: AZuq6aKjP+Ata+XEWCrzxtPZj5WAoo5kwzYjOObn0JcZKJXNXfgAAIs189LEbjvKarm
	PdDcQtmkKiD6+sED3gEEtmxi8MyKxsYKnfeOwRivgUdfirseU3ygF2I1JCxeaFxdr4aMz0gmnbn
	/W8063AQ+EgghhZB1/kvkvCBCARKPMZ1X9/n0R8byvcfrkxnuzZSdt1qzA2vg5ugzlLMJ0K/5sJ
	TqvY+j+23quuP3jY4RQF2JySiL2QcvSd7vkZEOAs37czi0o4S7Ok2S8nGjfQgQgwxKklbqFYA/J
	j6Di8vfuTPoLa2xkEkkSyHOwesLOLYdkKtA3AoZ7iN7YuWEiKbe3Uy2ZK2CdpbiaoS3LNE+6YHz
	fYVavTGcWOZyPciOkg0gEQyj4Pmva84ODQqf2tnYHfZTvst2PTqMifZ3i8TQAx7N4WaVvqTcwwD
	MqO0P5G+h0DVHVQwaEMB3cXB5/lCPX05DppdewtefZXIukiysLeOg7zpRmjvEW
X-Received: by 2002:a05:693c:2d8c:b0:2b7:1c58:dca6 with SMTP id 5a478bee46e88-2b85646d9c4mr8668019eec.6.1770744097312;
        Tue, 10 Feb 2026 09:21:37 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12717d89610sm6302360c88.16.2026.02.10.09.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 09:21:36 -0800 (PST)
Message-ID: <b461f583-bd3e-4ad5-bc4b-dbc5f014ff8b@gmail.com>
Date: Tue, 10 Feb 2026 09:21:34 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.18 000/175] 6.18.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260209142320.474120190@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215685-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02C5711DD2A
X-Rspamd-Action: no action



On 2/9/2026 6:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.10 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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


