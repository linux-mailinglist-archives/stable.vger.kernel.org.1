Return-Path: <stable+bounces-198115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6BBC9C546
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 18:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46B63343964
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 17:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2837F29E0E7;
	Tue,  2 Dec 2025 17:05:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C5220687;
	Tue,  2 Dec 2025 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695122; cv=none; b=ksoH3FQzqMwb/Rwn3q1NSw9b6sbf/qcFxthD/3CVeOIkMnvNXNGdD+Eag6mXWVlvrjl6Gh1F26BD8vpdnEeY7TfKlzRbBtSHHDo5agLlfqWD4Xsl9u9A8TFRsmlG2JqggEtPBNRoNw3MUE6gAQ8LEPvDBa/xMTjw2BbR+NmEysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695122; c=relaxed/simple;
	bh=kGAm+DZo4KK8yGTS04ICfPuYo5BjlcZB/qDXOY8MyWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9VYcVbZkSqeP8dGerIUEPcjwyqLp6q/cnAozx83Kck2AenD9nnGioWNvbIXf9sFgotEFd0maNr/SNxEO5MgCApOdMYpfe0aIzohD6HTlliFFHyhefXKEt49E5BLYqOLtzZtRAIHjNhcS4JMd5CMa/Y0y17mYS8hiNDNojtKdgA=
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
Subject: Re: [PATCH 5.4 000/182] 5.4.302-rc3 review
Date: Tue,  2 Dec 2025 17:04:54 +0000
Message-ID: <20251202170501.3598-1-bacs@librecast.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251202152903.637577865@linuxfoundation.org>
References: <20251202152903.637577865@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Librecast Test Results

Build and boots without error. No network tests run.

020/020 [ OK ] liblcrq
010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 5.4.302-rc3-00183-g95d4a5c8c83f #2 SMP Tue Dec 2 17:01:29 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

