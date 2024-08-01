Return-Path: <stable+bounces-65166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9297E943FC1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E71B26D6C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A61C0DFA;
	Thu,  1 Aug 2024 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bwy5o7fg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932A7E9;
	Thu,  1 Aug 2024 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472713; cv=none; b=L2K4XaU15I24SFLTd0uT1VhGzLOdOzh9OqnRYEkz4XfIHIoJBHbMOxpTOJYxB1Xpz7sqJ/iAS6IIJ3Qqq/c3FIuchbCG6RGJCWxYsABcmMexjzdsGw92z+ufCJkuXELReP3ABjN7Wiz5Z9LqTwhoyvOYXEvlVDxwCuNrCvOIvF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472713; c=relaxed/simple;
	bh=NbqnkNm54YARazMoAHscVDuOCUJdGW2n3rExvuwRPpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfqmIJJxuYMEqKdXG0V7b7P1veeihwlae+Ut0mEPu09dyxQdtIo5QWCsQdqPLv2Mt7BYkoj/eGmlM9bzyC3XLdjpJcBHeOzwmsXFIFh7LQg3se8sHhX7nmMKifrxk0DM0ttnOB8V7tFokaYSFm1ga2vqdBD825Exr89HY3UH7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bwy5o7fg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8EBC116B1;
	Thu,  1 Aug 2024 00:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472713;
	bh=NbqnkNm54YARazMoAHscVDuOCUJdGW2n3rExvuwRPpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bwy5o7fgJZbuSM6MAhlcqQrqGL+XpFQyn7M4N43uRW25KcfeKnDJ7uA0UQkPOr8DC
	 oIDFHobQrxe1CGlsm4yDl6hLt8pPOCxz2uluYeC7af9uDEapKi7IIV76JcPjk3Y6o7
	 01vjb+BONB6dlep83L3lJBIg7OMNO7FJWLgSYLo+cyetCO8qX6WJoK15/QykynOphj
	 bzYxPMU86vBXplgtnm1gKyBjDmT82bGP7InC5UOA++1FjDbfvk/W3RXRtzIVhzVXlm
	 gK3hASo1V1OKEh5ompV3CV6yr0aZxaNavKIBQruzVnxxO5xiFgDTU144ocK/DNmBE2
	 tbDELVB46Tazw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	peterlin@andestech.com,
	akpm@linux-foundation.org,
	christophe.leroy@csgroup.eu,
	suagrfillet@gmail.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 29/38] riscv: mm: Take memory hotplug read-lock during kernel page table dump
Date: Wed, 31 Jul 2024 20:35:35 -0400
Message-ID: <20240801003643.3938534-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 37992b7f1097ba79ca75ba5a26ddcf0f54f91a08 ]

During memory hot remove, the ptdump functionality can end up touching
stale data. Avoid any potential crashes (or worse), by holding the
memory hotplug read-lock while traversing the page table.

This change is analogous to arm64's commit bf2b59f60ee1 ("arm64/mm:
Hold memory hotplug lock while walking for kernel page table dump").

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20240605114100.315918-8-bjorn@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/ptdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index ace74dec7492c..b5a8c7c20d120 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -6,6 +6,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
+#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 #include <linux/ptdump.h>
 
@@ -324,7 +325,9 @@ void ptdump_check_wx(void)
 
 static int ptdump_show(struct seq_file *m, void *v)
 {
+	get_online_mems();
 	ptdump_walk(m, m->private);
+	put_online_mems();
 
 	return 0;
 }
-- 
2.43.0


