Return-Path: <stable+bounces-158643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF36FAE9185
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 01:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B043A1C40CEA
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 23:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3262C221D92;
	Wed, 25 Jun 2025 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TknqZ4N3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF050199FBA;
	Wed, 25 Jun 2025 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892576; cv=none; b=EvcGTFQz7hv3ZfMyeNAe4WBEQXAxJIp6weLQvsrSpiuBHHLevdguzEPuQO1E99i872XZGdnn3runUF1Huc/1/B1tmOE670aC5rB+WwEVK2v3a9BPg/3e2GTY/BrZD6LwOg/u+sPbmPfqdaIyQYcxkJYgdsjJAx/X/78CTvTKeVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892576; c=relaxed/simple;
	bh=2RUid5N504O6shRDf/v/1jLq75LikTOdtdePbpzwn0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrcwFVNsNjx4kJGfQA/AehUeMzeG1dlpfeg6bmYZTHztgO64bkEBtvMClMfI+RCVv0N7N8owoTLEz2ekLAPpjAarbv/BkFKoP6VbQAS5nJ9d0mLuCRgZmzfXmagIoVmI/aDVB+OrRlvthdEwj+kw/C6yt59HhNSm0Uf7FENBgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TknqZ4N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E751EC4CEEA;
	Wed, 25 Jun 2025 23:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750892575;
	bh=2RUid5N504O6shRDf/v/1jLq75LikTOdtdePbpzwn0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TknqZ4N3GUMcKOfoMWTBMYxEUzuIUHz/OpTXXGH8ePZlu/ocIJ+9s2/15QxxytahM
	 kEbCqMeR2FkFQlg1cUgfHYwUBAPH23465Wb+WvtlHEqpVOqYjpruuKu2/UX5mljpA7
	 p6+jQsQYiRbB7xDOZSucWFsT6dFsmDt8uuZhqS1bupG/IAhXhm6rOsJ5yocoEeoXn8
	 la6+YF9g7RjtclqDwzPnSfFit6VFHWVVCC13RNE++VTZjSeioSVpuk2NtckE0zsMRs
	 hZVjmGzoIUJHJYSb5mGqU0Sj8nUK9Ni+NbR0U20SO3pyPK9Sv/3JAkeNOOsHBhRtLk
	 7oBCmd7Gogzbg==
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
Subject: Re: [PATCH 6.6 000/288] 6.6.95-rc2 review
Date: Thu, 26 Jun 2025 01:02:45 +0200
Message-ID: <20250625230245.951422-1-ojeda@kernel.org>
In-Reply-To: <20250624121409.093630364@linuxfoundation.org>
References: <20250624121409.093630364@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Jun 2025 13:29:03 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.95 release.
> There are 288 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

(-rc1 was also fine)

Thanks!

Cheers,
Miguel

