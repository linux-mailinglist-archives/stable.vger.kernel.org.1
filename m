Return-Path: <stable+bounces-41580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2795A8B497C
	for <lists+stable@lfdr.de>; Sun, 28 Apr 2024 05:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718F8B21B64
	for <lists+stable@lfdr.de>; Sun, 28 Apr 2024 03:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396DB6FD5;
	Sun, 28 Apr 2024 03:44:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A036110;
	Sun, 28 Apr 2024 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714275873; cv=none; b=gTBpCgfw91VDHpnzj3HquYZSVml/nmyFKzvLvandnamnKCyY/fvMOGjv/ybIlUQ6qEYJAPB+2X91rhxZRrXsdyjQeQew8N24WgS+b0pjm+iohVGqMw8L7wBg2lyp6UnxowBvN6F8RYA/QvIcqVdLYOquX5ZP7mLSgmbsPRemxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714275873; c=relaxed/simple;
	bh=7wxdUUoI7cF2G/1Cl2n7cxk0NHbfao7jIfibRJpHGdo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZowNEtkLVo6Fln3LEryyHfgvnexqA2UPvN29YtRrG+mLkiMH8+HdB6gPJn9ltzrm8LngoSWXO0yviPFT6aPRqmNn1qiTP4I3mtynUX7JJ4jFv0ReH499DUY2jTUWWbqj98kdjhR8VwFy0ETOm9eYDp22j6FP6GZm+f+LmO9QGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VRsgr2HtXzwVSh;
	Sun, 28 Apr 2024 11:41:12 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 27A9C18006B;
	Sun, 28 Apr 2024 11:44:27 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 28 Apr
 2024 11:44:26 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <stable@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
	<yoshfuji@linux-ipv6.org>, <kuba@kernel.org>, <edumazet@google.com>,
	<kuniyu@amazon.com>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH stable,5.10 0/2] introduce stop timer to solve the problem of CVE-2024-26865
Date: Sun, 28 Apr 2024 11:49:46 +0800
Message-ID: <20240428034948.3186333-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)

For the CVE-2024-26865 issue, the stable 5.10 branch code also involves 
this issue. However, the patch of the mainline version cannot be used on 
stable 5.10 branch. The commit 740ea3c4a0b2("tcp: Clean up kernel 
listener' s reqsk in inet_twsk_purge()") is required to stop the timer.

Eric Dumazet (1):
  tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()

Kuniyuki Iwashima (1):
  tcp: Clean up kernel listener's reqsk in inet_twsk_purge()

 net/ipv4/inet_timewait_sock.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.34.1


