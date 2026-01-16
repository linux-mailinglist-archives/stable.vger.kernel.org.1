Return-Path: <stable+bounces-210080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 170A4D37B46
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 19:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 816713094802
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9785B3939BE;
	Fri, 16 Jan 2026 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="axVmUYz2"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72220393DE8;
	Fri, 16 Jan 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768585327; cv=none; b=acXrQbuAv4L4R9J+3YkJvNnl5F8ZMRGnP3mh0SX8AhXggdZUI/ZKaQT181Y6L8XIAl+XjWIUK7xVQZVDWDSNbX/VkPpp6+Z1dS8KP2DGLDGU42PTW5z0b9PajYIeMfGcaM2QThA8cWudiZQtTCaDDZIPnvbcEq5EDdiRhH2H1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768585327; c=relaxed/simple;
	bh=zmS0/Hv0A7vO6GqeUoRkYz8BWDYQPyKLoyEgnebY5oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZuU4d6KP7Wlpc1ATy/aHQRPqF0LBuetPx9fdVrOHBycNXJHwUc3OC/cuFUpG0/Fkxr9srAHB2gfacL574eAyQ0xlUKtKVvnuCCcLyCbhMcW8jYI/Wwvc2T3oTWppKMzRM+nDBWWgwlx3ztZQSWfJLsaWkQPVxob9Pw2hpgXh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=axVmUYz2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 02CAF20B7165; Fri, 16 Jan 2026 09:42:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 02CAF20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768585325;
	bh=zmS0/Hv0A7vO6GqeUoRkYz8BWDYQPyKLoyEgnebY5oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=axVmUYz2vZaNkeHplMc4bgjtgrMUBg8qj6xnxJYyz1td0BSFtJ/WLWd3jNnA7liD0
	 ES38BMaxm2YlST09hM/YjXnywn+VIIdq5w5hVLkhAefQyAh3YTrOFvlTfrx1BY6Q8l
	 hcpbhkSEj9xomUUzqUHbSa7/croVjWa3sb91ue3k=
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
	torvalds@linux-foundation.org,
	Hardik Garg <hargar@linux.microsoft.com>
Subject: Re: [PATCH 5.15 000/554] 5.15.198-rc1 review
Date: Fri, 16 Jan 2026 09:38:01 -0800
Message-ID: <20260116173801.273812-1-hargar@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel, bpf tool, perf tool, and kselftest builds fine for v5.15.198-rc1
on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

