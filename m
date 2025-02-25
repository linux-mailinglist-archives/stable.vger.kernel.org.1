Return-Path: <stable+bounces-119561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68459A44F20
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 22:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA403AFFF3
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 21:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428620FA9B;
	Tue, 25 Feb 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8jOhPBS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9D8101F2;
	Tue, 25 Feb 2025 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519860; cv=none; b=okpxcGddYhX3A5zJIoo6xxMzlW10bLlDAQ9Qq5MWdR3JnoFBBKExWcRxug+Z+rYRww2IDXXVOzgyx3KSowY2H2WH0ZKHjWR9T+Ie2clpsmvy7xcQfeh5QzVSxfd+9yMsK6znWhpweKsAQA6BhIvgzQLKm0j/d6S82Kco6OZCGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519860; c=relaxed/simple;
	bh=qJxyYCRNrutm7LFfwn3FN/3yAr9Lu3cPrDwU6q/T/C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbtD9RSwWpAfP65z7BJdCub8FHLjmf1EKEp6KhAGI7cWK+37wPp6/AxFiggM7sVIu7gwlmkXBAEP0gY7Tclo150bDnGoQC8KLlWnmH0W5Fv3OWH8DZB60irl/12rPXIJ1hp5KCW2L18RXbi4O2bZgwMo/2Euy/zT8wuG6gqHwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8jOhPBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DAEC4CEDD;
	Tue, 25 Feb 2025 21:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740519859;
	bh=qJxyYCRNrutm7LFfwn3FN/3yAr9Lu3cPrDwU6q/T/C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8jOhPBSxT5EG1o+0f4vdKfZINxy/pCQxbUNuMKs4hdho8TER8XfK3usQT+pmORpW
	 p1JYJO5Sz7hEJqVwJGemvQXt3I5a4IY5K/JCmrJZAP4SIkI2yBYtTmoLk+tQuFR+eP
	 vlXrmtRRSBd1+f463hQR0MwZUl+TQBaOUkuoMpuc4OSoGswKkAbiVysvq4XVS8Jo7e
	 i2k5YqbaNTOvLIvInNLOn01q5JkZN/W+ukojE26s3rIyePEaQZPN7EBNgbiN+Zy5A5
	 73eWoJ9kbll5loz8GdvcyZAUEEF8IBVeLoYZBpO6Vpnpjqip9JoU1jUCXAVBLLiUkt
	 BXuH5Z0PwrxDA==
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
Subject: Re: [PATCH 6.13 000/137] 6.13.5-rc2 review
Date: Tue, 25 Feb 2025 22:43:52 +0100
Message-ID: <20250225214352.521369-1-ojeda@kernel.org>
In-Reply-To: <20250225064750.953124108@linuxfoundation.org>
References: <20250225064750.953124108@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Feb 2025 07:49:18 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Feb 2025 06:47:33 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

