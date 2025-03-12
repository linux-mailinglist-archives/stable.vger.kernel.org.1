Return-Path: <stable+bounces-124175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340F8A5E2C8
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 18:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A531889398
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BB025CC9A;
	Wed, 12 Mar 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eUJAIf8B"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CDE2512EC;
	Wed, 12 Mar 2025 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800232; cv=none; b=JW3BzJOjWrOu98YbUN6IHfzOJsNDQZufWrFp36lBkRynVl/+jDNUU4w52wkREGEEdr7gAIXGdg51JzaM0Mm3oDebwnljCLSfbUSyYW3zjEQ8dHHn3j2TYeaD5dfNpbYBZGxT3ExTPvVUEw5BVtJt5dPmBDYrCh61nciPAAIOiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800232; c=relaxed/simple;
	bh=3CY5/mtzUqAeI7aKPysJmWyWJHLlNDIbSQ8PHiCgTBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p0h6oOL2wG7ybn/l+tGugk2dpqlvbxSzK+D469Cq8qIQ47G3ZD96yU53Vj1uyumIAdHZh3VSOFkqSfYSh5cJKaQBrtsAHts5B8ctWopy76zEMC6tJjps2J0R6bpuX4ICd2wuvlblehaOqCWww86IQfaf30cuwGLcONRI1WzfPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eUJAIf8B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id B8135210B144; Wed, 12 Mar 2025 10:23:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8135210B144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741800230;
	bh=G98LF0C8b3mEGnSyFEiox69Cmcv6aVbK/5O68ydfdkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUJAIf8BqbXmYe2AAm+fElF0eaPcZp74Fw6+ZY4c9RFpOi02Pwq9mU4dCyP8y93W/
	 gBAVvf95zSWkFcRFhqzGDhJZOCptjQbwv2axayoImlseA7TAEu7xR90IFmi6LOz454
	 9R5zZ83v610eurVAZ6x3t2lNb/BXXJlWEEqKZLBU=
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
Subject: Re: [PATCH 5.15 000/616] 5.15.179-rc2 review
Date: Wed, 12 Mar 2025 10:23:50 -0700
Message-Id: <1741800230-18070-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250311135758.248271750@linuxfoundation.org>
References: <20250311135758.248271750@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v5.15.179-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
23546603  11254934  16400384 51201921  30d4781  vmlinux


Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
30777963  12639336  857980   44275279  2a3964f  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

