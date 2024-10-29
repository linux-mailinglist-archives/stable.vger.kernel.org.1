Return-Path: <stable+bounces-89154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863D59B4025
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 03:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83151C211B7
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 02:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FDA155316;
	Tue, 29 Oct 2024 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sdgtkCIF"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAD231A89;
	Tue, 29 Oct 2024 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167754; cv=none; b=FApNYrtwcfNLtIOvbPh1eN+5I3xYRqIqirezlOMDGRV0m8c6IuNg95aRd1bnth+KEtEwR1qSn59JyARdIFgZbXy8chfVB0FK00A4QTcTSxbiqU/qQ97ov5Ku9SlMJqXFPYP/DQVf41xw2HhlK4hC7dc4Ad9a5LtlD+1coqtOgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167754; c=relaxed/simple;
	bh=H5yKHa85K/kN38MCbIEu0HaXLqb/id9+omWJt6O4sx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KGFCVe95b9Dn9t4emc2z5xIahSwbxUtIxsbnHVvO38gaz+LChf2x+fKDU3eX1R5q4Lz8btppB4AEc8aUOm61Z+9EXjpKm1ueTQIdXZ3cbFTdH1bzI68szWXkrOOu/B0tPTy2PavEiH2hA1j7SHIsVacf75Fc92tYxIQX7nGAsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sdgtkCIF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 1B7C5211F60E; Mon, 28 Oct 2024 19:09:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B7C5211F60E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730167753;
	bh=H5yKHa85K/kN38MCbIEu0HaXLqb/id9+omWJt6O4sx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdgtkCIFvb8Ab3CGm6WkXd9qssZjsOG442tKoQ4gMPhpGshZfR+rpEeYuXNkX52oo
	 Fq8WM+8n2Uw4PYdRQGLHFSrdzQ0wQ0Fc/BWOJPgcadbRoOzLXAZARmjO/aqCW4/UCn
	 ZwTlrpylkx+cifd8zeWEfIKTjriHiEuLd5nx11m8=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	allen.lkml@gmail.com,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
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
Subject: Re: [PATCH 6.11] 6.11.6-rc1 review
Date: Mon, 28 Oct 2024 19:09:13 -0700
Message-Id: <1730167753-10893-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

