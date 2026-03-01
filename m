Return-Path: <stable+bounces-221792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPlXEOuco2k3IQUAu9opvQ
	(envelope-from <stable+bounces-221792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:56:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C63541CC590
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 376D232B1320
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA365277C9D;
	Sun,  1 Mar 2026 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3LjX8bj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1628FFFB;
	Sun,  1 Mar 2026 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329150; cv=none; b=GjITFWtIqtHjW3Eyfxw0w6vRBN5b9896e8kGBmzMeFTDYk1asXjgBidANzDInOzAAqUjELrFVuWSdb3JxD2PrGivNvkJFRxF+iVJPo2xKaohr/3s8NjdH4bDdp3Xf9805KdRmi1MWkmVSh2au2boePPA9vOUZahwsH+qVIyCUnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329150; c=relaxed/simple;
	bh=1imFyVGkQa2hZAKARNwtFq6SMWvnEdxqyvH+wpyBPdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldX+c6PX33gw57s8Lc1hMslCG5hpUsbQe0/zcIxGaWc8wOsS5SB+unCuCBfzLf1XYV1U3TynHwLDhi0LIjk7V3TzbDhNwYW/WHkTljF2z+jkt2OxQ3+soo89TUyABikmXEQVScXTF+P2lZNuh5n6A77VpRo6ytGHOOQULRDprq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3LjX8bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7280C19421;
	Sun,  1 Mar 2026 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329150;
	bh=1imFyVGkQa2hZAKARNwtFq6SMWvnEdxqyvH+wpyBPdc=;
	h=From:To:Cc:Subject:Date:From;
	b=o3LjX8bj1sdswDp5cLUZmQjM5a+VLFAkzNsJQ7JkwgI+7yx/9J9vVGHXekqUCwB7g
	 y7flp4ielxBGt0Sm/QlBagcett0dpFqtK1AyLT1Awg3DAdarLkCy3Nrht//vvsRo3Q
	 bCQcEqm8GOt+NYZxWhxXD7G+tvLM/JAJb4beGte0qjSNK/ghi5pIz+hmIQnp8bqRhI
	 2+y4ipkRSBBK9J75dARu8nzktn9G9SPeEbBqIWiH+NttSc/+J7usmn5xpwCsY07tuL
	 0MRrpVik21Y2COZAlp68TGl8wjm993OugNeEfDqm4FIl03w5mBTyO55X/NCHIQ6WCf
	 QVmSHHEMFsWyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	geoffreyhe2@gmail.com
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbdev: of: display_timing: fix refcount leak in of_get_display_timings()" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:39:08 -0500
Message-ID: <20260301013908.1699995-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-221792-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: C63541CC590
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From eacf9840ae1285a1ef47eb0ce16d786e542bd4d7 Mon Sep 17 00:00:00 2001
From: Weigang He <geoffreyhe2@gmail.com>
Date: Fri, 16 Jan 2026 09:57:51 +0000
Subject: [PATCH] fbdev: of: display_timing: fix refcount leak in
 of_get_display_timings()

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
---
 drivers/video/of_display_timing.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index bebd371c6b93e..1940c9505dd3b 100644
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





