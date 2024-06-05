Return-Path: <stable+bounces-48091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF77C8FCC41
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300FC2935EF
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAE6198A10;
	Wed,  5 Jun 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fv4gK/2T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7D198A0A;
	Wed,  5 Jun 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588489; cv=none; b=uIY5ukySwpcGu4QWqUQ2o7TtdJ3t9JCCz/MTHEijoXzWtE14XlJzdYj3+xfqd7kRI2SMe7VM2xSHoRPBa6nCFl01OTUDOlcMLa4vW+xOeclF3M/0xy8N0AjP9vOQUZ7U2I7hsO+fyAdOEjhWNSmtT/ZwET59o+LFnnHyzKwRq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588489; c=relaxed/simple;
	bh=vZPl2Rg9MMjHgwCnAcC6p7mvcU/vcb8ipMfTFMNDETU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcKCwRaxWRHnKWY4JTRX4FbO1w/dQPeMYf0tPClmRpb8/Vyz2KK/AgiW7wjPqE8XG9EsUSswJctDU7S+QNe2ozfufwaPySwkZR69/XTcVVtQN5ZGhKjpzV3FAT5+pBj6wSBVwQzGnUsNSfYwXoAIMbU58INzaClqxlG/zOUwYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fv4gK/2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42030C4AF07;
	Wed,  5 Jun 2024 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588489;
	bh=vZPl2Rg9MMjHgwCnAcC6p7mvcU/vcb8ipMfTFMNDETU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fv4gK/2TaOcisB72KzmrfetYGsm4wspqz0YqHL7f5IZxtlearIdlFn7xk0zAejtWM
	 O42+3bIdQfWILZehaPyYx0Oa3EG4tpRTeFkqXc2uxP0I/Ve604Rn1IWC12dgbkvVK8
	 +J7L2Lo8ED//6d889tIPOODRwzFHRvkSzlvsR3U3qLwIqTAmCMGO/ZP6yGzv4kyaZ9
	 um/5DEDEqCM/D3tKTc2Y+UmNMVM7n03lGyoPE7jRvt051AC5ulWj/thSijV2fSmMyh
	 5KjJoMDRAqSCEwhLJq5bgi5apz9AjaUpWOdbOIGj7L8u2OnFe/x0MG+YrEvsbf/bLi
	 bG6VsToeHe0Pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Jan Kara <jack@suse.cz>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 5.10 3/7] udf: udftime: prevent overflow in udf_disk_stamp_to_time()
Date: Wed,  5 Jun 2024 07:54:32 -0400
Message-ID: <20240605115442.2964376-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115442.2964376-1-sashal@kernel.org>
References: <20240605115442.2964376-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
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


