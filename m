Return-Path: <stable+bounces-178891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19716B48C20
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E1C3B1E06
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 11:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392721B9E7;
	Mon,  8 Sep 2025 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljxq71/u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2FE3209;
	Mon,  8 Sep 2025 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330888; cv=none; b=kF+9wF5aVJl7lJUuX+4HPjHsiM+zBIvxc1/nvr/tYMuUmdFeeJGmyKGQab4M2jxh5YeK1zqZcUFyQcy3HCzk0Kzp/5Xfg7mXgvtXSI1NLHKqjoQi7lMTtqh/NWljSrjyp8Mea6wIQT3mmqlX4YW7+LqYJRa4CugtmybLWv65wvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330888; c=relaxed/simple;
	bh=/vifE/HTR5OGwgyrlXiQ25SK+ME+Q8peie+5NwrFSt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niAaq7pRTbXUgiSFnCHnP7kQ6ZQpmaSOaISIOiK2dczvl+JwoeeXq9uW+1auWQgCPtOSeKdAT55LFktqhySIW0oGVf8MhWatislJ8lwFxNfETQwvelhorU2piE0ZjGRXy3oOp2YAMlTHmJjGcedOD8SBbmYNkp9pFbow7OmrxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljxq71/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF29C4CEF1;
	Mon,  8 Sep 2025 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757330887;
	bh=/vifE/HTR5OGwgyrlXiQ25SK+ME+Q8peie+5NwrFSt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljxq71/uZ2QZzdmLp2tAWkDyj7YEL1oA6QMRaWmz9ql3zk76HlR+bDZKyvGs+vSmJ
	 9up8z1xUmGVZMORJXQfgaX4ogyOWrbrFrsl1gpRtOyYcZfR+owMPs17MU73jEg8aLg
	 +iOhpJzHeFLKJZ9wzLflCUO+tJLz4xvmrVGXOaQ6VYdB+6PNepMdsjvzQ15PuccTSV
	 tQKHl/g+HD043JnrO4ChX5deuHVo9gt/YYK+lJzGfBFRGHkAEBx5HMm+tWradKSXj9
	 TRS7YLKWlXxLF6UUsrUF7z8N/lxOJtQZeM435sRwzJHCUtjqsEXvELF4V6YmOPJQas
	 ha8e8ocN2Iuwg==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.6 000/121] 6.6.105-rc1 review
Date: Mon,  8 Sep 2025 13:27:57 +0200
Message-ID: <20250908112757.567373-1-ojeda@kernel.org>
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
References: <20250907195609.817339617@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 07 Sep 2025 21:57:16 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.105 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

