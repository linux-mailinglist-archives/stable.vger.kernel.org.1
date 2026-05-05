Return-Path: <stable+bounces-244253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGCiI2o3+mnVKwMAu9opvQ
	(envelope-from <stable+bounces-244253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:31:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3449A4D2B10
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B2EF30198B8
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 18:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895FC3C942A;
	Tue,  5 May 2026 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="KhcDdM6O"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE9B2D5A19
	for <stable@vger.kernel.org>; Tue,  5 May 2026 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005863; cv=none; b=I5RpLs7fj095qPPc4iFTIZ3zHAiDjG/BBoXb/vksQMUiJKpGyH+43X/Luqg2zPHkRG3t+aGgWGHwjbCnUXgaXis6rM6yhFQMi5FFkzYU9uRvRixzn/SZFaVNMg+KRWKRmZFlkJIEcN407qsv45KjYWpOnGmAm90okTQ2bDumkow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005863; c=relaxed/simple;
	bh=HyvXmKvXcCIH/j7y9sAxGypJ7gizPLxt/CU9hE5hs50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmeS4PD8hCqahOtgYyofCyCj5xTByR49fWN9k57W/2M+flr/+Tsu894wV7cpPSWzx0W1/+fM6N0S3rA2bZpAwizMetEoRa524JbAOQdIis1aJWOSGImXNNjcg5y5M1jZ6y2rp+DKvGOLgv5i6yL6h1nzb669irWSV/cicF4vR70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=KhcDdM6O; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12dca45ca21so7605050c88.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1778005859; x=1778610659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNOGLCaPzdiM71DvHqXrQsZiPrli1oJKLKFgCE+g9tQ=;
        b=KhcDdM6O3VdcwHpWnFDy7SP+c1obc0Jy2ZZE6tDIg7w3bbMv9AsUSno/ub56JBnJgu
         nLL61/nioOEXWfwdnFwLE9tixRrXhhaM/7TXDK8UbS/KxtNHJqhkv63YCwGKIh98JTuj
         mP4udmxzKqfQyWH0M82wxpG8p+RldrOS5BNBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005859; x=1778610659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uNOGLCaPzdiM71DvHqXrQsZiPrli1oJKLKFgCE+g9tQ=;
        b=N9KmyScjnNysRUhzH371IZFXU4ocwPcK9XAkdCEoPn9+GXx3FLENWOvbs21ydnTvoD
         cgrzReWZoAcTBFAX5Y9mwokP5FtT+OIuFOtg8rKy1Gfsl4gxELJxSHNzv9TQzTqAtBR4
         8SCHRDs266c7n85wiLVtlmIWwlEvJRwXM1tAOTxDX/xOhmvz0Mt3aZm6iwigOcQWT/QF
         G6/NJ4gLOr+LM7seUxV3eQT2JB0Cpo4UZlIm6Wp3JeFQuPV6IZ84/HFrrOlp/OTYRwem
         4YDxlj9IhjnjCS+NpfN0vo2HZ2QFcxhgfaFmWVG1Mkv7fhAAN2xEsOa7alSkIo5Ek/gV
         /3YQ==
X-Gm-Message-State: AOJu0YyG0MXbCfUmMagmPaly+f1WU/obpd9XyR8FFb0F6cBAx+T3zt2S
	7q5YCWlMbcZMyYR0RhTYx02seozOG6T4bw+QFtPqGGk60yv7UjgamEGcfq11Jpmggw==
X-Gm-Gg: AeBDietgD9I2tj7ONBbhqec295TqIVnAo4CRSxtUNRBo+XeiChu/ePu7719qLCG7G2R
	8w4mk7Q1wUP2d73xt1NfQmwxxi4aX/nwLKYrO3PTRu3cEx8USUWh3y7JySY4j9WMWt0IZD5s5Gi
	wPgm3H8gD5G3rCgl0146NPe5KsC3Z9cjMHplhuF6eIpRqxKcIgwo/glZ1HFwusSDK94QeJzJzwY
	6ikXTGaaZ9t2gyLqSb2j6as9+zZwjEXIoXt7bknp/v2XnimC8KXDuwtNMFXVc/6xjyOZxS74KJG
	oSEXTiZI66ZAULaM/8sv/aSVi2OdY5J5t+mxMxz/oEy95BhR7WTfIhYPDDzsGpbW6VTM6V2x3ae
	5BtgN/x8MWmZRO1XcPSHZGOyDLabt9UUWUz1Cxl/ikFkaZAmpRzzWpah0517vPIzEerIOKrLRr8
	xvEAHAxC0I5P/iAaN19MxabvVMAI+H2TUYqLehd8wzaP09gxEpGcw=
X-Received: by 2002:a05:7022:fa9:b0:12d:ed19:e6cb with SMTP id a92af1059eb24-1318eb3a351mr192117c88.29.1778005859233;
        Tue, 05 May 2026 11:30:59 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.104.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8278e7dsm20174952c88.2.2026.05.05.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:30:58 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 5 May 2026 12:30:55 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 7.0 000/307] 7.0.4-rc1 review
Message-ID: <afo3X4uMpuiVC2ih@fedora64.linuxtx.org>
References: <20260504135142.814938198@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
X-Rspamd-Queue-Id: 3449A4D2B10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244253-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxtx.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fedoraproject.org:email,fedora64.linuxtx.org:mid]

On Mon, May 04, 2026 at 03:48:05PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.4 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 May 2026 13:50:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

