Return-Path: <stable+bounces-179125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF02B50484
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7DB44837E
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF71258ECC;
	Tue,  9 Sep 2025 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Cmk8QOlT"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2E017A300;
	Tue,  9 Sep 2025 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439363; cv=none; b=FeNlXI3Zzyf2Vj/BEQV33Y+1xMjLY7nMdHOU+KueIXBZnyiltxu66lF84bEDUPLKQr+2zNmO53dh8AeK1T/ZwCRahZ+wQOBHLTF424Aq/RilVGvZJOzXBvKgFlEBiP+qkLqB4doCOatHYxlOBodKTBbs8+PhbSUeAtNKTDw43EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439363; c=relaxed/simple;
	bh=0T/Z19AGLxOENgkXFzSwY9ZMYtVh0NlNylD3yxdwYpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CfyM1/SFBujpWcwb8wQJRFfnE48AiwwW6Pe1GUXhj3DQ/yjMdLxvRmcTpP3vKexPH4THPsVNwdBpdx9BBQc73b4gfoUw9Cn4yauIyByCsFkEpJDgwjzF6jzsTABKZQ39RXH31N6hCPbLLVtCjqIUgH7f+nhONUwxDeNfrY2ZvzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Cmk8QOlT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 8DBB02119388; Tue,  9 Sep 2025 10:36:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DBB02119388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757439361;
	bh=0T/Z19AGLxOENgkXFzSwY9ZMYtVh0NlNylD3yxdwYpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cmk8QOlTy8OkHmQmLX3xGeeM7PHhYBBjJaPr4KfmaHDBpN+X554JdCBJlzoz2xDlp
	 jJHbOW+JjBElP1xTGSB74fCvNnt9x61PnMKBLsaYxs8t4wWBL5IhMdIPG5eUBmFHZh
	 w9+ejhEiQJOg1vUGhTERqRsxth/Q3E230PQXiKSs=
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
Subject: Re: [PATCH 5.15 00/64] 5.15.192-rc1 review
Date: Tue,  9 Sep 2025 10:36:01 -0700
Message-Id: <1757439361-14950-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250907195603.394640159@linuxfoundation.org>
References: <20250907195603.394640159@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v5.15.192-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

