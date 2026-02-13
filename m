Return-Path: <stable+bounces-216284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIh+FbZhj2nNQgEAu9opvQ
	(envelope-from <stable+bounces-216284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:39:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C6F138B4E
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9E6830528AE
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2F72DB79C;
	Fri, 13 Feb 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="XQVnlbyu"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10929AAFA
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004280; cv=none; b=hMaOaagmhd3Vz7keP4dv3VDAIWuYflcqmbYmq7VrhASwVHXu3/k4BqOH7BsfgB/C5npgmiSil2oEVE6ICcwIl/qTIAszOcJ53DngaHVnJvi2g9HMj+X84rg7IWHbni0KPv9azYPlk3O6rhAg2QPU/stC/05SHPS1hiBr+cwFp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004280; c=relaxed/simple;
	bh=fxpZJY1R/RlEn1RD1v40JkIHBzytpC4+Tt3THW2KLk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUYXLnsSV560jp8r1CU4aqFLFKBrWMDL5DBPu9x15z262LG4rx0KBAGUG8InW9S2CpAmN/3uw6HBm0fNAEOiRmnkBcuT1mwQTCtk94gLf4xdZ4ZTiFTrow9xZh0/m8QvVemXQDExWZZwKg00QJmtP9vSjwPhMsihc75owaloE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=XQVnlbyu; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1270ac5d3efso1235169c88.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 09:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1771004279; x=1771609079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60UOzH3bYxHjDmgksh0UlfnGbcvWJmcMj9ZhhGnbMCw=;
        b=XQVnlbyu5/X97C2RuNWhTSJRhYQMahRPhZR60FjqOUFiFy+3sYqP4Uk8Y6syTH2S3i
         /wfbM4ap1pnt93ZV3/XZsXkUgnM15t7D/KXxF8fVFpVbrtkhfTw1/SY5i1FBxNC5AMK3
         BpcDd2d/TEsbYADEX3OYp7hylKHnDwVi2Dac8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771004279; x=1771609079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=60UOzH3bYxHjDmgksh0UlfnGbcvWJmcMj9ZhhGnbMCw=;
        b=Cfdzj+hMG+QeEOkcML8AfQxxksG/A6OTET8mLBIE6+aoqFr5a02z/JFZuNHNAavIk3
         +lWp8nR/gFlZ+RuioVbtxUne4jMVDhuWVi2n5SducRsWyZJ70GGhD4Te+J7v/mHR+bFU
         U7he7c9azrNYNpisvctJCxCK9ptBjt341kGcia37JVzsxC0hlkjteGodqln2Wzil+ASz
         a/EL/rYfjtXGoJM39wlkmW+0nEoIQwWiGm+eLyYWajR0Q+YePqHmqOn4JRjKvy96RC/s
         XvNv28hvTJMqjjoWdV2X4zAGcRM8GAVdrCFDtdzma6MFyryaTMw3FI99j+DhDwcnQjFf
         1/7g==
X-Gm-Message-State: AOJu0YwYFLBdpw9i8hRZyHZQrfcG43VL+Z+UU49HSuQm1SD3Q5XUmlZw
	BirULGXRSQ/euhq4LE35hosB3rS5hPNHNlKQ6XdGCrBH29kqZB2F+DHjMhIyj7HewqTAaMvMvu0
	ba/M=
X-Gm-Gg: AZuq6aJsW59A6X8Sg+jhkjnxQhK3BxU4L/bwFTLUqfwgrLwHb7gnYD0xcb3zoViU41/
	P1I7UPwSE/6bJgIR1UzL2gZLkLu/GcldwkAuu+qaF4S+SYUZf098Idz/5xim05q4N98Cv1fMw/e
	HsvtGy0yGC1ysakl+47hv6HllQ7X0KGMpeB42nxkofsumobR+q0uFRrqFZm9bAJxuKdjXdO2Gzw
	VCfzmree4ql/4husRA+XpRd0s1bj+oa/sczEySh56dTjJ7SP1u/LFXu4Nt7HvCKcXJNSCnEO/Kr
	E3A3JQu8y58+H/xCIEjWdrLGowyZLaUXBDy0ZNPg1Qb5RvgcuvSYNaHGmD4ZDT379ZZuKdek0+V
	EZG+mKljS0DE5qLURPKUPJuYo3/l52fnEZUrRglP9cVbEzsHQoJvoh3Q+lXbgfaH3u235QWFaDO
	pRMMYlxLileiLjJ291jBnu33PocmaQsrIyrMA1PRlg3WXn
X-Received: by 2002:a05:7022:618a:b0:119:e56b:91e6 with SMTP id a92af1059eb24-12741bb83aemr134625c88.23.1771004278771;
        Fri, 13 Feb 2026 09:37:58 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.125.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1273c38fd8fsm1705834c88.9.2026.02.13.09.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 09:37:58 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 13 Feb 2026 10:37:55 -0700
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
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
Message-ID: <aY9hcz-Ly7wSLyj3@fedora64.linuxtx.org>
References: <20260213134708.713126210@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-216284-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtx.org:dkim,fedoraproject.org:email]
X-Rspamd-Queue-Id: A6C6F138B4E
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 02:47:19PM +0100, Greg Kroah-Hartman wrote:
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

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

