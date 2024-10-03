Return-Path: <stable+bounces-80686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EAB98F86C
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 23:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E6B1F223CB
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893CD1ABEA7;
	Thu,  3 Oct 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbGgPT4H"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D812BF32;
	Thu,  3 Oct 2024 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989494; cv=none; b=SiB1K2FxA2xFm8kxHPO5DU1wa6wvMP1t7ePQjrkxWEdx6q6lmStgj5u7sJD7hdjgs9JlyMOG+F2CWjNqaOhy/MpBiOqvgZKEsfxaUpN3rbPlP3rYBzAMHxkKFItAgrO0QE4TIMAqGh4aDhcV8USUqZORDORJxruXbu5aJOqgiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989494; c=relaxed/simple;
	bh=OCieWID+bbANtKcXubL5jg67fNWeMSGGGry/Ii02KsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enOlsh/XYZL9wo3Z5BflGGmeplkc+GbtZSqwK+BwfdUEnko3m6jX+Fc8Rq8GNwK4bQ0wxxLXmsmxrwwcoEaCIhSDpu+E+KosuTB4dZ249E9eJYWD64AvkTeba4bu163DFzRocV54oyLQurFirGDrdz5im8y2POt800LFRbs8nho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbGgPT4H; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84eb1deaf03so392254241.3;
        Thu, 03 Oct 2024 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989490; x=1728594290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5gQaf63hkNNcZ+deZSYAap7Pm/NsYaYJT/Td2soZD0=;
        b=dbGgPT4HkoTCMLI692b26BN4bxKf7T4E7yXGxsSgaCvUQQAMW1rQ8meH0s+jFv7a7A
         fUtoUVh2jpdvDMEtJ+HXu75L52b0P+INU9s6XItWtlUubpJzdOq1rVJTvpAsdqShbFMb
         BRoRlzq+2XSLAR/qhKUu6v2auKpDBl/rp8WSs2FY4w3OOQksKOCFVkF2AuVM49zSscp2
         9CpIIg4ISzfPvtjpIZdun3DM8N26UV4SQDazRcIynwa7OheGhwYuU8INhQGxXZq/+73+
         wy0QC8ZxyFhu8XriAixxAEMbdPrOra5Z4fv+x4ixHtNwC5Rqn/JlqRu1q7d+SqQ7/ZzX
         7klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989490; x=1728594290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5gQaf63hkNNcZ+deZSYAap7Pm/NsYaYJT/Td2soZD0=;
        b=w8vguKmgx1XE4nB6X/g9NM4GC7XT71fVG+8QECa9YO7Ez0rz+ZnGYi4n3OnkGee9kT
         WEhjYdleZvdpO2yEv3kOLn4p9WJbhXvTs57wlWggMsNbJ8l6zPu8EpwjSMqoprJ5REcn
         YrhBwdvLc0ORni6PiKtxWNd4bz1R66zbU7l4vEn7HjEtiSPJROe80cF54GqoIZosDNf9
         cmPfd3JUd2WROethMRp7jAzGNzBW6BYF5vlsePiBA6VJODzdgTGlcItaGN92gOD1xOMJ
         hQNV+UV4rAU0FiUPD9FWR4RWME2B4nrQdpjpLuV/qDKswzxnQNPBBe6esX0x/eLjK2R0
         8pOg==
X-Forwarded-Encrypted: i=1; AJvYcCU1CTIbSy3OWDqVZtH6SvVXZ8GXwk8e/RUUURYUahXYv4vyq+YHnOuHza5YVclsjyHjmJfhz4hZqtEzKjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgn32QtBXks/aJ3W57+JA6hGnQcI06BJzfGTKKAMPikGzIbdFR
	+AkkEVKH4xowCTlDoGrdf9LQ3siY8YoJn01w9ygwFqEdwp67TjNYAUO9taFqoDCNS/di6iRC/df
	V0+/+AniH32JlNCjPqmVRqifap6v7dxt9
X-Google-Smtp-Source: AGHT+IEnqPeRuhWH5MC2QJT18GB+oX5vHMjvBQAjuk20JM0hsn2zfIQdbT5FGpDoIZn6OMGAszgX60EsO0A/SoHspso=
X-Received: by 2002:a05:6122:2a14:b0:503:d877:b049 with SMTP id
 71dfb90a1353d-50c854741admr809264e0c.5.1727989490345; Thu, 03 Oct 2024
 14:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003103209.857606770@linuxfoundation.org>
In-Reply-To: <20241003103209.857606770@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 3 Oct 2024 14:04:39 -0700
Message-ID: <CAOMdWSJ50xQ0K2EdF075=i3b_XCh9X+vMMk-nzjS8TfYdFi2ww@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.54 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Oct 2024 10:30:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems.
No errors or regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

