Return-Path: <stable+bounces-72949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29D396ABF6
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 00:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8A81C24672
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808421A0BE6;
	Tue,  3 Sep 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Xc+MNUPx"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711083A267
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401843; cv=none; b=SNWhmWh42VmWvXvM8w2W6ODvpXGdVVeoNz4dm4axRbo0jfHGkwqMkxYgJdeS9l27xdya+1Q8ID9JzaZ0Y3dHjwKH1CVb/H0Rri539EJpN6Umn6t63lHcYR9XvuP2b8VonYUUM1i/bcGx2RYPA8tQpdeTiluSTxCXp0CPSD8XfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401843; c=relaxed/simple;
	bh=ixiIN7Un+lKbuuqP82YDNbIrIqTLTw6W6vi/Xln3G3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joJOPCpZ4OZ4jGQhjZCuLV2BboXXlyGKYxsHf3sp2GIT7+bVlU5yX75hgMQRhno/yp5LlQGPAkpL9MPj1LSUCu46+IsI5e6O0jQfKNiVoSm9Btx0b5WC3Drx9Pyv6D3j7AvC38gvXeOTkabFt1PxVvOPKzG0/aOgI3dxcPkY9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Xc+MNUPx; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82a1af43502so296751239f.0
        for <stable@vger.kernel.org>; Tue, 03 Sep 2024 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1725401840; x=1726006640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s38PvxZbBMTVGvQ0kbtSdyWDBrmSjvOO/03Z8xfaLco=;
        b=Xc+MNUPxpf3lC2zmYHaHEjHCDZ3jhq7yZ9iFYSWPZ2Hxqifg4jVtxbaC1rGPR6P5FN
         6ApZ9zu7JQOt8W5DtDPiFYyvvDZtrzirMRAwAXnQvsqY5mb0NPVpf2INrScDJ2S1EY8h
         OYb3SlmTsgJu5NHcEb7sOSrLA9K+z2yNB18Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401840; x=1726006640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s38PvxZbBMTVGvQ0kbtSdyWDBrmSjvOO/03Z8xfaLco=;
        b=ACId7xmKmw0iKNTR813ADUKFSc/z10G2KxPVwlyjyQ+esw02MqxC373L/LLmT2arAI
         fs3XqQjGsIWFLkzJpyuRKx52Wodl05px/p5UPTL7ZfPv9vWGYIi4J9YZqJZwkymDVKUA
         yn40NqRR/dgaYfVu2tTeAAPn1Iho+7w8SpI0IlTzcyxZ+0QIw1VnpmHB2nbOp4LFlBEY
         ywYjDdZt5w/fJkQpYyXtBCq9cCZkldoSIGs67K3nq/7tyWJzev8gKrhTFyqt5MKSVKK9
         kN8TioS11buoLhTkMjdTgMU+2ZmOLBOl0ludmqCOtLd4s9rq473hz/mu9UEU3BS99g90
         oqTA==
X-Gm-Message-State: AOJu0YxjBddBcIzOed0C7vBIz3yeiuiEUQSgB4jnBS2y2RpRWRwxjuSM
	pmDy5Cbe9jJIo5rZGJjBbTqHcDnxco3Hd9X3D2bui3Ff+a6YyMCvb8ACYSjWSg==
X-Google-Smtp-Source: AGHT+IHSG24Jh26pxj6oDOdaXB3yvTtI5BWzt2ZuQfpSpL2rvr53tFFIUcwfaMJpX+ZdObf03WdX1w==
X-Received: by 2002:a05:6602:6b07:b0:82a:23b4:4c90 with SMTP id ca18e2360f4ac-82a23b44d62mr1661524439f.1.1725401840339;
        Tue, 03 Sep 2024 15:17:20 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de5cf8sm2805547173.37.2024.09.03.15.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:17:19 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 3 Sep 2024 16:17:17 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/166] 6.6.8-rc1 review
Message-ID: <ZteK7TVPmK09RSz4@fedora64.linuxtx.org>
References: <20231218135104.927894164@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>

On Mon, Dec 18, 2023 at 02:49:26PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.8 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

