Return-Path: <stable+bounces-20421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E20859412
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 03:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390F91F21C0F
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4009D139E;
	Sun, 18 Feb 2024 02:33:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010CD4A33
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223592; cv=none; b=YRMl/Qjl/Sx+vwip0ohyAYB2JFwJTZ35jkp6Gb01I4SYMNljA53ONjr4sqe0vuYce2dY3395BwhP6wRcIbVIZKx34xw6m9wVJ1fazXA4ti4dThSa7YNC/ErdAqEu9+d0oA4bvvOMSUmaBpCZlB9tumjrtv7+8hkMzx7FfE1TNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223592; c=relaxed/simple;
	bh=JX0hDIhL6M+Xnzfr6uicaz74wvTaKtFxdvuOZI5n54g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pk/crBiUoaUZT//2VVSKixwNp8TTkTDlBeihp5pmZwk1tJ2ZGC3G1qqzHIe2L5bkYMcl1S185s5VE58w3dQIiedmA7H2WozPtYayzfkdjyaucjE9wco/YihRtQEwIzGejp4mmRmzEmNFyg7MsBm13mNiqqc+UYsK2yI/FsA057s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TcqR91xWcz2Bcxd;
	Sun, 18 Feb 2024 10:31:01 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 306E71404DB;
	Sun, 18 Feb 2024 10:33:07 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 10:33:07 +0800
Received: from huawei.com (10.67.174.111) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 10:33:06 +0800
From: Xiang Yang <xiangyang3@huawei.com>
To: <ardb@kernel.org>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>
CC: <keescook@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
	<stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<xiangyang3@huawei.com>, <xiujianfeng@huawei.com>, <liaochang1@huawei.com>
Subject: [PATCH 5.10.y 0/5] Backport call_on_irq_stack to fix scs overwritten in irq_stack_entry
Date: Sun, 18 Feb 2024 10:30:50 +0800
Message-ID: <20240218023055.145519-1-xiangyang3@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)

The shadow call stack for irq now stored in current task's thread info
may restored incorrectly, so backport call_on_irq_stack from mainline to
fix it.

Ard Biesheuvel (1):
  arm64: Stash shadow stack pointer in the task struct on interrupt

Mark Rutland (3):
  arm64: entry: move arm64_preempt_schedule_irq to entry-common.c
  arm64: entry: add a call_on_irq_stack helper
  arm64: entry: convert IRQ+FIQ handlers to C

Xiang Yang (1):
  Revert "arm64: Stash shadow stack pointer in the task struct on
    interrupt"

 arch/arm64/include/asm/exception.h |  5 ++
 arch/arm64/kernel/entry-common.c   | 86 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/entry.S          | 84 ++++++++++++++---------------
 arch/arm64/kernel/process.c        | 17 ------
 4 files changed, 132 insertions(+), 60 deletions(-)

-- 
2.34.1


