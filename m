Return-Path: <stable+bounces-192140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC7FC29DB0
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 03:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE2B3A868E
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 02:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F1275AF0;
	Mon,  3 Nov 2025 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb+71v03"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CDA158DA3
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762136659; cv=none; b=P4zUSv7sjUyzw4VDr2r9iFcIc+xjRG6EOhoO/u6KuNN4cqY3oAAWK3RVH1b6d1LVv6j1nG2QMQ5hEr9h7sH1qIP9keT474EPK0Lk6FnElg6JF4i5jejsuTF0X1l5chhJlOUqs9htDJCoxyaWfu+U/PGrEY51HT/36y3R8sT8eCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762136659; c=relaxed/simple;
	bh=sltqD2LFdtOkhPCcT1gNgvAf0lpL61tksWbVG+DTotc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hz0gtZFGGAaI59vH2rZdUJ98PSoMUM743U5sb5kp3drCYHFnLWbqNTeaJF0qWHm9npgj0HLAKxVDHeL96m2nhd4kYjJX/BGRN6lCFYoESB3wqhsHXRKgN1c4F96Ev3ztWpEriepLHMLBbjPt0tidMx+pigqFkAFHIsgj7U0GtRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb+71v03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761AFC4CEF7;
	Mon,  3 Nov 2025 02:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762136659;
	bh=sltqD2LFdtOkhPCcT1gNgvAf0lpL61tksWbVG+DTotc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sb+71v03tE/NWr+QRTvIho0Q6esYsqL5zGzE2loAuFQBNCGf8+me1GX2cAVOS2un8
	 iCdf/dehSsRnLdNbdI7yeZw8zS/oS7nxSgIL2V0KdQC2H9Q+gNjGtO1yxIiHkGTUOz
	 gc+/3uXhXus5U/WGm/xxDLBMNAT9BWOZBb1HeJznLVD0g+wjumx4j4rJFCOK5gCi3P
	 fUgnYujLWc3Qv1OboEQR7N0Rbro96OoZCTaKZ3odpRMIjmyo0A+0trBVBmgZBqZmys
	 MBWJFNiFx0Glk+RFvHrKLeGwTuCWVbqx1wFYS6aYskiQ6sE1PjkjcNwvmUlKNRpXNX
	 lPdcRx68FqGAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Luiz Capitulino <luizcap@redhat.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
Date: Sun,  2 Nov 2025 21:24:16 -0500
Message-ID: <20251103022416.3808769-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110339-catching-blah-8209@gregkh>
References: <2025110339-catching-blah-8209@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 64e2f60f355e556337fcffe80b9bcff1b22c9c42 ]

As reported by Luiz Capitulino enabling HVO on s390 leads to reproducible
crashes. The problem is that kernel page tables are modified without
flushing corresponding TLB entries.

Even if it looks like the empty flush_tlb_all() implementation on s390 is
the problem, it is actually a different problem: on s390 it is not allowed
to replace an active/valid page table entry with another valid page table
entry without the detour over an invalid entry. A direct replacement may
lead to random crashes and/or data corruption.

In order to invalidate an entry special instructions have to be used
(e.g. ipte or idte). Alternatively there are also special instructions
available which allow to replace a valid entry with a different valid
entry (e.g. crdte or cspg).

Given that the HVO code currently does not provide the hooks to allow for
an implementation which is compliant with the s390 architecture
requirements, disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, which is
basically a revert of the original patch which enabled it.

Reported-by: Luiz Capitulino <luizcap@redhat.com>
Closes: https://lore.kernel.org/all/20251028153930.37107-1-luizcap@redhat.com/
Fixes: 00a34d5a99c0 ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP")
Cc: stable@vger.kernel.org
Tested-by: Luiz Capitulino <luizcap@redhat.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 62f2c9e8e05f7..5c9349df71ccf 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -135,7 +135,6 @@ config S390
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_KERNEL_PMD_MKWRITE
 	select ARCH_WANT_LD_ORPHAN_WARN
-	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
 	select DCACHE_WORD_ACCESS if !KMSAN
-- 
2.51.0


