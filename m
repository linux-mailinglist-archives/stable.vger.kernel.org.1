Return-Path: <stable+bounces-202059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8852CC2AC8
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18CF930ACB66
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DE33596FD;
	Tue, 16 Dec 2025 12:04:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38833596F2;
	Tue, 16 Dec 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886684; cv=none; b=LjhPgmFgZ/ehtcUb5PNHV0oVG11d8cX7pAOMhzcsTz/c4JtpJzrnuUSHO9/pNRsmQR5SORqjbT5a3Mws7+3OOeWdjrmn9rkrRMxZ4Lh6XEM8q5sCa60k719VuCDXavw/g1wrDx1U5yE3CAySA43CaxNKI1DM7LLF5QhJTehIdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886684; c=relaxed/simple;
	bh=jTC1tJV1njrLF37SZ8GLBHAIawak2fDXOJ1tSJyXIUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgkT3554ABIp9U86/3zMF1rprA1c7v8qk2lyil96sm9VHtpoCCepExYwapGJthf4k/9dYqrUQhYToHpmdjb/rTNJNovTbz6lZGqKtoshNNJG5SPwi9ieKPDhSbVgs+ZklF5nubqNbH6ey6/TIuo1U5s2+r790zsrBfNrmPb8TAE=
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
	sr@sladewatkins.com,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [PATCH 6.12 000/354] 6.12.63-rc1 review
Date: Tue, 16 Dec 2025 12:03:54 +0000
Message-ID: <20251216120411.23776-1-bacs@librecast.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
References: <20251216111320.896758933@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Librecast Test Results

020/020 [ OK ] liblcrq
010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 6.12.63-rc1-gf8100cfd690d #1 SMP PREEMPT_DYNAMIC Tue Dec 16 11:43:56 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

