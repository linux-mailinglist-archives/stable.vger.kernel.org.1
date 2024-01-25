Return-Path: <stable+bounces-15822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A697A83C8FA
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 17:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24591B20956
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2737A13340D;
	Thu, 25 Jan 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pr/GgqvM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D629A13A261;
	Thu, 25 Jan 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201309; cv=none; b=dTSJzuGjykJgzRKUR/2z+BRdQ1mf2Nzyu0aY0EQ7QVpdG/5EWVLt2kPAiskXzV1gHl3WloS6BJodODlXDDvGfYndKWC06LBroTRagJcsOZ6WX/16cQov4tNLf0xRqwBXjcsmT0gwZCat4uHb3B0IK1YLxqLE0QOCHe6+BQy+7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201309; c=relaxed/simple;
	bh=ssSEP/zDEBu5i+gqyDVU7si8pxWPcarUdOEEfYwca3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEY2TxpqXxU+AoscHJTUaZM+gDR15kzKIcCvDfIP70O2gxsFGSYEm+vGeN8l1ex7HpdFpR05mdLoYYKsHSxpQEcMLEg+2LC8KReuVkPMrgEZsRxj4iyqawf4/5g4u33mlapl2QbZFee2OYvJRrAMrJxdpFCHHpY8JN0wHWdTJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pr/GgqvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94F1C433F1;
	Thu, 25 Jan 2024 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706201309;
	bh=ssSEP/zDEBu5i+gqyDVU7si8pxWPcarUdOEEfYwca3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pr/GgqvMM29YjYJBlYyhv7gGAgbHUJksNhAm/FuyO2eCCZgcMky1rhd6ne9ndRd8f
	 LOgWn0JRwlYlOP9QkCk325/yJ29t3e6inwqw9E/tVM/1uu17HdE7nvGaNt9lrthofo
	 +xQs0KjrVtGLeRqB86xWYflETnJfsWXZukNYMYhd+1bt0iyVGJFFu+DFSmoSBGhANw
	 /Uhicdlqfc68idLUPVteCoXewXmtErV+2dz/1zi17VaUTxLvCLdIUF4SmDCSANwl3y
	 QViUPjXThKaTsKaRGAd+ewzDGbWBt/whyFjZnPuyJiYV+PkwZSMdQ1mnQgYmUeOyFP
	 Ar2t4ucuQWqnA==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	allen.lkml@gmail.com,
	conor@kernel.org,
	f.fainelli@gmail.com,
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
Subject: Re: [PATCH 6.6 000/580] 6.6.14-rc2 review
Date: Thu, 25 Jan 2024 17:48:18 +0100
Message-ID: <20240125164818.211981-1-ojeda@kernel.org>
In-Reply-To: <20240123174533.427864181@linuxfoundation.org>
References: <20240123174533.427864181@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Jan 2024 at 23:17, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 580 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:18 +0000.
> Anything received after that time might be too late.

Built and QEMU-booted for Rust:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

