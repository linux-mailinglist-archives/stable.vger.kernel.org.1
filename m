Return-Path: <stable+bounces-78152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D0988A61
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 20:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7D6282422
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 18:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD1A1C1AA6;
	Fri, 27 Sep 2024 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="htT5hZAv"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16256136E28
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463119; cv=none; b=Nfhk1ANEVjh4kKDdoVJ5ZgWn1LwdDsgpyjUQsBjoV/++iEWlaIgUgPDWEj7jxjEmJfZHnf+HBJe4f7z1YiZ83keD8/6p5J24/kTic92aCWyJfQq8OXkPv1sQH7u5mb+RQOYIeD0DJV8OFC9PXU3UHbWesNrYi44oVjAkJREN0LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463119; c=relaxed/simple;
	bh=eITh1z6ROeAVjf34DngYzl3Vc0FLZBZpfykTmNZoXY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDJW3PscRGKUtg+4u/X1qToVfNinO40BdwcPHybI4rHdPeb2ZO19wylYIsnlPC1Zf5scSJ77unThOE8UATZZcmQcfAOPKjwzMU+YHhj6ETUOEMGr2cTDNBmTvC0VyH3c1j8OHg5Jt+yt2a2Ndd5aGRTPwo/4Bsc6g8lroNwLQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=htT5hZAv; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a34460a45eso7306905ab.3
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1727463116; x=1728067916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxyQQgkA3wMtE3Hi9DOhcULcCDQzTPtIVdh2jdevVzY=;
        b=htT5hZAvsc4OzGUhVRT0aOz+u1Tj4OQsqKOwZKMxumVI9srorEk0Nkt12LoxPPkxrb
         G0ENv9lBv11YkPUPnrnrQ88UNsBJ9rhNuIF1jqb7VFlQedkvWhZ8RBzmXHrSNo6kHAEB
         O1ECxrFJ6/QW8fe0ceXVzejqRAZZQqcOOLcUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463116; x=1728067916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxyQQgkA3wMtE3Hi9DOhcULcCDQzTPtIVdh2jdevVzY=;
        b=BBLlc2be9mOmiMQWdk9bFt+2sFlFm8TD8PNBF7avU6ZdP+PEd5swGsTAvgftsnBeWr
         fYXEtlBL0kkpAsvvTo1Eld3I2Og/BQop92CTCZaNxrFEJzFHAIE/4vA3xiNo3jidlhjZ
         HtkwaPgF9zgn54+TRpBRdFYWtapYEKnKuEw1+O4S6JqzCACq3f6JdopBp4J5is1hN/zu
         FbbxSp+WLEp8i/AC+siT5f8bbnu/NKqlWNAOHyW5N/mkquTuqmDuv4kH1PnOGBbVCI24
         m9LeNOjEZMWKMzuVTp4s1rb8pk/HLAdTbkOXlGoNB171TlMNQr0tytHhE5EfZ3u5AvKb
         B70w==
X-Gm-Message-State: AOJu0YxFXp7DPPG1T6Dx1CGRvl0yH878X/0EEGyzjojXM/UeeaG1oAn9
	l9VBU4PdHJemWn+A0bjQEGtjeTOIVsHieeU8S6qSqLP4Sh4dJyK55SZ/XejMog==
X-Google-Smtp-Source: AGHT+IGBJMHjU3F3oNzrEVYyvsCJoiibFm59q1GvVFt61CRaclCtx2Dq6FUyz7K8DJ0ILIP0e9KCaQ==
X-Received: by 2002:a05:6e02:19cd:b0:3a0:c7f9:29e2 with SMTP id e9e14a558f8ab-3a3451b691amr37024015ab.19.1727463116011;
        Fri, 27 Sep 2024 11:51:56 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d82ae5sm7443195ab.28.2024.09.27.11.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:51:55 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 27 Sep 2024 12:51:53 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 00/12] 6.11.1-rc1 review
Message-ID: <Zvb-yRASvJclm4hT@fedora64.linuxtx.org>
References: <20240927121715.213013166@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>

On Fri, Sep 27, 2024 at 02:24:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.1 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

