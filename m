Return-Path: <stable+bounces-106630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9F59FF44D
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 16:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D619B3A1CF0
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F1F1E1C37;
	Wed,  1 Jan 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="GkvazkIs"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA58F58
	for <stable@vger.kernel.org>; Wed,  1 Jan 2025 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735745644; cv=none; b=JqcaG0uKqEJU0u6ZtB0tayx6waJchSzjNcvPS0CWodgyy1Q9JKncaqBFqymsOqNLWtSKwFbZ1Szaa/Z2yIZsgSqFFX9aMY4ZmxGvjQ95A4UG1d14WiTruXbfvIvQPCXwRlYAyz2nY7RniXxgwj5SfsKR5X/wE6MOINDZFLQsRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735745644; c=relaxed/simple;
	bh=P3+zuA+9A7xmJKZ2lRKOaQ0D+DuWoqd6XsHj041ni6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWk/o08E/awXMF7KkeAzdE7NzgcyBqA+XlP4GzjLtocm+IGlOixrCatBOccUU8EdHAOhScHzOTdtZggKLVuhXUgJv7WjpnkpLGMtXZ9uBGKAUxBzy76xeJWe13X96wPD1g0Ts64hShgFVUZT9MFGQ2Qo4nBjoNfqVwd7VbJxPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=GkvazkIs; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844e161a8b4so327451739f.0
        for <stable@vger.kernel.org>; Wed, 01 Jan 2025 07:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1735745642; x=1736350442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPYhkQDwj4+4j5it/H6S6WTOthbU+coHVFGtarpUVPQ=;
        b=GkvazkIsLMxn2q5V/Qb6NBT0HMIFx7UeUTxpuW2VwDXYlL23J0SSeHgrGY3lM8EqfC
         eZfNCiHTJ3sxfuf+aqnzTwdixcqCQnIjV/rwW3LAQuGsG1CiBr9vn8nKHANpm0nwe+O9
         mgLpi8rmR5OiBojWjycrTw1CQOH2Ur6+3UXbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735745642; x=1736350442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPYhkQDwj4+4j5it/H6S6WTOthbU+coHVFGtarpUVPQ=;
        b=b/B7IJ7MYqYpo6LXUNm6h8svFhDheEi5wONeBxNYrHRk7rTeLLTZ/whY3O+nTd92NL
         CUNvaSxqGOjh1aKvzXnorBKcaH6MxeU2guRpPh8tSEGXQB8RhZ9eqIoqMkSVBA/UuQNH
         5SeIG9e963qrXfCau60CHSL1NBYmYAUDhKsWZvlzCF4JVfrewGihOg9EM6jbyOKpYyCz
         P8XkOLMJ4ciCYjsBzJ7NoBlDf142nkmEOKMaFXpkSjgayZGpdnew9gtigVasAYf/IC5L
         kp+tPQCIC3GtkBjvY5vEPvQnLb/6vlQAaR9ctXNkjuAb2xPZyP45bAVZbBqoBjBTYe10
         9QIw==
X-Gm-Message-State: AOJu0YyKthm369GvxwkBgp4ex3885+UeIOtRQlzlI1AB48cFbXgEH1Wi
	WpuR4NMIsIHLw9cFj2LShOGYv/+C564ydf6nsm6b8QR0+AhqoKc9vmV3A1w2xQ==
X-Gm-Gg: ASbGncuLlH1ArMeRzY5+9QyCWfKwT5NSNg0Ne9QOJ9PYdDqL26ckWiFcSWHh2cB4rPY
	49gxoe0UyZkoXPvT8Dby0vCTwOS/GBu7oFUMsXE85O4fLdSXDyvSnnNixpyuK7Qce50d25xngKP
	0EDbyzJjWU7IfkUTNQW+bjdApaqpZfuxOM+2rxeamDgT//d5F6qoUyFWi21ZGXH7hZ8uHZqpHRS
	ymWMGwK8AFOsI+zp7YISgnx0YkHEIsYmitOUaPc0RgynclfR9ywo6vBXJD8QJtRts0PsBdo6w==
X-Google-Smtp-Source: AGHT+IFvgp6d0hYeTh0NULR1nCaecGwhILzPF1W1Pxmq1/RTw+ezT3kqzKOvIHbJkPMRYjw3G+0NJQ==
X-Received: by 2002:a05:6e02:1a47:b0:3a7:e67f:3c5b with SMTP id e9e14a558f8ab-3c2d18b388emr334369105ab.2.1735745641927;
        Wed, 01 Jan 2025 07:34:01 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0debdac77sm68798955ab.19.2025.01.01.07.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 07:34:01 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 1 Jan 2025 08:33:59 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/114] 6.12.8-rc1 review
Message-ID: <Z3VgZx1zJ5f8-jyQ@fedora64.linuxtx.org>
References: <20241230154218.044787220@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>

On Mon, Dec 30, 2024 at 04:41:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.8 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

