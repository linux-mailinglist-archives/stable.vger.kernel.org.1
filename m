Return-Path: <stable+bounces-48083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A5F8FCC25
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4A01C22992
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49DE19754D;
	Wed,  5 Jun 2024 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCCEZxpX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F151974FF;
	Wed,  5 Jun 2024 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588463; cv=none; b=Pbssk+kQKguUV9/+Uexxy2dvTn+0DHK4KWXpFVS+QTuMctmMY/GNNd4Ai3ynT5u/Lw5l/4bGAL9xQ4w34fHiGSp2cc4KPei1BcpH5IyRE8jp4hXBp1Pw7KwNEnbyJJYGKjgon2Wnk8uU1Jx1nTCU6ToGePuo8xTOOUcffqPOua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588463; c=relaxed/simple;
	bh=vZPl2Rg9MMjHgwCnAcC6p7mvcU/vcb8ipMfTFMNDETU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY9y6dh7AO5V95QV9uA9RhIePorSNhg/1nbf7gWcxSmyUYnhiHZdz59BqjnSPMqkI5X+9n4tegqe/gyguzUW8LalnIIxCZiiQZyS3HWpYq8mLZVr7hTpEpqcIuoPl5M+XblAsPnR/vxmoAXDqzoE5TKle4YNRfddxIzoh5DSNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCCEZxpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B370C32786;
	Wed,  5 Jun 2024 11:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588463;
	bh=vZPl2Rg9MMjHgwCnAcC6p7mvcU/vcb8ipMfTFMNDETU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCCEZxpX/zWeYEK3nmS5lRZLp+TQPa1lEiufq2I+ByLxGgLXTDPBG5GJhS56X4plj
	 AKn+h43iyMM/fS7m/n2TkCEH6f1MODQ5scUeiuxqWXGgwo+jLV35VUVhLiD22fJjf9
	 OV/ZE+wq+Gpiro0YUYLZDQHU7zyOp+TI1ki11ZQ3Vjd9a3g3xPvCLs7c1QnymOAR9o
	 x53FvQaUQ18IDZzVZq491udQzTVSBiAaJ6Ac9vyra3/R2rAbaCWr1K1m/5IZM2t4BZ
	 Tnibv6SUEOQeFQ1CMpBkrP29GgVg2m9MV8gR50W36XLaV2Su3L/SkGbFdGKw1CKEBh
	 FkKiUWct5fwcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Jan Kara <jack@suse.cz>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 5.15 4/9] udf: udftime: prevent overflow in udf_disk_stamp_to_time()
Date: Wed,  5 Jun 2024 07:54:02 -0400
Message-ID: <20240605115415.2964165-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115415.2964165-1-sashal@kernel.org>
References: <20240605115415.2964165-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit

From: Roman Smirnov <r.smirnov@omp.ru>

[ Upstream commit 3b84adf460381169c085e4bc09e7b57e9e16db0a ]

An overflow can occur in a situation where src.centiseconds
takes the value of 255. This situation is unlikely, but there
is no validation check anywere in the code.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20240327132755.13945-1-r.smirnov@omp.ru>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/udftime.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
index fce4ad976c8c2..26169b1f482c3 100644
--- a/fs/udf/udftime.c
+++ b/fs/udf/udftime.c
@@ -60,13 +60,18 @@ udf_disk_stamp_to_time(struct timespec64 *dest, struct timestamp src)
 	dest->tv_sec = mktime64(year, src.month, src.day, src.hour, src.minute,
 			src.second);
 	dest->tv_sec -= offset * 60;
-	dest->tv_nsec = 1000 * (src.centiseconds * 10000 +
-			src.hundredsOfMicroseconds * 100 + src.microseconds);
+
 	/*
 	 * Sanitize nanosecond field since reportedly some filesystems are
 	 * recorded with bogus sub-second values.
 	 */
-	dest->tv_nsec %= NSEC_PER_SEC;
+	if (src.centiseconds < 100 && src.hundredsOfMicroseconds < 100 &&
+	    src.microseconds < 100) {
+		dest->tv_nsec = 1000 * (src.centiseconds * 10000 +
+			src.hundredsOfMicroseconds * 100 + src.microseconds);
+	} else {
+		dest->tv_nsec = 0;
+	}
 }
 
 void
-- 
2.43.0


