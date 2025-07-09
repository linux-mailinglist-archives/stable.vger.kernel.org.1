Return-Path: <stable+bounces-161463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2F0AFED71
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BEA18874E6
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D7C198E9B;
	Wed,  9 Jul 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX3WoInW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C9BA45;
	Wed,  9 Jul 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074132; cv=none; b=MGpNhmsNcH/8BTVbQK06AuNMvQ/EZcelI2jentoH63YMd/Hc4+ZjbnNK4+nvosMaeoCAbTh+XTZEE1Rb/+gDQnGKgXCeWcFoto2sK5MPYS2zbGO4FboXfa+7BiUKnHxEZ1D3i4jzt3qposiLF1z0Y1E+uGsKEQmj9Uik8KjZu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074132; c=relaxed/simple;
	bh=bY6iorj7WhXX/e9nzcLTF1sImx8lUcI1UrySsKF21bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQ88GEy08EBGKJovCfMpd1WTnwyYLfuXJpNNikmqA8C+7ZDz/fvEtOr4wYAu2Ws38g/7kNrcGkXxBV6heJsPfrZ8fjUh1xDFmP0+awqz9DbwUdT55k0m+/z1b7be00slLHVRjxkC1Xk9d1xdP68ljHfVZM4mRfPOLaUl7AG30gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX3WoInW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5857C4CEEF;
	Wed,  9 Jul 2025 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752074132;
	bh=bY6iorj7WhXX/e9nzcLTF1sImx8lUcI1UrySsKF21bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HX3WoInWPRY/fAheivUr2bEDlbNVlNFJWBCpzPsVCT/9XxWGXWCdU6WkYzvb/c9yn
	 44+NajNJ1lkRNujlflkh99uZKg5VNZZ6VRfT2ihHYITzQEzh1QkiKLJN9wolv3MFfD
	 Mqekc0Ix6BozzdFUNAjuiWsKOeQ/5GNgAyqdmkP4MFLGFhYJ56zsznsu8236ZSvznk
	 BX5/bqmOvV4yzfOBW/v2GzwW1PFaIsoc+seFhfu7V9W0dEfDLPsX4+/qj9Zg5CIEjo
	 8ibLS59CvOS4B9SDC3L+DcSGS/frEFMJc0XhCAvn+We1hkX/70ue4BiU1VZC/TSB+u
	 9Z01Smux4V/RA==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
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
Subject: Re: [PATCH 6.1 00/81] 6.1.144-rc2 review
Date: Wed,  9 Jul 2025 17:15:07 +0200
Message-ID: <20250709151507.840396-1-ojeda@kernel.org>
In-Reply-To: <20250708180901.558453595@linuxfoundation.org>
References: <20250708180901.558453595@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 08 Jul 2025 20:10:16 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.144 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 18:08:50 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

