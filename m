Return-Path: <stable+bounces-181575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06348B9873A
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 09:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB412A54D6
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 07:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A199266568;
	Wed, 24 Sep 2025 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EeW138aM"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE7265CA6;
	Wed, 24 Sep 2025 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697212; cv=none; b=PJJVAvoOv/iRgqq1+yHit4hrtTr0of5qCzkYqzeChAd/XEyt1I/se4hpQymRzNetZ++DI9swGvfNx0UW5tJke9FdI//Sl6BoFV3DoWCund+YExxTfr8McuMZHmh3dNYp/2+G5x5BZI/NLQ+eHKxl6YDSGPbwy/FyvHNtNtMasnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697212; c=relaxed/simple;
	bh=fj0nt7k8pHOm/92iWp4Ix7us8QGvyA/nMMgnfNqcvbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G5vft1kjEcduaZc9176SMYPMPDdbGk40xtv/vIVDzPgNQQfQ2bkuVWpeR1452tKdg3MlR9Rk9dhf+7tcXP21kppL47KNpTddhvGAQDL56FFwZ+sm6+6nUyw+qouap6fmlYS1rpTgX1PEArtZcZXrRz5vpHhTJLV0rBeY5orTcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EeW138aM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id C2F4E201A7E9; Wed, 24 Sep 2025 00:00:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2F4E201A7E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758697210;
	bh=fj0nt7k8pHOm/92iWp4Ix7us8QGvyA/nMMgnfNqcvbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeW138aM9i2Xcm+dTWZfAg2uFrgCdY7IPpJxoHNJkUdwL7dmBu/PsYmYVfRPBGVV1
	 HOT3Wa+c5RS8SROSVWEBXa4t+5fjVvgNmUB+F9LVNl6DG8ul6fe+J8CWfLYovlrvrX
	 wQJ+6xHXD2lqYF9q/MyZw9RYPClsMCuD8izq3W+c=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
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
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
Date: Wed, 24 Sep 2025 00:00:10 -0700
Message-Id: <1758697210-1701-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
References: <20250922192408.913556629@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.49-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

