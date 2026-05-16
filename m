Return-Path: <stable+bounces-249005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AALmJpGICGrEuAMAu9opvQ
	(envelope-from <stable+bounces-249005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:09:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F6855C410
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1555300F9FF
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736BA3E2AD2;
	Sat, 16 May 2026 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="h/e/4rM3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9808460
	for <stable@vger.kernel.org>; Sat, 16 May 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944137; cv=none; b=Ns+zzbgQOEpexZfACVstiHloeXBv7izxoDgGPV/LBDSwPGY3jootuFJs7XPaURvm9y4Kpb4/QTC+VWYdOZo9YqbEawUWHDMacsFlWR0naz3tvScT6K3nIeuLavzGo7J0u3I1woQ4tsptHQ7XxJaqo/KGiFcMPk5R9GciQg2xV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944137; c=relaxed/simple;
	bh=HhYbxy3zEpD+7odCYgwaqqCvv88DNcUidcMyf7yR+WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd+bYHZ8QyhRjHM+Fysdma4uv43OILvzNuRri5zDf6pE2b3i5N9FdU9M+0rid7buHa3Qc9qnKfP13YzHuVhGMH2uPKYOiTpczfQF2ngTkbGy938GXM7vVF9Y1f8eDmmaD7Mm/tiZb5XHv8DJXn2Qb6Iasz8T2X6QkBWIl2taOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=h/e/4rM3; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12ddbe104ccso515479c88.0
        for <stable@vger.kernel.org>; Sat, 16 May 2026 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1778944133; x=1779548933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UzPVeljAfAnCgUHiqp0t3POZa+/UdpXL7GVmJytOis=;
        b=h/e/4rM3ar9fnJffJBB/Q9OhHT6Z0czJnObUuhBg4hetv3w0wBrLCZA307wl3KHxEk
         32TmMy2iXoMHAVBKPTUQ9BUrmBZZUrVgYXkGVd92Y3icucliuYahfsnAeOav6/TM/+4E
         Or2EKYilofx5HHYIIYKBiz5ToegVll/o6ucyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778944133; x=1779548933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5UzPVeljAfAnCgUHiqp0t3POZa+/UdpXL7GVmJytOis=;
        b=VRkYRZ3zdGSqy0WVeZlaUBimrSZxgQbcr7hrY5hGrD69lNNiHSaKlaEbmlixVsVFbZ
         6PXyz9+KBlkGPigeITi4Sn1Nj3MXi2YY5qSn7dIjfx19U04gA+oTgokb204MU55PK8Ua
         RU3z1dtB5dwmgk4Hy769bH6gj9l/Gf2zPMHh5kXVdqTb8yQr2Rv7bO9D5uXmBHlYxJ7q
         L2su5/q2bBfBkNYv6fxQ25Q+n5rv/3jmMPRWM4RcOAGLZ7hNBlUXLsiCmExYrnAazDMZ
         C+d3b/lC9gabhL02eBKukrxaI/xpcuvJ4YKSiB9C7MmuvSpkKwIkUZXNKj/V+Vr80Wgr
         TnhQ==
X-Gm-Message-State: AOJu0Yxu5cORoEvgj6MhGuCCMBm2LQoS3uItIHcX6y6o0GF6sVt116eR
	09bMB9pVSRWk6Oev8uCs8nMZ1hz201sIgVvL0h1Hk6xQnaR/67Inn5e79fl1QlG3LQ==
X-Gm-Gg: Acq92OGrp8QnWOLzcGQGxyfsSlB/N2amcbELD9TLA1SP310jBoiaho44fZstwSwzmbq
	U4wK3lwupTIN9PFPxmtKIC/rpc/wIVx27GCcQNfkt/FqX8KBIDvojy5wMhGaFPZk1DesfhUWIHQ
	OOA4apwMLqo3P2ezcVb1YMl4fnfxAIDxV8Gay1kBhWSs7ZjtnW21wCJh7Er2lpXQ2MfWCAdlgz7
	kjV5iYXNpi5xEdhLLLAjQsSHHT05LYJ9lwTCVU0Zwp3SoCV62mIpk1rYcpkX+rprH919LUei+O2
	B8yRQY0T3pEd6YuLQyZQ9ddVc6BUBrKpiQNX3JghwxL6MHJDYObX3qdVIHWgmh65dlLIsR8lBRE
	5r3EFEnHO6c/p1detKsjN3UY2vydOuBkSGmXPAFHZ8QPOfLzVFgMFzKjWkw/HFlQDHejG6k7usJ
	BqKYCR3PH8vIzoxKLLT/7uGQ2yUF7InvMmQz2pFm0ZDhluM2czBBI2
X-Received: by 2002:a05:7022:2507:b0:133:679b:8f96 with SMTP id a92af1059eb24-13504950ad0mr3419247c88.42.1778944133258;
        Sat, 16 May 2026 08:08:53 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.106.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351c3sm14925442c88.11.2026.05.16.08.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:08:52 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Sat, 16 May 2026 09:08:49 -0600
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
Subject: Re: [PATCH 7.0 000/201] 7.0.9-rc1 review
Message-ID: <agiIgekiP3iu1lOx@fedora64.linuxtx.org>
References: <20260515154658.538039039@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
X-Rspamd-Queue-Id: 45F6855C410
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249005-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fedora64.linuxtx.org:mid]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 05:46:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.9 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 May 2026 15:46:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.9-rc1.gz
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

