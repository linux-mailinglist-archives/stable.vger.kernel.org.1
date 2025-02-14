Return-Path: <stable+bounces-116449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A753EA366B8
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 21:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEADB1888745
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2422A1C84B7;
	Fri, 14 Feb 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oTvGVUHD"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD719259E;
	Fri, 14 Feb 2025 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564036; cv=none; b=qTlBfjO5TaNoMl7rpoBDKmzEur8FrAoG5WL3DY18j+YzJZoTGL1p0zc9vFGnagD7nAzXGFpJEHfUthxIXVEp8kwryLyIB+583V1yvDb63k9/UBaohKzKi84P3NhCXuAOASvkqsrAR3PgOwbrVAs460pe9EnwIByF2UVKEiZMA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564036; c=relaxed/simple;
	bh=zYFjsSotXE6vZheU7rAWUZZUF0Srbvf5lz8jgDP4fJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Knw8u8H7FjBW6cPg/Qshj8pNoIt7rAaiqTVx0cU+8iP8BfPivRmPQ+ODdnwL96RBHjIVoUH+kQ7NvuTWxHKBWp96MG32cGKe1O8TA4tYYowmWbaNvmCr8yXnx5lGwNxz3OqDTCH3tTyVi7SeUGpSIf4rvFVb4MxkvLlBxT4+8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oTvGVUHD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 0A173203F3FD; Fri, 14 Feb 2025 12:13:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A173203F3FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739564029;
	bh=xJZlUceidVSAwmHXnWZ5CvBGMLEhcbu4V3OND3upxOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTvGVUHDyTkY6gElxdAN4TKdMsrfsxdJtk7i/iF0mqle+hhVOUX3p8FvAr8s7ffM1
	 lkEpGzUNS7090wnFR6+JZVMHzD1yEqKSn2OzHe+sTZlbMPzx3qxgArkq6b8/3Q81uf
	 hXNghAtIXPapKpPoKmQvNwncdiWGgOCxPVbkMVdQ=
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
Subject: Re: [PATCH 6.12 000/583] 6.12.14-rc2 review
Date: Fri, 14 Feb 2025 12:13:49 -0800
Message-Id: <1739564029-4365-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250214133845.788244691@linuxfoundation.org>
References: <20250214133845.788244691@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.14-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27753245  17708814  6397952  51860011  317522b  vmlinux

Kernel binary size for arm64 build:
text      data      bss     dec       hex      filename
36370691  14991881  1052816  52415388  31fcb9c  vmlinux

Tested-by: Hardik Garg <hargar@linux.microsoft.com>



Thanks,
Hardik

