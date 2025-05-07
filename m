Return-Path: <stable+bounces-142391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05948AAEA6A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006ED9C7A51
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335BE21E0BB;
	Wed,  7 May 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j7sODoOf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56742116E9;
	Wed,  7 May 2025 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644104; cv=none; b=jz++1ZTyjnVFdTK/BqdSwAuZ9SBHdLj3bvA9FXhZtFR/HR2wJia2Ja5RsdiUqFHRnSoecWZJDdFpvaAcWZT3fvLxPVrvxahGUrWGF/DBbb5yPmEXKoVwh8agB+7ZnQ5g1XUer6gHtdwdp2/j4PMJISedh0DwWP/iH2rRTUUopi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644104; c=relaxed/simple;
	bh=hWqfumIyIJa5fKCmTqN4h9PCDlo9nvG0OJaqd/5YU9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgXPmKIkpBSC/6Wf5A4pB+YdZs/4djKzCnCMKLPJE+Ln4XHZvX9mA2PbLOwMzzSeUy3M73L9i3kjRhyJ0ZaQVFkP7ZL9N0z/aSE6ToF6DdYSMije+i+I98qb1skNOK05U2eIjMZuCdCgXYBOC6FCYE1jMZ94un3WSKGnEop6ZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j7sODoOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6570EC4CEE2;
	Wed,  7 May 2025 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644103;
	bh=hWqfumIyIJa5fKCmTqN4h9PCDlo9nvG0OJaqd/5YU9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7sODoOfrC47flGpNBWbos4ejV8w2rEYpkRm+30UADPNLR1Q7fz2q7N+WnnOCoofa
	 A9DynzrXB8t+Md0ikzUcvh+KYm4GCyD9vFfbOVbrYbsGDX0HaOeAF0YSnMM0rKZEJF
	 QJfa48/1QWKem6j9GRp0BJjCt2bkQhwyUu4SFIqc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Shravya KN <shravya.k-n@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 121/183] bnxt_en: Fix error handling path in bnxt_init_chip()
Date: Wed,  7 May 2025 20:39:26 +0200
Message-ID: <20250507183829.726716729@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shravya KN <shravya.k-n@broadcom.com>

[ Upstream commit 9ab7a709c926c16b4433cf02d04fcbcf35aaab2b ]

WARN_ON() is triggered in __flush_work() if bnxt_init_chip() fails
because we call cancel_work_sync() on dim work that has not been
initialized.

WARNING: CPU: 37 PID: 5223 at kernel/workqueue.c:4201 __flush_work.isra.0+0x212/0x230

The driver relies on the BNXT_STATE_NAPI_DISABLED bit to check if dim
work has already been cancelled.  But in the bnxt_open() path,
BNXT_STATE_NAPI_DISABLED is not set and this causes the error
path to think that it needs to cancel the uninitalized dim work.
Fix it by setting BNXT_STATE_NAPI_DISABLED during initialization.
The bit will be cleared when we enable NAPI and initialize dim work.

Fixes: 40452969a506 ("bnxt_en: Fix DIM shutdown")
Suggested-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e44f9692dc2ee..da837866c02f8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11379,6 +11379,9 @@ static void bnxt_init_napi(struct bnxt *bp)
 		poll_fn = bnxt_poll_p5;
 	else if (BNXT_CHIP_TYPE_NITRO_A0(bp))
 		cp_nr_rings--;
+
+	set_bit(BNXT_STATE_NAPI_DISABLED, &bp->state);
+
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
 		netif_napi_add_config(bp->dev, &bnapi->napi, poll_fn,
-- 
2.39.5




