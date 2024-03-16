Return-Path: <stable+bounces-28294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF71F87D99B
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 10:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031971C20DA7
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2058D11CBA;
	Sat, 16 Mar 2024 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnw56GLz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2310940
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710581896; cv=none; b=D7nyR6/DtU7NWL9UY6+3Q399FpIZcnPuXd98QqARNrJOd5b/Q1sfB7RgNqei2pp09//kjGWOY/QIHNYILPV9m411kX4Nw7FPIRxnInDLT3Q1xuJslRHj8C4RTanDGhlRCqb/55i1xxAULaHC1Q5vxJ9aEW/wg1Kzo6k+GIBJNw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710581896; c=relaxed/simple;
	bh=yS49M9y1HpcWokGnvZx6mq/g7NhZRqRaiik+pE93ri4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0pnVHLkaUBId1dVC16eyYLghZGAJOTqokYSwnq+1N86qbPPJqQsEy5Xf3cIEjwG0auE1aA63PpSSVvVL8hgW5sC0jBJ29izUhxPgndjytqqxfoQZrd8974HXtT+PAH8tUGmyUNXsToWcPJyUXj+OkTdUansEmATkuXg2zW47YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnw56GLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DA4C433C7;
	Sat, 16 Mar 2024 09:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710581896;
	bh=yS49M9y1HpcWokGnvZx6mq/g7NhZRqRaiik+pE93ri4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnw56GLzo+Xa0Ijf0Rsmli8yofadWjp45lVj0gBxdO0L5YqzSzlbFiC9YLE3WvncU
	 dZxUe9RC3350tR4o7+g+4tge1BOe9dvqQTgYz0l/1hnnIvSHqfHTQ+UJDAWhXAiqM0
	 IdTjaCa3qRATXwPM0FdWlKqgkgejUVQGH8GFXTiPWZkOOvt3fTqUAtPCdXBaou37md
	 q45EH3dGlKLUMJ6S8dIRKWAK/hzctUMlcVM5/uIDL6OaUU0f2tmGRmaDhfPqY8yQAR
	 ZiYPU4hi1/i7FYz/5bfvebjmEUqpBlb1hY/csHFL8S26pnzwKYMC6xCbHdljldLX4t
	 fHEXzlzoBhbKg==
Date: Sat, 16 Mar 2024 05:38:14 -0400
From: Sasha Levin <sashal@kernel.org>
To: Khazhy Kumykov <khazhy@chromium.org>
Cc: stable@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>
Subject: Re: 2 md/raid fixes
Message-ID: <ZfVohhUu-SQcNDI8@sashalap>
References: <CACGdZYKuwuC9yhvsZEx5HvsRt1yieyJpgojiFZssR7hQuTkaRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGdZYKuwuC9yhvsZEx5HvsRt1yieyJpgojiFZssR7hQuTkaRA@mail.gmail.com>

On Wed, Mar 13, 2024 at 03:47:49PM -0700, Khazhy Kumykov wrote:
>Please take the following 2 commits from 6.5 to 6.1-LTS. They're
>already present in 5.10, 5.15, but seemingly were missed from 6.1.
>They apply cleanly and compile for me.
>
>873f50ece41a ("md: fix data corruption for raid456 when reshape
>restart while grow up")
>010444623e7f ("md/raid10: prevent soft lockup while flush writes")

I'll queue them up, thanks Khazhy.

-- 
Thanks,
Sasha

