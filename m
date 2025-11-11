Return-Path: <stable+bounces-194471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E9C4DE2A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F320F3A705B
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C583936C588;
	Tue, 11 Nov 2025 12:29:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5753590C0;
	Tue, 11 Nov 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864190; cv=none; b=QwT/m3nUpRf5aEMGIUoG/HlAzRDLyhhWzs8nA0cnrASO9V2nPeeFJLcS0+z/hFiTVjbDqBgI/KzH2E5K9YMsYV77a+E7lVwyKWHwvrL02Me0zagr4l2jMpzOTL+Ni0qZBERhcLKLGTHygK4Fku7o5nfe/ixx+0NQ8HUVb2kUhV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864190; c=relaxed/simple;
	bh=H4IStQz3FavmIamahHeMU7RavLfkzJSXKIenvmwfYko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWJqrC4Zaxz7eOa4joZl865pFk43sIphEx11oJUxEHjUSESdcgby0f1hE10U68pzHqdGDUtZ56vLtiRAifjXT9I0FaCQUFdFSlaKq/onJPu+c7qcVZg14+x3f5m7fT6+aXSndym199cpQ4GqRHbEAdWrd+FyqUSOsL9kpGNLK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
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
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
Date: Tue, 11 Nov 2025 12:29:37 +0000
Message-ID: <20251111122941.25584-1-bacs@librecast.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
References: <20251111012348.571643096@linuxfoundation.org>
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

CPU/kernel: Linux auntie 6.12.58-rc2-ge6b517276bf6 #129 SMP PREEMPT_DYNAMIC Tue Nov 11 12:26:11 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

