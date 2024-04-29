Return-Path: <stable+bounces-41696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248698B5852
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38B2286487
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3653F75804;
	Mon, 29 Apr 2024 12:19:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2382885;
	Mon, 29 Apr 2024 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393175; cv=none; b=SQNlLuCNQMQxCGObwgn/cYcLZPzwSUySwRDcnh+kapaufUZYoHEE44RUb/LfFx057S7cnzHlpPfNpms+HO7ZeLzg3VG1INPA5utjwo15/WfsLnIRzk20EgNjUQW+L7p6syxmZLuNwP0EVm6cJ4ETtHeQ/aHe2RVdgJzbk2TRfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393175; c=relaxed/simple;
	bh=7HPT+NaSwsOe9xBj7yjCD21Nzbxt0ufzpWTMlFll3tM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RF5ZrvXWA1YRqPkU++ilGNbVhVnpHUKapR7pC8UwLGJWvR53KS+bmosDZiNbn0ptmCufF0lVcRJvLWLIwVelJyu667Un5vSc5xg0RIX0DjUmWeo/awkZgukQD03fTGH1FybJEZAuSOwYinSytClViHe0FbMTM8IJcZcRX3aJGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VSj3p3tnFz1R5qb;
	Mon, 29 Apr 2024 20:16:22 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id A8C4D180021;
	Mon, 29 Apr 2024 20:19:30 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 20:19:30 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <stable@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
	<kuba@kernel.org>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH stable,5.15 0/2] introduce stop timer to solve the problem of CVE-2024-26865
Date: Mon, 29 Apr 2024 20:24:46 +0800
Message-ID: <20240429122448.2661647-1-shaozhengchao@huawei.com>
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

For the CVE-2024-26865 issue, the stable 5.15 branch code also involves
this issue. However, the patch of the mainline version cannot be used on
stable 5.15 branch. The commit 740ea3c4a0b2("tcp: Clean up kernel
listener' s reqsk in inet_twsk_purge()") is required to stop the timer.

Eric Dumazet (1):
  tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()

Kuniyuki Iwashima (1):
  tcp: Clean up kernel listener's reqsk in inet_twsk_purge()

 net/ipv4/inet_timewait_sock.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.34.1


