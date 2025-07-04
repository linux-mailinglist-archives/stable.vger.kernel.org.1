Return-Path: <stable+bounces-160233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7130AF9C9E
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 00:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A76585777
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 22:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A1D26CE30;
	Fri,  4 Jul 2025 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKd2hpn1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496502E3701;
	Fri,  4 Jul 2025 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751669345; cv=none; b=UI0Va+xJkc0Wc0Lus/VVF57YJi3ez7kax7tkNWsteeOzivNQE7hJJVjn4Qn3qZnlh0wclynAuWVY10pFDQfadsNcR0wT+ThcfbZQhwCkRX5tt7+/BxMey3l5PtTAUSiUoBVO+B7MXyja9ifZb1Pt+SowVDuMC2BZkmCiMAYxYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751669345; c=relaxed/simple;
	bh=ZMgTGcfcphmHgdShMOnlNA6jEGnh/5tAa8A1i0AbF2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ii8JRWGagxL+Zlu4Ma5v4lg9KM5NrESWV2kYSLYql6G8aOCliuOHFSuzpIfWyzPvuGB4HqVbYMEDQXrMSpvRbEelLF9bm2RqJDlox7HVi/LrrKn3JYl1iLFl3oenhKpmhKaTt153sgwpsbD4jDeFtX2feHFAzJeEoLzxiw4gMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKd2hpn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFE8C4CEE3;
	Fri,  4 Jul 2025 22:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751669344;
	bh=ZMgTGcfcphmHgdShMOnlNA6jEGnh/5tAa8A1i0AbF2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKd2hpn1QVPpJeuCk4rlzc5JnQDjyNVR1ETz8PfAgDjby3sxns4cPOIzlrKmWSPSt
	 nN9osD3OQrCL9uSUGkC6TR6jAJIOozpynP4yLcZmR/YED9qxNBROKPG+9OGWrP/4YB
	 88Ot0jT0+QFrtXCPn6P717LqO854yQNB707wkKUvu/OiQ6HBKOGnxbGEpNRQQBDpHg
	 Daqz+PXqgyaSkr/r4eDSH6s8dLcXi/1w9uOQ/6rwboFmYntrg2vm80Bszh7pJSpW9Y
	 D3sjC2ljNqqbok8nNuxb1tEOHSueuIaXiNCjM8gXM6LX4MrhGhgsH6+mEkUdCW096J
	 NOSYq7oFljnew==
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
Subject: Re: [PATCH 6.6 000/139] 6.6.96-rc1 review
Date: Sat,  5 Jul 2025 00:48:55 +0200
Message-ID: <20250704224855.328067-1-ojeda@kernel.org>
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 03 Jul 2025 16:41:03 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.96 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

