Return-Path: <stable+bounces-45351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0FE8C7F2D
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 02:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95457283817
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 00:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115CA399;
	Fri, 17 May 2024 00:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeLKudVd"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB66387;
	Fri, 17 May 2024 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715905716; cv=none; b=i9jmzr92FiyVVwBr4j6w9+cD+PWMLfnhf/xco6HzcOUhiNxsDFiRrTNLIenxv2REXOKGThgqF9bPz7shexQf8wyWTvwV5vzrK/yBA6SrnjBd5/TG9+//00zCz4EafyknyCVhVRckHVP7EWh8EwXcyJEkMOitOMlafGw+rwoHodE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715905716; c=relaxed/simple;
	bh=CkO8SGr3uIUI/OgequQPuoLhpOqUITNQj9EK8i1IjnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLYuBtr04QZFlw8PsY9p55ApHa4v517u6p6xaUvDXedXhhIPe0ovEP/kb1gGsgIGXCHhqlMeTWwAEmjety0Ehs2u6vS2xwkqiVrRzw4BYJeDWfPro9oDvK+LahmyPfIW5o5lJcojZzgPrUIVTPqRWiu+W0AnRtxPLlXDd/0SIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeLKudVd; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4df6e7414fdso60430e0c.0;
        Thu, 16 May 2024 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715905714; x=1716510514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n/jyAWPQcY8kSQKEOoekqeq1mLd+RuTg+/71Ne2/pnQ=;
        b=UeLKudVdzJF1Cav1seX8a+CI1OVfk9M05hQXBrzi81yAIiIwegAwU3k658RmQRWZql
         lippEB0u1vWC51HRgeipUZE/WNkIjiB1XD4dQ5TiA19tDzx2IS02dsOYMbc3suF5cxzk
         I6BWewyYPvHSafz5fKMm7wzULEq7OGDnn22U920O/5p3x7YRV2v+c2QJohjKT+lA1Mjq
         4KXc9Yb6Mha/O3TFfn7Y9JZMI8fEB3ip7lleo6VEXDN763gTniTWcRtyQVPP/XVthDmA
         lVrRsyIhVtwYd8CVOkMHNYG8+TDxYtsEN+STPaGzNdX1dBUWtK7jxgL2SM+7lr6TuXiF
         NQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715905714; x=1716510514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/jyAWPQcY8kSQKEOoekqeq1mLd+RuTg+/71Ne2/pnQ=;
        b=iKwb1UEBNOrBDjWUnWRCZ1u0txHIiJwVM82MP6YXgtVMSZHmB1PjKerWZ3kmdcC0JI
         3a0FEZXr+QeB8nQxJdKoUNWcj2DwjQLfmhrBCeqaD0KEMTC2f6YRlTe98oJmyAzvaVLq
         VspRDje+Y50KtDmI3xnaQ/uSl8ZOS0eJK7ToBTXNheQyPZTb1wRk/2O0w/RmZk66MDcd
         9vfKKxug1IO+ker1WRUiCPLt6mQULbaZTeLrT+nfsKYWo5JdYavIdCelYQxRjGMGJLoP
         i9ockXVdSENsEXZtlb6DYpRtWYRjo/FMlsV/5Q6ZIPWg32LZwhyRskdxz5MVeqfAADLO
         xkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrY9y23cO1OU3AtTfRc0xDlSzqnQMRDk8RKH92ov+PjHVH2EXEZwLZ/3arAgs/0amECTS1VTXgfdPq+xBER7OSN9DGJtnPl3E0DHDF
X-Gm-Message-State: AOJu0YzO/64shWmu4qi2SGRxvdy1bmK+loGUOLPyJV3NBQ+JeVe71NjR
	NHC/vk3KiFbUWpBKa9A8M9bW+DjcSS6K6nyFknpjhQqvaMKz0BseDA2wKK3LbsjxClQnnTQzSVh
	8C5DcZUF9uoHDEhOQZ2IQ0PvryIs=
X-Google-Smtp-Source: AGHT+IGZIPNNhi/2On1W9ZhO80r2OJahAqKc9Ee7yecm4HVWGUZQe22zbWas3dFzHStJmIZDph3hjW9cby3ssEJmJ+c=
X-Received: by 2002:a05:6122:318d:b0:4d8:7359:4c25 with SMTP id
 71dfb90a1353d-4df8834b266mr17676695e0c.12.1715905712899; Thu, 16 May 2024
 17:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516121349.430565475@linuxfoundation.org>
In-Reply-To: <20240516121349.430565475@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 16 May 2024 17:28:21 -0700
Message-ID: <CAOMdWSJr4eN-V-hD6UqdQ9aurk3RUj_A+3fMk+SMREhasGk1kg@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/339] 6.8.10-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> This is the start of the stable review cycle for the 6.8.10 release.
> There are 339 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 18 May 2024 12:12:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.10-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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

