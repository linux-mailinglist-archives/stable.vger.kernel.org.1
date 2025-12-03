Return-Path: <stable+bounces-199921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3CDCA194C
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 21:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 033AA3007CBB
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 20:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCF22C0271;
	Wed,  3 Dec 2025 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="LqIjUueb"
X-Original-To: stable@vger.kernel.org
Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75242BEFF1
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794603; cv=none; b=N6wRVzsA3OqP/WfvylX6bgOX1WCpclYfEpF/BnL1R4xdlxuOdUKKY4gqVDcxsMWf9Y8Uim0Z0DtmmMe9sI0wr/tyjjioJHlXDHKHe5TAvCJ7UKKpOkhTsdVAlNTldsak+1IRkDjKE1iOzCZ2r1vsp5ieRgFKfTYYcLbN/PnAS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794603; c=relaxed/simple;
	bh=uChY98SMxaqGwShhbtHMgtlQwE+YpKuZEtJ8qwM1jhU=;
	h=Mime-Version:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=iVWJGTIfi0KRe5g6R+t4DuBa0GhmElusvZoI7qE8ajs52KOANKaUno9BxkzYFopCqXiOvBGpu23hcLyRat2TAU//7LlhumJ3ZoZRMBFqTmMZdzT7jrITZqqVQkLD5X4NuO6kxO4DJbCAX57j1eMfX1hYSoB/gIWfaVlBQBdz9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=LqIjUueb; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id BF2479A293D
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 20:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1764794207; h=date:message-id:subject:from:to;
	bh=uChY98SMxaqGwShhbtHMgtlQwE+YpKuZEtJ8qwM1jhU=;
	b=LqIjUuebDig0OumYSnwuRfpFqxvZMekbJDygxYAe+pJZ0cN9u6UVOfwizkizRiDqCb5I7tWFhim
	B/VBZdkylOM5An992p7T+MvkB/FWL885iaFsmgD8ztdPP+4LFBMRL3P1M5b762Epf7xntT8n7cso2
	5iT4TedksSYahqiXwN+2mTA7oipUuo1QBUG/LPLc1CFr5Tb02oTrqicoB9b8xdTEWRfWDjpOkQZuQ
	vF56gHfyv4Z3jplHyFWln7+Q6kuCKCKFnYVnbOqnHk/BDgcCBXKYoW3QJheStRKhWlwIDHemJeAVD
	hKG8e35BA9ZTZOmNwqsG/IzP78V0nj/ZquWg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Dec 2025 21:36:45 +0100
Message-Id: <DEOVC1VVO6NU.1DAURHNHDPIPX@achill.org>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>,
 <conor@kernel.org>, <hargar@microsoft.com>, <broonie@kernel.org>,
 <achill@achill.org>, <sr@sladewatkins.com>
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
From: "Achill Gilgenast" <achill@achill.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.21.0
References: <20251203152346.456176474@linuxfoundation.org>
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8

On Wed Dec 3, 2025 at 4:26 PM CET, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.11 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.11=
-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Thanks! Builded on all Alpine architectures & boot-tested on x86_64.

Tested-By: Achill Gilgenast <achill@achill.org>=

