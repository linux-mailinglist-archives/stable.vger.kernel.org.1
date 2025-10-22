Return-Path: <stable+bounces-188886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547D7BFA0AB
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFC818C0C6A
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B852D2E7BDD;
	Wed, 22 Oct 2025 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ofilnfmd"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316031AC88A;
	Wed, 22 Oct 2025 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761110418; cv=none; b=miXIf59cW5oaYb5Jyyj35O/sDamtLgz8opjIFvshSvasFpPMUbdAS55AOtyL7BDpRALEshtWQCIvqbZrPG7xeBezjhzPm1DO4dBA16xo+EHleDHqDK9f22CnJl4rYccTTct4cFHXsTdI8O5M5RMaRkrC3DTKpiiVVlrm0Hmw53w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761110418; c=relaxed/simple;
	bh=wRPdB5c202GCyLf8UbmAbpTzPQXl9LlA5ag+Cakh2dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QOBY+69VAg/qCzgoVO8QYRgQ+tEj+kHvZtYwFwE5gtACsYUiQEnd2qzm/sVg7dvaae6oKYaLggz1xSvmvi72TEdK9XfEH0+IBG7yfGzhczh0A8dh/GgIue4zM/puhUyP/wkWdY96DfKUyhzTVdicZO5twVFEGzEFFnKY2ZTt8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ofilnfmd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id E6FE3201DAD0; Tue, 21 Oct 2025 22:20:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6FE3201DAD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761110416;
	bh=wRPdB5c202GCyLf8UbmAbpTzPQXl9LlA5ag+Cakh2dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfilnfmdZec8Cp2KXDjD/oI+dV05xHYyW81JmypTDJGTO6R3Rv0r5CtjOZj8Q4ddJ
	 oFPbCL3Xm/gOu9XdnISkcLfnKaL9X9ZdCkh+JwkNfCC1D8f9sighM0yxm3fI2D+ldU
	 YH0VnXYWXM9hlqVHzRAVLtQSzh2exorTzBLa0ZDU=
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
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.12 000/136] 6.12.55-rc1 review
Date: Tue, 21 Oct 2025 22:20:16 -0700
Message-Id: <1761110416-25725-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20251021195035.953989698@linuxfoundation.org>
References: <20251021195035.953989698@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.55-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

