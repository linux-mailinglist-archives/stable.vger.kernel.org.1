Return-Path: <stable+bounces-140483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E3CAAA96B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F75981FC4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDE63110DE;
	Mon,  5 May 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAlCFZoK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DAF359644;
	Mon,  5 May 2025 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484952; cv=none; b=l3HDls2+TuElIykp1AZhpuKIK1YDucBt/XKz1ps6pA7nfCcCdkYzOkIP1hXumPt7K3hBqKxGNBZItKHfNTJhIAxDkBQ79sPdRI3XPtiGNmmx2fCQkIActXngq7BnYvgVxUdNpEc24cWIshMwV19/+DS5h1J6zvIa0de61E1sqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484952; c=relaxed/simple;
	bh=fs/jH77eWpvtN/vaewmV7hxsfkW8lvX7xmdN+lFKZ9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYt+hnfukesFk7lyYpLNJ2jnRnyIPftmhNqfIkwGtXyQAiwnbwpbMtyo3aPNLch14vv+sfn+QiDlDO1EjThp5LtjJXay5+ErrhseY8CB1s+rI1J09e1Y5GEMXywmImisPPV5NU6JAWy2pyRdZtgGkepgo3sH0FzyiA6XsrzLVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAlCFZoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B920C4CEEF;
	Mon,  5 May 2025 22:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484952;
	bh=fs/jH77eWpvtN/vaewmV7hxsfkW8lvX7xmdN+lFKZ9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAlCFZoK+qmMUrbgp0rMu8WD4hFUlWjNDaYP3mbExUKVOKW3S9H5361fqQB0RQE2X
	 GR1fQW8l8twItiyrVCDzAuSj5XEQOM1gfoxodqgxgDrVdEpE/C6iq/T9FFKi4qGfZA
	 D35JXWOVmSSE0EG1rhYqOLMkR+nOLP1YvKjmwZDx/JM/nkuK05Az0mEnql6cao9S1K
	 aUI7a5F0XX0cytoK0JwMWIvBDs5x+gKEdbFsIi6Ijrbqsc81l3osLIFlpKMmwswc2m
	 eykG9YMZiPi/yQqKO0HzDEBN6IT7SKmPWsVXjzJHz0rH4W6aBAqOF8AYn7RbFG43t1
	 59CWQzgJvcqRQ==
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
Subject: [PATCH AUTOSEL 6.12 092/486] bnxt_en: Query FW parameters when the CAPS_CHANGE bit is set
Date: Mon,  5 May 2025 18:32:48 -0400
Message-Id: <20250505223922.2682012-92-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 016dcfec8d496..63b674cae892c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11776,6 +11776,7 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 	struct hwrm_func_drv_if_change_input *req;
 	bool fw_reset = !bp->irq_tbl;
 	bool resc_reinit = false;
+	bool caps_change = false;
 	int rc, retry = 0;
 	u32 flags = 0;
 
@@ -11831,8 +11832,11 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
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


