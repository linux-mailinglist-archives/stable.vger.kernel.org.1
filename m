Return-Path: <stable+bounces-255462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBqeGsyiGGqblggAu9opvQ
	(envelope-from <stable+bounces-255462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:17:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE175F844C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EF4330E2501
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834C733F5B4;
	Thu, 28 May 2026 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V4AKxDd8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157033164B7;
	Thu, 28 May 2026 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998981; cv=none; b=FYU5zkFxXmcH9GMoI7rY1fymUr2fasgT5mCQkyPely9/KRzjCwvQIV2yZmcPd4NgsOcCd7CNxFJztXwe44jfXYuBsJ+L9lUdZE84uxOAxDQCfRTTKRK76y+rgVz0wkQfRHcpxvyIuCmPHx31bHjBjdwT9d1POXkvFJpAzbJwACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998981; c=relaxed/simple;
	bh=/Or5OYGGAjubxEi0kfTuaZFyX5J2LZDnwtRRiAtn1s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrR1/D6eFksYGpeNDEaILWv19dYbQHcF2180D0IB/TRvFwfJoMfKr6ytY7HBxL3qmV48kYMJPIcLTi+4yvo4tky5NP0jjkEP2rXrsdcGUp2wuwXDwesIIaJsXB15RYwhhxZw/g62/ozGfN4SGzEodeNmQ0LlTIdHBPuU5nbLDgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V4AKxDd8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7147D1F000E9;
	Thu, 28 May 2026 20:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998979;
	bh=GAdUMwMnUGu7rs8Rh/NWzn5KkM0Mcb1GTxxGwZKAjMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V4AKxDd8yQV6Bg2wZTkqA5VzFEc4QBbYjuFcqMesCW2tq1jwkYUTDGzHta/UGwKJv
	 YqCtl1R2qotsOgMGoTs/Dbn72iyXKHlF/Ws4WQFlpTTvOexJ7ShG4eeAEYbcqBLHfT
	 EpW/xZzLWD0frcIK8peBhPf35iJheS8W+6C4naLs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Roper <matthew.d.roper@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 366/461] drm/xe: Define and use MCR version of COMMON_SLICE_CHICKEN4
Date: Thu, 28 May 2026 21:48:15 +0200
Message-ID: <20260528194658.034454070@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255462-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 1FE175F844C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo Sousa <gustavo.sousa@intel.com>

[ Upstream commit 6df5678b6a94ac80e31e847074c4b30c21025b1f ]

The register COMMON_SLICE_CHICKEN4 is a MCR register on both Xe2 and
Xe3. Let's make sure to define a MCR version of it and use it for the
relevant IP versions.

Use XEHP_ as prefix for the register name, since it is MCR as of Xe_HP.

v2:
  - Also change for one entry in lrc_tunnings, which was caught by
    manual testing and add corresponging Fixes tag in commit message.
    (Gustavo)

Fixes: 8d6f16f1f082 ("drm/xe: Extend Wa_22021007897 to Xe3 platforms")
Fixes: e5c13e2c505b ("drm/xe/xe2hpg: Add Wa_22021007897")
Fixes: 8ccf5f6b2295 ("drm/xe/tuning: Apply windower hardware filtering setting on Xe3 and Xe3p")
Bspec: 66534, 71185, 74417
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patch.msgid.link/20260514-rtp-mcr-check-v3-3-30dd47855fee@intel.com
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
(cherry picked from commit 75f65f1a4c06da1d87f28570a9d4cdad28f13360)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/regs/xe_gt_regs.h | 1 +
 drivers/gpu/drm/xe/xe_tuning.c       | 2 +-
 drivers/gpu/drm/xe/xe_wa.c           | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index e9a82029f5066..bdbcbccd759e2 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -168,6 +168,7 @@
 #define XEHPG_SC_INSTDONE_EXTRA2		XE_REG_MCR(0x7108)
 
 #define COMMON_SLICE_CHICKEN4			XE_REG(0x7300, XE_REG_OPTION_MASKED)
+#define XEHP_COMMON_SLICE_CHICKEN4		XE_REG_MCR(0x7300, XE_REG_OPTION_MASKED)
 #define   SBE_PUSH_CONSTANT_BEHIND_FIX_ENABLE	REG_BIT(12)
 #define   DISABLE_TDC_LOAD_BALANCING_CALC	REG_BIT(6)
 #define   HW_FILTERING				REG_BIT(5)
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index 314cbe70d2f2a..e15553bfb7391 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -112,7 +112,7 @@ static const struct xe_rtp_entry_sr engine_tunings[] = {
 static const struct xe_rtp_entry_sr lrc_tunings[] = {
 	{ XE_RTP_NAME("Tuning: Windower HW Filtering"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3599), ENGINE_CLASS(RENDER)),
-	  XE_RTP_ACTIONS(SET(COMMON_SLICE_CHICKEN4, HW_FILTERING))
+	  XE_RTP_ACTIONS(SET(XEHP_COMMON_SLICE_CHICKEN4, HW_FILTERING))
 	},
 
 	/* DG2 */
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index 4ecf96fb40846..dce0a39d19146 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -825,7 +825,7 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
 	},
 	{ XE_RTP_NAME("22021007897"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002), ENGINE_CLASS(RENDER)),
-	  XE_RTP_ACTIONS(SET(COMMON_SLICE_CHICKEN4, SBE_PUSH_CONSTANT_BEHIND_FIX_ENABLE))
+	  XE_RTP_ACTIONS(SET(XEHP_COMMON_SLICE_CHICKEN4, SBE_PUSH_CONSTANT_BEHIND_FIX_ENABLE))
 	},
 
 	/* Xe3_LPG */
@@ -841,7 +841,7 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
 	},
 	{ XE_RTP_NAME("22021007897"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3005), ENGINE_CLASS(RENDER)),
-	  XE_RTP_ACTIONS(SET(COMMON_SLICE_CHICKEN4, SBE_PUSH_CONSTANT_BEHIND_FIX_ENABLE))
+	  XE_RTP_ACTIONS(SET(XEHP_COMMON_SLICE_CHICKEN4, SBE_PUSH_CONSTANT_BEHIND_FIX_ENABLE))
 	},
 	{ XE_RTP_NAME("14024681466"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3005), ENGINE_CLASS(RENDER)),
-- 
2.53.0




