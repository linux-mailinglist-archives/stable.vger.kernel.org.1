Return-Path: <stable+bounces-110228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F3A1999D
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 21:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82763A1680
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 20:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74A421576D;
	Wed, 22 Jan 2025 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aaFkTtKE"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3981EB2F;
	Wed, 22 Jan 2025 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737577116; cv=none; b=XmgRFF5M8/sbsYJs1hAnVwTpbsiK9bWdM1yXF+60FgAvwolGIdnxobu2ue/sxEmiVkESep1ICjTjQCOTtUd8Xm2RR9yr2ndIRHwMF2K0Z64PxoxZkFjfpxkfRMQyoTo2VmiC/zeXosMb0CCueW5J0VpU9tqLBDzxe9EkZhI1wBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737577116; c=relaxed/simple;
	bh=RbF+NUu5/7bAxq8Ryn7pdyvMV/Ae+Qe+ZiXBywiphos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eEVz+jYjnU/WRSta2EZCVLM3Bip0xSvTLinA+trs1z1nPBEpgh17ecftK9BiwXvgrnWG205Pqb11u8Fam1cZzebOlDMl/WROp9AKFKvCOrpvbf7GuunmhZ1DJZNUAN4yEVR+U0T7RGtSbp/EOU4E79nNU3p5ugumWsikhpStkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aaFkTtKE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 16F7220460B2; Wed, 22 Jan 2025 12:18:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16F7220460B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737577115;
	bh=RbF+NUu5/7bAxq8Ryn7pdyvMV/Ae+Qe+ZiXBywiphos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaFkTtKEPGns4qO4Fse1MU0zFEDiymMw5+rkFPz+siG5+RZIKM5V8aoz+kGUBg+c0
	 4V7S27n+Tt6bvud7Z5+kAK5h/Wv64eLIkcPQSXW5Kr4qHtvg6oVv0IYLGH20hDnMZc
	 8TASSWmyC8rdhSJW9W4LqRlJDLDugDZ0U5XJZ27s=
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
Subject: Re: [PATCH 6.6] 6.6.74-rc1 review
Date: Wed, 22 Jan 2025 12:18:35 -0800
Message-Id: <1737577115-18241-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250121174523.429119852@linuxfoundation.org>
References: <20250121174523.429119852@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, amd kselftest tool builds fine for v6.6.74-rc1 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

