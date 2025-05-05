Return-Path: <stable+bounces-139864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 410BAAAA128
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A541887992
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EBE29AB01;
	Mon,  5 May 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1J+Ddgc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42529AAF5;
	Mon,  5 May 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483565; cv=none; b=iq3kfi1hBpxnvUXdeJs9V2LU11aPyXpL0CxqoeIpKQtjZd1tFzNVwhmLGc6QL8Iq/9BFyOhxLGHwT3cgkSlQkTUtkZFTd+5PxEcqb20h/VgEQLG1/1Rr8XXqkWqhuPBYkK10i1DskNFVGT2J68FycPKG4WOsFtSRYsNNbwPCja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483565; c=relaxed/simple;
	bh=JieVl527fMdsIJEaTCw0mRHB+zDbXyv0tUloB6wBAeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pI2P6NfOcircIiGUV3X2x0VIkR4YI97xz+GEOTCgyry8d9yTAIKOCgtKehYKsrjUGqlaoNTE6pKv0VwU7QteLG+y+kBl1pOacXOE090OPRY7fiAymfkbj1k90cU3O/c886lJfG47MYKDHzoIWUG39SOYMRZwWXcTs86llE6lW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1J+Ddgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83D0C4CEE4;
	Mon,  5 May 2025 22:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483565;
	bh=JieVl527fMdsIJEaTCw0mRHB+zDbXyv0tUloB6wBAeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1J+DdgckLUyX7/KwIUG6L3VchN21P/Ovzj7vNTWHq1tAP/S6RYjkadgVuq9zg1YR
	 n9PbdZsLHj+h9tGnh8vdTtwNeMculFJKARoURlDaCnPe5umq8oeY4Ouyf+t5xKmbuN
	 Og6skHTmwGk6kV9nlOEKXx/C2dY4nNF9wr1jRi2+FdhAKFbdRDTb27BRxmc6Bacobl
	 qM5wABgvaGQ6de2GXd19nAgFupWjGXt9F4fRhTEhQP563pBEo9KG+t3/HdymB+Fypy
	 3v1EppmSV+yIg/qS0WQP5G1XEwSZw/7rsjvJAd1K7ahWwaKSm1YrJVRv6OSWbNqzEp
	 3Xl5jkUNpiGag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: shantiprasad shettar <shantiprasad.shettar@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 117/642] bnxt_en: Query FW parameters when the CAPS_CHANGE bit is set
Date: Mon,  5 May 2025 18:05:33 -0400
Message-Id: <20250505221419.2672473-117-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: shantiprasad shettar <shantiprasad.shettar@broadcom.com>

[ Upstream commit a6c81e32aeacbfd530d576fa401edd506ec966ef ]

Newer FW can set the CAPS_CHANGE flag during ifup if some capabilities
or configurations have changed.  For example, the CoS queue
configurations may have changed.  Support this new flag by treating it
almost like FW reset.  The driver will essentially rediscover all
features and capabilities, reconfigure all backing store context memory,
reset everything to default, and reserve all resources.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: shantiprasad shettar <shantiprasad.shettar@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20250310183129.3154117-5-michael.chan@broadcom.com
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1b39574e3fa22..40af27c2ba799 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12097,6 +12097,7 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 	struct hwrm_func_drv_if_change_input *req;
 	bool fw_reset = !bp->irq_tbl;
 	bool resc_reinit = false;
+	bool caps_change = false;
 	int rc, retry = 0;
 	u32 flags = 0;
 
@@ -12152,8 +12153,11 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 		set_bit(BNXT_STATE_ABORT_ERR, &bp->state);
 		return -ENODEV;
 	}
-	if (resc_reinit || fw_reset) {
-		if (fw_reset) {
+	if (flags & FUNC_DRV_IF_CHANGE_RESP_FLAGS_CAPS_CHANGE)
+		caps_change = true;
+
+	if (resc_reinit || fw_reset || caps_change) {
+		if (fw_reset || caps_change) {
 			set_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
 			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 				bnxt_ulp_irq_stop(bp);
-- 
2.39.5


