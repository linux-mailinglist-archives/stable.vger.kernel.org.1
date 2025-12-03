Return-Path: <stable+bounces-199424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A21B2CA062B
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB89330B75B6
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B33587C8;
	Wed,  3 Dec 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ygmg2ZKA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6C3587C4;
	Wed,  3 Dec 2025 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779755; cv=none; b=h7+ISvq6y3cM5yyNHEWc3jOTfJ5YKDsihUh4OT/IOficMdXEis9ahRIEipyWwkuMZOa8ARndgWfyf1rRoNPKAFc33meV4DZmHua5NjJ9cysb/7u1ZM2sZLylzCtfblgowqRoZmvbua/RJoK/yhp+GUkxAlt52eISxzuXVYo+I6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779755; c=relaxed/simple;
	bh=px9P812iShy2WmLvUIQT4P66xhvagNakAIA2eriCT4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrV5uGs2N9/nrvrg/ipoTd8HTCPYFnQIJwMzeEMIXgkkQxuFF984ijchOnb+IPa7KAn5eOYoY/vzkaawLySA1s0QlLgxWA4nQLNHsnGxJjTKR0L2/pRdOvM5vvJIMDZMa6nvUsfCXXyq38wgYUo1Rp0VfV62lJ63SEF6vWUgPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ygmg2ZKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0712DC4CEF5;
	Wed,  3 Dec 2025 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764779755;
	bh=px9P812iShy2WmLvUIQT4P66xhvagNakAIA2eriCT4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ygmg2ZKA47LYuN3RRf9oQ2i5rY/1U6rzPNud/rsv3VVHoPEWYf5ozCNSuEX//ePBL
	 JayoRoMAbPJH4Aa+OHO/eW+LhncOdmjAPRKJfJOb6JMBlc6gg8/hrb+ge0WB3qXaFs
	 oLLagcDfuoeYuySeybtvoyttCt6zNpIwjWQ2mQyI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 319/568] bnxt_en: Fix a possible memory leak in bnxt_ptp_init
Date: Wed,  3 Dec 2025 16:25:21 +0100
Message-ID: <20251203152452.395723816@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit deb8eb39164382f1f67ef8e8af9176baf5e10f2d ]

In bnxt_ptp_init(), when ptp_clock_register() fails, the driver is
not freeing the memory allocated for ptp_info->pin_config.  Fix it
to unconditionally free ptp_info->pin_config in bnxt_ptp_free().

Fixes: caf3eedbcd8d ("bnxt_en: 1PPS support for 5750X family chips")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20251104005700.542174-3-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index ae734314f8de5..1c888d6c3aee8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -895,9 +895,9 @@ static void bnxt_ptp_free(struct bnxt *bp)
 	if (ptp->ptp_clock) {
 		ptp_clock_unregister(ptp->ptp_clock);
 		ptp->ptp_clock = NULL;
-		kfree(ptp->ptp_info.pin_config);
-		ptp->ptp_info.pin_config = NULL;
 	}
+	kfree(ptp->ptp_info.pin_config);
+	ptp->ptp_info.pin_config = NULL;
 }
 
 int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
-- 
2.51.0




