Return-Path: <stable+bounces-222022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH2/AqGco2l2IQUAu9opvQ
	(envelope-from <stable+bounces-222022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:55:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 795501CC46D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54C6E30AE786
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEDA2E7648;
	Sun,  1 Mar 2026 01:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGp5B7Jk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098C2594B9
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329712; cv=none; b=SBsnjPCAFDhlArUlgHzMFxcreRkiYKTJK73qY6bXfd6PVdJWZpwJW6XDN5d6zNFAMDj8i9qSFM+wF99q4GhDlEdRDAqn5zG+VbpnD6XjxhyQNLzVEjLutcgOys7J+AzH0p6xYt4mIkYLVgWeXBgkhg8lFn5JXPwDeFjrJFJ+pwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329712; c=relaxed/simple;
	bh=GnqiyrPx6H54np56kyfyEaN9ZySH9ie2NjzrGMOZrMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BoHuwVxBpMjTMZPgKj2CYuc9aTgms5ttUnkDmXRcl0LZKxJF5urlrrlAZvKgV3e2+132M5Qv/2q72u9VjG028rOraZd6Fh9JGi8DkyYD96rMLbc9rDsgbrbqh9ROFcwTEu2RYRrZ/wkHFhk0wsnjFwPvfzgZgnvie+paaKr3NcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGp5B7Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AA8C19421;
	Sun,  1 Mar 2026 01:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329712;
	bh=GnqiyrPx6H54np56kyfyEaN9ZySH9ie2NjzrGMOZrMw=;
	h=From:To:Cc:Subject:Date:From;
	b=vGp5B7Jka3rukB9f2fURsBdnxL0Mlek7rZ/t0Xby71h/8FpHxDy/mDfUETCMNNclA
	 nrjVHU51VY5DgewqRhn3XJJJ2R1cq9aQE6LkeCL/l3Rg899NgYZM5MpqwG0NpD4hb0
	 FTh5d/Ft3bbNMjMiwOuADOLfgTaksiETqMYMxzW0GqkxgZ8Dg5izZHO88TlYCvg0VQ
	 b7Kjcsegg+TiyfErc/KmW0XA3HdTejkwQihB+ciVrbhXXJugAZLE0xtznUuiLOTreK
	 LW8fM8pc0J+ulCe3E9XtSBKtobmRR6U0JAi4XobC342G+IaWXuLjBpJpJuagnY+dbI
	 zY1MOi/uJYG8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Yong Wu <yong.wu@mediatek.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "memory: mtk-smi: fix device leak on larb probe" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:48:30 -0500
Message-ID: <20260301014830.1712707-1-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222022-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,mediatek.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 795501CC46D
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9dae65913b32d05dbc8ff4b8a6bf04a0e49a8eb6 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 21 Nov 2025 17:46:23 +0100
Subject: [PATCH] memory: mtk-smi: fix device leak on larb probe

Make sure to drop the reference taken when looking up the SMI device
during larb probe on late probe failure (e.g. probe deferral) and on
driver unbind.

Fixes: cc8bbe1a8312 ("memory: mediatek: Add SMI driver")
Fixes: 038ae37c510f ("memory: mtk-smi: add missing put_device() call in mtk_smi_device_link_common")
Cc: stable@vger.kernel.org	# 4.6: 038ae37c510f
Cc: stable@vger.kernel.org	# 4.6
Cc: Yong Wu <yong.wu@mediatek.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251121164624.13685-3-johan@kernel.org
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/mtk-smi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index dd6150d200e89..3609bfd3c64be 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -685,6 +685,7 @@ static void mtk_smi_larb_remove(struct platform_device *pdev)
 	device_link_remove(&pdev->dev, larb->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
 	component_del(&pdev->dev, &mtk_smi_larb_component_ops);
+	put_device(larb->smi_common_dev);
 }
 
 static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
-- 
2.51.0





