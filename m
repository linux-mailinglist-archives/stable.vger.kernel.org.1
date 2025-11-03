Return-Path: <stable+bounces-192198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93922C2BD75
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 13:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 719CE4F9D14
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 12:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393130DEB0;
	Mon,  3 Nov 2025 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM0hY7OM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC9301700
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173920; cv=none; b=muC33mWcKLoJ2vJspKPevl9uppNCDTtwYLtoYUz5MMdZri9aUFBpDTVRygW4HmmuEPZ7yvHyvAO3IAQWOOZ3mXtDZISbjQQEeiX3hDJBVngPq8Fs7QN1SGJmh4krt6dRV5Z5OiM7fNmQs0/SoDGtW0ubO182kmKCFkU0/D0qtvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173920; c=relaxed/simple;
	bh=q/5Dp3SOjbKR5Z41pYK7ngwgH+0D/VSNB0MGWtU+NcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFXK/RHchJGpZd4QVnNIjlMQ4gqkjQ1QGtpmaTTaOv8apG75lTryvV3OTVrQLMhvbBUZ631jar3obJ4ueHZZrbPo8nkzbx1zcewtG1YQPSXu1me1hdBiyXuu614tDh89qx3po2grk/Xka223OeBMcKkbvx6fcBoTzEGBqCXmO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM0hY7OM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9910C4CEE7;
	Mon,  3 Nov 2025 12:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762173919;
	bh=q/5Dp3SOjbKR5Z41pYK7ngwgH+0D/VSNB0MGWtU+NcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QM0hY7OMgmJMhnVkLFbECd84l9TL3aCQSQGHiEE7FiZkhQ0O9AWiIam+ZiRW5SEkd
	 dHp3Tk8QiZxbIJjQmSULb+RbsxKLHY5302sKX5jKEYVAr+v9ZXxjZXgzhJFUmIe9Hq
	 TDaKt4zgAOBAWnVpYeIWUiJD8kDAI1WCdjrF1AeLWrRNV00phJNFv4kn3mClGTWFjY
	 bYhxNJMteedv1TdLT1isceglszohr68+6oMkcPcAOrhLoTsllPonWinB+E5SBIYrFX
	 wjVVlPy84Dkq78DgUUYrRADR5+JOasC4W7ytioss4HC2EMGfJRTE9qM8RGnfGyfIhX
	 o1SAIq7B1z0EQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Luiz Capitulino <luizcap@redhat.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
Date: Mon,  3 Nov 2025 07:45:16 -0500
Message-ID: <20251103124516.4002916-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110340-immature-headband-9af4@gregkh>
References: <2025110340-immature-headband-9af4@gregkh>
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
index bd4782f23f66d..e99dae26500d2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -128,7 +128,6 @@ config S390
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_KERNEL_PMD_MKWRITE
-	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
 	select DMA_OPS if PCI
-- 
2.51.0


