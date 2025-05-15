Return-Path: <stable+bounces-144535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440FAB8807
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1151BC41B6
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0672634;
	Thu, 15 May 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="EGM4ScRm"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC5472618
	for <stable@vger.kernel.org>; Thu, 15 May 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315918; cv=none; b=ZB6eJ+OUWUHqSm3nHkRDnNBsz8hTXhpUIGY/ep8pGELvqDSGkh++oDA0eWuVh8SrELIQCf375w3bMR9Z4HLYzAOEHgLP4t74weFmiHccmlCG6tkp2XHtYv1bb0f2igZjhHr86+2BxXTjfn2jGpg2wMSMYwonmYTdMbHAuQeeaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315918; c=relaxed/simple;
	bh=Y8GGo2AMVQLbxKDyPRfMjRfAQBjFC7gN/PCZcDvLNIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TA3xwhm+sDtMk0Q4FyipISCIMlBeUCLx0TIUQ8F6B7zjPnCSlfVH3j09R+SOZ5GfXYGyvMRMHVnSV3AgFqSyO69XWrx7oPEPxmLQULl7KuUaIQiV3KDBie2E2E28IPWl6VDmXQ3Jvshq2fpTFf5IpGbmNE/3dkp0efzv9W1mJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=EGM4ScRm; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5568355ffso76931585a.0
        for <stable@vger.kernel.org>; Thu, 15 May 2025 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1747315916; x=1747920716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idQ7sd0YlO6Ua6mQ5kuc0PUAbrEds8+KAPjDg8rCdTM=;
        b=EGM4ScRmj1n/VlfczGUQ5cHVcYCC+BIk19rooYOGJRVROie3Do3pZ2Ri7j72vmyZmJ
         7xtWF78/oO15hpoBEEtWfxy18UtVRE3npxpuKGGy12NctkfAOn0hf4dEUYds4Bwe8UGC
         lIReRIQ12AhEQT/Qw/kIIjZK60VnuDpvB2olS4Pcc6tkXuMBQN13WYkBZO9HpR1lEiB5
         /VobMaDmnpGygaUzGMxIc8ztKjvrL8m9w7jrEws4l2+ta8b/PLKBMGuHx4oi62eXuDGZ
         jpCLEiduTnPE2vOrdapI+Uy4dQjya1Kww5LAHlCTPhZyAdHdOqZKiodUrncE7LcP0SbC
         fXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747315916; x=1747920716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idQ7sd0YlO6Ua6mQ5kuc0PUAbrEds8+KAPjDg8rCdTM=;
        b=QN8Len2RagHHs3GgYLPpc7MQQHsyX9tGGLCc8KCRaeUoEpXt/LovjGvQcw77uXrFCi
         qUJKH2fvOUSzQbKifrnWJf3b9oLZq6He3vO8tiUlhCTVTfMIw+Mt8LO4Ab1/hIboAn0w
         aZBskYVlZ5FGznkqCKNZlJHth3kuXcc7yaZ6coXdtaaf8a97VvqL+mkdsmtYNjzV5ep+
         aYJUndioYB8ntiAJjF10qHxcDFMfkvvbjgHDk7fnUJXnRFndTsOLeEOxHqx2SwZOd3Fv
         TtybddPk39c86MGVKLNSd5TE8O7hUJXBjJ4VX4hTKt+Nhk1eQPWhE3kZs1+kPOKbF/zR
         V7Vg==
X-Gm-Message-State: AOJu0Ywb5lrwlM/+JUYfl0mwgYyIv+1xSR/7Z1rGpxFvECB33gviGN8G
	YbqK1xaf3FwLkvLdvWNpkiGZOkOhPtMnXRatpXlqLlc0fUgl3VF1kqvlWyKBBKi3bBCzycSz6mF
	GxTLizVpE6Pg6BKz/NnVhNcp6ND1/9SI26Sco0A==
X-Gm-Gg: ASbGncv+44Pf8eMHT9A03+L2GxqNZVQw1qQpuu1wxr+1hA+irXKshMOcikf4ehbC3pi
	jxd7cfKg1D9N4/Tlzkioh+ypubEIzwS8sYOayE7BOIu7514RHZ6i4oUC8G+3a1zTQA8XEQF3NQR
	cnKG3g8yV7NSLJsChaFU9C91lEGk7MwoOt
X-Google-Smtp-Source: AGHT+IFftrViizvwzo527CdaZ+aGd3PB2+/eA4itoniQfclfljSm+WYpnBXwFNoTgGMvKSyjqiFv6xwETd/kIumJRy0=
X-Received: by 2002:a05:620a:2445:b0:7c7:b4ba:ebf9 with SMTP id
 af79cd13be357-7cd287e16bemr972802585a.22.1747315915661; Thu, 15 May 2025
 06:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514125624.330060065@linuxfoundation.org>
In-Reply-To: <20250514125624.330060065@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 15 May 2025 09:31:44 -0400
X-Gm-Features: AX0GCFt_T4qmlAP_NoDOQdZAbnEbFphd6WaqCYxvy8tpdv3fkVAu8JdgYSY-VoQ
Message-ID: <CAOBMUvhtrfhJ7s2s6nL3dSoq2a3YwrHV60eRQ5e4si6Qhu3tdA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/184] 6.12.29-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 9:06=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.29 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 May 2025 12:55:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.29-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

