Return-Path: <stable+bounces-109842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA44A1842B
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD2518858D6
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9581F470A;
	Tue, 21 Jan 2025 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="prNAX6tB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3B1F4275;
	Tue, 21 Jan 2025 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482597; cv=none; b=DY/gIzGbTttDfwdXCdap8dEvguH2XEqrXkSD9c29W4BxgcNpzb4GMDi/nq9P/gYKe05ANNzCNfXJZV4+0n5XpZQKFt9FRQM8oFhfIQM1ipjR1pgOPjgwG2BVcMLCdeGtqFxljk3mQNZkP5z/EUpFKFucCamEZSTHfLexUcAT/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482597; c=relaxed/simple;
	bh=Xp3rzrebFdVULEmnI6mHaMGur1ntvbOAR3NSdt48+CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu4jdFCkrMp+YWgE1z0/vUaCIUzUL8E4PDrbVQtRoEfpXUcwoAmGawTcqnCHwGhqDliHwXiLbHpcgFjPGCF8GQ7WOeR7biymivNI3/F9wmTEmGpZndtUD6vUlDAx5gI35wrNdYHAJ0a8Cn3hxk5MBgWDY4cn5c5Sy9C0HPJ6Yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=prNAX6tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A483C4CEE0;
	Tue, 21 Jan 2025 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482597;
	bh=Xp3rzrebFdVULEmnI6mHaMGur1ntvbOAR3NSdt48+CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prNAX6tBkU+6AbXb+URs4tTrs8OhjFg0qxD12Odbf+r4nW3vUSLxWgXyrJhT5+7N/
	 HGMvqK/3jrP3OI33ZxgdBCvZyO5wFH891urAV/HHLXrqXoivuKmOcGVwMzvJ9BGrw1
	 DQp/S6I69hCrih+YE59IJwPQ7qtgidy7bwsaUNyI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sudheer Kumar Doredla <s-doredla@ti.com>,
	Simon Horman <horms@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 01/64] net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()
Date: Tue, 21 Jan 2025 18:52:00 +0100
Message-ID: <20250121174521.625666865@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174521.568417761@linuxfoundation.org>
References: <20250121174521.568417761@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudheer Kumar Doredla <s-doredla@ti.com>

[ Upstream commit 03d120f27d050336f7e7d21879891542c4741f81 ]

CPSW ALE has 75-bit ALE entries stored across three 32-bit words.
The cpsw_ale_get_field() and cpsw_ale_set_field() functions support
ALE field entries spanning up to two words at the most.

The cpsw_ale_get_field() and cpsw_ale_set_field() functions work as
expected when ALE field spanned across word1 and word2, but fails when
ALE field spanned across word2 and word3.

For example, while reading the ALE field spanned across word2 and word3
(i.e. bits 62 to 64), the word3 data shifted to an incorrect position
due to the index becoming zero while flipping.
The same issue occurred when setting an ALE entry.

This issue has not been seen in practice but will be an issue in the future
if the driver supports accessing ALE fields spanning word2 and word3

Fix the methods to handle getting/setting fields spanning up to two words.

Fixes: b685f1a58956 ("net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()")
Signed-off-by: Sudheer Kumar Doredla <s-doredla@ti.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Link: https://patch.msgid.link/20250108172433.311694-1-s-doredla@ti.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 2647c18d40d95..3d42ca15e8779 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -106,15 +106,15 @@ struct cpsw_ale_dev_id {
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
-	int idx, idx2;
+	int idx, idx2, index;
 	u32 hi_val = 0;
 
 	idx    = start / 32;
 	idx2 = (start + bits - 1) / 32;
 	/* Check if bits to be fetched exceed a word */
 	if (idx != idx2) {
-		idx2 = 2 - idx2; /* flip */
-		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
+		index = 2 - idx2; /* flip */
+		hi_val = ale_entry[index] << ((idx2 * 32) - start);
 	}
 	start -= idx * 32;
 	idx    = 2 - idx; /* flip */
@@ -124,16 +124,16 @@ static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
 				      u32 value)
 {
-	int idx, idx2;
+	int idx, idx2, index;
 
 	value &= BITMASK(bits);
 	idx = start / 32;
 	idx2 = (start + bits - 1) / 32;
 	/* Check if bits to be set exceed a word */
 	if (idx != idx2) {
-		idx2 = 2 - idx2; /* flip */
-		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
-		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
+		index = 2 - idx2; /* flip */
+		ale_entry[index] &= ~(BITMASK(bits + start - (idx2 * 32)));
+		ale_entry[index] |= (value >> ((idx2 * 32) - start));
 	}
 	start -= idx * 32;
 	idx = 2 - idx; /* flip */
-- 
2.39.5




