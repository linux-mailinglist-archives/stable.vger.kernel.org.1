Return-Path: <stable+bounces-184092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC734BD00A8
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 11:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BE418938B0
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA0D25A2D8;
	Sun, 12 Oct 2025 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8CF6hPG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6C1400C;
	Sun, 12 Oct 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760261074; cv=none; b=DBuKCgWmWjhdzdwPcUrSWfhAI4etOq+wc3faUeUBgP9PrhfJis6Lw4Ys13tq4OxOGCZ3/HJ++oa9AeBZ25wOSL714C/v15GoG1uGeJ0/k9Qk2e9QapsNZtWi2tw/bl0U6Tt7AScct53pqf8vTsokQ68qVfk4gB1XFoaBuEmyFAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760261074; c=relaxed/simple;
	bh=R/Kb2+AfMthJI2rLpMuY/eMmmRSKrb3lka2R0cRtZdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TStpzlbcbulPg+t3NeaAY1kbZJ1UZ1wl/Spamliwrb57ujfsUmuqisWTJT+tN2rcubPrsQoUj3vwrl34ogGsDmDRNmytQR2gVtAJ/HzMrF6Kb+z1miHhTgKUeBYfE+cCk2fhlJQvFSdMnIvSDla+27hy0cnjfNzkX8gN3f7w+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8CF6hPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B502C4CEE7;
	Sun, 12 Oct 2025 09:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760261073;
	bh=R/Kb2+AfMthJI2rLpMuY/eMmmRSKrb3lka2R0cRtZdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8CF6hPGhDvK96V2jqkRl14I0hlG7RgtMSXW637cLIvRIANEcqWKWccNgstnQBME5
	 gomz9FLjQOH/DuorXTkRxtlRJ468aEY6Nz7Acuds0Y2Z9yvyTupS8l5h6MeshcV/VY
	 +TdYV+Pe9cuU83xLr3gmqzYO82LZVz/BHO2T1W+PlIJatm2fmJ0y29erHfAxDgk/VT
	 KGzMPU6H27aWhMKWJLNc1s28RX7Wg2b2iT2nIP92UjFpolhAG5KgVTFXDS1vz+1k7e
	 b2Bzs2ISZNqPGkT4SIIsqwsexXs8I1TxigjKKM6vWgDx81H3BpyL7JR8IiWydjJWZd
	 7FgZYs14RfdFw==
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
Subject: Re: [PATCH 6.6 00/28] 6.6.111-rc1 review
Date: Sun, 12 Oct 2025 11:24:21 +0200
Message-ID: <20251012092421.997353-1-ojeda@kernel.org>
In-Reply-To: <20251010131330.355311487@linuxfoundation.org>
References: <20251010131330.355311487@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Oct 2025 15:16:18 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.111 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

um builds cleanly too.

Thanks!

Cheers,
Miguel

