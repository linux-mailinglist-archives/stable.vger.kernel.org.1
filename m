Return-Path: <stable+bounces-183363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D64EBB8CD1
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 13:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01FC6347094
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34A3260566;
	Sat,  4 Oct 2025 11:37:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B9DF72;
	Sat,  4 Oct 2025 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759577821; cv=none; b=urHc0MlAG2NubB0D/pc23Eh3Vm9P1S8kzihxom5AFf3VUaTBKi8BVKjYgFaMzbPgNAopUfcWfvtoH+XHbWX+yxvGQJRWv20F/Nmdmyspr2zcV5vXhXE3WBNgSSdYX2MHKbg2g1eLDu3usf6OQMn2//P4dQhdQMTDIWNX9+yEN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759577821; c=relaxed/simple;
	bh=3B5KlrBQXAo720U3FNSHYx1Cl3gNLQhe1rjAijcsW4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEoCgPPW6jI8eiWT6H7yiI8aPwiUiAjPjtWC+NZ4IupOGrgWRJs+EN618IVVE1znr/7InKXlmssRPYZvSr8e0sB4CAKZTILarJRdpSBXymSJk3OMP1tiTXdkZieiUr01oX+RrVOou7yNrc3OaK62CZ8HPio+rBWb09KYIOpBDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: 6.6.110-rc1 review
Date: Sat,  4 Oct 2025 11:36:39 +0000
Message-ID: <20251004113643.20535-1-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251003160331.487313415@linuxfoundation.org>
References: <20251003160331.487313415@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Librecast Test Results

010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 6.6.110-rc1-gc901132c8088 #101 SMP PREEMPT_DYNAMIC Sat Oct  4 11:33:00 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

