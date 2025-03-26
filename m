Return-Path: <stable+bounces-126797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA0CA71FE4
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 21:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821EC3BA0CD
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 20:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90E725484A;
	Wed, 26 Mar 2025 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnmk5jtR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94418253B6A;
	Wed, 26 Mar 2025 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019736; cv=none; b=KxKZHuwzvIjZ1VD0w1ZgWurO40ieT9M90KS2NmnrDeGwmAq0KsouQhAt12jVmZNR91D6pbebsru/brxodL470RNDsUQm5uKAUKTPt1JuAGP7K0I/j0JJbB59PKqoO4yMvdTUBeD8cVxl3RYZpDMBVD7cMWc7XtQUOESxODEbGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019736; c=relaxed/simple;
	bh=JMrDTh2NrkPqeRepEnKBT577obBBPYQ5/itD6gkKEWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cN6h3HvEd9i930sQb4Pf0yjr1ReTHYLePHpeVSYeAxJekr+0rFBhnftXYv6+zpRtUjmBlg5oWb6J7Ilu9mnKiXae0FakWBigXdKijtdmFoF31FleRGwBnz3o4zOuyVQyZKmY2fCGd+spYC0KL3NM+JD5XECjjPdaQe0eq/khLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnmk5jtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4FFC4CEE2;
	Wed, 26 Mar 2025 20:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743019735;
	bh=JMrDTh2NrkPqeRepEnKBT577obBBPYQ5/itD6gkKEWY=;
	h=From:To:Cc:Subject:Date:From;
	b=dnmk5jtRR/g+K3In1vGVEL3D4xR6trCdgNs4LotylIoGdZR7K5ZNvSdbpUWQmS0Hr
	 rRU56SxbKry0Pg8FBAhpmuL3CugyqasjqfwLJcgDU2elbTUz2qRhO1LsfGxrRnH4uR
	 V5PnL1ybx/Sl+De7RmQ1CBQqwA5n0FTVNSSQSflFc9/XuPtbZPPQK3Rx+WpCqJpv23
	 TH/00pWBZ1L9+4E+OehW31Fe6+dcBJUqFhj/W+oj+E44A5rkKn6adok+Swk6eSoz6t
	 jKIAxN6XmGrxILvn/NpBR0pvUZV4Y5CQ4eBCovVJowm67JDoeHGyueeSVSW9H9xamV
	 Z/k/V6AnC1PBg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org,
	David Binderman <dcb314@hotmail.com>
Subject: [PATCH] arm/crc-t10dif: fix use of out-of-scope array in crc_t10dif_arch()
Date: Wed, 26 Mar 2025 13:08:12 -0700
Message-ID: <20250326200812.125574-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Fix a silly bug where an array was used outside of its scope.

Fixes: 1684e8293605 ("arm/crc-t10dif: expose CRC-T10DIF function through lib")
Cc: stable@vger.kernel.org
Reported-by: David Binderman <dcb314@hotmail.com>
Closes: https://lore.kernel.org/r/AS8PR02MB102170568EAE7FFDF93C8D1ED9CA62@AS8PR02MB10217.eurprd02.prod.outlook.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/lib/crc-t10dif-glue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/lib/crc-t10dif-glue.c b/arch/arm/lib/crc-t10dif-glue.c
index f3584ba70e57b..6efad3d78284e 100644
--- a/arch/arm/lib/crc-t10dif-glue.c
+++ b/arch/arm/lib/crc-t10dif-glue.c
@@ -42,13 +42,11 @@ u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
 
 			kernel_neon_begin();
 			crc_t10dif_pmull8(crc, data, length, buf);
 			kernel_neon_end();
 
-			crc = 0;
-			data = buf;
-			length = sizeof(buf);
+			return crc_t10dif_generic(0, buf, sizeof(buf));
 		}
 	}
 	return crc_t10dif_generic(crc, data, length);
 }
 EXPORT_SYMBOL(crc_t10dif_arch);

base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
-- 
2.49.0


