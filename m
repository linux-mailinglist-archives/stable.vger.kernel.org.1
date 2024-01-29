Return-Path: <stable+bounces-17157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8E84100E
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B461C23751
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C9C15EAAB;
	Mon, 29 Jan 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EX7kKV+Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A637375F;
	Mon, 29 Jan 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548553; cv=none; b=sGovdysAz5wkN8RLrMu7KFLSvT/WLRA3cf/9l0n8nyAejIZ05DLsG2L2WLQyvW7WkhM9EMjwM42VIcX0pAgWUH9BEWgQz03XTpszA3m47zG3LpisReZcOvB+z/EU8rdOwNvPlS81YOXOdmlRL4srWtwIUEKz+RceiNQpOddg/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548553; c=relaxed/simple;
	bh=kVQxFrBgClv90i/X2LmN0O8mkr3RkE82JSeD2Zcf/uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXDr8TMA61k2aScuhMj1F1aOYK1J1efoOHYjHm6iTnnUtRhTwG+Hyy/8LlaqJMgzkkJtZPLUIE5S6KWIQzrXx5XHK3V8gSBajpNY1oae2w4++mOcYsDm7YXUHuIPbdiIXVKx6eQ/nrwL+vjUNKjN45FnI0M2t6UffYnBiUa6XRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EX7kKV+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD583C433C7;
	Mon, 29 Jan 2024 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548552;
	bh=kVQxFrBgClv90i/X2LmN0O8mkr3RkE82JSeD2Zcf/uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EX7kKV+ZKjioUPI2oTeizFBMSdVsZSSUELrP/RngPlUs0Wy8X23/1KVNKEwHZIFZY
	 xpKPrJzBv3qB5ZBiiiY4cv1OB3D2UAV7kGdBN9LwSqA8e1RcL9Z9unRSawM4hqwWTN
	 xl8Sun/LfZLDUgvlOUdMhTs5h6v4SmtvzCFq270w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 172/331] bnxt_en: Wait for FLR to complete during probe
Date: Mon, 29 Jan 2024 09:03:56 -0800
Message-ID: <20240129170019.948534856@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 3c1069fa42872f95cf3c6fedf80723d391e12d57 ]

The first message to firmware may fail if the device is undergoing FLR.
The driver has some recovery logic for this failure scenario but we must
wait 100 msec for FLR to complete before proceeding.  Otherwise the
recovery will always fail.

Fixes: ba02629ff6cb ("bnxt_en: log firmware status on firmware init failure")
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20240117234515.226944-2-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6039886a8544..9e04db1273a5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12261,6 +12261,11 @@ static int bnxt_fw_init_one_p1(struct bnxt *bp)
 
 	bp->fw_cap = 0;
 	rc = bnxt_hwrm_ver_get(bp);
+	/* FW may be unresponsive after FLR. FLR must complete within 100 msec
+	 * so wait before continuing with recovery.
+	 */
+	if (rc)
+		msleep(100);
 	bnxt_try_map_fw_health_reg(bp);
 	if (rc) {
 		rc = bnxt_try_recover_fw(bp);
-- 
2.43.0




