Return-Path: <stable+bounces-160150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC9AF89B0
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 09:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C4787AD6AB
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 07:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB7128150F;
	Fri,  4 Jul 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="T04H9V2t"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04327A101;
	Fri,  4 Jul 2025 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614820; cv=none; b=b3zMvLVvvFjysFJBiU/UlkesXSVAtmuIf7v8oWgj7hTKYu7w0fKTMXJ6LlPU0EfPUtN5XzfjTnJXrTfrqfbaN7pAGBP4emfhWZWKcu6Qr0IH3wM0MGu9lOkAomjohr9GlK3n81OhVUkrex5SHAe8pIkYlsppHqDD9CR1/HuNNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614820; c=relaxed/simple;
	bh=CGs0Fff65AzXGYRyDTJF/eX27m/8Ywa1tS1bgNimHW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCNQ0jfa2bknPxZKD+v1y5nwpuZgpwKKsBPY2STMPlkeqCxWpKuzGtIuMqftlScXgAcBXZlNYAaUu/Mr3dFHXIhyAR1J92n2KZQBkC0LTjJAT2QYO9DOld0jsNROtsp+jRgErPiquKmPt0cGFakk/pKrU1fJ9NdZB+NIyUqsQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=T04H9V2t; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1751614419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xasny3TaXLihi3Vs7IGinmOfqgdTVwfxsXvQElSYYDk=;
	b=T04H9V2tqxMIYJpDOmqbaDVGdOfruXd5Hg70WPlGnCm09HyK2cduZcsgIVK4QpqwtsR7t4
	r4yfoieN4XVFBTCA==
Message-ID: <fe4e0930-210a-4dcd-a215-9dd8b2613ff3@hardfalcon.net>
Date: Fri, 4 Jul 2025 09:33:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250703144004.276210867@linuxfoundation.org>
Content-Language: en-US, de-DE, en-US-large
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[2025-07-03 16:38] Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiles fine for x86_64 with GCC 15.1.1, and runs fine on various physical Intel machines (Ivy Bridge, Haswell, Kaby Lake, Coffee Lake) and in a Skylake VM.

Tested-by: Pascal Ernster <git@hardfalcon.net>


Regards
Pascal

