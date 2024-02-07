Return-Path: <stable+bounces-19067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03D684C9F8
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 12:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE9F1F27BDC
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295831B806;
	Wed,  7 Feb 2024 11:52:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34738241E6
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306755; cv=none; b=VtWpObV0HX0UaNHs+9u00TTW4buT5b4nG2kjf2DS8LXeKJKpDAUZnDl0Ye5K6Hwv1vEVyNTbv0VOzWzZiM8EyR2xpWGJB/g3esLp36cVb4h8c83eSjgoX6lwOfz2w4RWE2xd2O2pMxzvFelqsa5ctGTq3U18eOtyhLXs/CrLjwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306755; c=relaxed/simple;
	bh=kq6noIAdmwPVFrkYa1l9+EGZDPMBo3s17nXk970iCns=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OjEYD8Ffmv3fRcO1WVkuIyu85uC4v8/R9SlfjNac7rWXluTacB42YZYUMd1OAnndB4IEMPP4EU6dv4eCXx2C092f+Ft/lIqjm5Dryqpiv+VwQQNTn5tvVNla5XWL8XL4DBGul9D8PEtq/JJj1TVg+4/XwYyZvIAzpORXgdWMBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TVJNn54xlz1xmj6;
	Wed,  7 Feb 2024 19:51:21 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CC041400CF;
	Wed,  7 Feb 2024 19:52:29 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Wed, 7 Feb
 2024 19:52:28 +0800
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sfrench@samba.org>
Subject: [PATCH 5.15 0/1] cifs: Fix stack-out-of-bounds in smb2_set_next_command()
Date: Wed, 7 Feb 2024 19:47:42 +0800
Message-ID: <20240207114743.2209367-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200001.china.huawei.com (7.185.36.224)

Hello,

I am sending this patch for inclusion in the stable tree, as it fixes
a critical stack-out-of-bounds bug in the cifs module related to the
`smb2_set_next_command()` function.

Problem Summary:
A problem was observed in the `statfs` system call for cifs, where it
failed with a "Resource temporarily unavailable" message. Further
investigation with KASAN revealed a stack-out-of-bounds error. The
root cause was a miscalculation of the size of the `smb2_query_info_req`
structure in the `SMB2_query_info_init()` function.

This situation arose due to a dependency on a prior commit
(`eb3e28c1e89b`) that replaced a 1-element array with a flexible
array member in the `smb2_query_info_req` structure. This commit was
not backported to the 5.10.y and 5.15.y stable branch, leading to an
incorrect size calculation after the backport of commit `33eae65c6f49`.

Fix Details:
The patch corrects the size calculation to ensure the correct length
is used when initializing the `smb2_query_info_req` structure. It has
been tested and confirmed to resolve the issue without introducing
any regressions.

Maybe the prior commit eb3e28c1e89b ("smb3: Replace smb2pdu 1-element
arrays with flex-arrays") should be backported to solve this problem
directly. The patch does not seem to conflict.

Best regards,
ZhaoLong Wang

ZhaoLong Wang (1):
  cifs: Fix stack-out-of-bounds in smb2_set_next_command()

 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.2


