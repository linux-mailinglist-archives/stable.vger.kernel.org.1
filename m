Return-Path: <stable+bounces-139193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02A4AA50DF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCA53AC599
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AF125DD02;
	Wed, 30 Apr 2025 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ07nxSD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0E17CA17;
	Wed, 30 Apr 2025 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028464; cv=none; b=IqFzcsv74V2jSq+AG8GWfDCsOSMieRnXEJZODcpmp+3PvTK4PA+ItJ5XoXswk/Ou+e0VokkzEQY9EZmn7CKGv0Uug1tAeE8bIcfnqHRMxxF+u5gfHvFjGLZ7yJJVE18ez/bQjecZme+BfVrymN7KYR0BKM1k50PU6KhQXovJKII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028464; c=relaxed/simple;
	bh=z7E8Qbo13mwyDTVgulR62/h0cxEpdpORLCx+iFA/PcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+J6PFFJwDZGqgRUildkPn1Sn9rx++B+CTfQKVNa2IWsazxE+D66bClYbPNNCm6rpqgsta3kgsE2J1oAxsO3uMEWSCNOmGyr9ulvETI3EcvZGe3gftBF/xoQXgBTXlkvC+hpxR/gMhTuZUiuPvXHISo5APb1S+H4XEbGfxQDS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ07nxSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8763C4CEE7;
	Wed, 30 Apr 2025 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746028463;
	bh=z7E8Qbo13mwyDTVgulR62/h0cxEpdpORLCx+iFA/PcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQ07nxSDESASQakq8rKDdfFSMSacI8dxxX/QW9rZ7BJ+4U12f05PxkYRABFH9IhBH
	 Owu3Z4yNhSchvqx/6Yl2OEL06UPbSrAZHVqLyFydzwR/v5utxgm/Rf0nNqA1FgsIny
	 GfC7D/cMvegLkrnSfIQkMJeturfvukKAp2inSjiy+9AZ7wrIZk3muaiotnyeaX+vUW
	 Iz/imHadJL2tLh+nFu9wnhGvir5CgXpD1887igW64SivhGDm15kejt2bkvBEinsOlv
	 h1eOyvyGAqdz/YmyKhlzBx927MYiXLr4H5l3CwbmaI9BWiiTEf/C31c/mx5N4eQYmn
	 hI+/Z1J5Qjk7w==
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
Subject: Re: [PATCH 6.6 000/204] 6.6.89-rc1 review
Date: Wed, 30 Apr 2025 17:54:11 +0200
Message-ID: <20250430155411.796760-1-ojeda@kernel.org>
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Apr 2025 18:41:28 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.89 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

