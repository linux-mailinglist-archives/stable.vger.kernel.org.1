Return-Path: <stable+bounces-48052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4989A8FCBC9
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377DC288B4E
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362941AC423;
	Wed,  5 Jun 2024 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncQVyjkl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9788195986;
	Wed,  5 Jun 2024 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588360; cv=none; b=r0dufVSf95W2Wh1sHEXruzdX2gYyTMwAiYmxjzYgm7LGvDWA0V87cgRh8iTq2lfWF/Le4FFlOvTIjU6rE2If27Mix+I7ii79y+nA2sDFdG/+pmF4JvXMgMc0X0j3ayTJP5pfJjoZoWBQkGdsBYisEUlsqrItWIIuVjb64Muu/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588360; c=relaxed/simple;
	bh=klJFbPZVKDRnhHyoOzh54fT6kOqFxXYc3De6rLdD1aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYQFU7Ngk9gU9PKJ0PDn9qKlrAYn1pL59fqZPzcFjpL1tX5hEsHaMkjzoVDE6yWNmqf0r8z7/JfRo9xpyuMn0Vz/iPJU+6T4jObz4HHe511O6yY4Jw5akfNE2EW6udwZChscYwWv8tOZJkcAhHFY+DqrNSLbdHZ0Fx2wNvL3DZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncQVyjkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9FDC32781;
	Wed,  5 Jun 2024 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588359;
	bh=klJFbPZVKDRnhHyoOzh54fT6kOqFxXYc3De6rLdD1aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncQVyjkldIaneWiwEvPC2+7Zra8N+4tnNodxI/rL2q1S3pEh0Yrbd1ENzvT1KqJ2w
	 YqNyGFcShqG4bHuzyP+C1eEPix9/XaT+F/MgZM2xyel33arYAdxUeON4ZLWaaHUIZ9
	 dslnsXMu91lSU5rDcAgVZsC4CUTF0Yf7514/WYguoUpBSnS0GBYJFFoQUZiV9bdHit
	 3uNGpy6TkpqYXENRR6LJye8NwSmRxwPMMXfViMk0KQvtA6oPQBn1sw5oixMU1c4BNi
	 LPrfA2p+eTGA8GePIDSjNVKZHGcDiKEXdY7Em/lkj6TZ47dF9OwDau75NiSgw+U1hK
	 q4u26vHm4qAXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Jan Kara <jack@suse.cz>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.6 07/20] udf: udftime: prevent overflow in udf_disk_stamp_to_time()
Date: Wed,  5 Jun 2024 07:51:50 -0400
Message-ID: <20240605115225.2963242-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 758163af39c26..78ecc633606fb 100644
--- a/fs/udf/udftime.c
+++ b/fs/udf/udftime.c
@@ -46,13 +46,18 @@ udf_disk_stamp_to_time(struct timespec64 *dest, struct timestamp src)
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


