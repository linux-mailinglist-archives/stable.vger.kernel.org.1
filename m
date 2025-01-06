Return-Path: <stable+bounces-107772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF85A03352
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 00:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA3188501F
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 23:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D01E1C0F;
	Mon,  6 Jan 2025 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="R8jLBDNf"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E051E1C3B
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736206274; cv=none; b=jBs2iPtCrKrJrVbL/uwDTzpJ+7Z32qgsy6DTxKnDcIjkZeZhMDmJlxdwJzxBnGv0J3kX4Xr2lchQe+tAaHoAN68yNL/6nRXaQzWh+6fGgRb2qmqfW24v7L7CIinxi+YQ72b+TbX2fO8Wd67jjC8MuUrqE0kTxBb06hIHts99ExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736206274; c=relaxed/simple;
	bh=m0Ruvlbk2rLYGuubtGxVDpTBs86LzBej6l/iwJrupq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paImBMb/Mgud3p9HGiK7k8zMlAl90edu1rNhLGCtQoSYbPI+zOVmpg5rnb49WUEude7syifASAstppVj/dLDVte8ngIhEeWukuvyyZOQ0lYrBsvzhvMrVL4ZfET8VCsqBELmOBDMF6MC3Qg1b/397WIQlb6j4XlkHNnuvUfGbwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=R8jLBDNf; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844e61f3902so1268626439f.0
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 15:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1736206271; x=1736811071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIJfvJoTSvwqCL5KggXgWrMpXk3NWjGjOmhHlx+Sar0=;
        b=R8jLBDNfYpPjpdawTAX9StEhxiSr7U8P6H4JXJ7Ws0iTZptxCzXl+zz77EnV+Cnagm
         uiUh6IsgWuV4ncUjzonOVQBP2RcC5pUZPcD/jAJKOqHihjYUoT+nUEDoxhAe3yVGlB3q
         uktGfvJD1sg1T7PfN3AcsY1PjodOvoee8EIu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736206271; x=1736811071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIJfvJoTSvwqCL5KggXgWrMpXk3NWjGjOmhHlx+Sar0=;
        b=S50pId2Y+W/ATBk3ggIU/3u2l4rfCG5NxjrVd9P64qJgBzfu/FFN4ia6G+nj9WjZ1e
         lwIw0J+9p0MgXTSUMeFKAJ5hm2N2e63EaKZddYZMy7Hw8h6WoOa3lq18wx/PezBU+tze
         jydswahtX0XpF1b3mY17bH9nsy5b/iRmZOWIDS/G3H7nFO2UpNASNJshc1bI+e6se+lB
         lCdwLpzXXsDA7FhPtEslOjzhSgSOCgcvni9tFehdDy0ukUU6UYAXBF10eObOiSRHON6u
         yzwMEeuUQvA1x+bITkhj0bDRn9Clx8+ElW2MJGrpxFmTUf5l14Gw5XMx3vl9XuYqztud
         sPjg==
X-Gm-Message-State: AOJu0Yz1H4rWGnGwlPBXIqQa7qXZx+Eu7MtzQ9XfujfWshyqT4o5mCHE
	hDNDTmCDWCwjErAMMzMoEZfVIU8JVZm7JoApo3n5FyyDI6hj/yVb8++MZJzlog==
X-Gm-Gg: ASbGnctiVrKpmKFZCPEmUG5UvB3TbgqcXXA3FiCx0XMHXfA2Jc6IsPwbR6i/XpRrpUl
	kbrfAmbJ3Faavf9z35Qc7SJW5+Ks7qOuq4SMoBHc1YA6v8RY8R9me00/FGy3KLwMtWMXQFWGbuC
	L7ZptGMtf5PVeW7A0T4h7nXhPrdBRNw20yQuCeAzFRF9ngHspZDgM1CbO715cuok4jpsyhw6JE5
	Ix0f4gyXMtgNtDyr8LQ15OPTFw6bWVe+1dXe3EawX4n6lSGJzklgiZceLsPKRXQxU4l2A+3WA==
X-Google-Smtp-Source: AGHT+IHAbLIPScfo04HxvVnWsEo3MLGo+8C+ULCzFpqsWnbV80Kb/xRJooLbbVqWNVKGLGkA0ZOccQ==
X-Received: by 2002:a05:6602:b85:b0:841:9b5c:cfb3 with SMTP id ca18e2360f4ac-849e7385a43mr3730175839f.10.1736206271371;
        Mon, 06 Jan 2025 15:31:11 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c19aea2sm9479664173.96.2025.01.06.15.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 15:31:11 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 6 Jan 2025 16:31:09 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/156] 6.12.9-rc1 review
Message-ID: <Z3xnvfyEfj_hspNn@fedora64.linuxtx.org>
References: <20250106151141.738050441@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>

On Mon, Jan 06, 2025 at 04:14:46PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.9-rc1.gz
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

