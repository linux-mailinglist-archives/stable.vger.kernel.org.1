Return-Path: <stable+bounces-163237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52735B088D9
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E597B1A36
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A196528C010;
	Thu, 17 Jul 2025 09:04:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504428A725;
	Thu, 17 Jul 2025 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743049; cv=none; b=fPSlHO6wz4ZhjBwC84gsIBY61+lY9YEBe/o1IJ+EZT+eWtcixpYINQTZDPEZe0RXXYRw6vObTWtYqtExjl2/n3DfwHglejrv+KopblZOc1yjq2QHyYvthZeTdwdzazQmKpGZkGupat/DfcXyA0K1ua/NAkkLZLSflCuVkAIXZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743049; c=relaxed/simple;
	bh=13BjuG7BfdJkyvV3ryAY94i4fWrWvzauQEq5igKyfLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFxjyG6RE20Y9+pKyOautOqu7voUurCik7//bKV1Tuy4acRuAOR632Ii1sY2OPFwhRUp97AM2r6crU+v2PKklB7LMrs1TT3tAR1baCHV/wjhJeOqcX9G2+uVukBfEqtGZj8+T8jI0PQWYl1W14Lp9HwGngZ/4dNINF0fQClnqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Received: from [2a0c:e303:0:7000:443b:adff:fe61:e05d] (port=41748 helo=auntie.gladserv.com)
	by bregans-1.gladserv.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(envelope-from <bacs@librecast.net>)
	id 1ucKWw-007pOE-2W;
	Thu, 17 Jul 2025 09:03:54 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jack@suse.cz,
	jannh@google.com,
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
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [PATCH 6.6 000/111] 6.6.99-rc2 review
Date: Thu, 17 Jul 2025 09:03:19 +0000
Message-ID: <20250717090318.22708-2-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250715163542.059429276@linuxfoundation.org>
References: <20250715163542.059429276@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Librecast Test Results

010/010 [ OK ] libmld
119/120 [FAIL] liblibrecast

CPU/kernel: Linux auntie 6.6.99-rc2-gefb1c34bdf5c #17 SMP PREEMPT_DYNAMIC Thu Jul 17 08:51:06 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

There is one failing test with the 6.6 series kernels that I started digging into yesterday, but as this fails on *all* 6.6 kernels right back to 6.6.0 this isn't a regression in this RC so there is no reason to delay 6.6.99 for this. Works fine in 6.5.0 and in more recent kernels > 6.8. Will report this separately when I have more information.

Tested-by: Brett A C Sheffield <bacs@librecast.net>

