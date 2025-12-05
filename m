Return-Path: <stable+bounces-200154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5209CA7EDB
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 15:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A45E6312BF5F
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF8832E744;
	Fri,  5 Dec 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmnlTdbE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D21FF7C5;
	Fri,  5 Dec 2025 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935416; cv=none; b=kV00GWx1Eq1gXNHKeMWkODXRF6906EE+RLIPd7jCMYTFi6YbM6Qk2fbwLpg0OjG79H/m362AyvGab20YVzGOa8VnVS1WIKqig3WeCOUsUZzOmBoqQ5DJWrOUsow7fPYhQ/BDc6lGzHxw2yH5mQdgHbVBo0Esef+QfDFymufuNK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935416; c=relaxed/simple;
	bh=AFoPevPax0BQ1L1mniNOnwWzC2w7D4CyOjBDcxzlbcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3RqjJpgUUquwAbeQozYTdDNOVam20h2g54foGEcxxeJZBKt/nrYfezbrqyvWMpQBNnvtp1DvSNYnq3ocdJRDhWBB53iFqO8BnXTZeq069yZ6DjvToB7GhGy+F1AGE/r88OjRUjPyKf2iCs4+yPGA9XR0Z2fu6dqoSF4qMJNY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmnlTdbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35887C4CEF1;
	Fri,  5 Dec 2025 11:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764935415;
	bh=AFoPevPax0BQ1L1mniNOnwWzC2w7D4CyOjBDcxzlbcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmnlTdbE2cnJ8ok4qCUf5QfLUUD36gGFksG7xj9vFJyPNpm5PoyekUjoaOlYAgyW8
	 mZ+rx4hFJOvPc8+2vtZxolwHAcQclqdS1kslqEJPAltZxN3rO52dZ3uti6oKkZoOiC
	 ZmudeweisrDOhpMXoJb7BvpB4d3VmIyUQentx9BuFANJh8A4T7LIA/Ksc3Lb7gVZL6
	 cXQaRAxRgX7i1VZYSMPcy8u7j4VAlsPQhnKqhFPtM/fcBr9i9nGsBOmoMS7JgVx+O0
	 OlqgojXFyhRy42C3x/Ik9Vm3muyapO0AySf8mJkpRk9tP3mZm8/FX8/Y5Qgh7NbYpI
	 IsD4GF6oNd26w==
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
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.1 000/567] 6.1.159-rc2 review
Date: Fri,  5 Dec 2025 12:50:00 +0100
Message-ID: <20251205115000.2177986-1-ojeda@kernel.org>
In-Reply-To: <20251204163841.693429967@linuxfoundation.org>
References: <20251204163841.693429967@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 04 Dec 2025 17:44:32 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.159 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 06 Dec 2025 16:37:18 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

