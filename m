Return-Path: <stable+bounces-144521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC3AB862E
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 14:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E7E16BAA3
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 12:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B7298C13;
	Thu, 15 May 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ADdBRD9A"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B32B298C03
	for <stable@vger.kernel.org>; Thu, 15 May 2025 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311343; cv=none; b=NAFJSJ8qBuswiNiUjAqvQEAeAJk5xqJxeU6Szj62G6OpH+VUr0Wu3MQ9184nr3ss2bKe50Rwcr3T4BULshBFfMN9QrR3xbK2R6Dc22fgilAVPGLCf15UWInTOFp+DoniZRLf8POw+N29xLDkzWISL6yqvBSjVOjRUPBFk78QxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311343; c=relaxed/simple;
	bh=xSdV6ElSngf/vG72YPll51aXchF4HcqQwTl808G2t4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBj0wJWRtSTfXqBCSCRuqN9aXIKrjqC0BR2sV5NaI+4r5Rlj1OGLuJ4fYbv7kBxazFeiZitoAmelJy1tGdp0yRqsPUV/zrjfzOY0c3jWbnK95Vw/BnP94Er1w+si3+t7zWFDQYoaCXxc6ekwgBRxmLJpwozMNNT+qDM1zpRBDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ADdBRD9A; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3a0adcc3e54so482663f8f.1
        for <stable@vger.kernel.org>; Thu, 15 May 2025 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747311339; x=1747916139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uH0GAaSc7W4vyN6o8zkocK26uhT3TpN4oC3foWYOu0s=;
        b=ADdBRD9AcbnKshz/eD2TFVWwb2POcIt5HT6uUGFZ9U36qmMch2tq7Mi4DPWARrAum6
         u94eglNkOoebzboAOTkGycG/1StEHSGusu8BGitMs5GKxNpEE9SaXju7xuzJh/jXZMcH
         QRqVtz8AV28MKXQbeuxm5cacaM5njc2ZYU6A/DKWh70aojo4rV9ueHMyvalQoIgB7Hau
         mJyJErP2M3uEpN3aauoW5Pe1Qdba9ILjkOi5tqHEujrjSlzo6JTy/ltWfOX3G6QGe1D+
         pHYw+eo5cs6ymkHlhVcB8cso5+rRhsmFa8Rse3vGuLoJhs+41FxSFEryc1fhqDm1edkK
         bNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747311339; x=1747916139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH0GAaSc7W4vyN6o8zkocK26uhT3TpN4oC3foWYOu0s=;
        b=HsQ3+jFyvHRiD3ibP//zGpKDkkVqkn6EjkietCAJpxG9bwwjzNoeGPTx1/mqSRzdPa
         fPZJMkgaGr3D1NqItyod5SobKUjT7OXIYWb8Usxay+qXhF/+kRS7RSqBy5aKNkckWvjz
         q+H+/et/3S1N6wVGBiM2U+v7h+S/vi5GQ8eN/8vyazWmfDoHIKAfPtNgiWvxgZEAFzyx
         cNPYw9HTIjhjfubE2AFRnZ6oiGH+Lnm5q22wprRaNKNQTeEocXfUTHWMTwQyeMPTFvgF
         dcggYXZvCPKX9W7kZE9iLGT4TtfTP0i58rFjBxUxhWREN1blUT02jinORfXwtPBTJggf
         dsTg==
X-Gm-Message-State: AOJu0Yxfqe/mRbjsoYMAbEfp28LoBtjNWjPEcYIPEYmKgtBsphWExmzb
	mKEk8JgCJyO5ieNEFTlX5Tb/cP/W4UOBjcLSETlZ4MwfwvY/w5tdrED19ibQMU4=
X-Gm-Gg: ASbGncuqhF6Ua6QVr+mKU1DE7ThToU70aN/ihJLnz9efEGg2DbCPy2u2DHo5i1jFq6g
	wdngIDiCNWd5M3/wUOvscZsWsj9/n3GZauej0z2DTYrP54og2bAaErjZqS13pLy2pmOBvVAPNXX
	D6hbMdh4dm2AAUABBLIzN6cZ2pxBmnINQOiQLcpTPxkijuqqi58Y4YxhjiVRyjWjwclvnqn29ue
	8SqFu6D4mHEScCaAMkEeWtfrfKqHYWmw2BjUarrWIPeVIixYIM0eT5WdgGDyssJHqKMr85BRwVL
	fVq3sOzEz3Elk4SJdGZ+5utslfS01wy0O65BMe5xCj7hHInL3nipLEHePx5U9M1liYiaP6Q5S7r
	+M2sq3Bm+AatT82g/OSJweiSfBKwLxf8+K9WX1BUw7BjA
X-Google-Smtp-Source: AGHT+IGvHF0ghUmj2Kk8tVmCLsRiUBezE1BL4S2vxUPaMXUrfbDHNuKJGNldtJMeEAHQa/avJuPj0w==
X-Received: by 2002:a05:6000:1789:b0:3a3:4a30:9286 with SMTP id ffacd0b85a97d-3a3537a8fdamr2085268f8f.42.1747311339495;
        Thu, 15 May 2025 05:15:39 -0700 (PDT)
Received: from u94a (2001-b011-fa04-b2d3-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:b2d3:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237761f23sm11153625b3a.77.2025.05.15.05.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:15:39 -0700 (PDT)
Date: Thu, 15 May 2025 20:15:32 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, kees@kernel.org
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc2 review
Message-ID: <vrvefaimjqkseuoyuhgg6omt2ypgp5v6xwwuxihj2t5jidizyr@ir5w67k4kl36>
References: <20250514125625.496402993@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514125625.496402993@linuxfoundation.org>

On Wed, May 14, 2025 at 03:04:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
...
> Kees Cook <kees@kernel.org>
>     mm: vmalloc: support more granular vrealloc() sizing

The above is causing a slow down in BPF verifier[1]. Assuming BPF
selftests are somewhat representing of real world BPF programs, the slow
down would be around 2x on average, but for an unrealistic worth-case it
could go as high as 40x[2].

1: https://lore.kernel.org/stable/20250515041659.smhllyarxdwp7cav@desk/
2: https://lore.kernel.org/stable/g4fpslyse2s6hnprgkbp23ykxn67q5wabbkpivuc3rro5bivo4@sj2o3nd5vwwm/

