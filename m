Return-Path: <stable+bounces-221649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHwgE3mno2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:42:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE6B1CDD1E
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D01D308B74E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25458430B90;
	Sun,  1 Mar 2026 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZlOP1Pb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A02E5B09
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328796; cv=none; b=QyGx0iiSf9neQTgn/8c6uCISRV8sMdeD087sPpfRiYLuza8mtcd0nkeoJwnlMelPnilEp9uZR/WRX0ypUGHQ2gDPeZMkwIblWmmphOEheLZtCkTD7GWdqLoisLeP0l083BGUmmqPgq0dzMIOQRdwWveo/lIJCTLINpd1ScvvUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328796; c=relaxed/simple;
	bh=0dTawaciay8IXWhemM5UxTkyeZnSOAJHrTyPACbEs/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0kZkUHu/QJLaULQxDRyoETdVlGt527RhQ0w/Fh/cJaWAnvxAI3ClAEa1OUekeI+q9dTOgEH/pALRFCi+vNaj3NiJPX4A8vn5ivdllrodsvMy09jFJl8zVEbvD+JcfJuD3wEueBp0UC5N2GI8Mcj44509yVnCaSTcyHTQMxSigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZlOP1Pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6322AC19421;
	Sun,  1 Mar 2026 01:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328796;
	bh=0dTawaciay8IXWhemM5UxTkyeZnSOAJHrTyPACbEs/s=;
	h=From:To:Cc:Subject:Date:From;
	b=OZlOP1PbhCv/kN6R+UKb3Fu+dsvgJejoDkEnyZ5PXvTP3yrwrHA0jbwZRblMqW4My
	 RfYuxMQs+zTKxdhIYmNeB8T5W5KLj6xNICoB9veSvh6auUcJTSjx00IYKDt6hDFBeC
	 svkUF1QsFyHY89VlL/v19MGVSEOh7dznq4jMN24a20e/sgYUvce11lbjMQDYKZSLfX
	 1tP2guvOAUthYLGHd/eymWb3Yy0ClmVoCS+T3Sfpl+h6CRXRUyzoZrjNk4+hklaM0I
	 EpE6aULylflQda1YhnqKUCBHWPtrpLQaU92fy0ytYgTcE5DMDlVMV6S0NWlY1lBm4W
	 qaSG6TIKQUBCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	joonwonkang@google.com
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Subject: FAILED: Patch "mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:33:15 -0500
Message-ID: <20260301013315.1692451-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-221649-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: CAE6B1CDD1E
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
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





