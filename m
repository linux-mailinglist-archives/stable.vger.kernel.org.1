Return-Path: <stable+bounces-179127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78850B5049A
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985B41BC1383
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998335337E;
	Tue,  9 Sep 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BXc57LHB"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C02E2851;
	Tue,  9 Sep 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439726; cv=none; b=mVHIR1Kyuud5sgdYv07qOYPQYlfF1FpU+goiXp7F5Cxqfk3Lc/to2I377A7LtcXv0GJmtsaKl5FeFsd++UBnm6p2MdB1EX+BhbkY4c1PTW5XNP26q7q/JbeXD7PevCYSX+hVfPpSCKIMgkzQYXC0PUqJaDRZaz6XQm0GKNuYpHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439726; c=relaxed/simple;
	bh=AOpnrCAaguN7IaP8ut0qdFEqww1jUeXyrX/UJcfuZKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KGAzNpP7OEkg/v3IzCZ3hGHLwW8AcBKluX2S87rE0pCJtXZTHhk/J4fh9LaV45t0WITQTPz6H3kf2ucCKrk+OKSBdk8ZAQEBcCVAwLuLOkhAgxzbRDKxedE0/U47p1RLkH4OP30j/w6rmaWAPlqUumo3pWuiO64R6fsWqzUI07w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BXc57LHB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 29FC8211AA25; Tue,  9 Sep 2025 10:42:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29FC8211AA25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757439725;
	bh=AOpnrCAaguN7IaP8ut0qdFEqww1jUeXyrX/UJcfuZKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXc57LHBS3NaTmWqMWxj83a/sX2/jmd6H4C79JlJeaD6lAWw9pZVfnCuWhGyDcfBF
	 dn5DTXjUrcGEJPM9JwfsRet/cpX+AZg/OmvHam4JfCIhp+9TRse2lFGlfZk+wjzm7q
	 4Hb4iwrwDOrleALJyaac4rv56/Vl6kqmE61juIrY=
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
Subject: Re: [PATCH 6.6 000/118] 6.6.105-rc2 review
Date: Tue,  9 Sep 2025 10:42:05 -0700
Message-Id: <1757439725-16426-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250908151836.822240062@linuxfoundation.org>
References: <20250908151836.822240062@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.6.105-rc2 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

