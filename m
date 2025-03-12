Return-Path: <stable+bounces-124169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0DBA5E249
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 18:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADAC3A6504
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F064D24A047;
	Wed, 12 Mar 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fxQJKEv6"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7704B4A05;
	Wed, 12 Mar 2025 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799391; cv=none; b=ntuYSyDLzRD2NyE8DxDbL4baVUZ+SNYNNmO4kitqCbcMgdROobbmfaL0TnbSo+Vb/VSPpzWXEsc+UolASc1mvQkKg2OZBc6m5LkZvUukxnZ8O/YsoUrDM3yoG9XhjU6+IYzG+y4A5gSUUOtbAs/i24Re5kz49d+1Vx2vYHKK/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799391; c=relaxed/simple;
	bh=jB/qWuqYO06xfhdi+CopyNEuGLSUIBtuQb64A2uzIDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Cb7m7GIjLStnZp5qsssOj3+7NS8qJlcpWamC0PpPi71SVAAVfnXjG1XfIcub4pQC2gRn6H91aEFh/YDdiTItnfdLOQyFMkzd/F6eOgGVueRm/jO9r9CHyQSufMZ6hioUD1XR7pMfqrsOOhZkApt0PCt9ekM9Id64thDSMbgnTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fxQJKEv6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id A051D210B151; Wed, 12 Mar 2025 10:09:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A051D210B151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741799384;
	bh=lOBVfaNvoVsVwWCDZXhgCtWs2eWoqiLQksEtbnCmwBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxQJKEv6is+gstnk0hPAv7I1y780HSKDEXFnqyQcYLE6EPGHyoDMQtqYGMI5924vR
	 MN8Z28uiA+/GSLiwqCCEDLHL0srCKSgZfNDdMG0+vVHDXA3B457aLq22NtznUt2ZqO
	 2nh5DY5F4uxXJQTjkttC/KxRo3cCdUPk6PJ29CBU=
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
Subject: Re: [PATCH 5.15 000/620] 5.15.179-rc1 review
Date: Wed, 12 Mar 2025 10:09:44 -0700
Message-Id: <1741799384-15189-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v5.15.179-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
23546701  11254934  16400384 51202019  30d47e3 vmlinux


Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
30786457  12639912  857980   44284349  2a3b9bd  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

