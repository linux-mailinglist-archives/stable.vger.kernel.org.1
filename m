Return-Path: <stable+bounces-220675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMtcI5lSo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:39:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C7C1C87B1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45F933234451
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6613F5A53;
	Sat, 28 Feb 2026 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ3U3I/a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424683F5A4D;
	Sat, 28 Feb 2026 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300557; cv=none; b=d0ERcPIWvEk+ddv1rQXSKAlv+co/8Srg/YD8gZZYiTqg7US4AtLIC9m2z369p57FLWn1cMU+ZnrQgd7yj54aYTi/Pjec3bDPOZtkixCfQCfQdZh09E5wYRDuFsElF2nDFxgLlKpQqL2q7mUpTxsYwFA+RgczBeRse9KCmOH175A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300557; c=relaxed/simple;
	bh=fXRW22GKIGq9TiIb2fQM4Wiktdfuv2J/Mn6+4IMUBxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3kERc8LoEBGMO7bQ0ApHfFvfVio0J78yuyeFMCGxV3L7y9q21GAPFcDBs2tiF5/+q4bQQm4dMjmL4c3WITxfs9Ywi6ulEQiOSB/DerBh2B+P8zXrdjDE/sjHp3rmssk4S0tr+NOX28gyF1tEfDKxkkgf1YtUdGAc3I65ZAX8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ3U3I/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC10C19423;
	Sat, 28 Feb 2026 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300557;
	bh=fXRW22GKIGq9TiIb2fQM4Wiktdfuv2J/Mn6+4IMUBxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJ3U3I/aL+z6ydmklzlbx81J0ClkwT9etLE5SnELUwC9kOoOpUeCt5X0Zb++lmgs1
	 S9AqtI+Ah7PcT9VaWMHiEE3BkZ16GI2X3Iie3KSTBl7XeZ+w7WvioGNMOzTdjHKaaH
	 SyNO6K7pXPf3EfdmTDLxiipoKnzXfxi5aBN0XTYxg71yJJGCb42EXaMCksz0Y8FMQ0
	 sI74k0xasjg+OGqGoV/LQh9SAB36xJIyDpkJy1EKEpJtrMOYbgwQl9gqFfJIy83cmS
	 C+AD4DkunaTaYwA2+WIhWCdjBqigzd42Ibgr8K5Eq5xMI07HrTBuh5cHRGbspklX6K
	 UPIR8watTIT9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bingbu Cao <bingbu.cao@intel.com>,
	Stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 596/844] media: staging/ipu7: Update CDPHY register settings
Date: Sat, 28 Feb 2026 12:28:29 -0500
Message-ID: <20260228173244.1509663-597-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220675-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7C7C1C87B1
X-Rspamd-Action: no action

From: Bingbu Cao <bingbu.cao@intel.com>

[ Upstream commit f7923e6bafcad686adb51cc100ba1860f8b43922 ]

Some CPHY settings needs to updated according to the latest guide from
SNPS. This patch program 45ohm for tuning resistance to fix CPHY problem
and update the ITMINRX and GMODE for CPHY.

Cc: Stable@vger.kernel.org
Fixes: a516d36bdc3d ("media: staging/ipu7: add IPU7 input system device driver")
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/ipu7/ipu7-isys-csi-phy.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/ipu7/ipu7-isys-csi-phy.c b/drivers/staging/media/ipu7/ipu7-isys-csi-phy.c
index 2d57178835188..3f15af3b4c799 100644
--- a/drivers/staging/media/ipu7/ipu7-isys-csi-phy.c
+++ b/drivers/staging/media/ipu7/ipu7-isys-csi-phy.c
@@ -124,6 +124,7 @@ static const struct cdr_fbk_cap_prog_params table7[] = {
 	{ 1350, 1589, 4 },
 	{ 1590, 1949, 5 },
 	{ 1950, 2499, 6 },
+	{ 2500, 3500, 7 },
 	{ }
 };
 
@@ -838,9 +839,10 @@ static void ipu7_isys_cphy_config(struct ipu7_isys *isys, u8 id, u8 lanes,
 		dwc_phy_write_mask(isys, id, reg + 0x400 * i,
 				   reset_thresh, 9, 11);
 
+	/* Tuning ITMINRX to 2 for CPHY */
 	reg = CORE_DIG_CLANE_0_RW_LP_0;
 	for (i = 0; i < trios; i++)
-		dwc_phy_write_mask(isys, id, reg + 0x400 * i, 1, 12, 15);
+		dwc_phy_write_mask(isys, id, reg + 0x400 * i, 2, 12, 15);
 
 	reg = CORE_DIG_CLANE_0_RW_LP_2;
 	for (i = 0; i < trios; i++)
@@ -860,7 +862,11 @@ static void ipu7_isys_cphy_config(struct ipu7_isys *isys, u8 id, u8 lanes,
 	for (i = 0; i < (lanes + 1); i++) {
 		reg = CORE_DIG_IOCTRL_RW_AFE_LANE0_CTRL_2_9 + 0x400 * i;
 		dwc_phy_write_mask(isys, id, reg, 4U, 0, 2);
-		dwc_phy_write_mask(isys, id, reg, 0U, 3, 4);
+		/* Set GMODE to 2 when CPHY >= 1.5Gsps */
+		if (mbps >= 1500)
+			dwc_phy_write_mask(isys, id, reg, 2U, 3, 4);
+		else
+			dwc_phy_write_mask(isys, id, reg, 0U, 3, 4);
 
 		reg = CORE_DIG_IOCTRL_RW_AFE_LANE0_CTRL_2_7 + 0x400 * i;
 		dwc_phy_write_mask(isys, id, reg, cap_prog, 10, 12);
@@ -930,8 +936,9 @@ static int ipu7_isys_phy_config(struct ipu7_isys *isys, u8 id, u8 lanes,
 			   7, 12, 14);
 	dwc_phy_write_mask(isys, id, CORE_DIG_IOCTRL_RW_AFE_CB_CTRL_2_7,
 			   0, 8, 10);
+	/* resistance tuning: 1 for 45ohm, 0 for 50ohm */
 	dwc_phy_write_mask(isys, id, CORE_DIG_IOCTRL_RW_AFE_CB_CTRL_2_5,
-			   0, 8, 8);
+			   1, 8, 8);
 
 	if (aggregation)
 		phy_mode = isys->csi2[0].phy_mode;
-- 
2.51.0


