Return-Path: <stable+bounces-92990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3B79C88D4
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 12:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86EB4B24C5D
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 10:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE61F8185;
	Thu, 14 Nov 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kjzz0wYD"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F7718BC33;
	Thu, 14 Nov 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581514; cv=none; b=FfbbspgxyVqncAIh1n6E7t+0+y9Y3JdOixuFNXh5UKzhy6ys+bWMjSq/jSow4kd49WpptLx5j0R7SJrsgOdH4lyT1uKRDWFxtz7jY5TVlCoiPnDPY/TgE8Xr2KOkDglmC+fOfEvjaTuLyFnTcZ1Ktq6VKg60M3BUmJBm3QmKlQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581514; c=relaxed/simple;
	bh=H5yKHa85K/kN38MCbIEu0HaXLqb/id9+omWJt6O4sx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MjwNm9Lnm0HVlnDQOLgHPJdQAzMAUFTcRRNylQCUTkf8a2HNBNhI5JJbsOOTqNp6iPeoukZ8kbrZNrwkWLDexFG1kKSX24yDHizSOxtSijy1BxIbhTIYt0zRzHtUpizOSKoIpjLjjwkPkfen2wS0zWJLCb8R2FqzPJVLij9VOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kjzz0wYD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 9871620BEBF2; Thu, 14 Nov 2024 02:51:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9871620BEBF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731581512;
	bh=H5yKHa85K/kN38MCbIEu0HaXLqb/id9+omWJt6O4sx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjzz0wYDRaqueXJ8HPfYsP7Y19SPbWfmXROVHRCLiDEEii+oQcr1B3O0WB4mP45Sl
	 FPcfh2Ik69RYAvn0HbBB2jfyUE4ZWUez4M/AgVQFJIN63pq1T3iwpKzUuBcJq79HBM
	 SuGZnkLt3PayAZeLsq1lhXb9jhhfNloBv/JD6M/Q=
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
Subject: Re: [PATCH 6.6] 6.6.61-rc1 review
Date: Thu, 14 Nov 2024 02:51:52 -0800
Message-Id: <1731581512-10410-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

