Return-Path: <stable+bounces-48002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522FC8FCAFD
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50281F2433A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911C4199247;
	Wed,  5 Jun 2024 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daTZsFwp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AEA19923F;
	Wed,  5 Jun 2024 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588186; cv=none; b=CTGIxzuAcGRtLtmbfwhA0MksrnNbhzaqg6Xn3fVbCFzeMiieobX1kFNUE39XccIM4G2bD1x/nj2n20rV48bIMpU+L7faYKfjrE3JPsR9iHUOP08o1qg/DwN/7rOidcB0ZpkeRvZmq+DQUjVzCayNXOK+gXPT3aCycIOgYiivhFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588186; c=relaxed/simple;
	bh=klJFbPZVKDRnhHyoOzh54fT6kOqFxXYc3De6rLdD1aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTSaMUVP0objVWD18cmf593sxaKAYldgkEeu6GJk76bC/0mjjMZxwP4iWuO+s24q301tHC4GqJ76RjG4U3uyVPC8gVywd42deRlgN2JzkC+uz+skC0Z2ao43zSc8wdxJ8YmKllradxNWikbTacO2obCsiIlsKKz6BBtuyF5uXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daTZsFwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04823C32786;
	Wed,  5 Jun 2024 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588185;
	bh=klJFbPZVKDRnhHyoOzh54fT6kOqFxXYc3De6rLdD1aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daTZsFwpmyzWzLFo2K1sNj9B7L6J93kr0Lj/bviJ4aNJ8mhiWFuK+x1QLMuWGFwjQ
	 uLmrnpNE83b/Cx1MGz/QNbMmfQh4Pou02Xeq6GrVPGWsWMLwSccKUfSNnSbcJ83k8K
	 0V4lBNK1ZeIKvmmGem2/BddlvkO3l2EUYu7o9dYojdESnNkF5YUamrC8OI8yPumOsz
	 l995sr8MHctj37949mIWSvIIqh4QgTk3QYTJ1pIMFY3SkjTnw0kIj42tOdsZJN5Myw
	 DMakFeMTw7Ghtub1h8RX8VFS9YWmlrq9+01L2/LR+5Oy3r7YaUJgmOGJuiFkVDCoVR
	 W4ltzf+EWm1BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Jan Kara <jack@suse.cz>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.9 09/28] udf: udftime: prevent overflow in udf_disk_stamp_to_time()
Date: Wed,  5 Jun 2024 07:48:38 -0400
Message-ID: <20240605114927.2961639-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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


