Return-Path: <stable+bounces-222674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEfaCZPYpWmuHQAAu9opvQ
	(envelope-from <stable+bounces-222674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:36:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5891DE6CB
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 227213003BC1
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 18:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0634F48C;
	Mon,  2 Mar 2026 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpnGiUDf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B34337BA6
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476551; cv=none; b=HLRGp1UF7hp0Jskbb5CE8EhLf2Z/mJXG/Onn/6WvB2Ma/WFzzm7JBj30Zb7JM9qgzolub+BP2LM1OyK/LAtlqg5BVw7vaBj6OJ4rCxuz1SkXS8OpcMZJFZzG+UTA70xP0PXWdPgu+4+PpM2RV6YdWDDoK0cRN3MeagjcabEXxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476551; c=relaxed/simple;
	bh=2GOT22Az5eN2ZgabxgUYSIFjxuWVaCdnROj8IMw8bGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lX8Z0Y1MgAs3em0AJIavMN+SYyQiuXQC4i9jptfZU5C3AX7xCX0sOXwdNUefAm43xMo6FRLV8TlJg7k8TJXEzaBxaWdrjNJNB9SJ1tUxkrl0gekbRGal4MvZJ2FWrjLRnfElI/UYDrl2hiAvr5+X3BedEGo9WpncafBqKIiPC9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpnGiUDf; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5069df1d711so42518741cf.2
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 10:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772476548; x=1773081348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quSkEi1mQq0UcBslufuyU8hzVY2CrrAMv3rCqHOKUos=;
        b=lpnGiUDfuGqEj8jojKl1bIID6ANpwCxvLbU6p+jKlghN7pvRAknH3NfhTJnAhgxYd6
         6HNFUBSVyIgJ9+noPNUknUrul7i2rnpQN8MGk6L2CcnLk0JIsDKnb1yF4xMPKaIw3OpG
         AtTCn/gFQpuyjonCMr80OVeBqqhHTtPCQcI06GGr+SUsMPYHmH0VUWdjPOpu9FHRUrgv
         MsRjKlJyf0Yjja3RxEFXeUdJQ6vZOazLX5Qk1fnCdyk5Ulw3Dhul330Cd5li0gY6nsX0
         63VM8IrlIyLGr/1RceLBsq8CwKkowVWgHg1VK0kJBvYs6ziUgI39A6bgudrFKHJFkvsl
         iS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772476548; x=1773081348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quSkEi1mQq0UcBslufuyU8hzVY2CrrAMv3rCqHOKUos=;
        b=Ycwl8+sTGaOA9V46K+JEpKKSIiEWsOUCoKiM31JpWhwSzKPL175ZphZXrqXQL7Hv20
         5UMuwhaNvnTjEfOjbSv+CDs9J/QSyFQA+fDTiRCJji29oGNggV6CH/EYDQ7ai2wu22UO
         ZIT0eU0Q7Ta7w42355mQYtdiyHs3MopuR0kSzEqHzSJM0vxLrY/5bRXcgrRtB9k7v2Uk
         GW5PXFcciV2FlBV0E9emP6pmvQgh/f8WScfXJ7a3IRe8963YkZVxX1Ww30Vd/VXJtQWJ
         NwToX7dgii+VI8B2kw48OXU9ksVzSHPAtrn/0SpSBNNV/lMWqPsDVrAcCW/NBMHxCVlr
         t7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVMqUoAZtiTzLaQZOLOQvnAWo7Udqc2afnkgghNAaQpwe0SHpR7TF/+jRee+ixxUj5t8VhPzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eF7ESSSzpmzl4Cf78Kj4xlCt//DPe4KDPpBbdvk4PlqDDEY+
	uecMXT9Ar3x4Zj2GgKlDqvIuLMMQ1VktJFQAVNCqOkNHBAWz8KZSVD5K
X-Gm-Gg: ATEYQzxE2d17BQSiwyg+SClZn1pkqhMC4TLSg/IWBd/Xud6gv+QY8w5usFJSAyklOvu
	aADg1ctIog34TseQLOVtCL6WU2t2DLr+tvXd6KAPqbaGqwsr6JytJeTt+w14M3B6RriOlcSEeMf
	Vyit9S50N32x7aOeFp18/ubYylwfpHI6BUBVLhv1tctb1kLVvMbNROb1nucIMx95wgyDB0WEGwb
	yRglIJF/Yx49//X97oR6ky3Tfqk0DK48rQhnbvTBwdaPP7ZJQ3/Mbnf1eu24yivvv+ORJ0j9a/R
	ZbQliS/xbJX6Xu87ba5Bv9Qyr8KmT65OR9UBe8RrZDTWQen+6OZpkr5jatYnrAmR3OiDOnQC+XN
	y9tIQf2il6e8bJ8jvfPmGKH5Da4dXgEO2tcJZ9c7ko0SKC9bifIhMjrD80Ea8xY6P0aP+sW52Qv
	2EN/Xgdw1XZ6y+rMSd42JwvvOPncXHMeDw8G6Vlbel25B5LMMIYw==
X-Received: by 2002:a05:622a:1988:b0:4ee:197a:e809 with SMTP id d75a77b69052e-50752886490mr160353761cf.75.1772476547995;
        Mon, 02 Mar 2026 10:35:47 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899eab5cf2asm51032266d6.13.2026.03.02.10.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 10:35:46 -0800 (PST)
Message-ID: <1bdea3bc-1028-497a-b422-c14c3de6f129@gmail.com>
Date: Mon, 2 Mar 2026 10:35:42 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/334] 5.10.252-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260302161007.2523181-1-sashal@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260302161007.2523181-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2F5891DE6CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222674-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Action: no action

On 3/2/26 08:10, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.10.252 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:10:05 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.251
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

