Return-Path: <stable+bounces-211188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJB2N++GcWk1IAAAu9opvQ
	(envelope-from <stable+bounces-211188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 03:09:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0060B9D
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 03:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 139B4821A4E
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 02:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E687322C98;
	Thu, 22 Jan 2026 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="ikciujDJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C133FE23
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047658; cv=none; b=MYiAdMhcC3MSO8H29JGk0gRJ9yTe4DDlEQxAMxpFvs1vGTtFT+Px5R5V/PkczPyuXQcWJ67lVFk2db4DoQLXycJWvKPU5m5YZweTi1CawaqgH8Z1Ns+b7rQAz727Hi0A8745RT/675qB4TQuCZAtsup2rL3SllZ9d+LcJ2yjPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047658; c=relaxed/simple;
	bh=t+ym/opLo6mfDQnXsG2uLVcUKxmKwOvex8NynllbvN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZuQ/MKj1UvfgVe0O0U7B+qDBkDK7x4VLNcXnrP6dEcHb/Ghn9LHUij4916wt79NOpTWHP19T4xJdIMqTpDzwoWriU1j8bD7ePnOUSJTqrW1UFoIAE9Tq6rc9263GZErGitEmAstL94nH9yxQmFH25Z11QaxLJLYzPFkR7BuCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=ikciujDJ; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12331482b8fso1523686c88.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 18:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1769047655; x=1769652455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNruM5AAazPVdzrP4iDSGumpoyRXNPwCc7bPrEHbcqg=;
        b=ikciujDJY1Y17VXqI+EMCLtpspe2tJc+rSmIpO1HdswYXc4EbdEMe98poKyk7wy9Cm
         rIKdRwgahhWtarAGbQGIuqn0V2BRHkErsGxaRwYLvQAnTADYDQc5QK7oXLxzz1i309p/
         Teez+fzOgHzVKgT/j/MVl6MCkuYUdZf3Oi7kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769047655; x=1769652455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WNruM5AAazPVdzrP4iDSGumpoyRXNPwCc7bPrEHbcqg=;
        b=Fk1o2oYFSyX2zPvyZ8Yo7xdjA9FPkFBDKARj4v6sfqz9C6XcwVffcv0b7joyIlfC/G
         +4g1hTSLud8qpu2CTjRhFqlO7kisY4AzqupP5Y4S006tSltEOFyVEFQFVHHg0BgAsVS/
         JNv/0ODYNENALsvh8Izi+LTYF1CwyQl1uLeSNwgYCZgpV21e0pv7sl2Q03TxtaAlIPM5
         W/FSxeVcn61fDlQjdUsLWU7dTDgYjP955hwguddT9WJgzqB8qtyK7qY4eWKLNcbxJMkV
         7k8zEfyWKRjQTDFkI0UH0a+srm5DLNe8OwmEykuWFjCINhKN/tMNtWEKj5nWmLvkT39t
         7fVQ==
X-Gm-Message-State: AOJu0Yx60Ara3FY6YlLbDdAONuQ2o31niJVrIgwwL1OnJTTP8H40l1/N
	miI03uT3/4D2gIjAd5gD01mmM2ydzY0zL8c+XBTwoHFLzNIl3tBL6oN7cDiz9HHgrQ==
X-Gm-Gg: AZuq6aL8rP9U1MP41GIBVs80cNgCZ0vgqwz5x8k0++1YAndF2uoWVLelSIU1sCV5edy
	Hr6WXPkSMu9X9WBn2XfnpB7/T77rZfXmKvJZ5ykq9p23pO/vFsvG4KK19T1FspnGCpyRdz3j2vG
	t1XpRfJZ7a7c/uyPPrKU6m0oriC7bPFZPxiJgadfSoY2Qz11w5dbl6lZWkk8/gnw9CQRNHzcUlx
	IloXo/ksOfZstzQ53EC8t0jUdNPZymbv8P1vQ4X246g+UeIC49ngb4w/DpNeccIWjKEDYCDaksn
	Uhxv7hiSetJcCXuJ5+urK1r3Bjd/RTcTnhI9wOiMm+yMgCJMHkCn89BhzZA/YXvR+O/owMWmXLi
	yT7KriccoQy6rt3hJdzXEOFJ3n0T07vpXhOUo6e2TTcP2jtlGKHyaNYTtxKy6bSnb3a/UGmIRaY
	YPYBfZHUm7B5W4ghbRgCHhhhjOAZD678T0yIqFZ27k9gw=
X-Received: by 2002:a05:7022:6189:b0:11b:c1ab:bdd0 with SMTP id a92af1059eb24-1244a782231mr14959212c88.35.1769047654346;
        Wed, 21 Jan 2026 18:07:34 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.126.136])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b70d7f729bsm7494035eec.16.2026.01.21.18.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 18:07:34 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 21 Jan 2026 19:07:29 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/198] 6.18.7-rc1 review
Message-ID: <aXGGYbZ6UaOTGuPr@fedora64.linuxtx.org>
References: <20260121181418.537774329@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211188-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxtx.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linuxtx.org:dkim]
X-Rspamd-Queue-Id: 70E0060B9D
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:13:48PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.7 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Jan 2026 18:13:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

