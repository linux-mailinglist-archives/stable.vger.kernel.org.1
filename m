Return-Path: <stable+bounces-43469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2AF8C0575
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 22:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B293B2324B
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 20:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4122130A7E;
	Wed,  8 May 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYuCYQ9r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7562485633
	for <stable@vger.kernel.org>; Wed,  8 May 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199493; cv=none; b=NNq9wXIEivZTVWs888LCldbZWlhae2WrUEhGTqJ7CkiMDofDSo26sm6PxHbveFwxyCfL0vUNAEaFsV8y4KtaR4oGPHpl1Oqu125ZPPnLEfsQhb/tDHN2I9OvSRHO7182xZJ8EQgxqz7FUPwBw6BlY8tzXdERE1aszZ4uTaa44U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199493; c=relaxed/simple;
	bh=fhsPllci1sMfQUcJqDs9/Ghjs7EjdMQtzY1lDjpMeCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l62dQ+sb7grCaAHOuIVA5gLYcPBbZ0ASAlXESVlzMEAEmZMkplgQDa/UK8x++/TyFgWxTsOZ2SO02RMe2o6UHCDI7/y8d3Pznhy210X3NeB//JZVh4hoqOZkLn87Y2E8ECRNWQuCFApIOMw9bAarXdPsvkJBiL2u139yTTcox68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYuCYQ9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D56C113CC;
	Wed,  8 May 2024 20:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715199493;
	bh=fhsPllci1sMfQUcJqDs9/Ghjs7EjdMQtzY1lDjpMeCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYuCYQ9rR6HBC4sM6WPh3Gq3WayS++yEygv+uQapxR5thomUV6zqEb6SyHPoWCZHT
	 i7IuJt2IKG9ShJwELDCI5Bx3end+MucJoN47hY6zl5HzhJsZa2iNe6JXdu60vKD0iJ
	 gPWxO7wSTuW5MCfaPmb4w2bWN7Fh4HFLUs5Pe0o0wvNjCxit3ReqPCJS1aT6UJ2D6U
	 3jINrciQbU1Fm4nwDWA//ibDHWWBX9q8bcIS2Yb05tR285AU7rWa3m3C43rdxFGgEf
	 fHAC2I82gCVCEoDl93BSCQIm+QjyDiduLoUwLY4T1r1fVmbvRlhc17XeDswvwVyzpD
	 wMUJYUt2llpaQ==
Date: Wed, 8 May 2024 16:18:11 -0400
From: Sasha Levin <sashal@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: stable@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Pablo Galindo Salgado <pablogsal@gmail.com>,
	stable <stable@vger.kernel.org>
Subject: Re: 6.1-stable backport request
Message-ID: <ZjveA_YEh_N5l9o5@sashalap>
References: <CAM9d7cgVCqYVirivv3ApCq18eSCUuJjUoq7hbhw7X9AaTwNf+w@mail.gmail.com>
 <CAM9d7cjkv9VvV=NAxdsnFKcjq1ti-cAdxFn5KkisAi-yE6Sb0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjkv9VvV=NAxdsnFKcjq1ti-cAdxFn5KkisAi-yE6Sb0Q@mail.gmail.com>

On Tue, May 07, 2024 at 04:10:50PM -0700, Namhyung Kim wrote:
>Hello,
>
>On Fri, Feb 2, 2024 at 3:29 PM Namhyung Kim <namhyung@gmail.com> wrote:
>>
>> Hello,
>>
>> Please queue up these commits for 6.1-stable:
>>
>> * commit: 4fb54994b2360ab5029ee3a959161f6fe6bbb349
>>   ("perf unwind-libunwind: Fix base address for .eh_frame")
>>
>> * commit: c966d23a351a33f8a977fd7efbb6f467132f7383
>>   ("perf unwind-libdw: Handle JIT-generated DSOs properly")
>>
>> They are needed to support JIT code in the perf tools.
>> I think there will be some conflicts, I will send backports soon.
>
>Have you received my backport patches?  I'm wondering if
>they're missing or have other problems.

I haven't, nor do I see them on the list. Could you resend please?

-- 
Thanks,
Sasha

