Return-Path: <stable+bounces-182862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A433BAE5A4
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 20:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC717A3C7A
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2C62580E4;
	Tue, 30 Sep 2025 18:51:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F308E2367AE;
	Tue, 30 Sep 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258287; cv=none; b=ZZPxe7uJ75VtJkFtF4TjvdHEveHRvRGzSstaBFEl96H3H0iTqsipT9zw0087q+sVubxBVI4JKvIs6+OZ39Ef8A6fDcpv+krVebvSJSiK5Bs7ja8Xr82Mr1jisW9IRTIgY8ck6G3/gYmot4mFP7K4Jungi1ybuPX1n9ZyyrhDD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258287; c=relaxed/simple;
	bh=XUCH0rne+zbVgjF3vgC21kczx7W4a7sFZex8YVTAF2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9JWUFRd7L6iXRtr9y2pGbkD78uYBvkHPgqiemm7XQIhAc1FIm8u488gDwvhOofufG/HNSiQF77hN7tn7PTrhIRhPEVWH+OzSt8ztcywloeFUACCO8AM2d6YDzx8R8TYFHUR/TSWPOw2Tpts6P6GP6imf9+oFheGMryjz9Auvp8=
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
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: 5.15.194-rc1 review
Date: Tue, 30 Sep 2025 18:51:13 +0000
Message-ID: <20250930185119.3969-1-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
References: <20250930143827.587035735@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Console regression confirmed fixed:
  Link: https://lore.kernel.org/stable/20250910095124.6213-3-bacs@librecast.net

# Librecast Test Results

010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 5.15.194-rc1-00152-g2e59a3f5f544 #95 SMP Tue Sep 30 15:57:40 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

