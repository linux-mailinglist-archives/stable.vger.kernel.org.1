Return-Path: <stable+bounces-109320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5412A14837
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 03:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C161888CA3
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 02:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE811F560A;
	Fri, 17 Jan 2025 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MDIT/uIU"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C171096F;
	Fri, 17 Jan 2025 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080705; cv=none; b=bdNTM6+jvDWkklJNYmcwL6/5O1ymiTNHXaaEyQuf/3MeZ0JLhnijKRYx+Z53vlIZRiMowDJSCY4KipFZ9sv6t6tKriuzZql5FqmjtQqabYLbhBI21agP+WsxdTrZmagqMt2eFOGTfnlPByEH+UkyLBSk7yfpKpBS1TlQE3rVSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080705; c=relaxed/simple;
	bh=K66+KBx0lgtFW+ZOCmttgm95Hz1kk6u/sIgx91pWfQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aBoh3JcYxh23D78Dmd5i+kHzeo+AbDnwYOEdT/KZG/jXVKg8GxkAiaaNZwwINO/3Af4gnzjguSiNJ8cM3qI59N4o7qWT6HItYAU38JPmFzg9CkC6D/hf+cvMrvI2FYDaesLj/vtKiP8znMpvAgJjciqiTeEhHVhhTEIpiCmF2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MDIT/uIU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 3221520591AA; Thu, 16 Jan 2025 18:25:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3221520591AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737080702;
	bh=K66+KBx0lgtFW+ZOCmttgm95Hz1kk6u/sIgx91pWfQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDIT/uIUjMkmQFNj8iWCBwmJgnL1i4x71GzljdXVv6Bju7VT21kr0yBYf0rYnzcTc
	 ETcO1vibmY/I7hUhbYYVAI7pT8DtjYYgFUje3w1VHkva/VbJxrkTblPayLdqbg/ReJ
	 h5ACweBO2TkCoMy3t0HVkphtKA7DXevHIphqXnlI=
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
Subject: Re: [PATCH 6.1] 6.1.125-rc1 review
Date: Thu, 16 Jan 2025 18:25:02 -0800
Message-Id: <1737080702-23479-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250115103547.522503305@linuxfoundation.org>
References: <20250115103547.522503305@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, amd kselftest tool builds fine for v6.1.125-rc1 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

