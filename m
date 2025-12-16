Return-Path: <stable+bounces-202713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2355CC440B
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ED9B3119EB3
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F412F3621;
	Tue, 16 Dec 2025 16:17:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBE2E6CC7;
	Tue, 16 Dec 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901879; cv=none; b=cOHumh1Sg5SKGDqoiZnvdQB4stud+GlLoQwY7oFb0FGpaoHpAPeHsVL44YVSQK3rs2K3AZIqB9uCh0JmjIPXtPFL+2TuiDnIB52XY1cJ3B2Kfc4JSVVyaDrSz2PgFT4pRTPtjsTvwfwQXofY2Ux7Gob2U3iIDiC6Qj9/ITQXUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901879; c=relaxed/simple;
	bh=cDajNP8ldw7P9ZvqlZMqPFd263XtT0NYiW54xdTbfps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5NHIeqjfCoCZrSMYd0xIzt50EfMaHsD0J0Qzq9ZGCfcWnN3vkfq/+MIiPJOT8ovbsnOapDihh3tz1N8Eu4JiiSIP+7Wq+/Gd8uljvtL+Y5GQCeYl8MUwAZIRHYYYlZUVRS1S+Qi5Wo0lneVV7PccDb6CGLM3ZYl1WcskMTH39M=
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
Subject: Re: [PATCH 6.17 000/506] 6.17.13-rc2 review
Date: Tue, 16 Dec 2025 16:17:34 +0000
Message-ID: <20251216161740.32760-1-bacs@librecast.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251216111947.723989795@linuxfoundation.org>
References: <20251216111947.723989795@linuxfoundation.org>
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

CPU/kernel: Linux auntie 6.17.13-rc2-gf89c72a532b5 #1 SMP PREEMPT_DYNAMIC Tue Dec 16 11:59:14 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

