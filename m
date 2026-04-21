Return-Path: <stable+bounces-240197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMg7Cgyk52nX+gEAu9opvQ
	(envelope-from <stable+bounces-240197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:21:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D043D42A
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D69BD301ECDC
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3166936404F;
	Tue, 21 Apr 2026 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Amopl5zs"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4F363082
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788150; cv=none; b=SgaN6/ebmCm52onITRPLVd5W5Ubr93a0+gbJ1o73bYQrTUe5I00AgrIO+p3unUXTPYbje9iGY1TNY9ziuSqYcSA7ToeHTlhcM1TljQMOvxqFtFe6dQIXCsoD0kmtUvARbUNfLdrOSPuu2mFHlwRQjiWaJ/jF0o9pLltmM9yIt44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788150; c=relaxed/simple;
	bh=kLF2LcSyU4zJ+YCdge4/3hLDrdrELljSrKYDbqyHqj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPKoGLKnseSSZejkQ1s0X/R2iO7abqJkjaxxtJcKSxcqyjxo0vuDZqYPewsLqWoqZtko74jcFO1KiCkgesN9wjbmioZFK3Z1TkvSdA3AdT0FGBkpUTlieJbWsaSBM3lJKRl/Uv1p/eVYWiur7T0rDuEU0KDfO56WSCOd2aw82Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Amopl5zs; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2d8fa0fadfeso2351898eec.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1776788146; x=1777392946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A982EMvWd08NRtGResjdhAZ4Rp4Rh1A/m+2DTpYS8U4=;
        b=Amopl5zsKb6ie1rHX+hVuo9JjSwefWTXrkZDlGD6N2qPvHeW2FxV1YscadJzlwuJnw
         kFL/jqIKX9JhQ1y1MMfc8RWPUW1+0EGllXri/kJAY9TYbO/mg8K9x/A9Dz5Siq3UF3MX
         47LKci/6r049OWt58UFrLXv/J1IgKWzzaClP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776788146; x=1777392946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A982EMvWd08NRtGResjdhAZ4Rp4Rh1A/m+2DTpYS8U4=;
        b=ZfbmoYK+9T/0KDuKGLP8UExe6QFiTRABZno/biNKfOerqPkmtMRptJ/kJI8Gudrhgj
         sxjC8Q9BffB5BPFrzfbjQyoBhW+QufGOJ7ascaQP2h+lMeAgM9uLdHeTZWXTl7ETXwcL
         42OBVtD1TWXUCpf5SZCZgAS95miHg9TFCxijeJlj9HmIKiIjK1rbKEHT70gPHgArb05+
         IMxRuqmZsTkwwfRYvkJLcAu1tJjtna+D5ea7CLHP8jo4phZjEBxUaUgOPF1lfkQeNbWC
         iWlbha18CFYv8eAm8lbo+5w9wnapT3/4kJvnZZp9WyyoCPWcZhBe3yGxYkMLB5Gg0+J7
         Fb6w==
X-Gm-Message-State: AOJu0Yw06quwX1acaHIJm1dc6ps/j9TWK3Q/bthp3k747E3FzjIFPhrQ
	7r1sLPp+5X0sJJnbBMn9Luo6yt6dWvAVy+QSi0B4xnHD+Fcoot4tLGDaoHJLFlPg9C0JpCviOTi
	hlnERtQ==
X-Gm-Gg: AeBDies4gooX6ppir9XPAQowuikaoxvRdW6oR1qXZQfOv6SDv9GIxHIMVy8yhfl1pu/
	c7NdLXGnGXGGZLfmcfPocx0gpXerOXhaM4CBi66ZM4mOHBCl6qIEPjT/11SRROmnX+ruN0fDykN
	BN81oluXNPtRuWHYol081SACTrT5ovmJIECb2TjbHwpl2CkQCkJiIjzICka2bpN7OcH5WRo6QSJ
	rzQ0Zk/THFhZ6oPlmzdu/VF04OUbRLZQiuFPqLftboGqRKhYG+DiYkAyhI13d2ZYIZn8+fKuoXH
	qmdQuFn1nQ8e4ErC6Up+wxV6HWV4vrGVyI/nwhl5ZXiADK+VVDRXu8ueFfIfLgCa9MUZBZm9lCH
	4/JJNZbG5eCUbsCLYpX+rnsw4DP4I2gl547XrAAGWipA2bzMvb6gqBD+piVss/4qQpbQgQ8rpcp
	tTrjnb/B2jMxm1m/D+yugJpCN4+1hip24M35PMm8w+cVfV5kXb3/lR
X-Received: by 2002:a05:7300:e12a:b0:2ca:bd22:6102 with SMTP id 5a478bee46e88-2e42e200939mr7251603eec.14.1776788145693;
        Tue, 21 Apr 2026 09:15:45 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.105.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a64e5sm19528239eec.7.2026.04.21.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:15:45 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 21 Apr 2026 10:15:42 -0600
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
Subject: Re: [PATCH 6.19 000/220] 6.19.14-rc1 review
Message-ID: <aeeirvNl6Ia7yFFp@fedora64.linuxtx.org>
References: <20260420153934.013228280@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240197-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxtx.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fedoraproject.org:email,linuxtx.org:dkim,fedora64.linuxtx.org:mid]
X-Rspamd-Queue-Id: 7F4D043D42A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 05:39:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.14 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2026 15:38:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.14-rc1.gz
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

