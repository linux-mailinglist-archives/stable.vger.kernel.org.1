Return-Path: <stable+bounces-191477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30CDC14EC4
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 14:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204A01A20F95
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D130BBB9;
	Tue, 28 Oct 2025 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="kRutTT7P"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015CF14A91;
	Tue, 28 Oct 2025 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658832; cv=none; b=fPPD+nhGAWs4P7FL/mjydnQtY7FL+9+GSDPZl19PgF64M77RjcTHXNX3MMwx68LoL1wk1MlIZ5+pW0x9P3rLT0OPvwfn04smyrcHN5icTHq2s5s2WNIeGCAfhbJ1OEuFOiPPGWDfCj4rognnfI2/EDPDo6BVon/Tx4uwCnGGOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658832; c=relaxed/simple;
	bh=4isOoBfvoLcvKDHRkcK9OPTo8LnKjo2troj/tVLwnOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALBygx5O+YnlXvmYJtFvu+8f0RZ+P5jzmyd3Quao8z6Wlxes1DLc6AT+egp64StYsyPv54iVq99M7qmbM66bHo1HdodTmASG0cmUYVS5lIaMGpxMSrbzUkEIvTBjyVEESwKfAYmJ0uNC+Mt/LKGYPnfzTsX5sTXERnTSenvlIMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=kRutTT7P; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A6F9914C2D3;
	Tue, 28 Oct 2025 14:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1761658826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xo7TQuJYcG9+UK28crcCJLL6or7L7xI6NKDHv69QYDA=;
	b=kRutTT7PclY7sENP5lOYQbx7cmRzg11A4Jep1etWbaNXFiwQTssevEEiuLD2QlpTT8VQr8
	J3po/6JrtFKOdMZyWoGMfL4FNuKWcDfQxRg1ekFnzSf6IqWU47EH3ZUN8FafYLNzitkUOo
	4Bo0OmwbR+YXuwhMin4T5ZhLD9B26epyYZ3NNQiz4c/wq8kPDpD8lI2trPlws7xXXvOHS7
	oz38iVCXlHOXrc5zu1NxFw1oW2qoUMTiXAE8vZejxmtdnuTIyEPT3f0S1ojIJGmaCvZmUT
	VpoxgKOHcqRMK59DbcThZK8iy1gBd65UuyMWaqi6tD9sqSYnAWtGZZvKvrrYOA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1c797040;
	Tue, 28 Oct 2025 13:40:18 +0000 (UTC)
Date: Tue, 28 Oct 2025 22:40:03 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 5.10 000/325] 5.10.246-rc2 review
Message-ID: <aQDHs-d24Vj1STKb@codewreck.org>
References: <20251028092846.265406861@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028092846.265406861@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Oct 28, 2025 at 10:29:21AM +0100:
> This is the start of the stable review cycle for the 5.10.246 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Oct 2025 09:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.246-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 98417fb6195f ("Linux 5.10.246-rc2") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

