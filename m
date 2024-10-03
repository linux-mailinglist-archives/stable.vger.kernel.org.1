Return-Path: <stable+bounces-80673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3249398F501
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 19:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C041C20E26
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C91A7250;
	Thu,  3 Oct 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bnYnXcRe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800619F46D;
	Thu,  3 Oct 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976184; cv=none; b=bWj5jy7DticGqYDkJfjaucdgbj1AHOVKxwBaLuobK+d81TGNmpMEcvF3AVzq71BzSpP9HLNqwnmIKaLJE2K+1bG5eP1jXxr3dybOoyqMt4beDDcw7CCgQwTc+Awf0gHhjpRYSdud+kd1H0EhB/L5b395iQvORPtI/aZIkeAgytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976184; c=relaxed/simple;
	bh=nFg6t36blKBbLHHcY8kSJNV0f9O/rg5P4glWwT6XAWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBIZFry/3IwRl6dWUCcFO88L2atEEFhlFvRJKFID6yr7X1hkc0xaxKGeiuOg0tWAhDc/hK2FDuju7zDQYXpFYimiETSqJOuPRBwp2OptLTckeMqD5fGh7VTGvSEPf/QArVMHswrFXmhpkTUbbThB2SgOGIXKNWc/pwjmZAUwmwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bnYnXcRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05586C4CEC5;
	Thu,  3 Oct 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bnYnXcRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727976180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8Kpn070x7K5atiP8J015IY9wSZsRgIEcmVgkyNW+vo=;
	b=bnYnXcRetIMjanRUGYmGI04ZcFPbGSAP3kCaKCSGmTkasM8MK4y6E9tLo/J2sMmoxNnIII
	pkJoj9eJmvGnz+Lyd3ssxkJYm+3mRvsKl10G38IQxZNRY9DF9tvVOtoboywa87Dfk9bcje
	KV8fegy3BSU5WSD+0EftlO2I57O9/q0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 204d07f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Oct 2024 17:23:00 +0000 (UTC)
Date: Thu, 3 Oct 2024 19:22:58 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Greg KH <greg@kroah.com>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
Message-ID: <Zv7S8mu3lX6cfwTV@zx2c4.com>
References: <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>
 <ZvwPTngjm_OEPZjt@zx2c4.com>
 <2db8ba9e-853c-4733-be39-4b4207da2367@linuxfoundation.org>
 <ZvzIeenvKYaG_B1y@zx2c4.com>
 <2024100227-zesty-procreate-1d48@gregkh>
 <Zv18ICE_3-ASLGp_@zx2c4.com>
 <7657fb39-da01-4db9-b4b2-5801c38733e4@linuxfoundation.org>
 <Zv20olVBlnxL9UnS@zx2c4.com>
 <fa9e15b3-4478-4ba7-a00a-6632c98271a3@linuxfoundation.org>
 <CAHmME9qNd=bZ2NwxebQfwKBWsfNOawqGGWNedMRjNQdug0xccA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9qNd=bZ2NwxebQfwKBWsfNOawqGGWNedMRjNQdug0xccA@mail.gmail.com>

On Thu, Oct 03, 2024 at 06:58:26PM +0200, Jason A. Donenfeld wrote:
> Great, okay. I think the series matches your expectations.
> 
> I have additional ideas too for the chacha test, if you think it's
> necessary to go further, but maybe things are good enough now.

Posted patch 4/3 for this purpose:
    https://lore.kernel.org/all/20241003171852.2386463-1-Jason@zx2c4.com/

