Return-Path: <stable+bounces-132159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2B5A84916
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901E046764C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA51EB5E1;
	Thu, 10 Apr 2025 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TiupzvEK"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571321EB1BD;
	Thu, 10 Apr 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300487; cv=none; b=iYg8U4xM6ew8Es0LyAvuOM3oleRymJEY+/cVyq/Viqy/FJQzqbIkfWUwCaLsJP1s7DFtPdYRPGJLZ5XXTOiVQxrdfCnRp3bcYxhWqeIQEDfT7Xb5S3Vzm1KMIk8P2sHMgJzxFVYXwiQtl+v0PSUSLN7f9rdbJ76aFgaETSwkpoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300487; c=relaxed/simple;
	bh=9ycmDqfC7c/8Cy6dd7vPCxqYJwsTqg80im1QJGWQoI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CknuMfcTnUIzT5CiBpVpsi6KdhtSlLvMcceQOJrmQlzfE8rOEgJ85OWEy3eTRPDbTYemMxnwZdmDyltKKGQfXamOrHnqJ1SXL8S5xHDEvt7jyyhy178FZJLo+DDWFiyDoQx7GjFtKAX1/JaKAYU6YUHSUq3irF4mgMVuTdLmVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TiupzvEK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id E87E02113E87; Thu, 10 Apr 2025 08:54:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E87E02113E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744300485;
	bh=JeLshHLbdt1vY9LX1VYPtnh6jwgup1MkMVaqqGMziIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TiupzvEKj3d17oOUFT3ORsFAx8Vs7kyCOcW+PEC/GVfiw4yh8B5UAAGQDV3kEat3Q
	 ktas7HJc2S12JLMH/8X5d9Zde3yi/k53LOjyxZrXKKF0scqGJs3PXy2NJNKvuI4L3k
	 8WwbdCkZj/xlnIYeVUTGEJtlpQGUbldgp23+h0Po=
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
Subject: [PATCH 6.1 000/205] 6.1.134-rc2 review
Date: Thu, 10 Apr 2025 08:54:45 -0700
Message-Id: <1744300485-11223-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250409115832.610030955@linuxfoundation.org>
References: <20250409115832.610030955@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.1.134-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
25843965  11302730  16613376 53760071  3345047  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
31254277  12542304  831088   44627669  2a8f6d5  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

