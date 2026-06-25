Return-Path: <stable+bounces-268635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K7RpNRVmPWoQ2ggAu9opvQ
	(envelope-from <stable+bounces-268635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 19:32:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D766C7CBC
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 19:32:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxtx.org header.s=google header.b=hDK8bw0h;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268635-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268635-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fedoraproject.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E64F83092290
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866D35E940;
	Thu, 25 Jun 2026 17:30:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566C2F8EBC
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:30:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408658; cv=none; b=j6I5Mm2P69dpuVivhvgbEzfBK9/KW5ukE4D+KZoNTvQius24SyRKYbkztqNVjzcOzQFTYSsCiT7eBTfXaMyv962wuEHZUNokRLXyu+0kykmYmVo4Z1jeYhuc+nsc27Uph8mViXoFneKvX2j4WuhKI8WFTuKC8dpJorU25nn67Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408658; c=relaxed/simple;
	bh=wVpHIkn3RE3gC/nfpVm3k2hccIIjRg0U8XV2yLjOTIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO07mojDKa8zXwIQzny0EDldfIEdTjGkIcMGt8Caaj2bETI/Fyq2ac/3DYS7pP/c+R4zV/0eFOLd8xMUXfYU83K7zHxzGVApAxNM7brNycM2ZD9FgACZhpWtUfx76gjuhnCdvAP9HsI2dDtMzL6LCBIbm+GeO4VpZJAI+QhhYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=hDK8bw0h; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c80d215169so1674865ad.3
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1782408656; x=1783013456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ns9Na0/3PBHaGaylTzimtteynQsaE2Wv7+sI3PG6dw=;
        b=hDK8bw0hh4t69qZU2QfTUgGmXmA8Jvd6xVmAEvOB0xBo29O8MCvx2zTEQzvYSCl6x5
         ia8juwfK98DGGgfFcU5EMyUMJCJMJ4eu3id1u3Up7hFy6vV7wx93K/rnKvuNGFPbbwR8
         xY1491OoBHvtS8T5prnJNySobHevK4mwJJrsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782408656; x=1783013456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Ns9Na0/3PBHaGaylTzimtteynQsaE2Wv7+sI3PG6dw=;
        b=l6OTaXKj+niOcGcQqWVNVBkR5L53z27x+bOPMlpPjajRGMBTad/gZdz69lW8MGdirP
         +WticWyvAARJuUAdpj/fdzCHvi8G1AwIvnLHeCNSCpfV7uOekMsgisEap7zaHQN3QsGp
         xWGxppGFIcKnH1gfOOGfx5Bh1Ja5A9Q8svC8q8mAyUmx5KNVK0KQCw8O12Np6Rb2Q6Xm
         AOaxB91uU13V11ZCCgVGvlFnFrArTBrwh091bMc4H7ejhZGR+g96fqkC5JdatiTSdl9G
         nyNUwLwJU0amFCHzZt/JbYP8ydl9DkE50cwInalxO84/ALhO5epKFfhPSMkqSufOgr6v
         wRQQ==
X-Gm-Message-State: AOJu0Yy088vEyr1PCQSauSyegpi2Byoj0B+3jQpIb9lo07KuUiAc+sL+
	e08nxVQ67nRBQfB6HeZrSmOR0wi5c9iZCVcevvoEI4R0UcgYdptpW6VPiYlaoPB+pw==
X-Gm-Gg: AfdE7clPR9ymHjJErR3KcEKKqnOKR7wje72IM2m7ebOJ1GkjN+0xKA3zW+Yz61Jll8n
	JHBsxBYA+qTTmBs1P4kOvyF0thNT03Y+RpVK8qO0hB6PHMXu7zFlw7lxPCuTpRBS+R4L0At9vDm
	O19LozY2eP/OtptxgU6YSpkckjc9iQ1OedqOB8sP7oDIZav1fKW0sH/Dz2NHyWGHKRX+sa99B8I
	9qxmj5ofdoXyxlvWxby7DiLxEgVRri9RNHNsdnogd90Z5S+Chh7wJ1j89n67j7MObwByBtmUSHo
	YRpurB2YglUlmB+6YgYblophgZ5Zrch7p5HLqWthbapaDgT+8D/4uOA4iwCl3Bj8Z5QkxtllSxy
	xuQLXjb6Lip3C2Dl7tpdlRGKcB7MwL31U4i5MWss+fuE2j5VGubYRI8dyuEq4mqU/1FudK1I6yt
	Lrbr+tlfcRTXldnCAmMlJ3WpBX6XbIuURwU3HLkmgs
X-Received: by 2002:a17:902:f650:b0:2c0:db23:4c1 with SMTP id d9443c01a7336-2c7fc63261bmr39873245ad.5.1782408656107;
        Thu, 25 Jun 2026 10:30:56 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.107.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac8e3csm24377875ad.10.2026.06.25.10.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:30:55 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 25 Jun 2026 11:30:53 -0600
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
Subject: Re: [PATCH 7.0 00/49] 7.0.14-rc1 review
Message-ID: <aj1lzVpxbxFz2x0F@fedora64.linuxtx.org>
References: <20260625125637.527552689@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625125637.527552689@linuxfoundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268635-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fedora64.linuxtx.org:mid,vger.kernel.org:from_smtp,linuxtx.org:dkim,fedoraproject.org:from_mime,fedoraproject.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45D766C7CBC

On Thu, Jun 25, 2026 at 02:03:12PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.14 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.14-rc1.gz
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

