Return-Path: <stable+bounces-222269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKBaNhyjo2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:23:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42D1CD825
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E24534CD550
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8A22673AA;
	Sun,  1 Mar 2026 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoW/duLL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2761190664
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330455; cv=none; b=Zd3QzGAFbDAV8/cA7kBZL8FsysbIdp5TzvPPro3/OfMhHRRkq4hV3Q1K0/8KZ0KpUYp6AcIAZiWfDmAcWsmbTjgD026+74ULCAtwynjDfljJLZPlTM+PWasl23snKLZ6fLesWD0ZOw+7prizE/N1PqpUe1cmLyO08UrYx18h3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330455; c=relaxed/simple;
	bh=sfpiuxyMyhOg55SUk2UWzh/KW0zWseTzzIvgv+ooAW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDmSThnNvHqlIH0GqfN5OqcxmD3w8HPkvPCiqIepDEgWBxiaCDLVz+ukamHTFLd9amn5EcgvpnPO7h1t1PG/yApEbpjlRvFcDwD9TST63DF5K2mAB6bLDJl9Irg4dplMpksAZ7zs9zq3CszvqCo5HqJ2oq9fVImQ8Fmq7bc5Gak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoW/duLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B66C19421;
	Sun,  1 Mar 2026 02:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330455;
	bh=sfpiuxyMyhOg55SUk2UWzh/KW0zWseTzzIvgv+ooAW8=;
	h=From:To:Cc:Subject:Date:From;
	b=aoW/duLLEm6YO69hDkLZjJrGYGH9OTKlShLpn7t8/W7uMvag7NzjN4CnCKdg2HpwV
	 BCa++IxYMj5XuwjWCfB2PP23UZ89iZJR1Nsn965ujSuAC6AxSLv5ZFdt3Odr+uvsjm
	 nad+Wb2igYgojkzOU/jlktZhlITbqhDE5YpU1CStLGaO8hwQ4TqQ7Vv4v11vX7BadE
	 xWlbDh8vwK0g8nJIt52jNEbSa0ZXw2FtdP4y5uYaGDmmWTexsXtsYDDauF3uB3nYdn
	 /s3oKGLlltPZXAldE29UZBAbTenZYZWTTnOfhMvP49ljiZYd2rR6hJ1FrOtQbQlfVH
	 5XGcZ+xDPFAbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	joonwonkang@google.com
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Subject: FAILED: Patch "mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:00:53 -0500
Message-ID: <20260301020054.1727820-1-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222269-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F42D1CD825
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fcd7f96c783626c07ee3ed75fa3739a8a2052310 Mon Sep 17 00:00:00 2001
From: Joonwon Kang <joonwonkang@google.com>
Date: Wed, 26 Nov 2025 06:22:50 +0000
Subject: [PATCH] mailbox: Prevent out-of-bounds access in
 fw_mbox_index_xlate()

Although it is guided that `#mbox-cells` must be at least 1, there are
many instances of `#mbox-cells = <0>;` in the device tree. If that is
the case and the corresponding mailbox controller does not provide
`fw_xlate` and of_xlate` function pointers, `fw_mbox_index_xlate()` will
be used by default and out-of-bounds accesses could occur due to lack of
bounds check in that function.

Cc: stable@vger.kernel.org
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/mailbox/mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 2acc6ec229a45..617ba505691d3 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -489,12 +489,10 @@ EXPORT_SYMBOL_GPL(mbox_free_channel);
 static struct mbox_chan *fw_mbox_index_xlate(struct mbox_controller *mbox,
 					     const struct fwnode_reference_args *sp)
 {
-	int ind = sp->args[0];
-
-	if (ind >= mbox->num_chans)
+	if (sp->nargs < 1 || sp->args[0] >= mbox->num_chans)
 		return ERR_PTR(-EINVAL);
 
-	return &mbox->chans[ind];
+	return &mbox->chans[sp->args[0]];
 }
 
 /**
-- 
2.51.0





