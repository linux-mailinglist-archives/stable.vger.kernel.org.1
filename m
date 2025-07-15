Return-Path: <stable+bounces-163011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 886C1B064C4
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 19:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69231AA59F6
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 17:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54223D2B1;
	Tue, 15 Jul 2025 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irh+IKtA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1207E86331;
	Tue, 15 Jul 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598873; cv=none; b=CMzL3bZZ/nCXZluDW1Mew9WbYkr1cS61V78NbStR5XmEPaedAKHiHh/qyetGJJQaVCXYpLoGqZb4msaOZXYdOyu5Q9ojwtEoIrOy8RYrwllTFhRWtVwur+Tg10DSNuYNAONie7lHsYctbqCPOq6YXJ5BGGhIoHivChNGkn8VwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598873; c=relaxed/simple;
	bh=oWcRC1ejpa4cl1kPZsNFpzxdsH70luooyUvAqqjl06I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LECkQoQhnDOLw6Z4o1hH5JlueKFVokQF6fiG1TrX+lniwHRWsnsB7+uK1wj5F7iiIgtvm5uMpE2fw/6e3XWT4ybf/Syrj51TdZLGBZrq3DQ3yFBR3keXho9RGxXIZbHZlpkT8tUmjEqdwSapF9FvfKCDZqrQXyUlxPend4C9wn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irh+IKtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D919C4CEE3;
	Tue, 15 Jul 2025 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752598872;
	bh=oWcRC1ejpa4cl1kPZsNFpzxdsH70luooyUvAqqjl06I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irh+IKtARqb3Z/wjev95ThrPWq+FyVxMRHifwemSkt0qNaWghN4MNYYJwlfRznAPj
	 bMdEpNjVG0Ky4sNk5xU6iPVA3jX6h6ubUHbw8SWfp5Bvvg5nR8xJsfUm05cTLXqPn6
	 3wxHszpZPlcc/5psAjEGtt7ISKkb9qQ/BCLExEeB+AlrNHge5BokLuOmYIK7ODZLHa
	 Kh9Txq3grrDrPdZsWgU4U5z6QtAjIGX+W21nR2ptZXwhBqdR4XF7Y11uMEDZTz6hiZ
	 MPm5Ef02tah+G2mg4ewQKxn8i8ln2mL4My9Hiz69G67wOjB5c4Qf3/G9quW2g1gJLe
	 royTpxgLPXjQA==
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
Subject: Re: [PATCH 6.6 000/109] 6.6.99-rc1 review
Date: Tue, 15 Jul 2025 19:00:49 +0200
Message-ID: <20250715170049.2136668-1-ojeda@kernel.org>
In-Reply-To: <20250715130758.864940641@linuxfoundation.org>
References: <20250715130758.864940641@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Jul 2025 15:12:16 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.99 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

