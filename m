Return-Path: <stable+bounces-139332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A44AA6197
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E217A59A2
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EDD20D51A;
	Thu,  1 May 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRJ1j5XE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23882B9BF;
	Thu,  1 May 2025 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118387; cv=none; b=UhSFwyDeVsbxWPUTY1o2EXMhiH0mNWlVO2bPmfJe0WGgV3HL58cjxRNgKeb1SIPII/TBTdXoKjA8n9MLmn/4Dr1z+ahnQIiZt1gQDq5EHdlrDgczO6ZC9uAPs7/EhugfHhQnZybPxdKFk9y0haXCpqz0D04sRoRwg6DDFpSzRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118387; c=relaxed/simple;
	bh=+asoCr+kCdq2HXbDDlDIEGdHKQf3BuN2b1OJEx0twLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbVcKtEhrBBxRZ8ks6ZzkakHixnKIaNuOId4azxO3CXJkXcDXqxmLEscJlfT/3ceQSg5CWcxu4oOXuVyUcEidarzYtG+kC1aON6+XpIzsldk1Ky82pArjPAVb2dQzqv1gk/KTLyUlizDl56Cb2aQeXyeMVWLvWn1n2Fd038/g+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRJ1j5XE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB2AC4CEE3;
	Thu,  1 May 2025 16:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746118386;
	bh=+asoCr+kCdq2HXbDDlDIEGdHKQf3BuN2b1OJEx0twLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRJ1j5XEHsmvM/u/Ehjlv80WXSsdM2dKRQ7ARKTiltyMF/8fqXKj8Y2PtCKuptXhW
	 I0xyWvKkPQhJPxmUSpseEFB8Nd454hGymPoiVns3YRAjtZUZd/Wy8ZFGLUKCA73dgp
	 9+rBZVvMyPpIdzAFceozylFx+44QDKffOR3acOOe2rDceowjVVQAg5YfqtbomnAkS4
	 xEU+1qcrj17vBv4YGN4fEDzIDmAOIjikXOotOFiQDScuTBO6sPbOO0Khe/3UEdRPu+
	 LztvIn7jHXdnVa8daPU1J7dfTHDZNAfClcT46fuasy6OL9gdw658zmLxzQFZrGz+V/
	 BlmL3KmhvO0dw==
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
Subject: Re: [PATCH 6.1 000/157] 6.1.136-rc2 review
Date: Thu,  1 May 2025 18:52:49 +0200
Message-ID: <20250501165249.1124969-1-ojeda@kernel.org>
In-Reply-To: <20250501080849.930068482@linuxfoundation.org>
References: <20250501080849.930068482@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 01 May 2025 10:14:15 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.136 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 03 May 2025 08:08:16 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

