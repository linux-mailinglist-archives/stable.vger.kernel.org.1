Return-Path: <stable+bounces-187827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75169BEC9EF
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 10:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B64519A5309
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3156323EA86;
	Sat, 18 Oct 2025 08:30:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B621339A4;
	Sat, 18 Oct 2025 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760776248; cv=none; b=hoHPoy1+dctSPUiyJgXVlmec3SVzR9wueBAmB6gKT8JlBM2hgJOYMy6PKj3Ta28CQJZ5cGW6VniGuXwrYbfemZbtBM1bfX/tY8wPd59ml1vbpekzenGKebHjc1zJsQUQrUiAQhnwWsdYCKtJrGowVn/zFRpjLtmlm/CqlJomv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760776248; c=relaxed/simple;
	bh=N7zmIUCF30t3DZKgDeiEPSfT7pdxrCF0CdbSAssvvDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSkv8DheMG3zXU/EVBRFp9aJmfIWwYU5wTspZr8TFzCMJYoKr4DgSua/iWX2iikXaoDK9lUWtz30VxWVgqFUatS1opDMoHPG9uGhzipzJ7PlIR5ga84B9wQw/0KdzGoIo0CLJa+BiBQdiJPWnk8t0uR5ONnP1GSJRP0iyeSiO/A=
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
Subject: Re: [PATCH 6.1 000/168] 6.1.157-rc1 review
Date: Sat, 18 Oct 2025 08:30:18 +0000
Message-ID: <20251018083032.20472-1-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
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

CPU/kernel: Linux auntie 6.1.157-rc1-00169-gec44a71e7948 #113 SMP PREEMPT_DYNAMIC Sat Oct 18 08:16:18 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

