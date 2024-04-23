Return-Path: <stable+bounces-40726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166088AF3CD
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7468286E52
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F4513CF90;
	Tue, 23 Apr 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qDWjzsTv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340C13C9DE
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889362; cv=none; b=K/4OuAnLRQuBRTfD4LuN1WkyxUi2qeIBo+vL4SExMOZyKj2qCnsBrePJUogmOomjf3DqPd95Cx0Zl/pe9XvQCNHyQZxqn5zViAN3OBx8EBLngasz4VvpKyATVtntd5mQaN5/asOH/fYBaI8AHhqaoBH/12J13e1E1Y46CbijF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889362; c=relaxed/simple;
	bh=neXOWGl1TGrR3sO+pOeYiW58AU0ZzIq+cZLHOb2WTlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8MuNGcokjH8WBXU1wvqa8A7IxwIXATsIvt0lRi/H5nlkemvwU4GrOb0cEsDx2a8SM8nlV0AHeL59WTF2+VZlRrvjZUEmp+4o2auKKfF0Z5d8/QzkwiVffJ6VuTp5I/0vwCLOuMfvyUQWBqaQwS68XXsVczbGLjeTYJx69g35S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qDWjzsTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFF7C116B1;
	Tue, 23 Apr 2024 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713889362;
	bh=neXOWGl1TGrR3sO+pOeYiW58AU0ZzIq+cZLHOb2WTlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDWjzsTvXMjo84tUBlfsAsEh1kmaJ+Yoj5Ac9QhNfYVWLTOSqCa4iBoBBXJwQd8wS
	 NXxlQvbqIexf6D8QnhDAEuZHs6DTlz/0JoJm5D+JngFWAfxRQ0eAUV9VIC+s37yOPr
	 X8FsQtQh45OlDacy+Qa2FeHNRvs19yH2C3JaKZS8=
Date: Tue, 23 Apr 2024 09:22:32 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org,
	petr@tesarici.cz, Sasha Levin <sashal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: stable-rc: 5.10: arm: u64_stats_sync.h:136:2: error: implicit
 declaration of function 'preempt_disable_nested'
Message-ID: <2024042307-detract-flammable-d542@gregkh>
References: <CA+G9fYsyacpJG1NwpbyJ_68B=cz5DvpRpGCD_jw598H3FXgUdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsyacpJG1NwpbyJ_68B=cz5DvpRpGCD_jw598H3FXgUdQ@mail.gmail.com>

On Tue, Apr 23, 2024 at 01:35:28PM +0530, Naresh Kamboju wrote:
> The arm and i386 builds failed with clang-17 and gcc-12 on stable-rc
> linux.5.10.y
> branch with linked config [1].
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> In file included from init/do_mounts.c:7:
> In file included from include/linux/suspend.h:5:
> In file included from include/linux/swap.h:9:
> In file included from include/linux/memcontrol.h:13:
> In file included from include/linux/cgroup.h:28:
> In file included from include/linux/cgroup-defs.h:20:
> include/linux/u64_stats_sync.h:136:2: error: implicit declaration of
> function 'preempt_disable_nested'
> [-Werror,-Wimplicit-function-declaration]
>   136 |         preempt_disable_nested();
>       |         ^

That function is not in the queue at all, are you sure you are up to
date?

thanks,

greg k-h

