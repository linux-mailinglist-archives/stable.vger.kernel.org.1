Return-Path: <stable+bounces-145679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACCCABDDF6
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F743A9FF0
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654624BBFF;
	Tue, 20 May 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="K/K4TcRT"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC724EABF;
	Tue, 20 May 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753042; cv=none; b=kAfj4XnhTdKDp6PSX8uQGfFMz+XUIZvYlo3m4TaM0HEJa/Cp0UV3zn4FJ8wcw7iO9vhbeEOu/xirSEeVT8IHfhwFWTyh57U3Tw8xZQ/z8MEBrCw0h+sW9gJX2Y7PGc8BRvaBx5oGG/HGt+kx07c6VEQXauoSXzVjb3GYJAKXDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753042; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4JjUqDn7Qow3o742On5brkMYaryckTH8XCQc9/ONVXHYoF0iSY4rqKbg70ACDdAr/NgxIZGvUyuXyMuWTgTPRxj/S6/s8cHssZ8lcRsqmlewjm+aaDLafR8NMXPdjlpONvcepN4GbKP7AF2rZ4QMwSISxBoZuLrYGGt6fagJmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=K/K4TcRT; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747753032; x=1748357832; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=K/K4TcRThnPK+QGMXAEGY2FDi/YeEvqsIlb6iWop3kMoR+AZMbxakg1wHvN8Jcts
	 JGZlTAuSBt7KgBCdKCn2dM5kQr11pkOl1X/cLqHh89YAxTwH1m21vaUacGG7zXwWS
	 xIZnxlP7DM8aZzS8uNO7bBh16ViZLD74FoAq8/AT8xtzm+r2AhlPzvcqsYRVZxlxx
	 BGiDXBwhF+n/ZeCFSKPfA3Q/ELvC71mLFRnoJfc6rzTq+/6U9EbdrzsCHEHW5NV6k
	 8nD1f0IqgNmMY7kSx3mqqre+lS4ERIqjcprvHPdYNLbLIKPwgPt3t/oJBsl3s2H3s
	 4ZgNyUDMhUGLAHF8tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.35.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDnI-1u5sM53qMY-00AMI7; Tue, 20
 May 2025 16:57:11 +0200
Message-ID: <1750dadc-5993-483d-a238-2060484ac077@gmx.de>
Date: Tue, 20 May 2025 16:57:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/145] 6.14.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250520125810.535475500@linuxfoundation.org>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <20250520125810.535475500@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BHvJ+CL56xP4bsc4UN6TpqF/WMhEoBGc64rSzwbumTsH9bp8Drd
 BL+O+V3a59MAtHQomBfctOIqDkMC01HGyaTO1l+dVNqYdbP1MuT5Kz6kySCHuXLInO/4qHC
 /oSIDtcM+e5bM2fcYEDUqmx+xF2hpIgyTBgwOAVz9Ozl1H9BmLdd17pgRALTzAIsIA/CieF
 nmcn2DZcdYhp6RmBy6VLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:79/LDIqj9EU=;af9O9A79LfFbds+wcL0kgUtyG2e
 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

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


