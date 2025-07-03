Return-Path: <stable+bounces-160117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86959AF818E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 21:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA103582A70
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F5E239581;
	Thu,  3 Jul 2025 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eZD31DcI"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2BA1C6FE9;
	Thu,  3 Jul 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572005; cv=none; b=HvV6H0e97AOV3g52GqwM/fmETXvWvxYxEggnlcZPWAy7oXk8hH4CPF3HOUUl9UTFYzs19szdTn86B0nBqLouPb/P4g/+gLnnrrwVp0s6MVwYDPPirDQDpU414jkNl/kNxNFkgqlgGEr+it7PhE2NZcnEdms+Du5z0QkJqwIZut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572005; c=relaxed/simple;
	bh=NuR8GaaOyZM6TXxffQw2LvgqVLC6Lu3w71EEFCX+SFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=R1y9TmafFcWsaj4pR83y6Wo02tE9zPJPZrn1//A/fAhA54Sz7XvRA9J/Ju7sENP0QfSqIf4CjTRqTfbMy0eoOx3ddPsQDznncNWMIl01JVILo2xJDNPlgMXQlPMzOBnoSDX3A2vbPEhvmHhUZxVdEeRWvE9s0q8wmXySSWh4YI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eZD31DcI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 876C6201657A; Thu,  3 Jul 2025 12:46:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 876C6201657A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751572002;
	bh=4Geo6PELkZAKTU4pC4Px2bcV/rn5BFInkKG+LLRBNsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZD31DcIqjWv6tAl2CvPtVhObQC/eOQhCQsK0Jo8KbZY3REwaXfS0OxTx7QjT2esQ
	 kzukTbH5Vrisag8r0IXr0NxiEAfKoeree2K6N44SaqR9+I+kPFVltlCjroljt+XJ8J
	 Op9x6XxbMWCU+LhFelAl6Yp7KbfC6hLr9h/2+5KY=
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
Subject: Re: [PATCH 6.1 000/132] 6.1.143-rc1 review
Date: Thu,  3 Jul 2025 12:46:42 -0700
Message-Id: <1751572002-24950-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, and perf tool builds fine for v6.1.143-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
25848764  11309150  16613376 53771290  3347c1a  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
31276540  12551596  831088   44659224  2a97218  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

