Return-Path: <stable+bounces-43095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E538BC627
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 05:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53311281A33
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 03:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F7446CF;
	Mon,  6 May 2024 03:17:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5E38DFB;
	Mon,  6 May 2024 03:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714965469; cv=none; b=bOdVd60GAKVbmGlrauuGjv0l4rdp6IMPS1H2DlxMQRfRHzSuq35DczIZeXqxZhzUn+VDi8AADmy9hkmL0pkxcHyH+/TY99Dw/4JrO0ZZ6eKGdQcc0ub/jval7WIgJr3NZC2o5vm61EIzEpU8pmcGf6ABwqN50iwCklG5wgJ8J/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714965469; c=relaxed/simple;
	bh=Di4Dr1jMevpF94ywNAsHk7BIbRL2RRmOjyRhvVLpJbs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mC0QhNN4s6CzYK+evPpLXsMHIKPoGbY8rD/f0ugsdJh9+2UCzCHSwO+GixLjFEb5fPl8iKFL4C4pCj7gVp8pHmW0Pm0SKJ6gA931F56n3CRhx0rhVfDsYiipSJefe4uKWYgdW/5UzTSnaRao98bCkHk4iF86odhMta55+mRM3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VXmjF0lR3z1RDbN;
	Mon,  6 May 2024 11:14:25 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id F048814011B;
	Mon,  6 May 2024 11:17:39 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 11:17:39 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <stable@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
	<kuba@kernel.org>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH stable,4.19 0/2] Revert the patchset for fix CVE-2024-26865
Date: Mon, 6 May 2024 11:22:38 +0800
Message-ID: <20240506032240.3170844-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


