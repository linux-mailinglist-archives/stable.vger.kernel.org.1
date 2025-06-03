Return-Path: <stable+bounces-150766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31925ACCE30
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 22:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E233A4474
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0D221DBD;
	Tue,  3 Jun 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XMShCJSN"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4507C21FF35;
	Tue,  3 Jun 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982553; cv=none; b=SKRfG+61VvZdUaALWZZl/Iesf77aS6Ynz7opkD95fPVCKEXh+IUpytieptjTrb11TvSnE9U21zlcpGvbFE7ewt7/E/3PZH0WI5u37FmxdVZ6Mrwgmsyp9vn+RNGhBRN5WuFoGFwbgUKwZiwZdnodlIy1JUT0hLVUFkOB0ABEj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982553; c=relaxed/simple;
	bh=igw+deFwgc+7qUGU12KJ75BCj4BVLq/XKj0+rEld0KE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LH/jYrj2Kdlq5M16VuwEVJ/0PAXl5fXIvQ1EjImtKaXI7IfPM7tcAgot8MXujkMF0CtPqjskXrP6ikbkR3/Jxg65NmhRG+R4F74k9xlOEkYHHqvA8DxyovccUdinAEKOFgn8E2k8Lz1nqcJ58F4MyN1rIfF6iukjTzkc4tp+17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XMShCJSN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id B4241207861B; Tue,  3 Jun 2025 13:29:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4241207861B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748982550;
	bh=qVP0jKBkE9Kde7eGyla+USybbn0PC+c6hyhesikTWUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XMShCJSNydyMwCf1bESOql4HCh2prXnfrw+P8z6J9Jdb1sBUhYq1mvSTJ4IV9Ta+9
	 3iX1weYLJxTllDwn6CWSltLm2XNTk1leeWW34ezlLkVLjZU1bh+/2lkUpx6DAvxKAn
	 DV/LqfQau3HrSGRLZIgfPxp1aWX0pzZL/mKTT5Jo=
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
Subject: Re: [PATCH 6.6 000/444] 6.6.93-rc1 review
Date: Tue,  3 Jun 2025 13:29:10 -0700
Message-Id: <1748982550-6166-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, and perf tool builds fine for v6.6.93-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27322670  16732594  4640768  48696032  2e70ae0  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
34701581  13853966  970368   49525915  2f3b49b  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

