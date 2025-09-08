Return-Path: <stable+bounces-178956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0857B498C3
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 20:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B87188D071
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E231C583;
	Mon,  8 Sep 2025 18:51:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F68A31CA45;
	Mon,  8 Sep 2025 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357460; cv=none; b=bkdEez/6VJsoEalMTRo0aVqMf2Kybol7m53z8AQsjepuoU9Ajxnh/Mk+K8h39+JueT4gu0YGrVeTq5Av9NErdpAcOlO/CxtUIBJL/1cYU5Zc/qstqjVfWtRVyKv0c+0zNg3wuzQNICVuu7JqGjfTZlXVwK0j4Wgzwlp1jFfANwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357460; c=relaxed/simple;
	bh=5khN6Nv5usuKTrR6UDRGezxqBXVm45xJFrcQChwU6Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+F3C5U3dUrzpH1begvaw2ItjtqY8rHP8y8AP/dn0BgwLVsiPugnx5vG0nqj6eIxHWZCjM/ArijeYOENSbgx/WINkJjYsWRNuvWOI+TCKXyRUXpBIjDn/qY/TDKvupMvnctrnqzbkO0xDqyTwr5xT+lim4ODC8rYP4JhpGwX4Q4=
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
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [PATCH 6.1 000/101] 6.1.151-rc2 review
Date: Mon,  8 Sep 2025 18:50:39 +0000
Message-ID: <20250908185038.1177-2-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250908151840.509077218@linuxfoundation.org>
References: <20250908151840.509077218@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Librecast Test Results

010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 6.1.151-rc2-00153-ge60b159208e6 #79 SMP PREEMPT_DYNAMIC Mon Sep  8 18:45:49 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

