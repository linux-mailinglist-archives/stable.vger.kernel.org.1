Return-Path: <stable+bounces-210044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC26D30ACC
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 12:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2B33304275D
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21D334405F;
	Fri, 16 Jan 2026 11:49:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD52DA779;
	Fri, 16 Jan 2026 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768564182; cv=none; b=k2jDPpEe1DryobGlH7+DrNI/9vl6VArTaH+Lvr2p+JxngiDpIugSPTcofe6wXo/tKiphVjjSzLK0BbdQWGv2HM4jkc8KfXCcwPFWpDrGX/mYyhebfr8udTwIsRcrK+KlEdkQtMfFomPoOORia2aKGnRXjgEePCOwYT3VdwR9GP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768564182; c=relaxed/simple;
	bh=ofljk5HmdSWRztxGpvs8NGRdSuIfPlY7XO33pd/3sZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUqPqIMnF7EbD9sMUZeJ1xtogf18x/xT8m6JxcRyH3msYOcsa5RbTgg7HsCLw+0/Ttu+jd5sK8ftNS2X7jJhjo77iyMSgIc9ZzNk2WuLo6rCN7aI3hgkobAZ9N92xlNk3ZFqHhEfB7PVc6vLIDuq8lvNve5eV7VVI3q47mQzvwA=
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
Subject: Re: [PATCH 5.15 000/551] 5.15.198-rc2 review
Date: Fri, 16 Jan 2026 11:49:12 +0000
Message-ID: <20260116114921.10770-1-bacs@librecast.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111040.672107150@linuxfoundation.org>
References: <20260116111040.672107150@linuxfoundation.org>
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

CPU/kernel: Linux auntie 5.15.198-rc2-00552-g2b165888db3d #1 SMP Fri Jan 16 11:46:12 -00 2026 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

