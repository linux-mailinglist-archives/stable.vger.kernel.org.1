Return-Path: <stable+bounces-221451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPF2BBWlo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:31:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6D1CDA4F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACFF430BAD69
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C27280A56;
	Sun,  1 Mar 2026 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdGK41hs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACE02727EB;
	Sun,  1 Mar 2026 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328298; cv=none; b=QlEffPOWNeqNTTUNvGZSidjq4FWUytFVbJkqI5KjS1XwCcqvaXHJFNXfNcvUTp7w9uCI0SC8xW9iJibJiE6MeHyJhEs7ztUxJHOZlWdAWl8dHpB7te2zRdpNfXq0R2XLCGWJVrhjliHRN+JphUhcPgRXQ8HRT9Bk7s3cxr6aEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328298; c=relaxed/simple;
	bh=0Surn+6AK3yk3KWXtwc2Qa3xSwjSCqTcIj9Zt61HVSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GoE+w7L3XreRwpCKipH0ZA/cG5B7FQcWirTgC/Fm14LkgY9EpxcWxta7H0Ym+//VHsxEdklqmemJifxHTaPf4oL/iVe22B9t7vXRoYPikZ95eMNj21Lzg+pTUcLOL+cIgvsdnRM/wbSxYeNmo+nR01z87mTvhzHIfuMwCZcasQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdGK41hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720CEC2BC86;
	Sun,  1 Mar 2026 01:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328298;
	bh=0Surn+6AK3yk3KWXtwc2Qa3xSwjSCqTcIj9Zt61HVSc=;
	h=From:To:Cc:Subject:Date:From;
	b=HdGK41hs8RV1BErIRzPGcv9EwaCTmaPudr+vcz1vkHkftpN++qbeRhzjt2TlX3umd
	 tOx+LNbKCykguS8RPRI7mNsdlRJJwUWEq25LZTnaTpDlK5DOcoL95zq0wvFFNh04n5
	 7nTBsN2tokry9b5kSeVZk0uJnRFFZoSdBgse7VJ/gGA8Yr0Diz39efY85gPUHgOitY
	 TemRC8xvELu8Dzglj2g8Q5ZITZq84UnnHG71mpiQ/IOetbu/GvKsrhyax2Rz3l+JcQ
	 O1rg3t0OpfOpWIjEn5auD79G2a8uM8dW4+ZwPDAFjES+z27oPOt5TzmSFZbuQNhwEe
	 2uhUjOsA1W8cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	aha310510@gmail.com
Cc: Inki Dae <inki.dae@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: FAILED: Patch "drm/exynos: vidi: fix to avoid directly dereferencing user pointer" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:24:56 -0500
Message-ID: <20260301012456.1681912-1-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221451-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 93B6D1CDA4F
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d4c98c077c7fb2dfdece7d605e694b5ea2665085 Mon Sep 17 00:00:00 2001
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 19 Jan 2026 17:25:52 +0900
Subject: [PATCH] drm/exynos: vidi: fix to avoid directly dereferencing user
 pointer

In vidi_connection_ioctl(), vidi->edid(user pointer) is directly
dereferenced in the kernel.

This allows arbitrary kernel memory access from the user space, so instead
of directly accessing the user pointer in the kernel, we should modify it
to copy edid to kernel memory using copy_from_user() and use it.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 480c99a8f9f75..9709c07e5d8f4 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -252,13 +252,27 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 
 	if (vidi->connection) {
 		const struct drm_edid *drm_edid;
-		const struct edid *raw_edid;
+		const void __user *edid_userptr = u64_to_user_ptr(vidi->edid);
+		void *edid_buf;
+		struct edid hdr;
 		size_t size;
 
-		raw_edid = (const struct edid *)(unsigned long)vidi->edid;
-		size = (raw_edid->extensions + 1) * EDID_LENGTH;
+		if (copy_from_user(&hdr, edid_userptr, sizeof(hdr)))
+			return -EFAULT;
 
-		drm_edid = drm_edid_alloc(raw_edid, size);
+		size = (hdr.extensions + 1) * EDID_LENGTH;
+
+		edid_buf = kmalloc(size, GFP_KERNEL);
+		if (!edid_buf)
+			return -ENOMEM;
+
+		if (copy_from_user(edid_buf, edid_userptr, size)) {
+			kfree(edid_buf);
+			return -EFAULT;
+		}
+
+		drm_edid = drm_edid_alloc(edid_buf, size);
+		kfree(edid_buf);
 		if (!drm_edid)
 			return -ENOMEM;
 
-- 
2.51.0





