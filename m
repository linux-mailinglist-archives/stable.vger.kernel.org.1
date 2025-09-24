Return-Path: <stable+bounces-181574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42834B98722
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 08:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41F12A46F1
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 06:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1750425785D;
	Wed, 24 Sep 2025 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LY0yAcB1"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF944C98;
	Wed, 24 Sep 2025 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697055; cv=none; b=diCJ6wlGRbG1/bZbUH1NVBowuuV4YBlIJNC1/p/5ly0Izetgd4qK/9acxqtXDc8HYl8+uo0GpfRuo2tgWv8uSIvdh1XIkEEq0EAOB2aFVoyQgc0VMQCngJ8ywkV+JtMGJtmc16ySz8bP82pqZwxOCGEMMCxTA+sf9kEmDd7geyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697055; c=relaxed/simple;
	bh=E7enFAgAQqnaDQxfrHOF90YJfPYjW1vzkxftZJ4VaN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EYX3XbtpTYSXiD7p6JBzG6w0qu2T0Il9HM8HZfCivZKuw9MRv/SW6NMRwHYgQUb3S1cbRcaUpRIN0gZmqn38d1Rg4dmIxtJqM8MHyzwpImMpttC5BbafBWBbZsbXs3gR9/pFk7sZEgzWRe8351RZrTOxq9ab5uPazmLwlNGiBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LY0yAcB1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 5578E201C94A; Tue, 23 Sep 2025 23:57:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5578E201C94A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758697054;
	bh=E7enFAgAQqnaDQxfrHOF90YJfPYjW1vzkxftZJ4VaN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LY0yAcB1XGSb6LwdS/wzmVZ63TpfCuJ/svcjVNfO34KgRvcFRg7WGDEK/b+5JTin5
	 Yr03Rkotos2JQJhN2mfFgWTiR4j6L7ngBnysuvLeLwO0+bIub8WioQOGSMWGt3ka0h
	 TqpbM7XA7iB6t3VPw24F0HItIhVnXPE2T6pYJTO4=
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
Subject: Re: [PATCH 6.6 00/70] 6.6.108-rc1 review
Date: Tue, 23 Sep 2025 23:57:34 -0700
Message-Id: <1758697054-969-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
References: <20250922192404.455120315@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.6.108-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

