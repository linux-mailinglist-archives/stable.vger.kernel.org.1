Return-Path: <stable+bounces-164553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3694AB0FF3B
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 05:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DBA1C8726F
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 03:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E61B8F58;
	Thu, 24 Jul 2025 03:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dJnVBTvp"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C2A4C8F;
	Thu, 24 Jul 2025 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753328973; cv=none; b=Q0Jdr9zDDUz2e9g3YkXJbvoH5b81ah/wcBm5XYONp0qalOT9l7OA6ZQJG6L2GMWrE7tgoDI281hedHBkkOEHva8us+TpY1n8/+S8QcGSC4m/cmqUdBCLeV7jfo74231KwA965U2LLo6JthcfyaenU2yDwOcunPesBbskmyGbr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753328973; c=relaxed/simple;
	bh=pDeP7F16BsjwmoeJizrbHOuK68cJqCQBom5tiGPDMIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BmMuwRFiiI4/497y1438I8/uytHRmQloNajpY8hv1owFGHkIqCv1d06uB/N2Epf88FeOWc2NU8h8Xm6hCOC6Xs4hhFMCvnEvp3CeQN3lOTrMoAVXuw/tN+nl7u/9/XngY2eBRF5069nmkqB6xqqB8TLWVROGajXLu37/U/yIq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dJnVBTvp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 92E7E2120394; Wed, 23 Jul 2025 20:49:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 92E7E2120394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753328971;
	bh=pDeP7F16BsjwmoeJizrbHOuK68cJqCQBom5tiGPDMIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJnVBTvpF4otbsUNFIABaJpLQpxPsUoJzbtILBp4WHlkECnW9D9nk5DMKoOf6xaPV
	 Cg4k3GKGccNISrjzW/WvItxOvrmzU3LzDmLzYgrLAbiVTQXwWIZScOuSD9aGFMe6vX
	 m2hT/6LsUIypS13q8NOOX6H22R1puFj8ATgJXJwI=
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
Subject: Re: [PATCH 6.12 000/158] 6.12.40-rc1 review
Date: Wed, 23 Jul 2025 20:49:31 -0700
Message-Id: <1753328971-17760-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, and perf tool builds fine for v6.12.40-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

