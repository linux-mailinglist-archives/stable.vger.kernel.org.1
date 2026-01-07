Return-Path: <stable+bounces-206215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 195A7D000B6
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 21:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B7F03016AE7
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 20:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2081332937D;
	Wed,  7 Jan 2026 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SDi7n22R"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B644D250BEC;
	Wed,  7 Jan 2026 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818701; cv=none; b=Q1YU3m8sC0nBheRGq8q62r1U2N11+mRq6X1i0DuGlR13VTENlp0v1oq1XWnEg4BX0vbgc9Xrum79MNgfJqRYl/dS0koi73c8mO9DVWu+Vj2AZHw9nV6ZApcybD0UBnXOHebC0XrhQ7PewwVtqDKQ1aTL26uFXLQlYkKns8gh3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818701; c=relaxed/simple;
	bh=7O2rs2V0SHS1lxCQ9c2EQfNfzf7fRrm7jqw8rfYdgyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EoyalqaJpnWN4jWNsoDlLNbR5bYKatb7Qie5sy7b76enu22C+0WHaTyqG4K1tcIqaPXihI0Yx6DalgTE3EXZFXck3lcYHQAiR7CkjKg4uOkEYQHd9gsY9IKIw1+YiffCBnWCOLe9LXvG8jjJC1A0t+3Azy/tihcgQxwMmSpdvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SDi7n22R; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 42F042126883; Wed,  7 Jan 2026 12:45:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42F042126883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767818700;
	bh=7O2rs2V0SHS1lxCQ9c2EQfNfzf7fRrm7jqw8rfYdgyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDi7n22RTnqRwypLZHlAFDYbT3OyhwRM9pP5lnec2DtfHDvwRkX0kKo0xEIjvd6NW
	 trEGql2yP2GNJj++pRiU1dlxHTZlm1CtvL/nipZPKop3xtj0pUou21jvtrrJ8SB+Mo
	 /ir6PxyiLKBH8P30RScNbaNLEHP6d6WljOvKtQGA=
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
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
Date: Wed,  7 Jan 2026 12:45:00 -0800
Message-Id: <1767818700-14779-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
References: <20260106170547.832845344@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.18.4-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

