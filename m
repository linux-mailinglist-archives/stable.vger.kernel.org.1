Return-Path: <stable+bounces-48806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3728B8FEA9E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9541C25E7B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89161A0B00;
	Thu,  6 Jun 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o1oRuH/q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352C1A0AF8;
	Thu,  6 Jun 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683156; cv=none; b=beifBJt+RT1qlDeAqsVfnM7hT8AHtBQRNSwISPpbqn/JDyJ+9KAQfN5SiKvCL3BgPlTjhXXMGCvvmwTf+ZCjn6TEPnaD9m1W2+Jgbfe/ge5V2p9OW4KkxYuP1CtNmOpIOg4NBGUl4FZ6BHUWObtHKXZC2BbxmjemQeHqeBFz058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683156; c=relaxed/simple;
	bh=EOsxlo3ize9FJMzMGpjbZvFrWLNEtop70SDYoU9VRtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIsksI4symOAc1WaQfD50swcCYsXzQ4q9u5uB8eEyqG6Jcroq4qAACy1NuIShcdkR1BSZPlTgdVaGG1d4TVa5N9U4oSQlX0wPR4T1z7CGDCVCe/VHghAdJt1nsc4l/KIFo/R8VlWc/hSm7AzNPrD5PmrGXcHyQ6vUZ6U5E9N46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o1oRuH/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B02C2BD10;
	Thu,  6 Jun 2024 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683156;
	bh=EOsxlo3ize9FJMzMGpjbZvFrWLNEtop70SDYoU9VRtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1oRuH/qAkh7XKaUjlnkVfL3UBxqDKTvr2V5XIWh0DqMKpyO1SAEw1nrIaMdm8JzV
	 I6OeV1F1y8dPIjWGdw4m+RVPm13OsutdP2FopSazy4aJ3vPBtYWOvbSgF8RgSaDay9
	 cTzG+JEKToFxR31dYPpgnzzU7pgkl3zvJWeTLjwA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Biggers <ebiggers@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 101/744] crypto: x86/nh-avx2 - add missing vzeroupper
Date: Thu,  6 Jun 2024 15:56:13 +0200
Message-ID: <20240606131735.636419878@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 4ad096cca942959871d8ff73826d30f81f856f6e ]

Since nh_avx2() uses ymm registers, execute vzeroupper before returning
from it.  This is necessary to avoid reducing the performance of SSE
code.

Fixes: 0f961f9f670e ("crypto: x86/nhpoly1305 - add AVX2 accelerated NHPoly1305")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/crypto/nh-avx2-x86_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/crypto/nh-avx2-x86_64.S b/arch/x86/crypto/nh-avx2-x86_64.S
index ef73a3ab87263..791386d9a83aa 100644
--- a/arch/x86/crypto/nh-avx2-x86_64.S
+++ b/arch/x86/crypto/nh-avx2-x86_64.S
@@ -154,5 +154,6 @@ SYM_TYPED_FUNC_START(nh_avx2)
 	vpaddq		T1, T0, T0
 	vpaddq		T4, T0, T0
 	vmovdqu		T0, (HASH)
+	vzeroupper
 	RET
 SYM_FUNC_END(nh_avx2)
-- 
2.43.0




