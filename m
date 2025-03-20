Return-Path: <stable+bounces-125685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6691CA6AD24
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 19:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D717D17AFBD
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEDA226D1E;
	Thu, 20 Mar 2025 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="WfbHmWmW"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E38192B86
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495497; cv=none; b=l86L/0Hk5Q58XAfladDL78LP4lmHwESiIxTgO01Y5UguaeTKlOJRnKUrLXnFAEhUm31+QOPJKNd6Lgev/0suMu/Pzav4NdTUA6iel9676u2IX2dso6cxFLDZoOU9qV0KXYQNVEfMOuhqKRx52il+CIq+yb5ViVSCtiC5DsPQ8bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495497; c=relaxed/simple;
	bh=KW7c5R9LPeRvdEkyrrPNb19Z7ay+Q1gA6RBTzjIj+9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hkkz61PcoGLOYQW58hPQQAlXqndGbvGAVf2HCUYkHYh3sqYvhbUPC5Q15kxgsIfN3JCKmD30eb9OTS3kJsoLcUsT7euqJ4N/x0NaBOukh9Mx75KAcGnT6rWBUikR7dP6ptnKAsoDmnv5f992VELoHaYZcY47SYxqgCF8icbHvvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=WfbHmWmW; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso5070875ab.1
        for <stable@vger.kernel.org>; Thu, 20 Mar 2025 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1742495493; x=1743100293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xs9sWGtkq4Oqg7PObi/N0JVnImd5J4EMGp3yDmOQZM4=;
        b=WfbHmWmW/z1LpK8pe87aezjgqxjIMA1eMWPRTq/11QndkF0ZT7kWhoYqAUiW26/WCx
         EfcH9r95qfaTL0GrFMhL1Cn+87efV/rPlG1+axrm1EZ47USYrF5I64Qs8RwpHjRgoA2F
         e/b0xlJuZf+NzyvG4pWXtiBpV1rMZfLurxIFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742495493; x=1743100293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xs9sWGtkq4Oqg7PObi/N0JVnImd5J4EMGp3yDmOQZM4=;
        b=Zkefg4SaEyRK/TaPExnj0snfVKQwmhmb16O5L9E5wwSIZkorZUTJQvwHHSkvbu11Ty
         CNbxDk+te/zPOg0dm0uMPB28Pa9AecC46aH3TssXpfbdQ+HPlNYzyLcTlAXD+TkQrJQT
         p+Feov52lhntBhNmfX1mLqD0PvmE4VJ/Zz7BWsZUzZnHvJ5JyHAZliXp0y95V15G8+Dh
         5r1TrM2k5eXX2w827Bqm2K5zsIZCSN+0/L82Q20JZ0uaBnMjmvo3zcJ82gOqPmPQJwAj
         MrVQHZK4f/t9wAkO4+ygKx8jW1NtQzleIn6AfTdRKsOFzNmOAdmYWGmHgPCR2NhH3lTP
         oCiw==
X-Gm-Message-State: AOJu0YwiiEJHOOKMfyJE9lk3403mxwwB+/4VLXeovrWHKVIviPSxiWt7
	UskHvcNAA100cj+7kvD/TqFrl1GqEMALkQavOxWZaWmhHpCQ74KBGTVfKG05lA==
X-Gm-Gg: ASbGncu9o/dJsdttAspTza6UULZrDGajGAhK2rHaRW3VqWd/8S1LLnPXZ3UzI09aCYY
	L7CE5MVQoIrdYkokfmX+ZPzrY0Ntfw4NkSnQLfEw6YZCALPA47f8CId2CsK/GmpxA8Hgfqw7Vve
	Xe7NJozAekAf99sGbUi37x9+oxfNht4m5WZHdyQpkeeb1I1L3bu++gpbwLt4jKPhJKgl6MSYJF2
	i6VJ99kTn2ujS3ZAttqR3WQm9lYKpf+na1T/OKaJap8HkJg4ds+t9kGdWifEVFUx6wR7lC5D6gq
	yWTGvHTeHFgc5FQ+tvUtKIpzs+tiTSyzq+/Pt7h0LGIALhdMSeUQnZIC+9kp0g==
X-Google-Smtp-Source: AGHT+IH1B/ENspb1EAT9798Q5mHyvjf0wtm7TPVZ0us1pA6jy9nfdcYp5nR3VG+erfS7FWqlo6BnRQ==
X-Received: by 2002:a05:6e02:188b:b0:3d2:b0f1:f5bd with SMTP id e9e14a558f8ab-3d5960bf875mr5574885ab.3.1742495493404;
        Thu, 20 Mar 2025 11:31:33 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdd17f0sm45233173.45.2025.03.20.11.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:31:33 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 20 Mar 2025 12:31:31 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
Message-ID: <Z9xfA8UujBjRf5l0@fedora64.linuxtx.org>
References: <20250319143027.685727358@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>

On Wed, Mar 19, 2025 at 07:27:50AM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.8 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

