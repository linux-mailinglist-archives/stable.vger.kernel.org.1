Return-Path: <stable+bounces-187873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC85BEDE28
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 06:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BBD734B470
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 04:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F3D1D63D8;
	Sun, 19 Oct 2025 04:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3ZFTrOm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807F72614
	for <stable@vger.kernel.org>; Sun, 19 Oct 2025 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760848740; cv=none; b=aqtylu+ong3tWM3eiPDWb6cf3ymTVsxFArRIztCiPX6K0zh+S7uNscoj9LtI1mb+496ygDSPhBz520Qd0yrHVCblrQJj21aRBX7SBkVA2jzmTt1zlc3AWj/noh0ER/p2pkl2qb54LHLXyP7Y6PaBRse4XFQfdT5X/H2wW3CYqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760848740; c=relaxed/simple;
	bh=0VL6UvbA1L9L3KYApi2HBxM5osAN5B72tXfZdkax4n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJYlk8OulcUZLagE6ePtSta+UG1o2PzOrERkB3g9ZFHGTCO9joemYDoSoL3PZQ1FIV5yiqfIKKUNfQNtoiZJSlfsYBEOMLJww9M8+cFjk6RHG6oLAoEmU+tVbx5b5uKaDCGxgVqH4sUeqyaLHjNgmmbN03+4CPDAKeg5pE9hqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3ZFTrOm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290dc630a07so13611145ad.1
        for <stable@vger.kernel.org>; Sat, 18 Oct 2025 21:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760848738; x=1761453538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmK1mTi1aKqF882bTtKfCSZ/kTsVspf2lr8U06HUrwA=;
        b=F3ZFTrOm/fdEKaf6WBJmqCg0W+TaNaZrVAyDkmvtSoptDqo8MSHNrafraH0ypL3VQ2
         uA1LmHVEO7r1IoGyBmFgG0pi8AQECL4292GZd7fq48C7NChdc/512G0AxBnBRp1INDqn
         fHR3p4dqv3HwfwMnE85m0dmX0KMcvskzZrJJ/TLWgO80gYhJmcCEPmxAYXC4QgkDHE8t
         OP8NMPB5Cn8uDQAM+ty6FT6deNbWo+KsAaAqvvO5WHlcdqwBUKNHBO/0dVr1x34frHBR
         fe0RkWKZjf6qJgy2tcpvZtXXHZIO+dHwwQh4XJlhYext4a6ke7CyAVEaovykpxxaDO9C
         W5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760848738; x=1761453538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmK1mTi1aKqF882bTtKfCSZ/kTsVspf2lr8U06HUrwA=;
        b=meNhFIfKozruImlPJwUcVOwM6gkDZFrSuLTpJEexWb2X5GaRBNLYh7zaMEat5Gj2aX
         c8NbpWYpH4cW0aPzaTi2B8S9lyuNV16LbSQ310AVnlmDtPI+A3gnOkcmIodEFMBsnu3e
         hMjgjiBy/9YeImQXz0/Tn5HSSe8aWcVTwPWKgZP5xkAhtqZ9QlHLxRQa+EVfG9gpoOtj
         96nRVU7hyJusFAYmfSMjIgOSUV3gJc+Ms/LTe3yctAWKNPybDcIz9GqiubLZ8rktBJeT
         XSoVYfX91MNjwN4zcVM/MinxkyjHMSdrhntiWmKSoBIIDQmNA8ZxxC4PNdhfZSo2yrkO
         zlQA==
X-Gm-Message-State: AOJu0Yzr8qknt6OHof7/QLYxBPA8BOahr6uxvJg3qqRqZcjRmkCSbEdt
	b5r9sLtY5g5Ugk1Zqecp0Cc4qjxFXAvNKcCJGrHkJXfFq2dUE59rkXkS
X-Gm-Gg: ASbGnct+iF4kbIQzZr4S98HfdrtYyNU+/W8HLzokt9/YO9hSAOAFX5J/4q/Xgy/CagS
	3q3bggMFaToDkKkbfyiKet3XDTlgNQlhXi6hSJ6RhMkR+eMyXbMB8ij9CBaaLHD2M0jwuhgnOKM
	EibiXCik9n0qxQRl0Z8xBalxrbpjH7CU4zSp/mcFyS3eGqTGvHZ0qdazJ4svgVM+R/6FaiDalQE
	AE2rgAJXlZNhD1fIvM6rPVpfG7vPnr/Dc7TFwhTKG2kj2+nBoY8I1qNGhOK09mASNTuGhO+idPb
	s/2mZKTPdILGlPh327k9BghNpHrTY/i94ifsF9V0IeGtaYJYa77OsUg00BI5JDclck0fbK+P/70
	JVGHFjzQitl9UhL28q3ddtI05caGdE21Vf6P/sUkdz6ntFy7reG2z0RlOQVS1y+xcxyEv62RoCe
	Bd5L5YLe/oNhrD
X-Google-Smtp-Source: AGHT+IHdS/E/u65fGvAAeZHq/8Z61TPZEPdEbbbaTroydHGnbRpgb6AV15wzVJl9z/JFGKzlDshZFA==
X-Received: by 2002:a17:903:19c3:b0:270:4aa8:2dcc with SMTP id d9443c01a7336-290c9d34dddmr114629115ad.19.1760848737742;
        Sat, 18 Oct 2025 21:38:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm41615345ad.54.2025.10.18.21.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 21:38:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 18 Oct 2025 21:38:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	Yi Sun <yi.sun@intel.com>
Subject: Re: [PATCH 6.12 000/140] 6.12.48-rc1 review
Message-ID: <58d213af-f422-4b70-8821-9777fc1b7020@roeck-us.net>
References: <20250917123344.315037637@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>

Hi,

On Wed, Sep 17, 2025 at 02:32:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.48 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
> 
...
> 
> Yi Sun <yi.sun@intel.com>
>     dmaengine: idxd: Fix refcount underflow on module unload
> 

This misses a cleanup call to idxd_disable_sva() if device_user_pasid_enabled()
is true. This results in a warning backtrace seen when unloading and reloading
the idxd driver. Upstream does not have the problem because support for
IOMMU_DEV_FEAT_IOPF and with it the cleanup call was removed there.

This is just a notification. I'll send a patch fixing the problem later.

Guenter

