Return-Path: <stable+bounces-81030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56335990E04
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1864C288EF7
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00221DD542;
	Fri,  4 Oct 2024 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4VE0DyW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE91DD53A;
	Fri,  4 Oct 2024 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066542; cv=none; b=MtF5RjfwE6A3mxCrSt3RWYQM35ImaGhD2SfkBbejlit8ML1rP2BF0+dj9YaNvDlg6FUIkfiDM2SU+QKN47HV788Cf9RFruQMy7ZjIcKujDJcLMSBEqNYo9OqcElYv1bbmKRERpKp+as1scTGJDksDHbJgAjNVb9nViGT1hfij2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066542; c=relaxed/simple;
	bh=ILi78P8JHnsZkio7BUmcMe7VNNlwlXIBKqpDozxaViQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxemz02XQGIWox+uEu8MCouEgrhHwqIAK8jIKRU3v3r8QDKaH4oiCS5si6dsH5L4DApJYFJIedcIrGxCI+o+pl/zsfOR3WcogxqtOv9QqTwkpkOe//BtgYz7NehVBG1NNAQZATzTRr7YMM14+pnT0MLdVHchvsy0+3RHmHLIn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4VE0DyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065FEC4CECC;
	Fri,  4 Oct 2024 18:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066542;
	bh=ILi78P8JHnsZkio7BUmcMe7VNNlwlXIBKqpDozxaViQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4VE0DyW1/XMEURM+qLcDHbm+KtgNFzertk12YOa98JCkrAS5Z0JnveVAQy9zgZq0
	 VTvqpxVCxTKDW5wvmJGN7Ju4y6mXSmlWqEU8SToghAUh9S5tScLHSgAAU/15VjVfqN
	 5jCttxMLqC553uiW+iJm33qJj/y8fWikDAVLanuTr4Lvlvja6HW2t3sqjHHw364wes
	 d9unaAMnx7uaLCUsI1Be5ZC/Fom0POpgouxLvRUleVVOI/RFQakL2Kj9zqxHwky8wU
	 HP/JoTH6sBhhVF7ncryz15QFp5mm+JfNFAprDyeHlEUHET9kb9tf5DaCVtY4Ak9oaO
	 JAgos12hFhzJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	frankja@linux.ibm.com,
	nsg@linux.ibm.com,
	imbrenda@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/31] s390/facility: Disable compile time optimization for decompressor code
Date: Fri,  4 Oct 2024 14:28:11 -0400
Message-ID: <20241004182854.3674661-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 0147addc4fb72a39448b8873d8acdf3a0f29aa65 ]

Disable compile time optimizations of test_facility() for the
decompressor. The decompressor should not contain any optimized code
depending on the architecture level set the kernel image is compiled
for to avoid unexpected operation exceptions.

Add a __DECOMPRESSOR check to test_facility() to enforce that
facilities are always checked during runtime for the decompressor.

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/facility.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
index e3aa354ab9f46..bd7dc6fc139e6 100644
--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -56,8 +56,10 @@ static inline int test_facility(unsigned long nr)
 	unsigned long facilities_als[] = { FACILITIES_ALS };
 
 	if (__builtin_constant_p(nr) && nr < sizeof(facilities_als) * 8) {
-		if (__test_facility(nr, &facilities_als))
-			return 1;
+		if (__test_facility(nr, &facilities_als)) {
+			if (!__is_defined(__DECOMPRESSOR))
+				return 1;
+		}
 	}
 	return __test_facility(nr, &stfle_fac_list);
 }
-- 
2.43.0


