Return-Path: <stable+bounces-98236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92959E3330
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 06:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36D5163E02
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333C117A597;
	Wed,  4 Dec 2024 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UPZGKwbb"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA12F22
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733290587; cv=none; b=uglZYyiwXoKRI8lNG1sWowu/hN+q5hh8N4yRVicJ8lkfqTT0YgCFDAZJl2pBf/uAbBecD1Xd3CTKWVabCJTNgIYS7bWhhCsXida5Qlb1Tc7bs7Po96vdY+D2mJIG1/LaCG9mQzcRU5sQWDCtNWnuy7okt/q7FsTXiRp1yfHAUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733290587; c=relaxed/simple;
	bh=IkEZtadZftKjRqH9yhts5fEPqBDe38sXpY9gxB7o5Mc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=X/rgsk57EEt3+1Hly9EXFBHUpl9OtprlUaKtt4NK4PMBZTp/Z4xVS245UajhpQQlXPsYRxAImwh3kFD7fAgtSG9/rvDLG8wYfHQlZN3JuC2XSpCDIFiB3jBUZ8y3SGOLvRf8zVRuFj7zs+hGkPIn9iLap89wnbbwtHrV2O9MnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UPZGKwbb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 4265E20BCAE6; Tue,  3 Dec 2024 21:36:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4265E20BCAE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733290585;
	bh=WO1k8Du3NxHFMes7jiIFdn5k2SdK8KHlt0QIB6oFTsM=;
	h=From:To:Cc:Subject:Date:From;
	b=UPZGKwbbTpRzgj66L52zYVUCGFBRgfLc6Xc1Ecgv46auUmI2VFlFLvgqZHNTujnSu
	 ZvPP6rH+ZfFCa9T/IRU+VVRWthl1VOP12+PpRzusO7Rr3Q5/yrLTidwiplhSSkjg4y
	 g0IBNAqnb23kOq1rhbUZtzaH7pYH1Jgox4AKYX5c=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: 
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net :mana :Request a V2 response version for MANA_QUERY_GF_STAT
Date: Tue,  3 Dec 2024 21:36:23 -0800
Message-Id: <1733290583-10924-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The current requested response version(V1) for MANA_QUERY_GF_STAT query
results in STATISTICS_FLAGS_TX_ERRORS_GDMA_ERROR value being set to
0 always.
In order to get the correct value for this counter we request the response
version to be V2.

Cc: stable@vger.kernel.org
Fixes: e1df5202e879 ("net :mana :Add remaining GDMA stats for MANA to ethtool")
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 57ac732e7707..f73848a4feb3 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2536,6 +2536,7 @@ void mana_query_gf_stats(struct mana_port_context *apc)
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_GF_STAT,
 			     sizeof(req), sizeof(resp));
+	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
 	req.req_stats = STATISTICS_FLAGS_RX_DISCARDS_NO_WQE |
 			STATISTICS_FLAGS_RX_ERRORS_VPORT_DISABLED |
 			STATISTICS_FLAGS_HC_RX_BYTES |
-- 
2.43.0


