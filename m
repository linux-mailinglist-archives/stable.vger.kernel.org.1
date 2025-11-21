Return-Path: <stable+bounces-196507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25199C7A909
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E453A1518
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A4F2FE05F;
	Fri, 21 Nov 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qqgvsqAK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09936D514;
	Fri, 21 Nov 2025 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738717; cv=none; b=CP1O9KKDrLs3+oWtmpeywCCF9CkIRDVLTenSVfEiZTzWfDFdkfPgfJTahuJoI+l8j/7OPMB3zMz5PR6fmXwwPVFOvCDdbcW0lqthlhKhyuc77Y63RNeuJE54KXsF8xkrXPY2TyFLZRqtf5Wymuji4K6IX4aDR995KnNybnR66ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738717; c=relaxed/simple;
	bh=131iLOt4wnvDbcc/QLVRTtesMH9cFjx7uTD1fQLmqWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArgoNjqsWLpgviobvR72l/8KMzCihzN2X7UmdADx7RA1mI9GLS4u8BvHScbqvxmRQKL2zWOfLuEmkEBS+blglZClHGDOterEfky4r+7eRD93hGFXBugHpHNnlRpGjPPkal3sbcI2Cl/V41FzZMC1i6iPy+Icn1EH2vQPPlaRuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qqgvsqAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555ABC4CEF1;
	Fri, 21 Nov 2025 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763738715;
	bh=131iLOt4wnvDbcc/QLVRTtesMH9cFjx7uTD1fQLmqWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqgvsqAKnEted7kQw0estopDySdbH8bX5yZgLsfHy6gTnwvNfNTVDG1z3E6jXfgPQ
	 N4+YRZOPqxTY9rCqjsl3MnozeLzsEV2wx3vt++jX1R+Q4d9DhK+OjZXTd6keanqzaA
	 AjM14LRpdQ8EETgmrKfVmtDUBKfgQpQekR9zOVIQ=
Date: Fri, 21 Nov 2025 16:25:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ronald Warsow <rwarsow@gmx.de>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, conor@kernel.org, hargar@microsoft.com,
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.17 000/247] 6.17.9-rc1 review
Message-ID: <2025112141-regular-ungodly-8528@gregkh>
References: <20251121130154.587656062@linuxfoundation.org>
 <c982e824-3924-4fc0-aea8-9f940bb5f5b9@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c982e824-3924-4fc0-aea8-9f940bb5f5b9@gmx.de>

On Fri, Nov 21, 2025 at 03:30:32PM +0100, Ronald Warsow wrote:
> Hi
> 
> with CONFIG_KEXEC_HANDOVER=n
> 
> no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)
> 
> 
> but with CONFIG_KEXEC_HANDOVER=y

That's hard to enable, which is why I missed this, as I had
DEFERRED_STRUCT_PAGE_INIT enabled, which prevents
CONFIG_KEXEC_HANDOVER=y

Let me go do some more build tests...


