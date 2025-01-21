Return-Path: <stable+bounces-109979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3FA184CA
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8357B1883AEF
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB00A1F669F;
	Tue, 21 Jan 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NcubZvBj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770FD1F667C;
	Tue, 21 Jan 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482991; cv=none; b=iNOdEE8jfGhNPnZ0CGSrnlZ3ONW1q8odNx/Uzv2G8u7mAdch+wr2AJTVnziIQErLKZZ7oJPG6UJKYvTJRRHySsl4MR5+OyUraByNM4HP0o+wZn4fV5EOuai5+FEsxP2FAQahL92w0vCjtLME66P9hLMsNX0OzvshTaZrb4QeWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482991; c=relaxed/simple;
	bh=gNfjIRPqYptJd4ei6ce+CFivfsxfRtEXpQBUhCv7QoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxKtTiWv8YNx2D7l+0M4oDThgpRcjdQKfVZGIGcyS5DoIBDwsODymeZWQi63zyFIpWK0v78x3PtrRGVK9c/JEIOB9xtE7HLfSNBtY6aXqmqQMjSQXTs4favuuj1Sk93ng/+g0crZAKIvkGW2PeKlQaVEznsJsALSETBpQs1ItDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NcubZvBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE72C4CEDF;
	Tue, 21 Jan 2025 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482991;
	bh=gNfjIRPqYptJd4ei6ce+CFivfsxfRtEXpQBUhCv7QoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NcubZvBj0gIcg4pfTAiv2O3dnhJkfWW5NdzwRN7hCQf/bW6oxLU4UPcXWR+9y8V2A
	 gPonq5GY3TtWPrhS0ff24Z2r6bX4i3ZLHQ9exb/bjRpFzab6aTGgaN8WW3/FJMA0F1
	 olKmtlHc6smPGrt0atBWJVuaeLyyukAg6zeEnYFs=
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
Subject: [PATCH 5.15 079/127] net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()
Date: Tue, 21 Jan 2025 18:52:31 +0100
Message-ID: <20250121174532.704222513@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174529.674452028@linuxfoundation.org>
References: <20250121174529.674452028@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 8c59e34d8bcaf..348a05454fcaa 100644
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




