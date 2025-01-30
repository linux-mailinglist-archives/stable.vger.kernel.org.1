Return-Path: <stable+bounces-111581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D47A22FD9
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21E3168E0E
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EC61E7C27;
	Thu, 30 Jan 2025 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QNSi7Gct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F31DDC22;
	Thu, 30 Jan 2025 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247154; cv=none; b=DOma67baFhHgSZN14iLQbsU4D01MxBBvG2HXyLw/2KuwZo2RecVj5tU/3bqg8sCpxd/+9rcZzxIDxahOJPKiQEsxmd0NXaJnh7HJgLxiVANKJguc/PsIfkrdnBZGKJZVaq6iKq3+VGeBzBxuR07bIjLAQ13Q+OAcTSG+gJvKEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247154; c=relaxed/simple;
	bh=ZSdQMKo2LvL/kJUYSuMAJYwZdmieqYnw6d1MPsBHogc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLIszM3mIXLHenKbyLdx4THfvGmbtm4bmuUP4vC1IbxrRt3mzqI2gy8hg4/38K0ccJai5QCYgxpjZwZMWU94OK6ExFJs49qrk4k8EnpQabDQ6Mn2l9yzoBqngVWvENe+Eql3WO0AN9xOZJdvUtgXfTv2C1HfbWcJYgcDJXzEYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QNSi7Gct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8F1C4CED2;
	Thu, 30 Jan 2025 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738247153;
	bh=ZSdQMKo2LvL/kJUYSuMAJYwZdmieqYnw6d1MPsBHogc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QNSi7GctiVoZsrAlzJ6rM7Zz3nkNAtpQj1fTMsw7yuJWXMXvI/fSmI+ETofaDa5M0
	 f9qtH20RXWKtHSJ655D/ur+5CQciTW77ZjTTyUhllflXMbcm0gXXXkDx9VcMsv8m2P
	 bVzG3T27JU2j+e8qP32qDp+X0X+j7bj+FDOx80iA=
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
Subject: [PATCH 5.10 071/133] net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()
Date: Thu, 30 Jan 2025 15:01:00 +0100
Message-ID: <20250130140145.377728568@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 73efc8b453643..bec6a68a973c4 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -104,15 +104,15 @@ struct cpsw_ale_dev_id {
 
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
@@ -122,16 +122,16 @@ static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
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




