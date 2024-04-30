Return-Path: <stable+bounces-42835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5D8B8199
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 22:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121E21F237D1
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 20:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5B1A0AED;
	Tue, 30 Apr 2024 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="D5iJH4+4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D3129E72
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509606; cv=none; b=O82DbuhklmMcG867JEYb+ugeJzdl8RZgKjafMM+KDFnzseqR4viwPtyTWdOWDcrw1huYdqV88/F77Xw/jHAT9Eva4xexzebfExxfZPbKgfkk8IcXGphg04BDnt6ex9fRNMUR+/T+9p/W1UU0XUdPfD5gK+GwYY9gZB2s4Vxiok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509606; c=relaxed/simple;
	bh=oQSngsPwHpqjPWpk2CQtdzD5TSEeud66qrlHa2cPFsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vdg32pFZfkPd8AozbuGRLN/tZl1nLlm8j9lP4pRkP+/vfbgMjYe3f9kjr4JzcT/NeNv4ZeT3NoijlGo6rU+QWsOyjfZY0eTUdyoPR38Q1W4eD4zgX55sUP3NzpfUHKCznFAtyuTHGrlQNDUeQvQdoNGy2uB5Kc9SQR/+/Jnc+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=D5iJH4+4; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ee3231d95eso115451a34.0
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1714509604; x=1715114404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YYgSWxhf4zOPIcEbuWf3i+tS5g0up/+LJ/wCKYsmNQ=;
        b=D5iJH4+4eWojvAlJFfFNbOK0NrVhneQ8iK0IT+BHCN9g9vbAyvAOJr21EZvUSLXIm2
         gE68/bZfE9OiHviN+W7NsfkMoVLJ3Yysz+wceU1SngsmPQGBXUaMoCrW9KDZO9AZWqZr
         TbMcS+PAEZgViIp0CER1c4Y6sgERL62oFaZGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714509604; x=1715114404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YYgSWxhf4zOPIcEbuWf3i+tS5g0up/+LJ/wCKYsmNQ=;
        b=EYf25SozgFcuY3Gklf/GKbaD0WlLaUmcMb3PdwUyAOG8thIj1D6qzlqH4ZCV0JoyMP
         g8h49cAi8jOt2pfbar6+wgnOaWc/bd/9Y3sfxblSjs1zVCxkr/rNUfKrDdp/f5xy1TgM
         GNgA2YpLHrjgEuuuh5fUh/3f9U/OQo/mTXdf3EkUjGfORlIgV1xDm21RIrrLRjUA2kFt
         9TDoQx9okdjMzIRxiWC+BsTs99aXPdBX/KiFhukr7rFVbUl548lK4X1vadP3a9Evj2yE
         Od4D4i3mFJprbfR8vKdNbHDOovDSy/7LdSx7/03n2T8CqWRSR5PkcjQ8uhQ5UBqjmiU4
         nc1Q==
X-Gm-Message-State: AOJu0YxfkfS45kIrNWdsweVL8MoI+8BXzTBum9CLzJIgmozquRf4SXva
	4UTiDK7yOqs2C2p9IN/UFrn7tRJmh7tpwSaWq8JDslMcWF2Pwjx+kSlVtHQZMQ==
X-Google-Smtp-Source: AGHT+IFRIwaOZIJKk9q6FINe4lpZDhEXBbf7mbgHPgC2qdcV1d/X97KO1ZiGdcpPPLnYfRdPuBcpvw==
X-Received: by 2002:a9d:6d90:0:b0:6ee:3f5f:c4ef with SMTP id x16-20020a9d6d90000000b006ee3f5fc4efmr1871923otp.0.1714509603829;
        Tue, 30 Apr 2024 13:40:03 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id l4-20020a056830268400b006ee64b1c8dfsm395000otu.23.2024.04.30.13.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:40:03 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 30 Apr 2024 15:40:01 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
Message-ID: <ZjFXIftVw8F1VT6T@fedora64.linuxtx.org>
References: <20240430103103.806426847@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>

On Tue, Apr 30, 2024 at 12:36:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

