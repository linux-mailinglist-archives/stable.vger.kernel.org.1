Return-Path: <stable+bounces-169574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE7B269FC
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0227B5669B6
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429821DE3AC;
	Thu, 14 Aug 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYKlCDlj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAC4149C7B;
	Thu, 14 Aug 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182408; cv=none; b=U20OXQZUiL7ge39qfeHumBV7/Ij4qRheefPDDYVg5N6ASEwr+lnPcZGWFc9FPxFKy/ZsKDBXsZqC2HOnegvHG3bDtLuU8KAahbDwkLldIps0HY8QLTDLUmUpsN6WbUvog2CctuX9A/T6SfZVE6xpai+DX5Tj6eXT3JtrlNyoebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182408; c=relaxed/simple;
	bh=yDFqrPUyPLCfqYSBS14sKLQHo2t2+OUj3F6/x0jtDI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl7jq7CL5VCtPlqOtz/VpaTlnSIM5SAA9SAT6yxh5Fxnp4pHbNEwZYLlHUmgzIzydDFusRiWGcGCmKSg4Y40auRd4UGKu75YPz6PrrY3ryAzDFyPOc/Vwjjd+3F5lw1KQQ6+IhVSiqg08QZMuYikRs30614Gm+OIQFQJIBQZvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYKlCDlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE45C4CEED;
	Thu, 14 Aug 2025 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755182407;
	bh=yDFqrPUyPLCfqYSBS14sKLQHo2t2+OUj3F6/x0jtDI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYKlCDljZEv0GzcE8FZCCtfM5JbEiUXvibTXNkcvsrJvSyXaQlKplrUvLhOWQNCNK
	 ng65e5q6/gMgF1HnE/XKx1psUDZkqo2u5JzeVDzgYOD4D5R9QU7V42TvcPlD0k5Q5J
	 7Yhs6N5vYPIncJPd/frf8vLKS6po4GpFih2JoVve7lwjdJU4SBOn8vnLKEpmXT9fk9
	 fPHwinX7/p8l1VcYcK97/DpwMZ4fdNCg6BbOVrGrxfjxcy8QL6bKK0SR0CaOD/6aLD
	 FO9cmxbPJPelH7drulrOcSxXf/dkuoP3GKXgNTsUbsXlMssVVYt5lV8e0WSbEgqfsN
	 PgMzimVPT1QOw==
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
Subject: Re: [PATCH 6.6 000/262] 6.6.102-rc1 review
Date: Thu, 14 Aug 2025 16:39:53 +0200
Message-ID: <20250814143953.2341345-1-ojeda@kernel.org>
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 19:26:28 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.102 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:27:08 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

