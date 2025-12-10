Return-Path: <stable+bounces-200723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1508DCB2F1E
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 13:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7653930C2BB0
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560F35958;
	Wed, 10 Dec 2025 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="oHLQNqbU"
X-Original-To: stable@vger.kernel.org
Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E43E35966
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765370870; cv=none; b=M3rWiR+phX6bd6TrTias2J4BoKpGTXBI9imCOPEwjaJzUJMan0Numq5qHcAzQjq9i9YNF1bY2IdzRmfke0pZESLYTUn9fPOgarBiChPTywoWqrgnCXcVhp+eqQxqnvDncCl1MKB9wi0Iwv3Q+ADVTvnPjazeuALyuIOv6XB1H+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765370870; c=relaxed/simple;
	bh=349pdtQ78tNKS/+l5J9av1S8KNUHinldcziiqEFA3nM=;
	h=Mime-Version:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Ge0JVqDvKBsKN3e+fPOeRwfJYn0QxbgBGfbKTZC3gbdz+jmvufvKC5fWc11txwaKhKc02SjCc8S0nGIjFZWlfPHeyl01WzqbwSPnQ5hCZ76KOqLoQCBkCAOs90ivFbhL9m2/JH3iHSYW3j+p+ggyNCJKtbOleMs5lGNPKHINB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=oHLQNqbU; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id 36EAB9A2944
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 12:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1765370861; h=date:message-id:subject:from:to;
	bh=349pdtQ78tNKS/+l5J9av1S8KNUHinldcziiqEFA3nM=;
	b=oHLQNqbUVPyPvPDgcciuxoznu295ZVHn06J/q82kQrY+zbFuLonDieBLTeeJ0FuQXwEyduDKY/D
	kVgj+jrSl+LiKRLo7rckizxCecZJDb4YGfqhVnq5QBtPWg1Y1Do8LWK7AkMrfeOCZaHD2V8d2cIlH
	q22RL4COSMV9zAYDuvlwD1gfemVztjcSssaipoisTEJVNYnkOFw8gymVQUkm2dytniDsFFBvxmDKE
	7MSLr64DCgqhiVAOPcuUtg1ybJeq0bCbN7IyL/zdJwLP1v+FP6Er8pwETOI+95AvAInoIbSgFpNy5
	InHi5t5Jta8h+m5eRFqbAMdJKldq4Vi+8vuA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Dec 2025 13:47:40 +0100
Message-Id: <DEUJQPCLYOF0.1ZDLXUFC0IX88@achill.org>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>,
 <conor@kernel.org>, <hargar@microsoft.com>, <broonie@kernel.org>,
 <achill@achill.org>, <sr@sladewatkins.com>
Subject: Re: [PATCH 6.17 00/60] 6.17.12-rc1 review
From: "Achill Gilgenast" <achill@achill.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.21.0
References: <20251210072947.850479903@linuxfoundation.org>
In-Reply-To: <20251210072947.850479903@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8

On Wed Dec 10, 2025 at 8:29 AM CET, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.12 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 12 Dec 2025 07:29:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.12=
-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Thank you! Build tested on all Alpine architectures and boot tested on
x86_64.

Tested-By: Achill Gilgenast <achill@achill.org>=

