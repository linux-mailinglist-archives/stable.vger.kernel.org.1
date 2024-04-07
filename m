Return-Path: <stable+bounces-36184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FC789AF4A
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 09:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422ACB2136F
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 07:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D7F1097B;
	Sun,  7 Apr 2024 07:59:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76033E555;
	Sun,  7 Apr 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712476750; cv=none; b=KZ9ngj2KLkGWnZ6oHPbFy4gKg4IDYukl5ez/04ojp1LvecgIT75EaeeqNxqACUGmH4qRqE2RFTT3lEyipuNzzrdjumkDjEKzwvsLKiIRePdbSctfjO3BBdoHebIoVCg+ub/dmm8TrG1r89xqPZGHbfuc9VOtnjwOUR2ugUWe618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712476750; c=relaxed/simple;
	bh=C6SPO/OCXg9XDi0962nvzzJK61EB60z+s24bQP9C1bY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OHHS0fJO8SBrA8lTXsUS6wTIKljQdO+GvjwLKmADUhYT+udT9y5Cf4FLD1nxalRwkMtSkxR2lqowybk42DxEr2yec3ayITq5cbPzvEYftm6KhFx0bzEHs+TY7q4cCaOm2j/vHoBuONkn2qwi8+bU0I2V6K9qGWqn7BRbPFTafbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VC4L240nYztRtK;
	Sun,  7 Apr 2024 15:56:26 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id E5F7C140154;
	Sun,  7 Apr 2024 15:59:05 +0800 (CST)
Received: from huawei.com (10.67.174.78) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 7 Apr
 2024 15:59:05 +0800
From: Yi Yang <yiyang13@huawei.com>
To: <horms@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nichen@iscas.ac.cn>
CC: <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
	<stable@vger.kernel.org>, <wangweiyang2@huawei.com>
Subject: [PATCH net 0/2] Add check for usbnet_get_endpoints and cleanup
Date: Sun, 7 Apr 2024 07:55:11 +0000
Message-ID: <20240407075513.923435-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600014.china.huawei.com (7.193.23.54)

I split before patch to two patch. one for bugfix, anorther one for cleanup

Yi Yang (2):
  net: usb: asix: Add check for usbnet_get_endpoints
  net: usb: asix: Replace the direct return with goto statement

 drivers/net/usb/asix_devices.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.25.1


