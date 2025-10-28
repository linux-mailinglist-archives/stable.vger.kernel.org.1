Return-Path: <stable+bounces-191484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B455C1500B
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 14:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35E635087C7
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EBA32E12A;
	Tue, 28 Oct 2025 13:54:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339B3064AA;
	Tue, 28 Oct 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659658; cv=none; b=K3ZUiLVHs9f8gb7ixg6e3FoFgqPuDJOGYL8jnh06Ikmu66sxqZ5xCU2Urs/c4c5o/w+4fjWNMb0RFmHjGEfYwRWaGJEfcdcwkCUHyrfEhVTV89AZcEXgqRQdMawrCxQ9jONn79k63hsYMidf3C/FKgPTHmYSyXvinVhzqQfMbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659658; c=relaxed/simple;
	bh=2L6d1aKW/UbQZs8Zj2CSwI2wRj7ObqfFB7OGWEN9Cy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUzOagF0I1V6DfQji/wyBLQBWb4S5F/vq/C1d8hFCJvZfeYL9TwCp+y5P15vXL6dDcAOthDcnoSRAv3BLeN0uOU7fqFrNAi7dMs6eb8p2dgBN+casQfq9uZnHUn+Xp+w7czTSzGr6BURXP8lDST87Ur2GIiUTHa6jq7CSnHtp50=
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
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	sr@sladewatkins.com,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [PATCH 6.1 000/157] 6.1.158-rc1 review
Date: Tue, 28 Oct 2025 13:54:05 +0000
Message-ID: <20251028135408.3881-1-bacs@librecast.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
References: <20251027183501.227243846@linuxfoundation.org>
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

CPU/kernel: Linux auntie 6.1.158-rc1-00158-gf6fcaf2c6b7f #121 SMP PREEMPT_DYNAMIC Tue Oct 28 13:34:21 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

