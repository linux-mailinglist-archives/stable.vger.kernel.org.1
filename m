Return-Path: <stable+bounces-216308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ErZLNmWj2kQRwEAu9opvQ
	(envelope-from <stable+bounces-216308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 22:25:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 555FB1399DD
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 22:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D394E3007AEE
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 21:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBC629E11D;
	Fri, 13 Feb 2026 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqC+IwcD"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437029B76F
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017931; cv=none; b=gxqAvZWtk0XfZHsTcTAmtUCh+KrcsoDRBxv1QoUw9TDALm7sto0ngZuZjgZf93Qq51Jh8C4TB+wSI8CORM0kjmsbmL6Anx3tP7GgU5mGYL5D5J/WfJ7i+9z+pf0llMBE4fNs/zYP2pz49w/6JdzyUvJmVOcmNFjlMQpzAofwPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017931; c=relaxed/simple;
	bh=1WwrIcaWQymVreqECXIWYDtm1u8fIz9fAE30SD43/vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhJzDjuKHqgMAtw3Lm0ZjQaYB4aQDK4u9cPyFdXwZgGg6ENpW0hfyAam4iJLceNML3o3H2jwGmE5OL+LJ2fqVWwxNRwhuHmt4xf9ur8ma9DXkE6/Ha6JK2nd3m3ZHMjNAawxH0xjT+DmDCLqPnceWkFe1oRfQk1NwfQrxalm5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqC+IwcD; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12721cd256bso1892267c88.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 13:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771017928; x=1771622728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIxCdoHa233ZeVcDcsaE6m/fBIjWqKAR+0y9FsDJO5M=;
        b=ZqC+IwcDUmNhfPkyn59VYhryj8i/+ZNZS2jkyQjKCkfuQ07xZOKmbaUVFkU/2Ti+Qc
         TJKzEL81o4jQDZbpqFPCuYmSiulCNZ1JqKT5ZJss11dYiTJV2dH6Q7gnUW9Jfd+FLFv7
         uXARC52zZh3Ne1o+1kYLc0PDDiiQ3SsiLt51Pt+b8nC5i2EJJoi7avvpOoo7huquUnqc
         mSyYed+B6tsUjiJVwswk2514IWyhbTp7oPhs4JnFqMo5cyMftkUiX5oxbhaZpRVWqo1e
         wIc0gzkiI38+XGtI1X7XPJFZNZeARKLR2GW9euPM3Thrv28jFomneE1iJgrj5qAgv7W7
         ecaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771017928; x=1771622728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIxCdoHa233ZeVcDcsaE6m/fBIjWqKAR+0y9FsDJO5M=;
        b=QQVN/9XcHLs7k4BNifU/usWWvJrxSkoWE+8sH3ErWMsPS2X8eH8h1/xe04HhVrmZe6
         J3I2YBsnu3kSwvaVqrCqUEJYS/fHu4z6fVqyGr5yiqhcaBTq8FbbTpNA4/T6I46cP9in
         xvRar/XmScihxyIiVSMENaEdp66n/fZuV03QtL49V9mYwT8fT7BTAqI+XPsDvBomtExU
         amGInPcVSzXC/q/u+HSI0bCIoz8G216qT98MS9PAVyqZpK5RZ6uxcmLOpPdDOuRCgWdm
         ehPLqHRZ1gKs+IsVHGHRIrQnaMjjdhJE+fYyl5auD34OJn2NzjswaiIcMBfzmRERfVg+
         wieA==
X-Forwarded-Encrypted: i=1; AJvYcCWlq3iD8QfjQuoHXcYDgHpezcL8qLYiVZi3ro7OfVPU5D/b2BQZFP0G+qtu0wuGqjzoZGMiKgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfbjSwLCbU85jBpHRqfaH2jqx0JHfOXFmvazQiGhe2o7eEp8D
	PTX1HQsZI0v+LLw40KZf4HGc5mWXGF3+y7AoIAIomaZsnuO+YtGrDhzZ
X-Gm-Gg: AZuq6aIdUUBNGPxhtKiCIfWQcqTAzpXGD1HeeZewgpyx86+5l9LDbIyySMbo3FA+X+d
	guTJHVPlgT0aToOi6XGm6Zfgnms+7g7ToXTIkfRwFVy2sSYkGxm9bk8DZ4yMc52VzIke7MddbY1
	uEairVVs5WB7f6GEUqhKTgdUumlih4b5QnqNjDzOA4u8dQAacw4nr6kjsgbyOUM+s9p9q9J2lSA
	O05gqo39cDz/5SV+oP6p6hW63TgHSHISwQQ0JGZfpQAdD54qYpaRo+m71iKEfc0P2+3bgMFnSp7
	XY5KBX97Xne+BnYgMYlGf3EX4W0xeSArehoeHsZ2IKYl3AFAbM7BnjzBrVi1I10Uqh427slHcLV
	mCox44lhRPwGOMmyTBoGwFI6X2jq2redKgLX0yaCVJiLfqBTWR5h6+PNJ810W5RQnMhBeWouhLr
	EFBOgeuyoRhN6KW+5jBsTL3tpZbwYIsUPeI+cBbMsUq9/2xoufqw==
X-Received: by 2002:a05:7301:3e19:b0:2b7:3281:6c64 with SMTP id 5a478bee46e88-2bac9356778mr271085eec.14.1771017927525;
        Fri, 13 Feb 2026 13:25:27 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb577c1csm86147eec.13.2026.02.13.13.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 13:25:26 -0800 (PST)
Message-ID: <136f19e6-ba84-4f1d-bb49-465c2333bda3@gmail.com>
Date: Fri, 13 Feb 2026 13:25:24 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260213134708.713126210@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216308-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 555FB1399DD
X-Rspamd-Action: no action

On 2/13/26 05:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
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

