Return-Path: <stable+bounces-132133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CA0A8486B
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526423B566A
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709191EC006;
	Thu, 10 Apr 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MShC+jxo"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38691EB9ED;
	Thu, 10 Apr 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300063; cv=none; b=tGbZHcQ/yPOSrx8adkElWZUuGDTL2FFfWsDycLMSgHf6A/wJ2OIRP1xr8bmvf9XRUhRHqOfjWgEhLAPlxdlONFXyeOJtYhRLvmZufqC+oeERP7kkMIze+V8ioTDBY0s78GrlHOiEyIJRbSFmYZMS8C5gb1zpzSEwCHZC0ftcQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300063; c=relaxed/simple;
	bh=uo3r6AkCHNKCHOrQI8dELKJaJyw0dfqQlFVIlCAnUsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=g0VDUaKeFHbKjF6WrFBoabP0YdfMaCWQ4SSBVygEN6v8mrMOkLEoG+P6iHudSt+4oLCxbH2a57w2k+xBJBtMeO3CU4eHe5K2XBN23xnyc4l8MMLCOEysWx7p9zvcs2wG1J7J5t3c2G1xrOrhuswaqprLDNo0XoacBx64SIqtk1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MShC+jxo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 78F682114DA5; Thu, 10 Apr 2025 08:47:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 78F682114DA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744300061;
	bh=eIdtuAnlfw9Tp/P7fwrR25olbu610DeUKWQdwhOjqJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MShC+jxoPqlu4ktgqPYrlDNPsh6Tf10/i6eVYWWdokwFEa6eccywWcuD3bn0bzynk
	 GoSUbwrepf4S0BYhTd5PrO7bI3MjeMu8Pu7twbRS3hQwzQlcVS3FftzbKpOZ2hf455
	 FM8bAfs+Xok3JO67EMMMX2CqYm/6tvq3AZ2i/itI=
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
Subject: [PATCH 5.15 000/281] 5.15.180-rc2 review
Date: Thu, 10 Apr 2025 08:47:41 -0700
Message-Id: <1744300061-9419-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250409115832.538646489@linuxfoundation.org>
References: <20250409115832.538646489@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v5.15.180-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
23547098  11259126  16400384 51206608  30d59d0  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
30786912  12640776  857980   44285668  2a3bee4  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

