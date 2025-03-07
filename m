Return-Path: <stable+bounces-121404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B8A56B9D
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41B93A6DCD
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF66C21ADD3;
	Fri,  7 Mar 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="dCSrvI9+"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B021C185
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360522; cv=none; b=aIZq/AK777yp51oyn/lu8x5S45UKbhCX8b5qVjcfQdQ9HlDEG8LRhzezsPk+Knc1I/1UCIG49MKuC93QG8zxt9II81BOYgftRz07h5hFuaH06AXttMTgkmimMAbdXQVKuK2n8rT+hGLO24J5iAgG8sQQu/SGJXPPXO7nBWhItNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360522; c=relaxed/simple;
	bh=Jyg0BlNEVONMN3/qpK5whDdVuZ36nVAtfOMd2YynnAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMn5ySEtfWb0BZ9d7rwJSj03GGFcDvPsqvFTBNrFDqxvbu5pOERQMXgq1QLHtR3gmBIIl1CNTZxzgOBCtCjswNaza6xJcMR69vdQ5nVOSqq4KznADhsy2pKsZvQxACnOLWZ8fyI0DXOA6GcD4PGaodu8HHDqqRRD0oBMIak4TvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=dCSrvI9+; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-855183fdcafso92432139f.1
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 07:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1741360520; x=1741965320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNhnQrGFa2eZSGaA05d8tH8yb8bigPtWKz7iWwlz8ks=;
        b=dCSrvI9+JxYTPle6B1IbN6y1LQdb5a5c7gdl+F0xu0+1sY4oQNPl64+q3aMY+uiAAm
         JrKEzfevb68ZM+G7Ai1McBP3r7JzgEqGzoNa8PlkUk1hDuW8ebLwjwquRCjr4881V04+
         aRmzR6k7/91M2cKz+rOMxuBn9yCdI5AmzwmoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360520; x=1741965320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNhnQrGFa2eZSGaA05d8tH8yb8bigPtWKz7iWwlz8ks=;
        b=no5/vRyxdkxQpwyul1BTAriAFhU06V2hHl5zSCeDhQeblt207si5tLAp3Eba/4gT1L
         /EcOTTB772ypQzofhDBG+lsu0X0RBvSGCo1tUSS1VAKNWFJH7Wc/6fZ70Agkw1nPl1vS
         6MbsU6WDibjlQYatxXCVhK9Sm0DXznjBUjSBT5NIDV5Gm1ghCNqGoj6fDlQib09TeVhp
         Zcmsaj47mo5/rGAg2hZvBgtKEtWKis+4ZqSp+g6AKBPNmm9xrDCW/RtPoZMDISz4InU1
         pd0rCitUFD6gJo0INKHUXMJJLm2g7L5lqL5zIdiaVCBZ40NkpI1PHaSaJKjFaS/yLSLN
         lZXA==
X-Gm-Message-State: AOJu0YxCPZHjTvIIo8LfCs+ZLWf6reGMJV32XKWERY0zQcpcimV+curz
	RCzLI+kCqz9G1VoeqDIvg2dKit54tEAo5+SPq4JkFZoh+3gkpxmjzFz5tIxmgQ==
X-Gm-Gg: ASbGncsAX/UV+e6j53swa6SCvrJAs5TnEacrCJ3onvJs1I5l4ZtszeywKxVf04A0t+i
	gnNOVZSso+51Gu4lJ6SMWEWmHFZjhJr8ejO6FEHyDaOaWuPDJirK/zuSn0l+Q8RXQmENve9eMNI
	PdN/kvc0oA1+udEcPt7KTLjw0efA72PvegaX5JUmh2ntacdFWbCkganA7Ep6ht3oSWv3HPR1NhA
	oZw8ouwcvUUMLgB41KlOtHHvyACpAhi7oR9l+kSy6k67JNdQbZIw+gBUfCSgFGmHfK3CIwjif0t
	3dyvNyhVDrsCchvrgg0l6E9+wVG/Xo5vJnn+4SJnBII4CbetXqnSr73uP61JvQ==
X-Google-Smtp-Source: AGHT+IGJMJxSyE4UNVIY3LX2S7nhf3Y5lt2eLGH38VXXHHpoq/52h36JCsBDp/RY5WFAtMDkWXBzow==
X-Received: by 2002:a05:6e02:1a84:b0:3d3:f72c:8fd8 with SMTP id e9e14a558f8ab-3d4419b2bb9mr42285385ab.6.1741360519989;
        Fri, 07 Mar 2025 07:15:19 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b599080sm8399705ab.60.2025.03.07.07.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:15:19 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 7 Mar 2025 08:15:17 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/154] 6.13.6-rc2 review
Message-ID: <Z8sNhU27IirlaPn3@fedora64.linuxtx.org>
References: <20250306151416.469067667@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306151416.469067667@linuxfoundation.org>

On Thu, Mar 06, 2025 at 04:21:02PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.6-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

