Return-Path: <stable+bounces-200746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A251CB3FAD
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 21:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76FFD300D161
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 20:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160752C3271;
	Wed, 10 Dec 2025 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CtvM+h0a"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EFC548EE;
	Wed, 10 Dec 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765399209; cv=none; b=uedH8Y9fDpbX6qlJYDo30L0s8EJ1dOxwsaFZa6BCumKAq+BhefU00m8RUZk7ivko3aoZTATqBT9o4mCzeq0GRfA4ov6CcZKHik5OjXlibhbBjcbB1A+Mhx34HBR6ksm44n5E1pVt0TT+TKgkFPbWhFi3jNF5yOBSFW26UR9b9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765399209; c=relaxed/simple;
	bh=O9lAxXs+y4Osn4icivYB/sxvGkBePGWMQ0pzj7mHYVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EC3lsvX9i3YtOLZuvX+4UIqk2/2fkqiU4k4y9zTMVFiWfFwRTexhnxsW/qdojRKSGjJv1vUbEhOx2D1qoQg5xUXTWkRWFNXIzf1rm29dwZ6l/B75LK8cGYXctoJUzoTfsf4P7mzKW2x23ARlgfeItv9MQpg71ySdZWWD2BLzGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CtvM+h0a; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 4FF16201D812; Wed, 10 Dec 2025 12:40:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FF16201D812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765399207;
	bh=O9lAxXs+y4Osn4icivYB/sxvGkBePGWMQ0pzj7mHYVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CtvM+h0aeJ77qw/dw1yaa8VOwzn0cS9cYjtvb9KJkq+hmyM1Da627gIGV5SFYRlps
	 4TKr7ISEE5YwA23DU24CtrC6hRhy22WJe6kVut+eHeWXl/iYi36XYeuk96VtXu7t2J
	 UObgPg8QYPwpK3yqDrEAeQxMMzto0avkeWwHDeQQ=
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
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.12 00/49] 6.12.62-rc1 review
Date: Wed, 10 Dec 2025 12:40:07 -0800
Message-Id: <1765399207-3774-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20251210072948.125620687@linuxfoundation.org>
References: <20251210072948.125620687@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.62-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

