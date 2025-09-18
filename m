Return-Path: <stable+bounces-180524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6ACB84BDE
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA727A53CF
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 13:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC86A308F2B;
	Thu, 18 Sep 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="cvMyrK4j"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BE828504B
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200933; cv=none; b=R5WT5umT1v/sJk5Ckt2jacMCdqWXb3mB9j/G/9QhoL9z2fVk56ZrfTC1fxvaPt3MLl8mot8kq9ea+JXf/iX2UDe9i74Ctg/fYR70tnhA/19CZhq9ACVRhUCy1rN7IeQgc71ggWBI+9FORfzraMEVbMcKvF9/U2tdilemQb3s+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200933; c=relaxed/simple;
	bh=MiPOtFlUbt8t5mkkoOEMpCXHDPi78OTH6xbWfZ7DGRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6zgRiB0k4RJvcxDh2ANs5VqD9VBmzsuZ59DGgKISCTyCrr1Uw0vHAAdMOFwAtlyHnqBeGPICy5yqib/MeCEGzQcEMtGvi2HtcWS9BfjF/uV6BQcdZ6ESrQnmeP/ybCkujfGqFfpj7F0gIUBb2gOxO1ypnMiuS1gOSXQ9EfEciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=cvMyrK4j; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-82a334e379eso60630385a.3
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1758200929; x=1758805729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGbQKBDEp65TUh3jBVAZzg6GKFTf8pj7WLSq9aZrdY8=;
        b=cvMyrK4jw4vXNIEmJIAqxeK+WB2a5AleM0kd36tdUhN83d2gvUm4D18z4abCD2OZM/
         RDPW7kfBZvXJnVmffW2hgJNR1FXL7wto3Z6OuR9tgIH4BxVfonT4vi34msow4JAP1VfH
         zvqJOBjL4OnJJmeeK91u5mpLL+co//VguE7dGoKLQYZvQFyoSX2E2e92YvGp40AX0Nhn
         ia3/0xq27A5XL5PC8hAcvpvKV098JO2ubsV0xStnQ5Qz4sF/y/1MYAvkQaREK0bqGQMj
         Mbyt45BzG2gHz/ayOm55WR7yt4L+QukdAoOfEI8KKUu8WpQfcIawhX3q8DihyQB8J9/0
         /q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200929; x=1758805729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGbQKBDEp65TUh3jBVAZzg6GKFTf8pj7WLSq9aZrdY8=;
        b=Y1IL09cVGO/OVCvQKBoDR0VrpIa/4Eexc8QWKKnUAo12o5Glkkeq4RywzSHkeJWJhS
         Z42BRl4p6JFb1fjK25c3RzzOdV5ebVaCBrIt99DNStRwFXk+uvFmtk7LlX5X4oWEema7
         3ytxcB4DIKcGa8xHkGiC/C8L/ZCCA5R40j0KSsXQeSB6I13SVcuEf5Z0H4hUstK581nu
         SxNcZuld2Oj1bLiNLPXekAKjzfPE9gr4EicRxBpY+rbCKCzHn9vzcKyubjwDPWyFZKqh
         3JCMvAvCVFfWdfS/3na4KA40GI+7kixI8MrhFvVQLg5mqhAtwu3NDcEE7vlDvTEQLcV7
         ZxyQ==
X-Gm-Message-State: AOJu0YzpLlO663KXe6SkEXLiIE9m8MsxwblbLmrM6VlIboOLRFul1YBo
	129DTGuHTDPHY8/eqNi6PrepYpj4X9PWm5ca2dPyfSa+Qa0viuch0dFF0xZP9da0OZenGveiqv6
	akUsOziXHX5mexdtx4HldIwFEMTejDy0RucKX0G4DSQ==
X-Gm-Gg: ASbGncu8QQQx/oLbNo15BSAt1GoZXc8zCxmjipsorZZRVd9MdGZehA/bpdCi3tgKJ8N
	UkrBdRkZZI8wglNC6qOrWRmvEZ3y6pa2zYF2Y6gius4cr7OnO+bQTXdgYMUZ2KJlBX+JPpp5+MK
	8ivciJpJE3ZPnlA8gwmNH/cp0QxRAg+yTjxbVfvq7PziWYxRs/0TG1xd8pd2h3nKGSnOhiiI5rE
	4ajVKz27YLzqRN+ox9CNs9pTvw=
X-Google-Smtp-Source: AGHT+IHelxpl1f80CJWLjoVJmEHYdJGPILPJ9Om10uXhQBYkh+errVXpSNl2QIO11FjsrjCy/TZGGAjpjeDzf/ykliQ=
X-Received: by 2002:a05:620a:29c9:b0:828:47e2:f407 with SMTP id
 af79cd13be357-83110afbe1amr582735985a.60.1758200929182; Thu, 18 Sep 2025
 06:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917123344.315037637@linuxfoundation.org>
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 18 Sep 2025 09:08:37 -0400
X-Gm-Features: AS18NWAnVFAbN7cGEMPi5uSP6yfieOtzy8GuF5GwV4ANGOF8knGeTQaKAOU9C1U
Message-ID: <CAOBMUvhwfizZxP-YT9LsOwxEJuasazs=JHhh44EkLzoE8q33Xg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/140] 6.12.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:52=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.48 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

