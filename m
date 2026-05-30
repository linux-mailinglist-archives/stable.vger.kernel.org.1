Return-Path: <stable+bounces-256909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3r1kHK7zGmo9+AgAu9opvQ
	(envelope-from <stable+bounces-256909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:26:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D37DF60D749
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5D5A3011061
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3842B2F8E85;
	Sat, 30 May 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpGLMWne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150AC1D435F
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151210; cv=none; b=igwS5nfV/ODaW1k9/e/HABSfMDcPwOgOqSg1d6yAFFuoBcbg8CYpVgv6FTLrfi6A8g5EGn0n/MWv20NwaO/rfU2bYNcC4rThOo9P05V+vSmkczaxJbSw0A+oR1zInhBa36OpvL1XNH1rF+YUYQYiztNfpfD+w4V5rrzlcKvjuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151210; c=relaxed/simple;
	bh=SkWZ3urlQ4DimJpzXzPGEcXuWQsMh8DaUrmxdksHDhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di64mxw/M3aSKHmFh/SxwZY+cP4AvmWcrEQdzqol/1YH+o8BHuWTXlDkP7l4qs7licKhJOENvAxc7k+ZvTZT+myibh/sSz59H8hErFLfxYWD+3ZIFaJ+Ho4k4iX3L93TqlF4EBbIUjtH0/2a+3JyWEyc00oJhpOu5Me9xH7W8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpGLMWne; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AA31F00893;
	Sat, 30 May 2026 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780151208;
	bh=uKto/xjxB3eNazAUSeswotrApnF+RSd1bZaa9ghk5uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TpGLMWne8U7U5WjHBM+i8nIistlfapRLH6Azk9ThgUlfmYzsAcrCfOp267+P4aMZo
	 pqzwrZOHRiBvMF9lZMmQirBoijyJGlgLLSFVg08CEJw5sCyomutKclNy4Bl6Y4PBla
	 8t374le8ARukEao6wwRtv5zNH83JJhzXpPxpyK1++VZIxi0uEUACOUSy3/HUyElQoF
	 sxxdHyACMJGOQOeebziawzlxRK8ol6N7ym8rwHir04kn2hNzzDbh7/Btg5KNKBTSFs
	 CiqCtPnmsowoQLppgQNtWTNWqnqAm/t8uXSjKjGFA6qO8H4d0wJ1FNcbo2TYWEKJM6
	 tWrVAzgB35Z0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] octeontx2-af: replace deprecated strncpy with strscpy
Date: Sat, 30 May 2026 10:26:45 -0400
Message-ID: <20260530142646.2429080-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052830-proofread-ludicrous-154a@gregkh>
References: <2026052830-proofread-ludicrous-154a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256909-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D37DF60D749
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Stitt <justinstitt@google.com>

[ Upstream commit 473f8f2d1bfe1103f20140fdc80cad406b4d68c0 ]

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We can see that linfo->lmac_type is expected to be NUL-terminated based
on the `... - 1`'s present in the current code. Presumably making room
for a NUL-byte at the end of the buffer.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also prefer the more idiomatic strscpy usage of (dest, src,
sizeof(dest)) rather than (dest, src, SOME_LEN).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-v1-1-a443e18f9de8@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c0bf0a4f3f1f ("octeontx2-af: CGX: add bounds check to cgx_speed_mbps index")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 278dc1aabd4b4..394061a3d38c7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1286,8 +1286,6 @@ static inline void link_status_user_format(u64 lstat,
 					   struct cgx_link_user_info *linfo,
 					   struct cgx *cgx, u8 lmac_id)
 {
-	const char *lmac_string;
-
 	linfo->link_up = FIELD_GET(RESP_LINKSTAT_UP, lstat);
 	linfo->full_duplex = FIELD_GET(RESP_LINKSTAT_FDUPLEX, lstat);
 	linfo->speed = cgx_speed_mbps[FIELD_GET(RESP_LINKSTAT_SPEED, lstat)];
@@ -1298,12 +1296,12 @@ static inline void link_status_user_format(u64 lstat,
 	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
 		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
 			linfo->lmac_type_id, cgx->cgx_id, lmac_id);
-		strncpy(linfo->lmac_type, "Unknown", LMACTYPE_STR_LEN - 1);
+		strscpy(linfo->lmac_type, "Unknown", sizeof(linfo->lmac_type));
 		return;
 	}
 
-	lmac_string = cgx_lmactype_string[linfo->lmac_type_id];
-	strncpy(linfo->lmac_type, lmac_string, LMACTYPE_STR_LEN - 1);
+	strscpy(linfo->lmac_type, cgx_lmactype_string[linfo->lmac_type_id],
+		sizeof(linfo->lmac_type));
 }
 
 /* Hardware event handlers */
-- 
2.53.0


