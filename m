Return-Path: <stable+bounces-111494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4A9A22F7F
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DCF27A3A0A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B227C1E990D;
	Thu, 30 Jan 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BUSqA4ZM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711721E8835;
	Thu, 30 Jan 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246899; cv=none; b=uijS4rt+B5vSI7A8dCM7TWEJBDidkJb4SUMektP3Jej4Oeni9SRsoo2aj/sVTCbmbGHaga6muJJ1kiUrPNyU2wz2CRuBUJQzJXCEh82S5ISrSYOAVyHVFdHybogJsNjEQAs/B/EpU0ZrAHoudJ38MMpBV9MxXb/quOSvlOI/D2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246899; c=relaxed/simple;
	bh=Ep3ZP5o4p/p4J5NSeiweG8XmFCcPZ1rZJo75Wq1misk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVChAD+hz0nQfuLUWSgmrBh0KcsAupSAo71i9VyZ5xx1pr1cmsk4OJhmTfrJUYC3XimJccXcya7udGu0mavTZXLoELPjCrKIMJe1o3bRObJ7sCjnjkWhQoiDfPFltRALHuumZ1SrmRPmW97WSI81ARnM56vaJMeR+ERidpiN81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BUSqA4ZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2039C4CED2;
	Thu, 30 Jan 2025 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246899;
	bh=Ep3ZP5o4p/p4J5NSeiweG8XmFCcPZ1rZJo75Wq1misk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUSqA4ZMzYqzo1abokzpyCEcNuc3sIv21L+UL/d5cvRq1fluLOV5wMj96m1/tsNpl
	 uZtt+DAPiPCHUsfakcqhEgsepAXs655VyXOSAPmwFMHQXB0vQRGDEFXxJxYjc00uDP
	 E5CbiSCRjSt0ZccAdHP5Sx8QFY4YmxMeqzqtTe68=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anumula Murali Mohan Reddy <anumula@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 014/133] cxgb4: Avoid removal of uninserted tid
Date: Thu, 30 Jan 2025 15:00:03 +0100
Message-ID: <20250130140143.080162768@linuxfoundation.org>
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

From: Anumula Murali Mohan Reddy <anumula@chelsio.com>

[ Upstream commit 4c1224501e9d6c5fd12d83752f1c1b444e0e3418 ]

During ARP failure, tid is not inserted but _c4iw_free_ep()
attempts to remove tid which results in error.
This patch fixes the issue by avoiding removal of uninserted tid.

Fixes: 59437d78f088 ("cxgb4/chtls: fix ULD connection failures due to wrong TID base")
Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
Link: https://patch.msgid.link/20250103092327.1011925-1-anumula@chelsio.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 720f2ca7f856..75ff6bf1b58e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -1800,7 +1800,10 @@ void cxgb4_remove_tid(struct tid_info *t, unsigned int chan, unsigned int tid,
 	struct adapter *adap = container_of(t, struct adapter, tids);
 	struct sk_buff *skb;
 
-	WARN_ON(tid_out_of_range(&adap->tids, tid));
+	if (tid_out_of_range(&adap->tids, tid)) {
+		dev_err(adap->pdev_dev, "tid %d out of range\n", tid);
+		return;
+	}
 
 	if (t->tid_tab[tid - adap->tids.tid_base]) {
 		t->tid_tab[tid - adap->tids.tid_base] = NULL;
-- 
2.39.5




