Return-Path: <stable+bounces-249769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UARYCGpgDWquwgUAu9opvQ
	(envelope-from <stable+bounces-249769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:19:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6879588CFB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86BBA302D0AB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5202534F255;
	Wed, 20 May 2026 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fH2pRqpL"
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956F22425B;
	Wed, 20 May 2026 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261539; cv=none; b=vAJFDlx37DeqJ5+ACiz87gshR67x4ItEJj9O1xt8mexiflCNaKiB7UMaiCY0INp3Dw8wVDFDN8Cg3hOf8+FltQDhXn6vb+/I9pcyNvk2AZHk7ZAq9ZQUpH7QnoMVeDYK5iE+2uyAD2IjhtXhwB6qQZQtVtvFDcatSMaYu7phuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261539; c=relaxed/simple;
	bh=NsWpWw0FtvU2LAjxVTrLyqACHUCJ4PnWXRAYqe3hUdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N0JqM0kichUNZ+eDZTLWRSo31ftNqss1pdjjZYAxohBiufqUs90N1si3YC2Sg8b9SLKnGIaEXNuGQhwS3SXQL+Tip4GV6WnorLzXeexJwk0sLraNWStQGPzm0OQdbwlfc6iwrXb8Mke8zPEMj3264WQRCYtdP1n+KxRfo7rPa3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fH2pRqpL; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3f1c75b10;
	Wed, 20 May 2026 15:03:32 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kees@kernel.org,
	Ariel.Elior@qlogic.com,
	Yuval.Mintz@qlogic.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net] qed: fix double free in qed_cxt_tables_alloc()
Date: Wed, 20 May 2026 15:03:23 +0800
Message-Id: <20260520070323.2762379-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e44325f5e03a2kunmed0efd2c2d89c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUtOVk9MSUhJHh5PH08aT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=fH2pRqpLg/Ew5iiKHOQfMutHBqneVG972v7JIpsB+dr1o4+kEap/Qcr9QxBeSe4+T7wQSnSbottWzZxpkNISw6cFuYSCxNzCMJ8GnB8brVVvJREm0F1BPYRLoyVy5pk1mgcehniEq6XRZY3JzzBw1fJfcmLTmEsgskNPE3iWL2A=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=wGRVS72YUwJ3ysVjj/w2ltBkUei4mxyPkzLjiNJiYKE=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-249769-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:dkim]
X-Rspamd-Queue-Id: D6879588CFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If one of the later PF or VF CID bitmap allocations fails,
qed_cid_map_alloc() jumps to cid_map_fail and frees the previously
allocated CID bitmaps before returning an error. qed_cxt_tables_alloc()
then calls qed_cxt_mngr_free(), which invokes qed_cid_map_free()
again.

Fix this by setting each CID bitmap pointer to NULL after bitmap_free()
to avoid double free.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc3.

Runtime reproduction was not attempted because exercising the failing
allocation path requires device-specific setup.

Fixes: fe56b9e6a8d9 ("qed: Add module with basic common support")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index 9861daa82d9e..b70262e70baf 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -1036,11 +1036,13 @@ static void qed_cid_map_free(struct qed_hwfn *p_hwfn)
 
 	for (type = 0; type < MAX_CONN_TYPES; type++) {
 		bitmap_free(p_mngr->acquired[type].cid_map);
+		p_mngr->acquired[type].cid_map = NULL;
 		p_mngr->acquired[type].max_count = 0;
 		p_mngr->acquired[type].start_cid = 0;
 
 		for (vf = 0; vf < MAX_NUM_VFS; vf++) {
 			bitmap_free(p_mngr->acquired_vf[type][vf].cid_map);
+			p_mngr->acquired_vf[type][vf].cid_map = NULL;
 			p_mngr->acquired_vf[type][vf].max_count = 0;
 			p_mngr->acquired_vf[type][vf].start_cid = 0;
 		}
-- 
2.34.1


