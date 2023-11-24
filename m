Return-Path: <stable+bounces-1232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997B7F7EA5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF092B2178B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88B2E655;
	Fri, 24 Nov 2023 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f1mnPs/c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041C37170;
	Fri, 24 Nov 2023 18:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F50AC433C7;
	Fri, 24 Nov 2023 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850887;
	bh=AQlF/LcFjdnHI/M6+7vnGH+yCK0qMTzsHmgr5R9Gm/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1mnPs/cKH4PVLkmKDazz5yz8oxPEs9gxtyrzFWWQnE7Aqlwl5z9Z2Ov7KxARssSO
	 +qvSgVIJfJQUDGdWYRVv5DziI4mqnCIOMRLbtmXB80I5Mahg84+vWKpqTCzu5lhhgO
	 sLQKL8Zp+JFwGTsCy96BIuw2Vt/I93iHsEsKpTI4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.5 229/491] powerpc/perf: Fix disabling BHRB and instruction sampling
Date: Fri, 24 Nov 2023 17:47:45 +0000
Message-ID: <20231124172031.441443398@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit ea142e590aec55ba40c5affb4d49e68c713c63dc upstream.

When the PMU is disabled, MMCRA is not updated to disable BHRB and
instruction sampling. This can lead to those features remaining enabled,
which can slow down a real or emulated CPU.

Fixes: 1cade527f6e9 ("powerpc/perf: BHRB control to disable BHRB logic when not used")
Cc: stable@vger.kernel.org # v5.9+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231018153423.298373-1-npiggin@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/perf/core-book3s.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1371,8 +1371,7 @@ static void power_pmu_disable(struct pmu
 		/*
 		 * Disable instruction sampling if it was enabled
 		 */
-		if (cpuhw->mmcr.mmcra & MMCRA_SAMPLE_ENABLE)
-			val &= ~MMCRA_SAMPLE_ENABLE;
+		val &= ~MMCRA_SAMPLE_ENABLE;
 
 		/* Disable BHRB via mmcra (BHRBRD) for p10 */
 		if (ppmu->flags & PPMU_ARCH_31)
@@ -1383,7 +1382,7 @@ static void power_pmu_disable(struct pmu
 		 * instruction sampling or BHRB.
 		 */
 		if (val != mmcra) {
-			mtspr(SPRN_MMCRA, mmcra);
+			mtspr(SPRN_MMCRA, val);
 			mb();
 			isync();
 		}



