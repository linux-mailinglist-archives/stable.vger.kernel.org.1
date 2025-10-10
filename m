Return-Path: <stable+bounces-184031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036CEBCE6C5
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 21:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECE619A7EE4
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 19:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB172FD1C2;
	Fri, 10 Oct 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="KQzWqHah"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE2207A20
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125703; cv=none; b=SRlbLb6Q5o7uPBBgnZDhIU+OhnqDsd5+TmsTn3JutLd0N/SV4yn5FveLetz4U/CYWwq9evaSGqlrMbD0/SUFsGnvAYoqTUvFX3BncFPioMScPxM4EzLBKYwyAV6rb9Zx7eeIH6Ht8iDushMZkLZFX57WgFEtwJQCU0z8vZULunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125703; c=relaxed/simple;
	bh=83wimRLVprbnqmC14GL+S6WE4qbPtRnCGe89nxv9bhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCI7v39I1ZrSrjxvZOEqwiAx/wSVUEVuJv0ck57o7IM3fERfUKjayeI6ufk07u4f0dImXU3U0RTgatD2CvfYzcsVmeB3PVtzyxwnicQmCsCGaNZP9nfyza2IbJXjm/mGpg4PX3LQ4Q9iuaadsZzN2EOTDj7MugCuxCU2r4YsXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=KQzWqHah; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7bdfbc6ba5cso1011797a34.1
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1760125701; x=1760730501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=De3XODNHpFwsaVSSqNIM0lQEtYxnx4u9mKva8FKwHIU=;
        b=KQzWqHahzgG3v1aDtn0+rBaCugRYS6r/bEzb3z7D2xvpTDjhy1xfogLhVyipGCdHvX
         okMzNF8wgpNOLSDVx8VrAzh5MrcwoMK8PG2G+jBU6DLRdpPa4nSDwNQHwVaBL/8LFOVj
         ZRuCEkgV/kLwDqmXG5qZBXuzK13vd4OgB7bk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760125701; x=1760730501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=De3XODNHpFwsaVSSqNIM0lQEtYxnx4u9mKva8FKwHIU=;
        b=kRq9kEWWH5KsD7gZ2liZwB0oiRFJWsPpc1pteCawh2eYEsIVInWHqXod4GK1L1Qav/
         0uORB8b1MzWq82S5Tevzk+AQh9aYhu5oZqaQWeHiyOWZZRzWgLKaVQbgmAJvUKnDalu9
         4lb5WWL461w90L8NrHFmlt9AKqu98YYzJvPTUXt0HpRtBIHhV4TgSTOb/13+jyLtDW3/
         X/koPcLFlc20t09EJ4bjvBFRO03QSxX51ZAayTQVBf5jNmAJDusP9jXgaRbNfaOTsyDf
         dVjSav9ZyVRT4FLHdujXSGqB8J/zqQ3lZfzvBQIm6ESpnCceSxrUNOfVa7ACG2fLmbrj
         4UJg==
X-Gm-Message-State: AOJu0YxOVOeydy9mnaYUrnjlIic5SMgrGXEQFEZXC2bGLcnhjjAI/WeD
	oJrX0RfFnKp1NwoB3LGNtMXSHh2ZXrc1XCpuPOOaD+x42ONMhLtNtWa6Dk/pg11oUA==
X-Gm-Gg: ASbGnct/mT/Gdw7TqhDA3WwwL2jqvlrmf4gCLZRzcyxMzsVBj5zf0A/8a4Ht04AQgFj
	JfKzhq1W/XwlhoS61i4XDRqs+0IAPR5hb0D5IvZ7tIG7UdTmzZlJn5NVnVKvQst5o2B1zgXJBi5
	IGqofHS+YtdCt8nbHJb32kBGuQUWNfFUgSvsJBe0mma4MOpQDn5grUfOo80NlJ07UMcgO5nMaeD
	XQuqcMUCMXb7mVhb+srse6cJbP5/L046MgBjan3qVoaQrq9t9pgRhcL0e6GaFdIIYJMbZXI8xUz
	Kc3eUEGkGJvo4C1c1bebQCbpH/Nf4sxAoJQ9rCGi6BoYiytCFmo3ppJWis12HWgYMBolZDZN+JG
	lxu2nLmgi8+j9G/gVz6cG5WrJd4eGzE9j65jcVxalId3adkSmk/SRAkR5naWn8os=
X-Google-Smtp-Source: AGHT+IG2a/R7yGXvpWUnjwb2SugGnCDZzWLdoueR11HoiEzxPMFcCyVBrmazlF3z2WbJF/PnTfSfRA==
X-Received: by 2002:a05:6808:1905:b0:43f:9c7f:9b28 with SMTP id 5614622812f47-4417b2de937mr6142483b6e.13.1760125701122;
        Fri, 10 Oct 2025 12:48:21 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.121.221])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6501a8cc2bbsm584872eaf.7.2025.10.10.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 12:48:20 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 10 Oct 2025 13:48:18 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.16 00/41] 6.16.12-rc1 review
Message-ID: <aOljAhZFwcEiHqPJ@fedora64.linuxtx.org>
References: <20251010131333.420766773@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010131333.420766773@linuxfoundation.org>

On Fri, Oct 10, 2025 at 03:15:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

