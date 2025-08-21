Return-Path: <stable+bounces-172172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1ABB2FE13
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D513B11B4
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C76938F9C;
	Thu, 21 Aug 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuDapDyE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945B020B218;
	Thu, 21 Aug 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789152; cv=none; b=mcl0luJ5IQyvTIcMqs8jBPf/X9SEtndNoHHzPivC6V4rIwtWgpT3TlKx6IdT+RAVq+i0YolQTru9wmNvY8/L89NWx0WUHQHkQbbkLjFo+Ii1vlRRJDdXzK3Avqo7omXMbXey7cr34MmR6ObqH0t0p2Q8LVr+m/3bLpST5ImnE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789152; c=relaxed/simple;
	bh=+t8snXkKmcjjxAr5BHCKqum+mz+VMESzAYGS5C3LXnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJqCQMjaCAvIdJGDjNYSqzc+1liJQofwTbTO0bk6fNXDMApVbpSiy/eqLD6ijEK4gWL29DID/V+oXps5unlctjore3clwxxzARw08yaUvp/nEsSkRf+yAGwJmxsb8Np6IsjdBohbmcnWnG4aUzu7gKIrpD5nTBSf9N/+4V/MZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuDapDyE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-324e3a0482dso723527a91.2;
        Thu, 21 Aug 2025 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755789150; x=1756393950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66DlkmYsPsoYSqdkPK/KdDv1XaJYGY0dUdLFlLXTfd4=;
        b=DuDapDyEHZTTOxpb6Ae+mZRcBRI4XTp/NHjSoVVMW7aMIvtPspgHs30/Wgg8/MZNIb
         L43acnOGqkmouwoYWC9G+KEyxQ25DPw6gpGaTl3UejN5jFvVA8Gd6qwPSjUglDI1SMXP
         zd2N6a89ojcsseakvRWXVXsmgaQ0qdlsJYBRkdjSehakA/Nz6yBN2UfyYhgKplPIHMzW
         YcY9RtKX7Zi3EuWTh4uAKDbBwTmIY/7K3ASpX58myAQYY1w9h/FEyM1DqXM6oPQZo7Ia
         9K55K8FXDliZM6z1y1x7Azgui/JyZMT+EJp+1mcCxxaIzmoORy9+zbeZ4EJaZ1p6GU97
         hQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755789150; x=1756393950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66DlkmYsPsoYSqdkPK/KdDv1XaJYGY0dUdLFlLXTfd4=;
        b=NxP2uuB2Nj/B6bMY4+4VNWPqPttYi3e14MS1voI20L/aTtr8yGYjaYUXEWDeJHEc5R
         6SyoRwSm8lkBAJ3BLlc39Te0axWVrKcfRV1ggZ/glr51jtDoR9Ukax+Yh6KSxYrC20cS
         haK2ztIdqOpkli6ZrcKsz9FopmavZVPDvEou5pahw9uymkoe/F2IBIFZBxJ62S1cv7pB
         jxyUCoIfPbcZ1nzR2UsI1NH4slPFighafaFXgGhc090eFkmZx9A2t6qcFA9YB4OXXrA4
         qMQxM3YPZWxewfqr8R57GdXn1S7MVy4YUIRxfIKl0wsW/9M+A04w/038wbOLL7aNXAW3
         gAlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWstaxtQG/xUtCVeF2yZU3e/cOVh6pz7CIO1LOl0RkknSjmSeDTyjeEfCYWkwyUpyhn7l5sPMC0P2Ufq/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFicXEr16NP2J/yR/OLs7YM3/XU3n5c0N8aQZrLAo99PT4h9lz
	vhc/iAyitabdNf8azd2c6xdNR5IwMdAliyHyh0HLlWIGoO8MSeFwEDMY
X-Gm-Gg: ASbGnctxXNQN6YG7taWZSvhoU8jZsDQQ1hTGd+M0SRhUauXy+lreMjzuk8AsWlzOtEF
	4hCehdo6yBAifTE80YI2XNnXPR6OVDYb6gfk0hnIeV1wxeL03FwVRjJPez/fOLBnuWOHtEpzbhZ
	Zs5KyB19B/W6F+Be6D8tbVrt1hQhsmJTUB7MCkbYmJkcPGRlxADTmhZfyIAeqU+oslxm2FVDsLZ
	GdvkbGBdxydXEOMDew8Hd0zaJc78JhXwTrlDxJw1FxbXTqIXqwZG9CbZCgF8HKDFRlc5YNiqi3G
	BgFg81oWSMFecUtTHLDv0l8UU/xNyXoehtwC69F2RE9wXRSMlcmGZdrd0v/HANSha1ugZHPbc7v
	iB0xt7y3zdjypgrV12Scymotl1Jav1IfASkJ/MG9hJMYIDw==
X-Google-Smtp-Source: AGHT+IGuF10wSRyOdJQ8u9SwxmTQNE7Yfpm2eiqD8pnVDjHTYzs4E2tneYeJRUzpKjax9uwed+ExsQ==
X-Received: by 2002:a17:90b:5746:b0:321:abd4:b108 with SMTP id 98e67ed59e1d1-324ed11995dmr4378690a91.12.1755789149706;
        Thu, 21 Aug 2025 08:12:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325123e7902sm52128a91.6.2025.08.21.08.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:12:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 21 Aug 2025 08:12:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.12 000/438] 6.12.43-rc2 review
Message-ID: <63e25fdb-095a-40eb-b341-75781e71ea95@roeck-us.net>
References: <20250819122820.553053307@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819122820.553053307@linuxfoundation.org>

On Tue, Aug 19, 2025 at 02:31:21PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Aug 2025 12:27:16 +0000.
> Anything received after that time might be too late.
> 

Build reference: v6.12.43
Compiler version: arm-linux-gnueabi-gcc (GCC) 14.3.0
Assembler version: GNU assembler (GNU Binutils) 2.44

Configuration file workarounds:
    "s/CONFIG_FRAME_WARN=.*/CONFIG_FRAME_WARN=0/"

Building arm:allmodconfig ... failed
--------------
Error log:
drivers/net/can/ti_hecc.c: In function 'ti_hecc_start':
drivers/net/can/ti_hecc.c:386:21: error: implicit declaration of function 'BIT_U32'; did you mean 'BIT_ULL'? [-Wimplicit-function-declaration]
  386 |         mbx_mask = ~BIT_U32(HECC_RX_LAST_MBOX);
      |                     ^~~~~~~
      |                     BIT_ULL

There is no BIT_U32 in v6.12.y. The same build error is seen in v6.15.11,
which is also missing the definition of BIT_U32. Odd that no one seems
to have noticed this. Am I missing something ?

Guenter

