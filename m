Return-Path: <stable+bounces-176414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E84B371BF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839A1206BDC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DEC2D12E4;
	Tue, 26 Aug 2025 17:52:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C329DB88;
	Tue, 26 Aug 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230767; cv=none; b=j4ftEHWBvpEaTyd1ZiP22lnjCydLu/Ftwm15FlE1KpsRGm+seQhenTbHm2EzU7o5iwOKXVnkNv967GWug30CCVKNXgsMDr/wt0HVs6LmT2vG8olV33eOWafCEUdOIFtUykqgLBBapaSXq11Quvj4cf1uDdUn9DcM5yGBeWFnrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230767; c=relaxed/simple;
	bh=UgsRK12Nu2rYuBYswNUNth/kBrDdZsgxYfz5n5Gg5JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTEzQ9rnISfSmpPGlIT9lDX3oXEtvdbOI+1WzcOjETwwEGcsqmwl5hjr6XLYWm5Of2j70Cb9QI9Pe7mrmvjp0sTeM5WGUJTwulm/7MPHlA7kfzvsW3Z0AGeGwlhyg2kBIX6l79aWosleucD0c5kTSrngemRsFQsVn417VHI77gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: 5.15.190-rc1 review
Date: Tue, 26 Aug 2025 17:47:16 +0000
Message-ID: <20250826174715.29916-2-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upstream commit:
9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")

introduces a regression which breaks IPv4 broadcast, which stops WOL working
(breaking my CI system), among other things:

https://lore.kernel.org/regressions/20250822165231.4353-4-bacs@librecast.net

Mainline fix pending.

# Librecast Test Results

010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 5.15.190-rc1-00645-ge09f9302f92d #48 SMP Tue Aug 26 11:48:25 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

