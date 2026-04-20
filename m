Return-Path: <stable+bounces-239655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEAeLPtm5mmlvwEAu9opvQ
	(envelope-from <stable+bounces-239655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:48:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0614321EC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 944AC369DF68
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3C733D6FC;
	Mon, 20 Apr 2026 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kyBNHTf0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91D2DE6E3;
	Mon, 20 Apr 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700882; cv=none; b=OHQ3Dw61xS+YnanoCkYVgsCKlTUNRGz/GeTKmtcPcQZkChFmBOzCnQgxMNi2dJjgjL9yszpXRBg1JWVuTH9s44T4hRxs9mw3usZF2f59RnN0Z32G3hMbvtX/y15AkqyubRmCk73uZOcpQb/21u8L5Sg5G33gD0KG9dZslSCvCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700882; c=relaxed/simple;
	bh=jpVzWrjBsx0R/oJ5iSeHBnJOtg0tlHu9Z7kM87iuJnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/g0ALr3zNWsOpZn+tZH56LcDK2/P9229/B7ff7U8TZ7E4TI84LidExT+X7RMExS0aFBTeL3bJGRcHCKWezCTERIxt3u3spqmjLfzBpXYdt4ixj2yplZ5rQgD1U0RvC/EI/UxPjvdnl7Q0Fej8V0l31lEfrFfY+hPOdMs38PwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kyBNHTf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C4AC19425;
	Mon, 20 Apr 2026 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700882;
	bh=jpVzWrjBsx0R/oJ5iSeHBnJOtg0tlHu9Z7kM87iuJnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kyBNHTf0nuHZs+8vqYBkDxWRA2sC3xOHEstp7JTKFDZDEYCGRruWjHoaCR0W81RDR
	 KfcTIQR/dQGy2O582HMRTTvL1gYEsJsvrNSVbo/qNfPEjdhribPyvUme7YFuwpSwst
	 zMw3DR5om5mzORrau7SER+Br5ImPmUZixL53RaRw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 096/198] drm/xe: Fix bug in idledly unit conversion
Date: Mon, 20 Apr 2026 17:41:15 +0200
Message-ID: <20260420153939.061470643@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,linuxfoundation.org:server fail,intel.com:server fail,msgid.link:server fail];
	TAGGED_FROM(0.00)[bounces-239655-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A0614321EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

[ Upstream commit 7596459f3c93d8d45a1bf12d4d7526b50c15baa2 ]

We only need to convert to picosecond units before writing to RING_IDLEDLY.

Fixes: 7c53ff050ba8 ("drm/xe: Apply Wa_16023105232")
Cc: Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>
Acked-by: Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Link: https://patch.msgid.link/20260401012710.4165547-1-vinay.belgaumkar@intel.com
(cherry picked from commit 13743bd628bc9d9a0e2fe53488b2891aedf7cc74)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_hw_engine.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index 1cf623b4a5bcc..d8f16e25b817d 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -587,9 +587,8 @@ static void adjust_idledly(struct xe_hw_engine *hwe)
 		maxcnt *= maxcnt_units_ns;
 
 		if (xe_gt_WARN_ON(gt, idledly >= maxcnt || inhibit_switch)) {
-			idledly = DIV_ROUND_CLOSEST(((maxcnt - 1) * maxcnt_units_ns),
+			idledly = DIV_ROUND_CLOSEST(((maxcnt - 1) * 1000),
 						    idledly_units_ps);
-			idledly = DIV_ROUND_CLOSEST(idledly, 1000);
 			xe_mmio_write32(&gt->mmio, RING_IDLEDLY(hwe->mmio_base), idledly);
 		}
 	}
-- 
2.53.0




