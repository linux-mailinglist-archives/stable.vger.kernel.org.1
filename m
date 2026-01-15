Return-Path: <stable+bounces-209938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A67BD27FBD
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F5273053BDC
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208202EB84E;
	Thu, 15 Jan 2026 19:15:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB5286416;
	Thu, 15 Jan 2026 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768504525; cv=none; b=CX/U7PYbPZ+rTBUAyZtdu/BwuFlQ60588OqewsKGQ4w/mDyrvZfqMVD1grbjKwR1EyVerUg7k+/gSJRTD5vqKysQiQSsZ649V8qaCR+2uAtbmLUtf6dTu7cRdrTz59yXroIjgBRhEFrAx00Anvo9MTKDZ8nkANLava1GqOdQImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768504525; c=relaxed/simple;
	bh=ZOePuxBbnox0DM7IlH21SiU2UTFG6y65/qarnZFJTBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcoBC1ZMw+Nu5iWUpFgL8WZxjAciFmTuamj0XtiRwgIC1No/qmKX6FqDAoufYzXRgk0FHCxOtQ8o4++jC3iOk5blNajONniDK8oAkirbKCTaVgISswb0AReglyBFQxDNlyVOU1PAHwOr/16xKkfy5Ik//JMvCcbePlyXEpFKSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
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
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	sr@sladewatkins.com,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [PATCH 5.10 000/451] 5.10.248-rc1 review
Date: Thu, 15 Jan 2026 19:15:01 +0000
Message-ID: <20260115191506.15563-1-bacs@librecast.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
References: <20260115164230.864985076@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Librecast Test Results

020/020 [ OK ] liblcrq
010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 5.10.248-rc1-00452-g48eff3b1f60c #1 SMP Thu Jan 15 18:13:51 -00 2026 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

