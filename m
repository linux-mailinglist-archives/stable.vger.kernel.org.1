Return-Path: <stable+bounces-268634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VzebF+tlPWoI2ggAu9opvQ
	(envelope-from <stable+bounces-268634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 19:31:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA30F6C7CAE
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 19:31:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxtx.org header.s=google header.b=SyfCW9Lo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268634-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268634-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fedoraproject.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C23F4302A2E7
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1072F8EBC;
	Thu, 25 Jun 2026 17:30:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1823395F
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:30:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408629; cv=none; b=KzfZ16iOaWkrovwfOAb8nEV0Ef+y47wWH7VvXrrwusj/UK9FbqXbCod/vbjSQ6I/p0Gi9eGcmHFZQXSLoMCKZoPdBaTYH5dU0YxkGMuJOMkCSqF6avJ1eBZA5uaWMm3RGtdKMI7Z8ZRx9Z01nbv/gBc45cVhmZideuCIkmDp6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408629; c=relaxed/simple;
	bh=NoGkKodnObKXJR0Us6UBG/b/W7A24gDDiTNloh0Qkug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS+trke+pYm4Oy2vAwQ0b6qRaNcdh7VzKLc6Wc1sZh/OojwWno58Yn1x9uOTibVMV2wPOeSaUlB1t6vj8bktoe38d8F/4jj7vHxFoaVXJYUCcJEevtEiZUOpoBfXnhDChTxG62YdenqgsQU1ISeYHmqAFXboxvPGdsTce3GGVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=SyfCW9Lo; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c7f3148705so1479775ad.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1782408626; x=1783013426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvlW1NLLHFTexM8JcQ2hd12AbG62cMkVNkCtboa04e8=;
        b=SyfCW9Lob+aiQo00NOrydHYuIfSjNPNZCXQQfM+NwJIPeuXlLfP1lGIfh3YHn7/HLY
         YzqAYkO/maxhsQ2XZsXeXsL82o3IBbfDy32R6ukmMSEQLdkRMbh+i5fjpM/NxNyqbe4a
         aTFfkmc+oIJHRTpPAuQmNFEZhLrHp5neD2gvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782408626; x=1783013426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvlW1NLLHFTexM8JcQ2hd12AbG62cMkVNkCtboa04e8=;
        b=hHLvFIYf9HEVjtdSWDnkNdKBTr9pSrgw4eSeI8b5bIjcEUJIla3ZjfOzpvb3vzWQaM
         Nh1U1lJbIPbiV0x03bJhkdzb1he7ZDyJ1BOmqSbpupxD+9G0hrbOyMoNiDd3a4LdzL0g
         ZD4tbcBpp05yuNeWe6lQQftIoENzYlxF+yhnbT0TCjeEWIhEsFikROpCqPMaDDeytEl7
         pM9qsze2C1IZ5SmRR6B5/f9eyc/IN9tr52xfAh1MD/5JkA2WPX5UbO4LV0nRoxKmn6Sm
         cUI9zUc3vFFa3Xyug+rUthgWx70noCVMphGIAbEq+Nn7zGqFtPvkxfXfMA+0XroJnNBZ
         nX2g==
X-Gm-Message-State: AOJu0Yw+/CeG2Ij6kYkkAzn/LzzyGfuVYJ1KvN7rmtUdIcDkC/8OE3Cu
	s7hb/UaHLm2b/bmWAw81LPuOf7ClK7Gr9GO/ypzNZVgp4sl32qQO3KQ07QJTQ3mAxQ==
X-Gm-Gg: AfdE7cnkCM5FjtGuu/QR5xkWaz1M7MPplMY/EBF+cQhkw7AX7ZD8er+ajLalr0V0PiK
	ZOivsEmhVBdtdMu5vavpsylE8PLCzfqURzqu/3oRGlJCWXMfjJ7E+qmDp8XuL/s0tZH51frH75G
	9R7OUCwbMdNXIB72s9c/zgDNE79yn8pqfQoXOA+IkT52XRNiCYS9QCx43m4Cc8tuUlfjkoo/N5l
	IVD3bjNj4ok3EJLAOmZVt4Zj5MKOManD3f3YGRdAK7bu52uJPDe+dgEHS1KJGSZRHCANj51RVkG
	MLq2+0VPoVI5L9ywLIlAK5OmP76SBnWypZzrlDfySbpmDRzzuCVke3A5l9YxciDTl2Vl0kJNTcM
	+Tpzm/TGkRnf+nHg8kiStfFlEkhr3wBJP6roWz9SRpTMddAlsIitxfh12n6oiSnPTYSlVojmDEm
	3K85BdsQIOTBevJWu3yBt/lvc/hfakpLpawyq75DiN
X-Received: by 2002:a17:902:ef50:b0:2c6:a2a2:13c4 with SMTP id d9443c01a7336-2c7fca716dcmr36835755ad.24.1782408625892;
        Thu, 25 Jun 2026 10:30:25 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.107.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5b0c1bbsm24633175ad.37.2026.06.25.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:30:25 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 25 Jun 2026 11:30:22 -0600
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
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
Message-ID: <aj1lrqp9Atxv39j-@fedora64.linuxtx.org>
References: <20260625125613.243729608@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625125613.243729608@linuxfoundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268634-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxtx.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fedoraproject.org:from_mime,fedoraproject.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxtx.org:dkim,fedora64.linuxtx.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA30F6C7CAE

On Thu, Jun 25, 2026 at 02:03:52PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.2 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

