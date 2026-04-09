Return-Path: <stable+bounces-235311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLrwAxFE12ksMAgAu9opvQ
	(envelope-from <stable+bounces-235311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:15:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1E3C6814
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C09D30091C8
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481931196F;
	Thu,  9 Apr 2026 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B0I6hNPB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8A30F531
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775715337; cv=none; b=Ueygeb4qx2SRAupkSqBsFDIFO6fdqG44XRMLgupbCT0FXMNzhVeNqrkEBgvdrVyuFAadT3WjYWP71WPS3LWzMV4ZzjoEpI7iJzlWSe24uE4epLi6FQlz4FizVFaFkFFNwKPPwoJO6J4jiduW8Zr7NVqMPRk1uL7i97SoqvN4E1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775715337; c=relaxed/simple;
	bh=gynYxE/cJH5GXtEhmWuEkMGUWBTMJgN5AYOWIKIc/fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6c0AeRBxvxyoTO7T5kdhsu6SQiNbM/67kZq+BXGI9Pv5ohymnCh1tFpr185KPtjOQlu9lvKJXPQiZ3st9Gbdm+ba423NroIFB0USmdX3YmY3tAm49GgLS+sLqJE59PATK1/3J89TVPQ+bpYs3qJlzwX7rkrnMs4kW6y46A73hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B0I6hNPB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a29e6110so4797315e9.3
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 23:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775715334; x=1776320134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unrWXz/BvVWB09BOLpqqeC5jaEKVeUeeeLOkPeGWieU=;
        b=B0I6hNPB7lK6mDWRfFNugwyMfBvZvaPBINNsBbhVXANfP6BF+/W3EsubwUPLCOe2ko
         MOLHeicRXdXM1t5LL5/Hc++XhbiwQjCz95KhVflHfnDOaApJS7Rcs7D1+tLNKb9H8Mvv
         yI4OsZezi3CUuPJkOtaIYXE2/YKiuKRnBmateOTMOCCVeogBpyNmYmT4IEYqIjMGg/zI
         yBXK2K3lq85bjV9rlM4nwfbSXsCgnhwLKmrVn1XjszAwgBXCRHHF04BaCBF1Nu1lfkI+
         lRWV/BsmV2xOoVf/L6RLDhtnAl5DSXrxlZi+CUyqERxH/YUMbrsDBMgaADqbRh+dKWZ0
         KGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775715334; x=1776320134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unrWXz/BvVWB09BOLpqqeC5jaEKVeUeeeLOkPeGWieU=;
        b=lcdOFP/Ykmf8bEfCXCnlflzlbuHgQXlBBtGLe5KJtXyJcHdqW9piBTp1swDBQKwXXb
         fbI4BMydKWTBhw32mkBAJC9amREZm3M8GvAkQ5ju8R0tGXnU3Mep91Mzd21R8N2Rb2KM
         jXf5Tor1cCPU9+jiJytRSz3H3U/99b/4lAsSTFVFEjHcqIWN1QiXQa349aUUGVoTPvkX
         Ar0CUvF8AfQIxScxsLXHEIjGvm299yb1F8LBQtV+0LDRWlcJCPCKDKXOuqxtF0X5CMVV
         rsNKGdqyqEHvocpKueOiMsR6GYvHbftbxfgUYq7h0wo8wb1AgKGKDLu2dQURJHIrLDj0
         PBMQ==
X-Gm-Message-State: AOJu0YyEiK2siYgj9Qc8Fp6QhzpsNfO9UjEzuMV/+pIfGHFhn1bkMHq0
	teoKXgS42WzYLsqRBt1rWE+s4dzMhAwwiqy0hfsn3XrNj4SQ2MJeMXTQxx1BuBCRL4E=
X-Gm-Gg: AeBDieuTRE2um+6kTsfY2ufNVKWHYAuu7F19fBEnFs2mrPLF0wrU+Gq6eVO2Q3lAMEr
	tzxR2tPSyWlboMOok922dLypT/VSwppchCwBO9gOJCoap6a02eAsawDSrXn0oBPWdIWLu5ZTctL
	YyQVRyJn2L+Dp26d1jOrJG1qur6/1iyrWU/jMl4f8U/O+0A8O77RQleg+uYeQwfk+69T2ggc/R/
	MCI1vG8+uPQ4DBGlF9aoXeZxazfnlZ/aN9q6n/OBUJulT8r10mVhO6sIE8UEWypkHqHjeYS4V4o
	cxQJGd5ecBHTpP/FWD7yIsiaAunuHzeHMKZjnJueGqQi7VYXkTtLJyjfaKxnYIsE0/J48oXGX7e
	PjNa0xkdmo66n1ASobPtsNaGpeV50aoEg98Fwm96uq6zXDnB7noGVJO3/K8YHDHvEILflIQHhiy
	9sXW1gBnFc3xPBb8vswjsTp82kpxG08DBZBzwSKkCavTz08SYS
X-Received: by 2002:a05:600c:5292:b0:486:fe39:28b7 with SMTP id 5b1f17b1804b1-488996f08f5mr359918855e9.9.1775715334280;
        Wed, 08 Apr 2026 23:15:34 -0700 (PDT)
Received: from u94a (114-140-130-35.adsl.fetnet.net. [114.140.130.35])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9546344aae6sm4114265241.5.2026.04.08.23.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 23:15:32 -0700 (PDT)
Date: Thu, 9 Apr 2026 14:15:08 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc1 review
Message-ID: <7we3hoy35kjuwbrzarr4266ylu4x4zcurpuhuhkuzhijbhq2fx@o3zp2r6kgvoh>
References: <20260408175939.393281918@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235311-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14F1E3C6814
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 08:00:00PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.12 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/24153838933/job/70487760072

[...]

