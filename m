Return-Path: <stable+bounces-48097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABD68FCC52
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD7A1C2384C
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB1198824;
	Wed,  5 Jun 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU/GMtN1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B4198E9F;
	Wed,  5 Jun 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588507; cv=none; b=KLY+hvdylm+a93T53Q+nsO6nFBsU8RjkQ7nFV2l2/jV7j6WEnBehmmT0jlZQoyQSnlIKc9rWvParNoQT9YAit6YiBDPQleu2s+f0vtGU/41Q00BhSVGHspkU932gSNGdCD0qKvIoafHAXj86IPMeGYElPE/SNLj9IVZd2xpebzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588507; c=relaxed/simple;
	bh=vZPl2Rg9MMjHgwCnAcC6p7mvcU/vcb8ipMfTFMNDETU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQxqXkSGvLC/kI8FdV3+uBmSFtU5N8y23OJH8PuoEUuu401S5PrKj+atEQb1t6q0ttNEiiISdpKrNL4Kz7LRXQH1qL9ADbpaz+TGCB9te4j5EKGpihs8+e4BErpXkiKqsNKsPE1YZbGgjSE653Vh/dIwgq2jcmj7k45GVqPDA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU/GMtN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5292DC3277B;
	Wed,  5 Jun 2024 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588507;
	bh=vZPl2Rg9MMjHgwCnAcC6p7mvcU/vcb8ipMfTFMNDETU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AU/GMtN1lXUyNSVhJRO2E6HlWJ+Mq5Uk0NGIiH8dFvCKzGJu4ER41STlVyLGz2VbT
	 30sQZYX3ODJDLoVtNbZQyHxaPrIDqZlMMqrDjykDIvSseOWT2n5ONinbrBWZ5omssn
	 nxcovO0h3PQGkVI467bKcTxZgyRk+nHWnjlgFttxPZw8R5oF23Pu9YaLMZvf8S/iw8
	 JnuuShd+2KIqnyIoyCOfmN35dPIkUhIlT/ViIO49bMXDL3VD+vU1HN2F43AsPjhZsz
	 hLWpbm5GsAby2AaMwB6Pd6quN5McdVlX4LabTjawxNyL8wZL2GQuYLEgZ/d84j18E+
	 jgf9C4Rp2dwjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Jan Kara <jack@suse.cz>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 5.4 2/5] udf: udftime: prevent overflow in udf_disk_stamp_to_time()
Date: Wed,  5 Jun 2024 07:54:55 -0400
Message-ID: <20240605115504.2964549-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115504.2964549-1-sashal@kernel.org>
References: <20240605115504.2964549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.277
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


