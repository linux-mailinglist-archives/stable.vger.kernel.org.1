Return-Path: <stable+bounces-256481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJPfCGURGWogqAgAu9opvQ
	(envelope-from <stable+bounces-256481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:09:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B44295FCE88
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99FFB3048AE0
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 04:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26C36F418;
	Fri, 29 May 2026 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="kuDCqILb"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856FD36C5A9;
	Fri, 29 May 2026 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780027606; cv=none; b=bMr5TsLlFrA5I3WxeX/ZrNLBnC+CFzx4m2VoErEy6rWEfsZXINR20pdQoaaeBhTkzpkyqYZ9MOwryK8+mjC5GLxZsfSmIaQGclu+yh1yuma+M2tq4QrR06G5M1Xo5gp1teBPquPkCl49pLCXyXRISc0oedkiHQ9NlIjnvRZYeww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780027606; c=relaxed/simple;
	bh=KzU6O0oaQxdN8fER/sAFGVLRyq1GlkUdYGWKBN7OWMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jSUSKzjZ+KB3P3TtWbe8s/D84dJzBw9W/q1cB5jnvv7aKMhGKEBR24OMI0wSAZN9Gos/GyFeb93NGxwocUXdSibzH3yDf1IhfiXaH/RMzaHtFKW+LT52cj1ivr66MZBdQkpN3vN1zSCDPPOPOQNuff4QKeuqShYGchKAiJb8OMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=kuDCqILb; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 404634e9f;
	Fri, 29 May 2026 12:01:17 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: ram.vegesna@broadcom.com
Cc: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	bigeasy@linutronix.de,
	kees@kernel.org,
	tglx@kernel.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] scsi: elx: efct: fix resource leak in efct_xport_initialize()
Date: Fri, 29 May 2026 12:01:15 +0800
Message-Id: <20260529040115.2735213-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e71e4c08a03a2kunm6552753fa6be4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGh4fVkIeTBlIQk9LGB0dTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=kuDCqILbIXwg54fvwxSOFWZlqbBSIn/TqfvmBOLrIU8PLKJ2mNlWpIqYbwaJA8Nxyk5V1rln56wH3JBTlTVCL5ALNS72hBvd1pn67KWgCVi20vNgj9POIVUiJjYCrUSrGCM9LtJDEbhwhGFFVKwLDySMZWXwJhGEdUrdB8eFvpQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=VbiDC2PSm+G49sEOu82h+lcLRU5NKq+hJZBIagGj7yU=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256481-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B44295FCE88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

efct_device_attach() frees efct->xport when efct_xport_initialize()
fails, but efct_xport_initialize() returns directly when efct_hw_init()
fails. That skips efct_hw_teardown() and leaves the hardware resources
allocated by efct_xport_attach() behind before the transport object
itself is freed.

Route the efct_hw_init() error through the existing hw_init_out cleanup
path so the hardware teardown runs before returning.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still present in
v7.1-rc5.

An x86_64 allyesconfig build showed no new warnings. As we do not have
access to an Emulex LPE31004/LPE36000 adapter to test with in this
environment, no runtime testing was able to beperformed.

Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/scsi/elx/efct/efct_xport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/elx/efct/efct_xport.c b/drivers/scsi/elx/efct/efct_xport.c
index 9dcaef6fc188..e7b7d2c3bbf3 100644
--- a/drivers/scsi/elx/efct/efct_xport.c
+++ b/drivers/scsi/elx/efct/efct_xport.c
@@ -229,7 +229,7 @@ efct_xport_initialize(struct efct_xport *xport)
 	rc = efct_hw_init(&efct->hw);
 	if (rc) {
 		efc_log_err(efct, "efct_hw_init failure\n");
-		goto out;
+		goto hw_init_out;
 	}
 
 	rc = efct_scsi_tgt_new_device(efct);
@@ -256,7 +256,6 @@ efct_xport_initialize(struct efct_xport *xport)
 
 hw_init_out:
 	efct_hw_teardown(&efct->hw);
-out:
 	return rc;
 }
 
-- 
2.34.1


