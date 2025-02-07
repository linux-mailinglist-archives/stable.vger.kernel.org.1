Return-Path: <stable+bounces-114348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6F0A2D157
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 00:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41B2188F4F1
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881251B87CC;
	Fri,  7 Feb 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HxX2lXfW"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C7F18FDAE;
	Fri,  7 Feb 2025 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970200; cv=none; b=EuXekPt4zlvD7rUS4GjFXHkCS5lQiWHpXkxFk8Iw29JMzwaO54PVr9OJQnqicfDbzKZPmWT/tqws0eGS1+08mwaC1eWd0PoEo/8eYDZMHdEeGOxNbMl0qkLm9WLcrFEpwjTSp0uD90Q10JDZxKAU+elvZuRwgISXzlddroW/cGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970200; c=relaxed/simple;
	bh=elTo7tm33xyEuVb7Q03QiIaHG2n1C4DSWRPF8CIqPFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NTyly7V6stA62IE8HNW+lQJgVH4wqM7Q7zgSftVJUKkaZaw0NL4gxcPFk8bsv0BqzP0uI9pVSMLlGl7lryXxV7T4LpUoVF5Vu9lH471wQ46tg2l+fnPHNmCzB0OpWxyZK3mUxEyYUE0fSiY32whFwuX8+6z2f8M9bTj/DOwvrpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HxX2lXfW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 74C182107303; Fri,  7 Feb 2025 15:16:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74C182107303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738970198;
	bh=/h9bndaqCJz/Duc+GJgNKWPnYhqPpY5vf+iJnO+FKUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxX2lXfWVZ0tqRDkb8fUx2Ab0X9O6UO3Dp5hKbi1pcR5rwBzzRiCqcbk9yp/GA3eO
	 r5utmNottkmjVwBSWaiHPloxiAE2I7YaMEawVFr3bm2tCtHMx3c/YasvSEXeX/PonE
	 1m06YuIQJN3d5H1+6CAkeYqcgxvGVtiyMQyjbe3Y=
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
Subject: Re: [PATCH 6.13 000/619] 6.13.2-rc2 review
Date: Fri,  7 Feb 2025 15:16:38 -0800
Message-Id: <1738970198-6607-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250206160718.019272260@linuxfoundation.org>
References: <20250206160718.019272260@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.13.2-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
29934254  17831930  6320128  54086312  3394aa8  vmlinux

Kernel binary size for arm64 build:
text      data      bss     dec       hex      filename
36656132  15075873  1054416 52786421  32574f5  vmlinux

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

