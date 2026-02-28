Return-Path: <stable+bounces-220204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDMFCusro2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 743D21C532E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F47630DF84F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40264D8DBD;
	Sat, 28 Feb 2026 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psAweZjG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736B36F40A;
	Sat, 28 Feb 2026 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300109; cv=none; b=Wv9v0HStjpjvIF8hiqnM9RYkIwhR4P8aJtU/HAjEqsH+8wmsjMYdQZdZkue51C5PeHd4FLyOgk8Zdm5H2NAqElrZMeKowm+x0Pbd+QO4QmhfqwHUisnns9P3nlJWGUQxzXSfXcmzPAO8+IvHuJDEuAzNv5wmLqH65MP3Rj1pPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300109; c=relaxed/simple;
	bh=dXPRIil9Z8yUwBs9VwVNLimcRmtPk4s6VpP+5WBMpgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/47A+NFOiHooaqOg2eQBGVanmkerSb8OS9aMPDEF/E7wiK5g4eAOZCY3fDzAnlpcfYqFojowhL7blasmcaHMVWJIpBkRsFKtRPygFUvx6k7/0urWOCIlRgC65UXvFQXeQw0zcOf5xO+JWewVFSjH2MgdqQ0BXXFV68O6YNgKHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psAweZjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F2EC19423;
	Sat, 28 Feb 2026 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300109;
	bh=dXPRIil9Z8yUwBs9VwVNLimcRmtPk4s6VpP+5WBMpgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psAweZjGpN1D/zdZHM3Eh8kF6+ahcQR64bJ1O9DWfTECisWCui5yyVOLuIGbjXyY0
	 qxqpcexFsvVniqvVzx6FCSUd1yKHpPnXtf3+PxzZ6Q4K1q6rcfxcSYdH780P/w4mmE
	 DqIFl4HEm5eQ2dxV9lV+Glo5Hj1c8YwDf8Wwvjr7avIqbBlrZ/QC+Kvjmz5vFGWu/l
	 4y09ES3nG+Lu0vthNnYHqwm4R6fL9H3QLhnMTJ5zJhJShgRahKkEHCGeagQiuHDMBN
	 Q+h3v8HycbZfOzrE0Ow2OLZn9d/sdCnv/CAgJIQd2mHXjZH5HUdnKDofFQX96e3Oet
	 D+InEC/Zrm6qQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 126/844] drm/xe/xe3_lpg: Apply Wa_16028005424
Date: Sat, 28 Feb 2026 12:20:39 -0500
Message-ID: <20260228173244.1509663-127-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220204-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 743D21C532E
X-Rspamd-Action: no action

From: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>

[ Upstream commit 9d94c1cf6ef938abd4b849b66f8eab11e3c537ef ]

Applied Wa_16028005424 to Graphics version from 30.00 to 30.05

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Link: https://patch.msgid.link/20251121100822.20076-2-balasubramani.vivekanandan@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/regs/xe_guc_regs.h | 3 +++
 drivers/gpu/drm/xe/xe_wa.c            | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_guc_regs.h b/drivers/gpu/drm/xe/regs/xe_guc_regs.h
index 2118f7dec287f..87984713dd126 100644
--- a/drivers/gpu/drm/xe/regs/xe_guc_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_guc_regs.h
@@ -90,6 +90,9 @@
 #define GUC_SEND_INTERRUPT			XE_REG(0xc4c8)
 #define   GUC_SEND_TRIGGER			REG_BIT(0)
 
+#define GUC_INTR_CHICKEN			XE_REG(0xc50c)
+#define   DISABLE_SIGNALING_ENGINES		REG_BIT(1)
+
 #define GUC_BCS_RCS_IER				XE_REG(0xc550)
 #define GUC_VCS2_VCS1_IER			XE_REG(0xc554)
 #define GUC_WD_VECS_IER				XE_REG(0xc558)
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index c7eab0c4af7a8..68238e73015b7 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -15,6 +15,7 @@
 
 #include "regs/xe_engine_regs.h"
 #include "regs/xe_gt_regs.h"
+#include "regs/xe_guc_regs.h"
 #include "regs/xe_regs.h"
 #include "xe_device_types.h"
 #include "xe_force_wake.h"
@@ -315,6 +316,10 @@ static const struct xe_rtp_entry_sr gt_was[] = {
 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F10(0), RAMDFTUNIT_CLKGATE_DIS)),
 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
 	},
+	{ XE_RTP_NAME("16028005424"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3005)),
+	  XE_RTP_ACTIONS(SET(GUC_INTR_CHICKEN, DISABLE_SIGNALING_ENGINES))
+	},
 };
 
 static const struct xe_rtp_entry_sr engine_was[] = {
-- 
2.51.0


