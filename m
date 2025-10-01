Return-Path: <stable+bounces-182982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0073BB156E
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 19:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DC02A5896
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907172D24B2;
	Wed,  1 Oct 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c93mpxBt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C731F4CBF;
	Wed,  1 Oct 2025 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759339036; cv=none; b=KJVyQwsjRag77+HBhLXiJAbLtcyrA0wi7RIf5+rvZ/V4F17LLvGQE+seIl/qU4Dm5B9MGT8bJQsdXyEueoR2RNLF7uonw/qPPaiAWri19jPezxAGYuUhXojdo0vBPN6nU/EKZSOZTOMy/lh8/xyMV4L1OQHNPHFjrrDY/5qgthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759339036; c=relaxed/simple;
	bh=+lxyFI13ssbrG5MbxDut9vGIJo1uwhE7cHzEx/u3JJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8+XdtwHd7jrAgxuTgMzA6vuz9D5hO3cTdeQAcl/2Sv9Cz5kSU645nfsCq9NqXVvvGdq05EXSsa6ANJiAJZC2B6OmcfbzJV3h9MP7HJ0SmrUL+qzrFGs+eFdORiiTHtMOjEdn08caEuZ+qXt3TW7XZYq8d5VwQsYp7hqDA9CFgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c93mpxBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3F8C4CEF5;
	Wed,  1 Oct 2025 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759339034;
	bh=+lxyFI13ssbrG5MbxDut9vGIJo1uwhE7cHzEx/u3JJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c93mpxBt7BF5j7Z7ImuVW7GtOvg0UG7cSwsZdy99Udmc9TTlrxTJ0slXFtRfEiHjG
	 jAjI2qDyYVxOpVL94xoGpbI5e+0qrV/TckmHScM8zj8vRzsiobsmeSi5rqs1R5jBjw
	 BJMfUL/jOEw85KEqxS7eMuDYuxpcvzC1cx2OfZFSIWX62RyQ3C9/tnbB9gpKLrMmNy
	 KMp6ZIfkU9EoerBqidIqH+0ad09H0C8bb5+D6WXXsKxaOioz8xJfZDI6QUej7SJUCy
	 50h5Vq67wPs7THNfZPlXD4j54XGjk6a46z7OY7wIsIAGgjVdlxvmUglITSFjqK7Aqf
	 Au1NEhQhYACbg==
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
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.1 00/73] 6.1.155-rc1 review
Date: Wed,  1 Oct 2025 19:17:03 +0200
Message-ID: <20251001171703.43012-1-ojeda@kernel.org>
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
References: <20250930143820.537407601@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Sep 2025 16:47:04 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.155 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

