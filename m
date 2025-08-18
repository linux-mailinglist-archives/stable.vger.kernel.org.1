Return-Path: <stable+bounces-171666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731BB2B439
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5FD188AD31
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 22:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A46D24A054;
	Mon, 18 Aug 2025 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bJamyyQd"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE21EC01D;
	Mon, 18 Aug 2025 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557465; cv=none; b=opbPc5KawhZvUXQK5CABK0O+ZR1S3jyUNsrZsYdAAteJQKBhemWs9w/Shb+0mp2QLjK9eh6+whK1Yha3RgVv9QMq9AoJoVRB5dvwHbh0vF5gw4U6P285Ab4lUWxyXjAatXZQVMejm+496yHPoHkuWP6gDQ4PCeW0Lydd7P89W7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557465; c=relaxed/simple;
	bh=rroISPl003D1rKJy9f+OWvTrPACCxw/3r1WT3Ct7X34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AhEmKSb7WhQNGPSZ1W7OxJoXLK7WQLsHzUeUMiTDdyPDA5PHAwe/b4vkeinAH5sKJv4GPuhko7MYqWra8aXGER6x0uBACr5/1FXaByorlT7PjZmajCt8OzC5K9AYD3ZFxK6L1xB0naWx2izmvQlgVjZa64gKUUsctHQZPsT9WmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bJamyyQd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 800A92015E53; Mon, 18 Aug 2025 15:51:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 800A92015E53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755557463;
	bh=rroISPl003D1rKJy9f+OWvTrPACCxw/3r1WT3Ct7X34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJamyyQdKDAQ1lxSvpcDCI790L1htKL6G+A4kWHjwXEthrqhzJl4W1Y0asw3erUQb
	 kWwwfG6T1LqlkXPne3270S9OieEArOJMTDx1knLhkIMo0Dt1Yav4TGXKaPFc6CneEk
	 HekL8t0rBEJNAkuD6i6EwIPBxWXjNk0Y0RnuvRDA=
From: Hardik Garg <hargar@linux.microsoft.com>
To: hargar@linux.microsoft.com
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	gregkh@linuxfoundation.org,
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
Subject: Re:  [PATCH 6.16 000/570] 6.16.2-rc1 review
Date: Mon, 18 Aug 2025 15:51:03 -0700
Message-Id: <1755557463-14842-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1754011892-27600-1-git-send-email-hargar@linux.microsoft.com>
References: <1754011892-27600-1-git-send-email-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.16.2-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

