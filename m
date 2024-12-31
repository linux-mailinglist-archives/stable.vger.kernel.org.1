Return-Path: <stable+bounces-106622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F4B9FF1EF
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 23:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D73216182C
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 22:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326081B042A;
	Tue, 31 Dec 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KVT154yA"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B4F170A11;
	Tue, 31 Dec 2024 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735684516; cv=none; b=pJLp/1yMqw4TVNURVWCno/tDDdrx4t/TRrUBXvEA95I3Ch0EFO/jR993u0pegXcsJ49Z69DpiFmIVcmvzRleo7RBQ5D91yfxJyzqOSXF17XOTl6kn09pSy6bQmFATVWvuN5PLS7glHBZ9NQ+wbYzQstRYVdbt+Qd/m1ts09CEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735684516; c=relaxed/simple;
	bh=Ohhj+4JzrDvuTw7oSSDYmpkPb4IAA8P49UYGQ3/WGug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JKETFmgBR5qP3HqdWku78tYguEBpbRC63KvCRp8lO+APRinu1Kmhpd3Zw10rc2GEji0oaspKywJHn5e30R9dXpxEtHUONgubRyP96h5km+PD9UoGEt4H2ERBgJWwotNTArVdsl9u+93Cu5zJo9AS3SNTQcCeX5eG+ef5k7XKvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KVT154yA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id C9CC12046769; Tue, 31 Dec 2024 14:35:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9CC12046769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735684506;
	bh=Ohhj+4JzrDvuTw7oSSDYmpkPb4IAA8P49UYGQ3/WGug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVT154yA/Bb/Q4twXK+CX+/jHDsKETjpO7SzQfB0BXNhzVP+TUPJNCOsoH3Ou8cL0
	 Ptdek8DfJB8J6kiZEmrNCdCafjS+Vf00Rx2YYLIauqIX0+GyVyI+ZUMtUlcGP4oYIL
	 BdBRex4w6UgHH5c7cz/dubls7geJk9MORgaqXSxA=
From: Hardik Garg <hargar@linux.microsoft.com>
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
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.6] 6.6.69-rc1 review
Date: Tue, 31 Dec 2024 14:35:06 -0800
Message-Id: <1735684506-20456-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20241230154211.711515682@linuxfoundation.org>
References: <20241230154211.711515682@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, amd kselftest tool builds fine for v6.6.69-rc1 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

