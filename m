Return-Path: <stable+bounces-41701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D83F8B587F
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AA11F246B5
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F087353E33;
	Mon, 29 Apr 2024 12:27:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7FD1B94D;
	Mon, 29 Apr 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393630; cv=none; b=tPGr32hSZPgbKFCefz2aN2iXSFbaNqkynjAw5FDX+NJH88g5r96pYjIEvdxgSUCyVgPVLynYF95Sr29FF40Oa7WkNSET5NrJCziSjHQLhyQBB9PeskVcj/atzHjlZ51JAwSU2oN1nKCKzEpHtngsuS65zxSvTq/wL02FDL+gtqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393630; c=relaxed/simple;
	bh=g8D+f+ZZS/3YuLxsTPmjnspbgQBVz930bA/5ZEJUnKA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N8znwKM9dxy1so182EtoHYFy5lfRdbPVdqpsqqhPUZoBus39bPd8ue8NqBIZA04hztQ8cUxD7wUIXwwXYRH4/8smhAO1EY90iLY4zZpj0H6b4gWH7L/gJA3xypBgdiCbQccWoVMLI/qjfTDE5+ZsyGlo9nFQII04lwrSzJ1lsjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VSjGv5XZKzccdb;
	Mon, 29 Apr 2024 20:25:59 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id B6DDD18007D;
	Mon, 29 Apr 2024 20:27:06 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 20:27:06 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <stable@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
	<kuba@kernel.org>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH stable,4.19 0/2] introduce stop timer to solve the problem of CVE-2024-26865
Date: Mon, 29 Apr 2024 20:32:22 +0800
Message-ID: <20240429123224.2730596-1-shaozhengchao@huawei.com>
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

For the CVE-2024-26865 issue, the stable 4.19 branch code also involves
this issue. However, the patch of the mainline version cannot be used on
stable 4.19 branch. The commit 740ea3c4a0b2("tcp: Clean up kernel
listener' s reqsk in inet_twsk_purge()") is required to stop the timer.

Eric Dumazet (1):
  tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()

Kuniyuki Iwashima (1):
  tcp: Clean up kernel listener's reqsk in inet_twsk_purge()

 net/ipv4/inet_timewait_sock.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.34.1


