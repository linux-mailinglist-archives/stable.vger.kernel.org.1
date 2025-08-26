Return-Path: <stable+bounces-173371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A692B35D75
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEEE4618E3
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E453469E3;
	Tue, 26 Aug 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0hm5On/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68059285CA9;
	Tue, 26 Aug 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208074; cv=none; b=W6oa3hupATZYpHeqd8+GACsGwevypNpYFM6YF4SRkwaUVIK+i20/CkqCpkHetQCaYE+iqMmXQH1Mp4Ao9jg7AaJuWu6pE3QB6uALANfZVB5+64Xj5ixdVehWbglMpUkStBK6B3vaCgNKIyobue4WL262KKG31roGvO0iTyrgd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208074; c=relaxed/simple;
	bh=uIjfNtshM4t1Q3KGt+M1O3NFl1pJ/H7jCnPYetDu/dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNSOPwsg/p8a00uyn2oJN/6e4Yn/4lMDUEBMtY4v8vw78dr/enCJrAeRyhp/tnhOhrFVKEqtcuR7zzISEE78S1XY+BmBFLPNtDz1KJrKcMr+aSt+3/3ZIbGEqdcGk86eqJbPqZbLEsseO7n15ohLMj7RTSBKoJZk0ADA8z+yIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0hm5On/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5ECCC4CEF1;
	Tue, 26 Aug 2025 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208074;
	bh=uIjfNtshM4t1Q3KGt+M1O3NFl1pJ/H7jCnPYetDu/dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0hm5On/xj7raUNFZYNPRWJhxidVowCVVfV+sxTJS66yfZ7LWTB00lsVgCuScuUTT
	 8gi+N09Lr9/eFwlGbpGM7X8K65mTxp579kxJd6d4iQaIUNVhJe/wd5zitUt7xLakht
	 r+QramjjWy+MSE25ADWRa0q7JkAK2s/NZHVTkmWw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 428/457] s390/mm: Do not map lowcore with identity mapping
Date: Tue, 26 Aug 2025 13:11:52 +0200
Message-ID: <20250826110947.865946344@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 93f616ff870a1fb7e84d472cad0af651b18f9f87 ]

Since the identity mapping is pinned to address zero the lowcore is always
also mapped to address zero, this happens regardless of the relocate_lowcore
command line option. If the option is specified the lowcore is mapped
twice, instead of only once.

This means that NULL pointer accesses will succeed instead of causing an
exception (low address protection still applies, but covers only parts).
To fix this never map the first two pages of physical memory with the
identity mapping.

Fixes: 32db401965f1 ("s390/mm: Pin identity mapping base to zero")
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/vmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index 1d073acd05a7..cea3de4dce8c 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -530,6 +530,9 @@ void setup_vmem(unsigned long kernel_start, unsigned long kernel_end, unsigned l
 			 lowcore_address + sizeof(struct lowcore),
 			 POPULATE_LOWCORE);
 	for_each_physmem_usable_range(i, &start, &end) {
+		/* Do not map lowcore with identity mapping */
+		if (!start)
+			start = sizeof(struct lowcore);
 		pgtable_populate((unsigned long)__identity_va(start),
 				 (unsigned long)__identity_va(end),
 				 POPULATE_IDENTITY);
-- 
2.50.1




