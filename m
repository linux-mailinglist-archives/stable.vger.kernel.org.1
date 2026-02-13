Return-Path: <stable+bounces-216269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLhQIH1Vj2lqQQEAu9opvQ
	(envelope-from <stable+bounces-216269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:46:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DAD1385AA
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF2CF300F9F8
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0532B98D;
	Fri, 13 Feb 2026 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6SjUb1d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD07330D54
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001106; cv=none; b=m44IjS9N65zg6s9ErrqSxlUHbrVgi8IsiTGET3yJoTwwOs7HRjlYGhMieIXuqFNg0MMXvQl4Y8HApVwP6WnSfFSUut5CW538JP7WXsRosr8d1ztL/xNuJQ16lL/NeYCYlmtZmnPsjOJhJQujdEKS7CzHlHhuoFY0rfUDhg/SGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001106; c=relaxed/simple;
	bh=ErS7FcqxpgIDO9+PtTjDefIu/LDlYv+5sZfprvQyozU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXh2NcjD4n62hsOglPmhlmJktMgPSbcwpO6QyXBMRf2eNHE2qVKt/D0OOIljwQDT7CFt5HLMHZMsTVrMWuA+iIXwLREVkQzYNHsBaxn133n9PL0P2LZdyYTmUS03VHSGrl0w/GNSk1KNIJhVOFgShjVA/r1UbTD5n+hys8Kh0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6SjUb1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322CDC116C6;
	Fri, 13 Feb 2026 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771001105;
	bh=ErS7FcqxpgIDO9+PtTjDefIu/LDlYv+5sZfprvQyozU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6SjUb1dA+7KbC91xkH8Vy17ByW6fY3Kd8alOBdZ5rOQDMJ9+E0R8s9qMfj1krJ4F
	 SaUZMMnK2lb+tKpfIkFmbKcgKEFFyEBrtoHgVJg/ayae+zBS/WxP7Qm8O2JVbXlASC
	 Qoz/6ZxjoUVLEMKdn/18TuRd6unIt9sqET6eb5PaPKsjGAGp5tVd7GY0D7KHnEW4rD
	 VfWqfrFbLKtf/VnfhIgN5xruQc2ddb9pOWMKCQG6qPLXtsfGp3mzkzozsFhkVMWFmb
	 CdU0+kQBedeREUOO4CbBTS+LnIiFfer7esCI2/gOg2BO/Tp2lLIPbNBeSJBMs6H2O6
	 Q1CRM2UAjjRxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gleb Chesnokov <Chesnokov.G@raidix.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] scsi: qla2xxx: Use named initializers for port_[d]state_str
Date: Fri, 13 Feb 2026 11:45:00 -0500
Message-ID: <20260213164503.3564614-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021306-playful-overact-2bfb@gregkh>
References: <2026021306-playful-overact-2bfb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216269-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: D5DAD1385AA
X-Rspamd-Action: no action

From: Gleb Chesnokov <Chesnokov.G@raidix.com>

[ Upstream commit 6e0e85d39e528da2915a2da261195f81bfde6915 ]

Make port_state_str and port_dstate_str a little more readable and
maintainable by using named initializers.

Also convert FCS_* macros into an enum.

Link: https://lore.kernel.org/r/AS8PR10MB495215841EB25C16DBC0CB409D349@AS8PR10MB4952.EURPRD10.PROD.OUTLOOK.COM
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Gleb Chesnokov <Chesnokov.G@raidix.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 7adbd2b78090 ("scsi: qla2xxx: Free sp in error path to fix system crash")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h | 35 ++++++++++++++++++----------------
 drivers/scsi/qla2xxx/qla_isr.c | 10 +++++-----
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 02a2fd1b150a9..5416d1f776c1b 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2689,25 +2689,28 @@ struct event_arg {
 /*
  * Fibre channel port/lun states.
  */
-#define FCS_UNCONFIGURED	1
-#define FCS_DEVICE_DEAD		2
-#define FCS_DEVICE_LOST		3
-#define FCS_ONLINE		4
+enum {
+	FCS_UNKNOWN,
+	FCS_UNCONFIGURED,
+	FCS_DEVICE_DEAD,
+	FCS_DEVICE_LOST,
+	FCS_ONLINE,
+};
 
 extern const char *const port_state_str[5];
 
-static const char * const port_dstate_str[] = {
-	"DELETED",
-	"GNN_ID",
-	"GNL",
-	"LOGIN_PEND",
-	"LOGIN_FAILED",
-	"GPDB",
-	"UPD_FCPORT",
-	"LOGIN_COMPLETE",
-	"ADISC",
-	"DELETE_PEND",
-	"LOGIN_AUTH_PEND",
+static const char *const port_dstate_str[] = {
+	[DSC_DELETED]		= "DELETED",
+	[DSC_GNN_ID]		= "GNN_ID",
+	[DSC_GNL]		= "GNL",
+	[DSC_LOGIN_PEND]	= "LOGIN_PEND",
+	[DSC_LOGIN_FAILED]	= "LOGIN_FAILED",
+	[DSC_GPDB]		= "GPDB",
+	[DSC_UPD_FCPORT]	= "UPD_FCPORT",
+	[DSC_LOGIN_COMPLETE]	= "LOGIN_COMPLETE",
+	[DSC_ADISC]		= "ADISC",
+	[DSC_DELETE_PEND]	= "DELETE_PEND",
+	[DSC_LOGIN_AUTH_PEND]	= "LOGIN_AUTH_PEND",
 };
 
 /*
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 1459ae380389a..8b13797d210d1 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -49,11 +49,11 @@ qla27xx_process_purex_fpin(struct scsi_qla_host *vha, struct purex_item *item)
 }
 
 const char *const port_state_str[] = {
-	"Unknown",
-	"UNCONFIGURED",
-	"DEAD",
-	"LOST",
-	"ONLINE"
+	[FCS_UNKNOWN]		= "Unknown",
+	[FCS_UNCONFIGURED]	= "UNCONFIGURED",
+	[FCS_DEVICE_DEAD]	= "DEAD",
+	[FCS_DEVICE_LOST]	= "LOST",
+	[FCS_ONLINE]		= "ONLINE"
 };
 
 static void
-- 
2.51.0


