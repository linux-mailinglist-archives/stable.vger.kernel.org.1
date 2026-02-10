Return-Path: <stable+bounces-215595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLhVAbKhimniMQAAu9opvQ
	(envelope-from <stable+bounces-215595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:10:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C01116B04
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E90F5306174F
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A52E4263;
	Tue, 10 Feb 2026 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="WvQW10Ig"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27785288513
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 03:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692886; cv=none; b=SDbpTwZF1Q2l4RCM4itVTeNv3WV/nr1JbjMjVsW3LSfOH4o8g7S9BiDDHKbFol39Ykxv3IXncU0CWvRV7uu06r4TMLB8vZKiblxl5JiFa09gcjn4fQOhE0L84DZtWcaaPFUr+9psxuIY1+J1DePz9ANNLZ5zci2lsnZRHRGITP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692886; c=relaxed/simple;
	bh=0WYlr6piOWfxP0GjU8bu7yPqc8AAnMf7N/ea9Rr6sN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgSSdjSMb2uhe3KGCWYDPNPjq1/ptZIPGjEjUZvdwWExqr7u3NWY0bq7hYxTAsv3rUrF7TclH5toIBA0qYpMgajHRMcm2ZpASlqULsVlW6fP+0lTGuHM3idMzisAOC0WdPbFQwchw4SK1nbeerGgiZNlAEg/Gkr30+loCeA5eKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=WvQW10Ig; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1233bb90317so4367566c88.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 19:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1770692883; x=1771297683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxN0ZBYJOxaUh/EXb8f4RxK/7+y+khToCQG6Jn79vmg=;
        b=WvQW10Igzkcns+Q0N6EDyHwjPxsATP9248XbqVIUWURY4ehYDF0cNPHjyz+55qEVhO
         PDxLcAG6Oj0U/Ym4/Thp5uVkYbo5PXKqjLT6jTLR38O+iUdZsJ+RNtM49NtqgIsnS42o
         gOFtLBS5SgHVN5j//bm+JhXEI8JEHktYfIUno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770692883; x=1771297683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GxN0ZBYJOxaUh/EXb8f4RxK/7+y+khToCQG6Jn79vmg=;
        b=wSdQgkN76jvn4o5JCU7nIWQMPD06I1F37/9unOwZMfCDTrs2wiOUgvGVfz6ptpIWWS
         qNLbhGTapmOotBS8uSt10aT1jG3njsNOR8aNnGBwRfBLYc6R2mDETgBrEFEPLs3BVJAw
         vYK8N1wMo8VX7QPunpJqD6WYQbtxDjNHmQF8lF9frsTb08yB1g79VjY65bG0asGin/Or
         t4tU32pYeLyjAFYmAevcbvPlmIqJt/sBoNFtocmQ2dIHjU+J4jMCdaQej/qpEAs6pLP5
         DAGcTov9//3FJFR5M4FNtudnJ88+2kBxjG24zvjh2XLFUH24Fc2CalURnEAaUBJ6SOJR
         3jAg==
X-Gm-Message-State: AOJu0YzYH6cQW1+uzhJeqftIad1TCo0SBxPert4dLFBetYHccljKjyPT
	K4Ub69eyiJDeWRNu84egHt7AZYwlfM0qyQ+BeUyN3gZq93M+cgIujTHzTTX3DAaAjg==
X-Gm-Gg: AZuq6aJOo90VGTa3wV5/J7GcKwi0ANpyE8FMsWvBKUSvSl5O4LdsG7/faMXKO8u3SKZ
	V6Fq9zJ55NbfaHz/CdCS2Hxlzat9r/g2Yc8mvSGYXVbDUR1cx0Cg4OXRQeF88LkKTZ00LWlwcyw
	GXgGqBTvr97y5CI5mYVECDJ1n+PQgRW7SecTgQWAsRCklbGdwxx2LkJRLD4A2cw47lmNkTqmrkt
	C0Woo/wQsVST6rSoG5Qxe3QZURDOA5cUrKALskro74RBAjhru4XWB1FuAdHEMWxcUE4CL362ntC
	Ef/ZQd0tZ6wtdkYLlNs+aoqPs2L+r5QJ8kDuvjtFYP8xeBl+eXLns9vUe51Gx23y6cUNLkIveHk
	gpX5l+5Qek7WybUJTK6/E7289Z4fPDTC1XwKAcc+AcDVlCd9U/XWiprBE91qZ2gGp5AokYcri6m
	tiXwhNM94uHEJr6GwIG/wZXJ4vUuVhePfhUrURh1hLu5U=
X-Received: by 2002:a05:7301:d19:b0:2b8:3b47:8951 with SMTP id 5a478bee46e88-2ba89c5d6ecmr381690eec.1.1770692883105;
        Mon, 09 Feb 2026 19:08:03 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.121.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af7806sm8732789eec.10.2026.02.09.19.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 19:08:02 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 9 Feb 2026 20:07:59 -0700
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
Subject: Re: [PATCH 6.18 000/175] 6.18.10-rc1 review
Message-ID: <aYqhD_cVw6bT9vgR@fedora64.linuxtx.org>
References: <20260209142320.474120190@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215595-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fedora64.linuxtx.org:mid,fedoraproject.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97C01116B04
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 03:21:13PM +0100, Greg Kroah-Hartman wrote:
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

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

