Return-Path: <stable+bounces-162322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD3DB05D21
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E86318907DD
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911CB2E3B13;
	Tue, 15 Jul 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QzrCspcg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ABA2E3AE2;
	Tue, 15 Jul 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586250; cv=none; b=i4AiyqLeq1d2XFswtgvx8YKzLcluArHm/zfFCw4vDj2ksdNaDsVlyHWZM5j7/Q2liwSnIq2nEGOzhlMnNuPYscPkSMBAIDMIvQ3W/N41sPmDWuPbanIbYqjVgHrEjKpf6WLVocYxMUYrUMkuvHHxavWyx/+d10nyyd8C53V5qHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586250; c=relaxed/simple;
	bh=efBhIwKPPjOGmGL+kT1nntAUbHmbRusXO3um3qSNySk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sn7pvw9Ckh60mhDZyxl24F739vdh+jgqDTtJZuvvVJamlgIznCiJE/q1km16rlpOImVbUdBZeJshB30/FQhEoFQ8bbHUDrymosUMPeukroiwoFRTsnPDhkNCb3o2t7uv4Ekl/FcvRwAM4xw0MPlxLtoVhdrsvhpBJtxdlyJnZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QzrCspcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB943C4CEE3;
	Tue, 15 Jul 2025 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586250;
	bh=efBhIwKPPjOGmGL+kT1nntAUbHmbRusXO3um3qSNySk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzrCspcgWzZmVErnoV20hU0wv5Otjijg2vsrfFnOufBsr29VdOFMRIFchRgk5rfm7
	 hl2Ig4LEVT2oks8S3yQZu3hG7iHoot714117UggzkQT4C2wHd5X3gAUhNbByu/lnEk
	 joJx8gyekFtOjEvz0mueBMWzUEpLY/oqXdN8pxTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Shravya KN <shravya.k-n@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 65/77] bnxt_en: Fix DCB ETS validation
Date: Tue, 15 Jul 2025 15:14:04 +0200
Message-ID: <20250715130754.336288188@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130751.668489382@linuxfoundation.org>
References: <20250715130751.668489382@linuxfoundation.org>
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

From: Shravya KN <shravya.k-n@broadcom.com>

[ Upstream commit b74c2a2e9cc471e847abd87e50a2354c07e02040 ]

In bnxt_ets_validate(), the code incorrectly loops over all possible
traffic classes to check and add the ETS settings.  Fix it to loop
over the configured traffic classes only.

The unconfigured traffic classes will default to TSA_ETS with 0
bandwidth.  Looping over these unconfigured traffic classes may
cause the validation to fail and trigger this error message:

"rejecting ETS config starving a TC\n"

The .ieee_setets() will then fail.

Fixes: 7df4ae9fe855 ("bnxt_en: Implement DCBNL to support host-based DCBX.")
Reviewed-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20250710213938.1959625-2-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index 228a5db7e1434..596513ffdfd9c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -479,7 +479,9 @@ static int bnxt_ets_validate(struct bnxt *bp, struct ieee_ets *ets, u8 *tc)
 
 		if ((ets->tc_tx_bw[i] || ets->tc_tsa[i]) && i > bp->max_tc)
 			return -EINVAL;
+	}
 
+	for (i = 0; i < max_tc; i++) {
 		switch (ets->tc_tsa[i]) {
 		case IEEE_8021QAZ_TSA_STRICT:
 			break;
-- 
2.39.5




