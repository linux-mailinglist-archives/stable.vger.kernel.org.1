Return-Path: <stable+bounces-217208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKT3LEU1lWnfNAIAu9opvQ
	(envelope-from <stable+bounces-217208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:43:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A03152E12
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF5D3303F057
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 03:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C532EA468;
	Wed, 18 Feb 2026 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7s41Otr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A68255E34
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 03:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771386167; cv=none; b=O27F9KSCj4RJipLYWKIBSIeoW9PyIenAv9Fnc7b20zH/6d/RfOCHoLSXRAWu4g2zpStcnlWayKAp1GA/4SufXsx7Sy0edwmpWivD+XoqtMYIw0rJluZ0aoLpl5kZFsj1Rau4Y+Z0ljIQyoUeRUBnSM+rnsPWI2RyH5LTmIfzQu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771386167; c=relaxed/simple;
	bh=XFKjx+u+/hhOhQe7X6vTFITiHd1JDcT2vygR8cKPNRw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HryRI6sYvfvxF8N/spxAggwQ+ZrHjQBw+gGZVwLqseAdJ/LkcF0j9Sev9Qf0wV7Yeez2+MAACPDNv7w3V/JGMRoNDRkBfnAqiUkM685j61s4zQkf3blUZ93NjmOrgf5FajWZhWONLpOa2n9kccI94KSXdJpBaInyqV6yfWA8Qaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7s41Otr; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a1b23c05so58120401cf.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771386164; x=1771990964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnK88Mv6cVbsLGduaxNFiB1ZInYoTTpuQX8qgOf+0q8=;
        b=e7s41OtrVqCJ0w3fsE5O9jeIrAE8MuA+yj6sRP3oT0YfJiYFNmPSt9YBlr+Edws0Pf
         3k3PF34Wfams7Wy8p4L8R/sEeyia3f5el8BDWVwyvp3RzzLt0XPabaeRWh2GkZyJfz3v
         P26FATBXE9y+68/AyOa7bVr+oxcCsOG3vNVgnxzYS1Tw5QJdINnvYBVHNCScKAj/v5xd
         KeTDRap7Mq1dtj79HBicOL/yd5Hb8IMZvTfa7TvTLo7OSonV/z7rDR9hB9wKl5MiqAer
         zs+ad5nunVp81wcM9e+9MKyzt6xz0sw1oAW5IBnJJAsoNsJRefOF7gqaKgR9qxel8Zy7
         JDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771386164; x=1771990964;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnK88Mv6cVbsLGduaxNFiB1ZInYoTTpuQX8qgOf+0q8=;
        b=ZPleRIFaOblFUiw7IfiYkEF3zkXOlMcIBCThD5G3MooOdftWbXkQRKaTBRLfSyyUp7
         SwT+qNqOgeLpdY0meF23tU1y1cqyUksoBBlh/g0+7RuPDmY9zvkUZQrgo7i7JgXvS+Pb
         Kqi2FR4rmRN3IEQqAAiqCPy1sKa8C7UMgHz3g9AYgaCecMRYymkg2q33deJ1pWEfFloe
         2llxcTh//UDzvwMV1pDHKKVxU8Sn7BF84WAVeypT12rT3Lv5NJT/dxQOhKqB2eTzbM3+
         LX1AwXBHKd2a6nHkMNalEk2eUih/wHxkmf8nGTiIe4L8uswDHZcDpFpcYsYbD2zZ0sCz
         cNmg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3mlie1HZpMU6DUT4JyFIhX9aVOlaemTmw1JkyZ8KwXwfXsKwCNya+qy1kV1uegnMvu3UA8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKhjM5inzToxT3bGw77Hshn3TwKGSjIIPqBP+NdCIofi3IyHNK
	IYlmdt8XPKt8DsonsoA3SngkQ+BTc0TOM4G7+FnQh7PDMqjVdcVdbic=
X-Gm-Gg: AZuq6aLIlbEDB9p/0IwziyK2c8LJGJolc3zA/c7zAtBrtgzSuASJeYYDDu53dZgw1bF
	YDgK0wP2nFx6s6PFwpdqQOXDsSf8wEBBGt7gjn3upyBD74aR633R19Qg/84bvFat9t+84SgetjG
	XGoexnTdg6xaeqMqQ2B4cqqztY3/WRGaa1jg3eQK7pfrXjY09lpJSb7RKa1O+OWcJe4mtDWBjhG
	TGb5DBvGt2zr0X4lz9guy+7RZMtGH9ciCxOG0MWhMc3RfZI1jI8eGVqgadd4WRF/fM/8D8Rmlty
	cYd0Kz0ppQ09GuaxmE1UYLsN5OmcTQS6AtsSHQTkn8AicNxaOb6Ej+i6yAiu6/6M0sHv+YiQbTz
	qHFBc7v5SynI+R3CQx9fAKByAx9whApjkjlMzvO7/eBBcadzSYzWVQFCF9Qll2HJs4OgYSbCXX4
	JyQqAuD7Z/pHfljyJxgeOsawKwcAZeyXW3z3lRzwWcJCCo8Sr70GY=
X-Received: by 2002:ac8:5a11:0:b0:502:f26f:136c with SMTP id d75a77b69052e-506b403bbd3mr177443651cf.78.1771386164012;
        Tue, 17 Feb 2026 19:42:44 -0800 (PST)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684b94f33sm168088641cf.25.2026.02.17.19.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 19:42:43 -0800 (PST)
Subject: Re: [PATCH 5.10 00/24] 5.10.251-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260217200000.708219618@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <7a867e86-d5b5-0ac0-bba8-d38240b7c090@gmail.com>
Date: Tue, 17 Feb 2026 22:42:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260217200000.708219618@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-217208-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[terraluna977@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 58A03152E12
X-Rspamd-Action: no action

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.251 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
>
Builds with custom .config and boots OK on an i386 machine. No dmesg 
issues noticed.

Tested-by: Woody Suwalski <terraluna977@gmail.com>

