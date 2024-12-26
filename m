Return-Path: <stable+bounces-106160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEA29FCD58
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 20:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BE7162100
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B31482F3;
	Thu, 26 Dec 2024 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="opqLCxq7"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EACC81728;
	Thu, 26 Dec 2024 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735241319; cv=none; b=uisews55Eg7VB4IXwNZsp9YOXIjbQB9OoPGl6LAQD06LXvFU/Gg+31P2Ps3ZnE2/5zm24+smbssiCSRBLmXzlzjzoqT6ZKS3KxnrH9Won/d0h2R8bkpuac36VdtxC2XapCF3WMHbykkV9Vhd5B6tfnktzePEHVQcm001jWBfGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735241319; c=relaxed/simple;
	bh=zqYKVe6i60kqrncDfNqM0FK+F4Jn2x8VTiHY91wF0D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IXj1CPhs5w8LFcyGfTB1wY3cTKKKenTWaJp3PKwJqUY9mD9I59Dk7XgLe3luwLW1t5GT9ooNZqd1SyhOYZzDPuI8+rO7o063i6+uIJo+aBcuxVvyOwjyve23/UNfF7ieuzcS5tr1W+uKI9O2fGAgzs6wt9XCsf5LmixzPoSwIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=opqLCxq7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 3D185203EC22; Thu, 26 Dec 2024 11:28:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D185203EC22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735241318;
	bh=zqYKVe6i60kqrncDfNqM0FK+F4Jn2x8VTiHY91wF0D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opqLCxq7Yj2KWh/tqo3iIcSkYmn8pj+VllNLGJEq7mSPaTMzAiEcjjzQQTszIrc8I
	 0HaakxNCSaV5xcbeB8BRWJv0w+FukbmKnB4HzG4OT8No93BntsDu5uH9HlAvMVermc
	 yAt+VjMKBp+oIbuT/uqrEZRbddYtETbpEPHr2YAo=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
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
Subject: Re: [PATCH 6.6] 6.6.68-rc1 review
Date: Thu, 26 Dec 2024 11:28:38 -0800
Message-Id: <1735241318-21475-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20241223155359.534468176@linuxfoundation.org>
References: <20241223155359.534468176@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, amd kselftest tool builds fine for v6.6.68-rc1 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

