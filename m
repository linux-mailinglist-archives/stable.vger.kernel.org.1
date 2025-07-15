Return-Path: <stable+bounces-162108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E69EB05BA4
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F1856635E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58AB2E2F1E;
	Tue, 15 Jul 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LTWrLg73"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C02E1C69;
	Tue, 15 Jul 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585693; cv=none; b=Da4/Y8KS2urZskB2CeR25yoWKjg9sVDLGfBwAKHD7jMqakvN6iHvcNDCLA0GoT4DR23KNUGg4pndIqxL2YngvVq5akDIuwDTlN5KgbfJ86XQSKGAf/ApAgOABx9wGZScWVNq57L4ZaOBmqmY0/ZOxx+A+mFmuXHHuFFo3iDPhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585693; c=relaxed/simple;
	bh=xzWIsrchLNdQGmaimcV/l1rsAe04EUuPgXsdXsC6QVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KejB+lEqT9Xa0We0XamXvcCNGaTpjjadhansDt19LwZlxVBJIaH6odx7eDzG/zAsJtuyfcAbKEqEQNsc+jHW7nMW1xYftZpLC3NieRAhNdAlhw1hFAHxxmFVqeC6BeGRNqyRvaN7Ydw5bXEQa3nwTZNVt4GnddLSqJ+Rp2hfKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LTWrLg73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CB1C4CEE3;
	Tue, 15 Jul 2025 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585693;
	bh=xzWIsrchLNdQGmaimcV/l1rsAe04EUuPgXsdXsC6QVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTWrLg73/AlKh7AVxzAdSMEVVjVoteM92d62Dxt9dXmpKPp4B4r2ik4axGcOcQeYZ
	 ktfPpPqIBkaXtEHuxMB5+Ne3P1yVzy+wQvSg1jzr7MAnSpKQ4gg3sfJRzD3LFSe0N8
	 f9XzmxlvpaO11ihtA38g5ESxVu4y1QvYqoTnz4Wg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Shravya KN <shravya.k-n@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 136/163] bnxt_en: Fix DCB ETS validation
Date: Tue, 15 Jul 2025 15:13:24 +0200
Message-ID: <20250715130814.293976975@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 0dbb880a7aa0e..71e14be2507e1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -487,7 +487,9 @@ static int bnxt_ets_validate(struct bnxt *bp, struct ieee_ets *ets, u8 *tc)
 
 		if ((ets->tc_tx_bw[i] || ets->tc_tsa[i]) && i > bp->max_tc)
 			return -EINVAL;
+	}
 
+	for (i = 0; i < max_tc; i++) {
 		switch (ets->tc_tsa[i]) {
 		case IEEE_8021QAZ_TSA_STRICT:
 			break;
-- 
2.39.5




