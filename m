Return-Path: <stable+bounces-77507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7501985DE7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E855D1C24A51
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A002072A6;
	Wed, 25 Sep 2024 12:07:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311B20694C;
	Wed, 25 Sep 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266073; cv=none; b=epB18W0H/9Hsk5ImGDAiqz94btcLedAKdDW2S+p6yLkgTbbbmNJzCFOXiDoVALUxXZSSo+zxauh0QqJW3N8ImFEQeZE7lqj2tSWcyC67WJLqCYf/C5viS0Jj2MJtNY7CCElm+sNEpqBPKViluYzDUXanzFjpBB3ziSFoZZY3px4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266073; c=relaxed/simple;
	bh=c25KAwKZprI10BTGfcXZs8f/T/8/MQi972FpUDSFyy8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O8P2Ir01CxVH4FJ8gSepthTmsn54Vv1e8MlQ7hQxPj4m9LuMX8ChMAsASchEw+KABtRQYjO0yvpgkDPtldAK8KdFwZeK2/6N2IEQDpcgVz0Qzu79TLTJJB7vQtifL204mFqixdRhp7nGu6P23KIqH5nK6WKWNTLB+OKwOOgTo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XDFpD6vD3z2QTw6;
	Wed, 25 Sep 2024 20:07:00 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 2265C18001B;
	Wed, 25 Sep 2024 20:07:48 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 25 Sep 2024 20:07:47 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<akpm@linux-foundation.org>, <thunder.leizhen@huawei.com>,
	<cuigaosheng1@huawei.com>, <wangweiyang2@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH -next 0/2] Fix memory leaks for kobject
Date: Wed, 25 Sep 2024 20:07:45 +0800
Message-ID: <20240925120747.1930709-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Fix two memory leaks for kobject name, thanks!

Gaosheng Cui (2):
  kobject: fix memory leak in kset_register() due to uninitialized
    kset->kobj.ktype
  kobject: fix memory leak when kobject_add_varg() returns error

 lib/kobject.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.25.1


