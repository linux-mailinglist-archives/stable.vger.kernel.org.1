Return-Path: <stable+bounces-60571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 515FB9350FC
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 18:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A575283784
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F7B14532C;
	Thu, 18 Jul 2024 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewa1XUsi"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD22F877;
	Thu, 18 Jul 2024 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321870; cv=none; b=Zx7BvPytw2MNpxQCy2nK0dDuJxx3rVz8U2NNXou0IrEmao6m4m+bBGrC00Ju3RTgNpSktorMFeZUeqx3B+u4hBZm1rX4BsstSdjoUydtEQAR4SZRp/Qof9ZuSfyb0tj3ZLZjcARdiLuQ/YcLVpahDS9519uSHE6iMVvuLupvYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321870; c=relaxed/simple;
	bh=yOZ2lVrysGgsrLNNF3fu3XFM79WD3lMVMxlnAodUu5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DclkFbg51foifNRxYxFxAhuWVghX+u3+b3HmbQE4EGJgwLcAP4lrrEB2FGzv5IQBY/PT76KH4UCbHiKJIi5hMiFNbjsbOCRQNx7jBgHJMb5qqI1MFd5FBd+RCDfiW0AXx4I+Vsc14sj3jLLsH6gHINvr+PReCRGvDZQ4SMGEpIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewa1XUsi; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4926a6b53adso322716137.3;
        Thu, 18 Jul 2024 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721321868; x=1721926668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpom6bl9hEnF3mAmDgfplew3U5KLsgSWL4OUoqlDDVc=;
        b=Ewa1XUsiWidLjTwPV2CDLuTR4zRzjT4DqReGoJi1dXVh8B98H3nLJi8n8FRSN7WmT0
         gj3NFzanKEzHZHw6Eiph9PFwZh+HKYzSd/FH+hjolG7W1nODheoKh0IJuSuE7YAD7z7N
         3Z9UtgEJ1jWiGB2bvJ1TgoOtFf4FUL4g89Li7fWNVMaGO53/X1OdCDBMZKnu0DKZRVw/
         6hdGTTBdeTfniWmI5bQ6yPA1G/hAMzMKllqTPKz2RVjHSIvkFzmsOaSPG57vN9+hF32p
         u43Q7U0Vi4DASv/D22h3NkDE7mueEsooZurEtuTfDXttw1Fc5gY+pBmjIuaK6o+ZtGr1
         qIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721321868; x=1721926668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xpom6bl9hEnF3mAmDgfplew3U5KLsgSWL4OUoqlDDVc=;
        b=v9syQ6IaPh9s+DRS94SXxXyEfwHLYhq1nFMGFGMCSJ1Kylc5s4QzCNBae/iauaw6YT
         ju9eZxpSnRK1ox+/Sf/Q5Qk3jtmPAVXRUGMu7kRTUUcyiZcToYLKWuQ5dNR3bHA5zOjm
         80N3zPAv5EdqkjluvHi+QgkZP0BFlLo5l8K72vb6cJ62cq+7LfJXbParRDLIRtGZG8OK
         k3+PEaS6A4AZ2/TBlRpdijw8AxvOoyVOev/8kWtQeAigdkNMjLbcPb+UlI7+MoDP3a88
         LX/w4lph/tnGDj9qSRd0XeiLXcTx/v7G87wED3S43u4D7vlQKnQiVn+IC8vybE0dRfOY
         Sy/g==
X-Forwarded-Encrypted: i=1; AJvYcCW5AkAq7fCYe5aMYnTN/debGm3CTD6E89uQGnobud8mssvXgOSESrbXAjMvv0EUD8B0r/+3kI3ZwHRLKYMH4dqjAOwQufAk5TRl5Ztk
X-Gm-Message-State: AOJu0Yynh5iBBdiXNyCPRMfvABOLcv3r00D08a9GRECnB6sHBa7PyYt6
	AXxg58ZE0jcDUqBcNQFMZ7FalYtuaF7PlAmWq2ZtLkrPndcYHNo6y5iIrvcWFrNDQ7YsnppCFWZ
	TkVN1rwtQG02xaIGlpUjfwOox3uA=
X-Google-Smtp-Source: AGHT+IHR6ThkLua6HIyn2QhH18U8FmhK7U8KNC6CQNV7Xsj3RxN9U+naSfkElXcxTQzC4BQqqvkGQQx3iFlgdJRnaMA=
X-Received: by 2002:a05:6102:15aa:b0:48f:79de:909e with SMTP id
 ada2fe7eead31-49159849e1cmr8033869137.18.1721321867791; Thu, 18 Jul 2024
 09:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063806.741977243@linuxfoundation.org>
In-Reply-To: <20240717063806.741977243@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 18 Jul 2024 09:57:36 -0700
Message-ID: <CAOMdWSKHSaQm-nEdRykxVfWXGM+ehBD6xfH6vk_ZGNJyVxoZaw@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/142] 6.9.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.9.10 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.10-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

