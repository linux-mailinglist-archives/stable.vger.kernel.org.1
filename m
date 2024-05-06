Return-Path: <stable+bounces-43084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B46A78BC5FC
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 05:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E6EB203CA
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 03:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0F54085D;
	Mon,  6 May 2024 03:00:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9938DC8;
	Mon,  6 May 2024 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964458; cv=none; b=rqcz9l2sk7CRCfQfwYoOUsQwpcnY2Pt+slQORCSzfgjVQJMPL9D4ijYpPudpFEQQjfcndFhd1F4N6TJNzKyunlKkMtvHDLOC0c/eaTZ8CKthuxWK2Q2eZyPai8oxJgDqI2pcVf9qT7fmnRcAHE3TGp01QXfNgvO0NQw67H0K+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964458; c=relaxed/simple;
	bh=Di4Dr1jMevpF94ywNAsHk7BIbRL2RRmOjyRhvVLpJbs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IDox/faRloxdKKN36J+yi1wQJp6xtMoorpfR2YPGlxQ34JbQFQ/mWoTbG62mluNsd7xD6/JoM1SAbHLpr2az+4+MhRk6/eGtoq1+/V+zR0/N21/dtO1nD0epJjYOjgypfousqOwnPjHedS73M7SIdZnHsqi8tv6VKE/nOSQwmt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VXmKG3wnvzYsrN;
	Mon,  6 May 2024 10:57:06 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id BA4CD1403D2;
	Mon,  6 May 2024 11:00:53 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 11:00:53 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <stable@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
	<kuba@kernel.org>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH stable,5.15 0/2] Revert the patchset for fix CVE-2024-26865
Date: Mon, 6 May 2024 11:05:52 +0800
Message-ID: <20240506030554.3168143-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)

There's no "pernet" variable in the struct hashinfo. The "pernet" variable
is introduced from v6.1-rc1. Revert pre-patch and post-patch.

Zhengchao Shao (2):
  Revert "tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()"
  Revert "tcp: Clean up kernel listener's reqsk in inet_twsk_purge()"

 net/ipv4/inet_timewait_sock.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

-- 
2.34.1


