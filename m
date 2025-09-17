Return-Path: <stable+bounces-180428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B5B81426
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 19:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8283AC2CC
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186CE2FC89C;
	Wed, 17 Sep 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iGHnYFvw"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923C32773CE;
	Wed, 17 Sep 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131809; cv=none; b=YuB08woQilXNmYWbP/1MQcPVyA0dgSw9cSBxchbHUdjAbpF7zlRWFmSAqIX05gxIKhzI6mqshN4wUTaq/sGrwl0jTHRavnvGdsoXDmOo5p/hYFnHhlp8ii7hb4SZfeknRI1Wt9omAYNxWTiJ6MEf+E4H+h1alxn1nzhPaPMvfow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131809; c=relaxed/simple;
	bh=2I3ucNbptVz/o/0a2THX5Y1zOx41TXHI/Cl5kt+Qk9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JbJa/R7nP/Ik9yXQUko/RdOrvCi9GBNgstHejw+ZzqglgCidgI3lbjKs47W1//0plL885CtnzkOy0aqLSMEevrgabMv0F+7TgEALx4y3hf+BC3EJVudSdC0MaMuW7BSJDMfyA+5R+nCwr10IE9T3VCf8qOUV2CKqloEmyxGMFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iGHnYFvw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 2E51020154EE; Wed, 17 Sep 2025 10:56:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E51020154EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758131808;
	bh=2I3ucNbptVz/o/0a2THX5Y1zOx41TXHI/Cl5kt+Qk9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGHnYFvw1H6ZX4rS1Op11gnHhfqPivq5gNy1jBhKux3pelv0EltNUsM/SwLVBDv0a
	 grjH0x+p6vew3YTbLBrgMcTprS52LJb42m8cR1ztnTvU8bZsUe3TdJHUk058/hsWdX
	 ITWVJmfVIpL85KG0Dt5hk5Wwm33VQUFJk2ffgQbw=
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
Subject: Re: [PATCH 6.1 00/78] 6.1.153-rc1 review
Date: Wed, 17 Sep 2025 10:56:48 -0700
Message-Id: <1758131808-15548-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
References: <20250917123329.576087662@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.1.153-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

