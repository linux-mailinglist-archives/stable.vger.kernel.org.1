Return-Path: <stable+bounces-89232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46509B5021
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 18:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697962841FC
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416F01DA0E0;
	Tue, 29 Oct 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="DAVKcMtS"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006671DBB0D
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221636; cv=none; b=S4skZbkrojC72AGMK9jXx0gCPj5opn2P72adxx0SJPKeqrv8YnMpO/WbpygX9sGF3O8EXVAZEMcK3l7a9ki6vQ/a9ot96G9Vk1ZBEGl4d7qKzAhQ4ddcKN3tvDrJ5SeTzbu7X3lqzXBT4TEUuCot2rlyjSeFcCP1ShvJ15Y5u1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221636; c=relaxed/simple;
	bh=HIAt7Xdq33eEcSF47rRGWWp8L+H3VMAAWWAYqZoatgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcNfNp3aBpHpqOsx+cPN++6Pi8/+PAITZzBryjVHcbUrNfYGuiwQQssAD9I4fzoEOIXFawoYGKHTMUamVO8DQPo00IlhE+xaj2sDBfqbOGF4KPHdUxCuAu1DfEReVY6VsSm000noFDRtkgX0omRPfY15ZWak0xQvw7BRkS3DQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=DAVKcMtS; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a5e0bfc7fdso1672535ab.1
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1730221632; x=1730826432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prNOXuzq2k9yHwgN9GjPKL//CDayG10KbbsLQkFhgd0=;
        b=DAVKcMtSJt2Brj4Rc72qMB/vQh0i9ntbDU4KNo/TaMxI+ZqoNQV21BBGN8o0fLqkmc
         3aOMVxAZvwMzHktylxXkv4mne1EAYRCv2827JQLFOW5ExlyE8H9+Z3u/7jcuj7sPEMj5
         GJRbIvkRje3Nl1tbs+/kJ+OQstl+Nuq546Al0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730221632; x=1730826432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prNOXuzq2k9yHwgN9GjPKL//CDayG10KbbsLQkFhgd0=;
        b=fAgM+fDseQV+s55Y9XRRpp4eav+PhFiNfIV91qyTj1STWUR2Q3QEJqLANOegPoXqrW
         NHm7EOuy0VaBeoaeDf2bCrNMgy4LVA2IBAeP7GHsoMHHpW+PCNbUqHpynDuvZrgtqF4F
         GZXtn40nxGAPKXg3R7QwNyvySgW/NFX6jDSPCy90joVauO7mvjq7mIXMmbq8cQBuSZGB
         c92WTsM/fQ5NZNNurGi2goCZ5xBameW+rC8oV7FfN6n+4gT/hcRNaRmlKoraD9RuHzFw
         9tcxqa6FF3+zOPtX5xV+dPC56giUmHjahzfSyflLG0SX2woGnBvhDHE65HTQoQ07KPYN
         0hhQ==
X-Gm-Message-State: AOJu0YyxHSl38hWBHuNeENnwiPHM0DxFbl63RpI8YucYHV+bHVp/rIxL
	giW6ysGQaIt8hNPQSUojD/ohrPJP+47eGAqfn0T+BGbaxByscj5/LBD56colQQ==
X-Google-Smtp-Source: AGHT+IGN9Ci4Y8VOHnsfF3L5QUISAu+V1eVqvAiXjJUJFmaZ1nzDtFq+vrmYfNB8DmH4n9y6WW09Ow==
X-Received: by 2002:a92:cd82:0:b0:3a4:d9d0:55a6 with SMTP id e9e14a558f8ab-3a4ed2f4ad5mr120407025ab.19.1730221631706;
        Tue, 29 Oct 2024 10:07:11 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc727b245fsm2480505173.179.2024.10.29.10.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:07:11 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 29 Oct 2024 11:07:09 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/261] 6.11.6-rc1 review
Message-ID: <ZyEWPUUCBMQArAP_@fedora64.linuxtx.org>
References: <20241028062312.001273460@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>

On Mon, Oct 28, 2024 at 07:22:22AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.6 release.
> There are 261 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.6-rc1.gz
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

