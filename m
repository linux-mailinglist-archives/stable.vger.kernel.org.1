Return-Path: <stable+bounces-221183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKzBB/xNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:20:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A331C83CC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0832230E56EC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7AF373C16;
	Sat, 28 Feb 2026 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv2znecd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E859373C12;
	Sat, 28 Feb 2026 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301540; cv=none; b=Mh1H6z9+xKDqHeeKU8ZzDP64sHZpuAk4bAoBNbQqFf47fl+p+qZ1e0y9V1+qj84IFpcQDmipyEU9h9dRKwCnF14It7cVtaU227HYeoyb5pCnoCBPsZreexSAVZt93qeruaGNf+niahUG+n16Fmam0s6VC3AP/hqKQRhP/haUUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301540; c=relaxed/simple;
	bh=M8MWHRNU2U3V/ORthrQefka7sZGGqMMKX/UwrSEEr04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hItUJlkSFKNFa26rQr3nWdmBvSuiNpCB2ppjXrZovdq2VR2PrN4YeLaFqKOf5cao1NJOC0Gt1jWKDEe9Px8EyoNq3l3SiHwj5lx6deMq5O2KiwZTeuTFq5Ap0v2BZrg9AKI4lmr1K4KH2qykbhMo9E7Kw++rsxmwG/FrH6IsMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv2znecd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CD9C19424;
	Sat, 28 Feb 2026 17:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301540;
	bh=M8MWHRNU2U3V/ORthrQefka7sZGGqMMKX/UwrSEEr04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sv2znecd/5iOwCa0wlUekZz4YT9+z37aDHc6t3bhOi+XQrsIosbSauhnN8gJzxjL2
	 2TdcCshYfwZwETOA+LY/hycBEGcdUu0LrROfgvTX+vl+aNmNS/TpPE11+rDxn+JuCS
	 lt/j7cCkZ/HX7uF++hl9UKHVwPvweOH7PONldBWgcJCx1h5NHKsoruvpmmb7XY7s9a
	 02UBHgYnXmX5gkDgJaiwVVZoqP071t2gMExU2Iz0ODkFeExXjLK00dWOTErXJ2Up74
	 Zi8qfOXVSeFuzpuQhnqbOAHUuK8wMcq8qwA61GnXIiyELLkv0UsPn6ErUpRQ/p3GBZ
	 njtntpdTw7cmw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Weigang He <geoffreyhe2@gmail.com>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 722/752] fbdev: of: display_timing: fix refcount leak in of_get_display_timings()
Date: Sat, 28 Feb 2026 12:47:13 -0500
Message-ID: <20260228174750.1542406-722-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,gmx.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-221183-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: B7A331C83CC
X-Rspamd-Action: no action

From: Weigang He <geoffreyhe2@gmail.com>

[ Upstream commit eacf9840ae1285a1ef47eb0ce16d786e542bd4d7 ]

of_parse_phandle() returns a device_node with refcount incremented,
which is stored in 'entry' and then copied to 'native_mode'. When the
error paths at lines 184 or 192 jump to 'entryfail', native_mode's
refcount is not decremented, causing a refcount leak.

Fix this by changing the goto target from 'entryfail' to 'timingfail',
which properly calls of_node_put(native_mode) before cleanup.

Fixes: cc3f414cf2e4 ("video: add of helper for display timings/videomode")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/of_display_timing.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index a4cd446ac5a59..a6ec392253c3e 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -181,7 +181,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 	if (disp->num_timings == 0) {
 		/* should never happen, as entry was already found above */
 		pr_err("%pOF: no timings specified\n", np);
-		goto entryfail;
+		goto timingfail;
 	}
 
 	disp->timings = kcalloc(disp->num_timings,
@@ -189,7 +189,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 				GFP_KERNEL);
 	if (!disp->timings) {
 		pr_err("%pOF: could not allocate timings array\n", np);
-		goto entryfail;
+		goto timingfail;
 	}
 
 	disp->num_timings = 0;
-- 
2.51.0


