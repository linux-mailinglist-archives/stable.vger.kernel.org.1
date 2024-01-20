Return-Path: <stable+bounces-12310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4183329E
	for <lists+stable@lfdr.de>; Sat, 20 Jan 2024 04:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9DE0B228ED
	for <lists+stable@lfdr.de>; Sat, 20 Jan 2024 03:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A86110C;
	Sat, 20 Jan 2024 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="doufZz9q"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DFC10F3
	for <stable@vger.kernel.org>; Sat, 20 Jan 2024 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705721507; cv=none; b=LbE1FMzgHGQHHt6oB/D9FN7KKhVH7H1UQKcEZhbjOZSDXz9R3oldfhHAiX28Oev8vDmqhcw9Gvgrrgj3tvLANT4X6+1q5j3GGVqmMhrblUxJ/OtCBUcoma4leEJUCmHEUimjJkonE5ifd6ViQoER8y0xnIRiF+yQ+GkhA/tDEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705721507; c=relaxed/simple;
	bh=LiSPUDxF3TmHtS3WNwEBf85tybfySArv3gZhh983HDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqv5DI4/WaKoG984UhUvU1cM4GA/ntA7ZJLUsRZkN30bFB1OYUfuRYIOTlzvMyXkbnMGzWdnulTAjEOV0vdc9uUJ7vUk61HhwAI5NvAxGzGUfkEoAxfgOmL9YKKDZ3dfuwThh+PFgDG5m41pDUvU1s3HOJIhf3B8UJ1YOOR6jvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=doufZz9q; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-595b208a050so776468eaf.0
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 19:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1705721505; x=1706326305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsJxldHn891bCc+jF0VMK7q05TkM2hxbbbR/mc8mU5o=;
        b=doufZz9qKHii2JpNzq8AgG4ZBiSoi7LoiiDa/BGY6wkAJ8evVnppWIoFIJWqd+wVJe
         9eTISOXw+2QTFQq/wuFzd3zg0iWjmQ7DZjyGKRjvGUx0DwjJ3kbEqN3yzS3owmzH/Jya
         WVb8yTP0CWfhKjoAqYPrqWeus1mydVMvxpch4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705721505; x=1706326305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsJxldHn891bCc+jF0VMK7q05TkM2hxbbbR/mc8mU5o=;
        b=DbkTAkajexVhTc77shExtoag1eVcofPdRJ8WmAjlziif9Cmx1N3X76sdfvZV+HcfOO
         iBH/n0yCmSRsJva+xly98CemCyS8h5Nfcdn0kU5xD+/Q5lEQFyNiDVoMhp93mLLPjxIt
         0mKrBDFRFlYBlgWo1Fj6M3fuvrBwwuoXpO1mafGtu35uG4076J2O4UcLhl4E7kfQkfzK
         ZZDI5iBXO9BwoobiYtn5SnsBnrA8Dz0ghTcgZe9uBl+ILhgAXK3d39yvolUkwxS4QUbn
         VtGGY70CqfGqPn/tZYXEatpjHmB+aT5axF+LC9/ZRmSUJNDH07W72fWIKc9dWNexO6Ef
         lefw==
X-Gm-Message-State: AOJu0YwA3hoSCG4Kd2DDEBkpZBu4mQhjab1owq2RC9a1kpw+uen7l1nE
	IxBbKqotbWaKfAcXCk26ctPM+6ILKRXBhjk0arXqDJvnb1cHcb90v4cHiuR5Mw==
X-Google-Smtp-Source: AGHT+IE6d+GxuDRAZdnj1d+lu43v9dxXJW5a8mbWwf445bisVKaPKSX6ily5JD1X/KvpuaG9fqlpuw==
X-Received: by 2002:a05:6870:b6a2:b0:210:d74f:d3dd with SMTP id cy34-20020a056870b6a200b00210d74fd3ddmr836265oab.103.1705721505289;
        Fri, 19 Jan 2024 19:31:45 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id hb17-20020a056870781100b0020655a8f247sm1135783oab.15.2024.01.19.19.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 19:31:44 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 19 Jan 2024 21:31:43 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
Message-ID: <Zas-n5xh6QaNXLpC@fedora64.linuxtx.org>
References: <20240118104301.249503558@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>

On Thu, Jan 18, 2024 at 11:48:50AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.1 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

