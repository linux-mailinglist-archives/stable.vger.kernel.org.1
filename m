Return-Path: <stable+bounces-141678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40201AAB587
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55091C07599
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632D49FA0C;
	Tue,  6 May 2025 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBgvUz8i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66A2874FD;
	Mon,  5 May 2025 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487146; cv=none; b=r9NzszOLxWbUEpOISXuP93iDFuPcLN7zjzsHoaM91ddwzpMzE6uZZDxMsJOrmiMcH1jE/i/t3eo7tv2Uq6n39wsVOgeaYdb852pFQ+cPg2mLcPK014CBWjxCij76W8D4QMyGZlbGAh1JuV5gWRbzRMT2efgpwVezrUS1heKJDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487146; c=relaxed/simple;
	bh=ZkpvWBITQF3SKmzOdsoI+6jMbMBW9mXE+YR6udQhi5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ca94YwPwcY6drFxfVRP+JDrH76Hs+qHk/l9LCkdKy5619Y08kngWwE25HzvYDNWXLL3rfm5rS0jKcSQXZ6Bo/xHCZW9VtnkjvJyjiJzxLRat1Z2HCc78oliSuhQmZo9u4wEzo2fiyA+6YG8h8MhP9hMmBFBYmy/tAg6QVHFnkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBgvUz8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5750CC4CEED;
	Mon,  5 May 2025 23:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487145;
	bh=ZkpvWBITQF3SKmzOdsoI+6jMbMBW9mXE+YR6udQhi5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBgvUz8inIu4dCrFegoVNNe0j8Sr0g6c/KPWsgA7rzuPLbRjKxizY8+eLpwOtSCHg
	 RkMW8cDHgdomZsb6qw1cduHNsIhhoA+CYUPjODgAjk4HHO4ZVT+K4tYLFoVgHIc8jZ
	 e1xsvodKX286Bo5KZncNHxFk11pSUKAplRHtL1OCXbt4i0zLsCTEsrKpLoitBA6iwc
	 eGKdWqfCciaQHjOWzWXD7A4umXhpzi4lssJjk9u6p7eGukqgyCA/JsPCzXCZTygnDP
	 nFudmB8xcAeS5aBdUpzbdt8/gVKjiU52U5FWgkcQSbDCsBh072R8R9NCSCZm9kRzmb
	 HTPg24njePH5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	dave.hansen@linux.intel.com,
	benjamin.berg@intel.com,
	richard.weiyang@gmail.com,
	kevin.brodsky@arm.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 023/114] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 19:16:46 -0400
Message-Id: <20250505231817.2697367-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit e82cf3051e6193f61e03898f8dba035199064d36 ]

When uml_reserved is updated, min_low_pfn must also be updated
accordingly. Otherwise, min_low_pfn will not accurately reflect
the lowest available PFN.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250221041855.1156109-1-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 9242dc91d7519..268a238f4f9cf 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -49,6 +49,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free(__pa(brk_end), uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.39.5


