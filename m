Return-Path: <stable+bounces-131970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7605A82B3F
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7683A9A0BCC
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAB0259CB3;
	Wed,  9 Apr 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOSdnjid"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2E1A8F68;
	Wed,  9 Apr 2025 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213327; cv=none; b=r1D5WqqSQAIa82NIvhgMHCaQQkJj2+J5mAU/IkMizHijo6scS+YiMEuFoO00aG1l6c9nTsbwrXopBr1CMkF3xi0mx41pXw+dsGo9LQMQhI8iCE4d9ylen01W9dXOzTDnc3vP2Il11bt1BNTZKQnf8mUpeMfd108MyJzzNQT0Nxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213327; c=relaxed/simple;
	bh=elt1729OMFG3MyDsDxWsdrT3EfbovhSmungsHV+AHN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tK9zvoFVf8JSzb5LnHCV/9pzeHO5zMeMbkvrjJkJpH9RJpLjbwNfZkbfrfmEV9UHVdosgPPuqJ/67Cj+ByQiqE7a3U0PLirVu/HWLi2LMOD8Fhb56uAxHLInZcfGrWvmdsZGuFi5cUU6KgSqTfdUj5/33PxFNuOAFwFXKb9W6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOSdnjid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B8FC4CEE7;
	Wed,  9 Apr 2025 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744213326;
	bh=elt1729OMFG3MyDsDxWsdrT3EfbovhSmungsHV+AHN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOSdnjidmSa7TsdajaHdkVipM3TJI8+pVfJKmPWxzMXJ/dsJOxJAIZyfCHH6/JCPO
	 ZqTpU1DX56CilyQtnMyZnLp1ps2SyG+eR7WTnmA4U2qUbbCFr/nO2wIaO6DNAeTH7F
	 m5ohAphau/oXvzLYjNYXVCYvc70c4f0lahusgcfZmv2solEF/Aqb7HctihR2bAryKB
	 od2ZFELJztsL7Ti52iAnkMSqlXhxAVozc4IYrzX5n7BTvGlg1nSKBnNWfVaV9lZcnh
	 AfVq0xWTsH6JLJYSFUr0FGeqBJgo/uzWKgDBtoUSNDXbH+U/VT+oVNCMK3WpJwLltp
	 BoocmFRwav1sA==
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
Subject: Re: [PATCH 6.14 000/726] 6.14.2-rc4 review
Date: Wed,  9 Apr 2025 17:41:53 +0200
Message-ID: <20250409154154.1232949-1-ojeda@kernel.org>
In-Reply-To: <20250409115934.968141886@linuxfoundation.org>
References: <20250409115934.968141886@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 09 Apr 2025 14:03:36 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 726 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Apr 2025 11:58:08 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

