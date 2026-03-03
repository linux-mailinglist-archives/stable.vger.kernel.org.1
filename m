Return-Path: <stable+bounces-222781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFWFBFBrpmlRPgAAu9opvQ
	(envelope-from <stable+bounces-222781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:02:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 696D51E9175
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE9E305855D
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 05:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079C1990A7;
	Tue,  3 Mar 2026 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF2iEENL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB12835898
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 05:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772514119; cv=none; b=od/11+no/b05w3NcJ1PvRHYa3Tp77PisWoNcBtM344lr09QLtO0jUl28C9ESs2mNZMz8/bKkKnpMSkW1CbyKVoCmPk74oDCk0KsYTvoWGii683CNjibvbsAR3NTng2NWQqlG+KhGgRBEHb8AJjui3pVnlsR7sXu3k2Lw5baWqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772514119; c=relaxed/simple;
	bh=5NmHXSIqFUGmEsfXJnMjdJ0mjLICbBExU7EmpUZLC7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET2I5nRUJqfSObM/+2eaJmlrkHrA+Qhgi7tT0UzvJL34cTNnPhSlw5XFeMd8i8GMoqbnOHbNVIkm2lp6nHJ4hSzW20ZagQ8hkVX9b9+1sDNkjPSvRS1OzJumYF18ht6fqVYpEGjhSuUD2PWA5Q6wXp71j8bwIQsXJ3iQkHPe3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF2iEENL; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b4520f6b32so5970093eec.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 21:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772514117; x=1773118917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywsUjyg2uH/dQpIhZoRPIwK9ClhDr7/lcr7K8x1S4Bs=;
        b=EF2iEENL6PhqGJd0DlpkiDHyccqzDfCxyim4gZ4Q2YbXcLr9mGd11Z3K2+Ek9qkTgC
         c9g7OoJP2PuPcC/copRSNJlQycKZ14xjkgTRXBwjpSbsGEbNLxtFFOEmkUMGnnh6Vhv9
         PZmJZZCQK9wI+kN+R5UEgJZ+fKqKQ0Q+nazMQ1bi6FWOSUbEzJSBXa8flW7pt4Lh5zmW
         e+Yu/NM1f6/2YjTOo6OBgu+rdDkRTkWmOONIBVNRB5GuGZeKAn5wf+pFxD4cSGe9733y
         bwahaht1RP6fPBZji2yeym7Iu9nfFWsspKqDVbOSZUNAy93YhefrjWZWHCxXskuCcl4Q
         Azww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772514117; x=1773118917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywsUjyg2uH/dQpIhZoRPIwK9ClhDr7/lcr7K8x1S4Bs=;
        b=bPFdA6mft2GLb5sS/FKds+siza27EpIXb2yFtl26UICftZ0xNe6/X4h3ukF2wAxzx4
         qynV+F92ptuojrtXTvduotVoMB+KEyVubjp037S2NDFrpI0kdjvWxEmEEsnLAIbnaTkX
         lP+c4CuxguChHnqnUE/ViAilJQLyHtlhRfxKojGXE+PfgGRr8+ImdCGj8QZbxEH2G79L
         jdjmLYVeoxZrrV229b5nc98INZb4n3I++vxYCDpz95Z2XlwqgYk9RPnGb785ftuKHUSy
         5EtbRNtYpZSnw7G0PsXEzHCh3kFFQSRzS/1mlgBbqmhEMMfr0BOmgTzlYKK6o7hw3XSY
         iOag==
X-Forwarded-Encrypted: i=1; AJvYcCUbGuHnwW3Nl8RIgkFXiDPgF0FJZrQrmIzgfGeSpmFDyaSRFIMYEW04hZRMZQmUk0ClB+ZUJlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWhRzQ2PyliiYD3J3idyQRhvPW5LuLLMFnqRzha0ySlb6vHaB6
	1b0f8F7vnPP2xNWyNq0UH7QxetOBLguYVbKWtSWPkwwc2UyLN2oehEZW
X-Gm-Gg: ATEYQzzZS77n8bU+IjcuW8nDSHlDVTKlb6i7i/hbF0yfk3nf9etll5Qvr6t1Khm6t7f
	lHl0ScfbeQEWeMJH4e7VLMVfasbJIQxFqmsrWoK2UzHDCBJb+qCwLBaUhYaeiIXhxEBdglheXR+
	wNBX4WO7J4RANaz3MJ11jPxrYysd8IOWGfGQkOqdgXUVRQaDqdU98aVrUtIfik21Kuq+Dp0tazf
	ylPj9jK1tUMvUQWR8vxVx8hQWL1D5B5kXp/VsrHkVnK29UH9TsTVANM9mt/hD0Sn/PB6IxuR632
	ZsNxH956l29Wt7XLnvZSYZEouGUeWKU9cmCLqSzjp2978tCymF7KqkrxZ55h1U+vTCZsW85EtBk
	3DXBijmbUCHNtTA+3SJ4lJ8bW9h2vZsJ2FW/0xVo14Bi271NuAEHosAe49pHL1FD+ZZ8TPm/eUU
	9Z3gJoDCj7JIngN+zhcFDWgqGNNIN+rvLjf/uBdjIc8RROQ/6sOriMui+QpMPGoriT
X-Received: by 2002:a05:7300:af06:b0:2be:18eb:1004 with SMTP id 5a478bee46e88-2be18eb1899mr1440007eec.6.1772514116935;
        Mon, 02 Mar 2026 21:01:56 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f48c77sm13918913eec.26.2026.03.02.21.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 21:01:56 -0800 (PST)
Message-ID: <bc5718a9-4041-43f5-ae5c-6c6d7f12eef4@gmail.com>
Date: Mon, 2 Mar 2026 21:01:56 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/684] 6.6.128-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260302160934.2521545-1-sashal@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260302160934.2521545-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 696D51E9175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222781-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Action: no action



On 3/2/2026 8:09 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.6.128 release.
> There are 684 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:09:32 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.127
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


