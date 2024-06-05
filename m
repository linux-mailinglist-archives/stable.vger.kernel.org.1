Return-Path: <stable+bounces-48029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E363F8FCB6A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BBB1C23134
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54D19642B;
	Wed,  5 Jun 2024 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8jjTgbA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65A196424;
	Wed,  5 Jun 2024 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588279; cv=none; b=Q8+dDfasAeqzpP4irQVCToBq0ug9FyrraBzdww/2MEawJChyrtXKolN7PV6tuJeVZ+iFlQ1dlOeb6Y1icMXUFJL7LJP215oWomu1tXDvU2hMQWz+FRViMNCeO1ZIiVem/j5LZN37PTyUwqS1wNF9kYGZy4D50F5JZQzyWOplz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588279; c=relaxed/simple;
	bh=klJFbPZVKDRnhHyoOzh54fT6kOqFxXYc3De6rLdD1aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3lOZGiB1PtwRS9ipzNmms+slDJF9vxdH6YUdWFV6pdxadeyChHwt029sHuvv4pv9C2Pg8+kiFGqatVrm8hlXuE4SklxIQN3HI9GGyY5BUJaSkESIad7GYDdDVeVOZ0W05S1OLWAXVWiQoE/ZddCb+47F/QkI3Q1qUVskBFoaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8jjTgbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DBAC32781;
	Wed,  5 Jun 2024 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588279;
	bh=klJFbPZVKDRnhHyoOzh54fT6kOqFxXYc3De6rLdD1aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8jjTgbA992t8B4ok9eCURRH2UH3ydfL8jvpQcknLKlTOWhKAZCnSUsu4I1QUpV6g
	 iJAp3KUvB0/Mwzy8fzPkAs3UeonfSJYjr2PmQ88CwaoKyCHHsh1jWP3QwChL9PJwzo
	 HoXZkAcBeCnGlwJWfQkA5+y+29/TMg5t/Y/taUaZDj3TSKFS4pD5Dl8eSOlB06Bq+k
	 qYDP0fhnNR+fLpmJ65QqejlbnfZyLEvMZdDvFPd9okjaZvvECdVJlVXfkYMhSMCb4A
	 5qgj51KwMGcndlXSHTFZR9CssCO3EyZc1JlEdF5WXpGXJnalGXvyHcOLyrk36faylw
	 KYt/9Sd8bS4iw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Jan Kara <jack@suse.cz>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.8 08/24] udf: udftime: prevent overflow in udf_disk_stamp_to_time()
Date: Wed,  5 Jun 2024 07:50:18 -0400
Message-ID: <20240605115101.2962372-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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


