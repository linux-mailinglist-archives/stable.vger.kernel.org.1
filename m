Return-Path: <stable+bounces-226973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK8wEJlSumkAUQIAu9opvQ
	(envelope-from <stable+bounces-226973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:22:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CAE2B6D7E
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9470B3055839
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7AF2253EB;
	Wed, 18 Mar 2026 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ayUT9edK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617024503B
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818216; cv=none; b=GQYRnP/29wU1m8gQ4KCkQj5elmddADsYNmi8OP7R/W53rE9QHJcMsvhSloRXJqLbttETeYwAS+WAxHG5HCKSUlo4ii3L2rpWaWQmgwmODd/ayzcl+qsFquEcmtxoNxn/L0lCY7y7N1wkv9JR86ggwdMXNEgyN7qKhaJIpdJW6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818216; c=relaxed/simple;
	bh=Nf80Au6wCKnLR47bZXhrqtqC3C1ce/Dk91infyE9yeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkU4MKciZirB8FlTalP/bpB4ubilDeCdhC1YFs3qOplkMhLlJXoY1BxDuqTN2YnIc12az4QdGjdaYcdX4v+WlFYoid9C+TAmcvebihqfR/i2AANOx6Il6OuNziNC+aQeaG1namKZuEU2CYbCQY0dCN8mzolCvHdV5LH664E00TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ayUT9edK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486507134e4so17759435e9.0
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773818213; x=1774423013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsdordiQBG8KvI/TOVG/4SQIVN4E6bDexKX1lez9BHc=;
        b=ayUT9edKqten/RsJneWJ7N1kcefrAb+tePXx53GKE1Ramy8KUIhDUKtd14aHlCucm/
         bR9b43XmJZpXoddpASpGpVYd+EnsCKSTDLp8j4dkCHX9HCXidBCEfusvGTXtaE7Wyyy0
         yqgQkNCeJYpw4BNydIcxtl8LIW/dkPWG2CIIEBxXkFd24WsqSz/OP3/0MQj3xNE7RPfo
         8IB2tPVibmfV4K24d+c/lE5FFHmGHzlJYCukCIwLxRKPtVefj7nsQaTYMsljfRSCs+ZT
         j3yQph6L9N0PVw4p/b2B2nVO51IgtIOC1sgKFwJEnQU7yL+fB1RXXKR/TN5r9oCV4M4C
         ILbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773818213; x=1774423013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsdordiQBG8KvI/TOVG/4SQIVN4E6bDexKX1lez9BHc=;
        b=Tv5y8pB7zYGuqvdmLWFJJ0omTpsLJxefKxPNijLpNN7/cB13pff/GuK/LCmyudB/hV
         Zp/9odnFLc0dEIIlIMYkGsJ+8BAuqKtp0KUxsW6MGezEcG0/iRn2eq7jRM36Sn/AAZcU
         UGG+KIVx6mqyvPY5eanPIbYyG0kVsnDrdiaDLuS/szcLJAYDRv9J7J1vCEJufiS/Ye+p
         tYoYxlv74kYQ/4sjldcjKK+OyeIw4EYnJJC4ZGQHUbte6NBWRKKadRejSxdJq4W0ajx/
         JBl4dduD/k6ZfjWN/gm9FI3Jc7ny8y2B2C9qu2B80gYWAV0Ne4ev2MQDnCwJPBTQ1Kzf
         SYWg==
X-Gm-Message-State: AOJu0YznMqAqiu1dqYW4IO/7/RXREN3z7dxqjZlyFFm8CYlfel5xhv/8
	7rqyzit5vR2dibnntvFDxMTqi1+ZvLCf22c4qKsKc7TMClCxaZuhKh0DE/zeTaYVduMw7M3CV0b
	JZbbjQDo=
X-Gm-Gg: ATEYQzyMcdVgbgSEf6IuOGJLVBCv/EHbHsx2GVRrR7UC70/lmzoU3N9nXGVqmRl9a7/
	Vu4h0DV/Y+d0ZgYclQnQo3cTOyMwHbSrQ5b+PsuOPSiG7OfKbArRDNK+aA9baxjo5YvPzgWVrGt
	Nj9clwDXVxQlAwqKMPng6c8k2XjMw+KI8daW9LRLc22CAsukRWr1hoqCaZC9LxrQKgSdXyPW7Ee
	w03MgAxxgoQLAvR1FjZIL9XSA7BKrSEq1Ke64HiVvEqF2Ox/qZWZHVawzHETtSCkunVD/Gbxpqp
	V3GmOn3gf/gCR62+Cm69N0EQJGQxbl8zd9OrYrJ3jZkvjE2mvnZQKZQYvpoVIHGr/2+0lV0CKi0
	bCj2IiECtNn/pfdj59u0kSssszBRCmYZ39sRUavjCLjLn7JFjpDKhSpZBCSI0Gu0Grly8Ru5RX/
	pPMkixI6txzqN6RR4Irrw=
X-Received: by 2002:a05:600c:1d09:b0:485:4388:348b with SMTP id 5b1f17b1804b1-486f41fd356mr38112435e9.0.1773818213388;
        Wed, 18 Mar 2026 00:16:53 -0700 (PDT)
Received: from u94a ([2401:e180:8d6d:4286:a96b:a815:7332:44e7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b541cdfsm1612786b3a.1.2026.03.18.00.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:16:52 -0700 (PDT)
Date: Wed, 18 Mar 2026 15:16:44 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/333] 6.18.19-rc1 review
Message-ID: <qh44yqp56wymolegs4gbwnbsyb7ogzwwboyrv2feqftdfbo6n7@63i74d5f45ah>
References: <20260317162959.345812316@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226973-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 95CAE2B6D7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:30:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.19 release.
> There are 333 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Mar 2026 16:28:59 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/23211625016/job/67531397844

[...]

