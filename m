Return-Path: <stable+bounces-222324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBUvK+Kjo2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:26:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E881CD8C8
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF4FF353671E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0292C2FE59C;
	Sun,  1 Mar 2026 02:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCXgYwMd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973C2FC011;
	Sun,  1 Mar 2026 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330598; cv=none; b=LF55Qg6PmeMETOcF9wHJryGyWxLM0ttbh2g3+Zm1R+HDcmwQzQWQbRlZyRAphfgsjycdi7fW8uBSLtysTVMv9yNsELFhOnMbVMdAn3SWJQFTMUcdy0EdEy15iTOVciDnI8xQQ7wpWs6L2PYF4HkS07j0K1+3rw9jDXFWOPqnA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330598; c=relaxed/simple;
	bh=Ab15j7H21BT3eK7YbjkUq4fU6YmYPpWrDF2PCJMGp9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZwBtZGSxm1E1BHXHXbuluG5Mib8ktYlpcIW1KEepLShi4IA441H7ToSrXOrvIC+Cp7X2CWCNLDru+W4OogxzykbHLNLP5FVHGcFpn3Y5OCk8yf+O2Q0S+UZjCHAmIMqzq8ZPJOwu0yXe3a7xbfEJKs3vWVCvE+zSs6KxY0EVfok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCXgYwMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AECCC19425;
	Sun,  1 Mar 2026 02:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330598;
	bh=Ab15j7H21BT3eK7YbjkUq4fU6YmYPpWrDF2PCJMGp9g=;
	h=From:To:Cc:Subject:Date:From;
	b=WCXgYwMd/b5L5N6Rja4KDXaWLv5rUUboW8rz5w+vZKE/AdF9rWA0kiqhbca/Qae/I
	 lDa3TtvP3K887lu0SzBGNl6Iorh/u87EbXmg+UmQllGkRKE3XA8KgYM4VnLnt5DVTA
	 CLqESEAfD8lonHycJrbUOyXJcJyKV1xVnOqRP9CyXnWq8jkvni8jZmHPijG0VQ5rdv
	 qCXPYiEVM+1ed9Sp7Ebn1ZR3H0Pg1jrwxJv3zUpvxLCFLSKNVxTHsnE6oDDungb4AA
	 ev0rxQxX6cPE7og7c7lzTRiIx2mclq11XTxjTiOs2Le54f7Vy4tV84DwKduROcFzfQ
	 Mk8Axv/7IFv8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jszhang@kernel.org
Cc: stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: FAILED: Patch "usb: dwc2: fix resume failure if dr_mode is host" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:03:16 -0500
Message-ID: <20260301020316.1731307-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222324-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 06E881CD8C8
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a52e4f2dff413b58c7200e89bb6540bd995e1269 Mon Sep 17 00:00:00 2001
From: Jisheng Zhang <jszhang@kernel.org>
Date: Thu, 29 Jan 2026 10:15:34 +0800
Subject: [PATCH] usb: dwc2: fix resume failure if dr_mode is host

commit 13b1f8e25bfd1 ("usb: dwc2: Force mode optimizations") removed the
dwc2_force_mode(hsotg, true) in dwc2_force_dr_mode() if dr_mode is host.

But this brings a bug: the controller fails to resume back as host,
further debugging shows that the controller is resumed as peripheral.
The reason is dwc2_force_dr_mode() missed the host mode forcing, and
when resuming from s2ram, GINTSTS is 0 by default, dwc2_is_device_mode
in dwc2_resume() misreads this as the controller is in peripheral mode.

Fix the resume failure by adding back the dwc2_force_mode(hsotg, true).

Then an obvious question is: why this bug hasn't been observed and fixed
for about six years? There are two resons: most dwc2 platforms set the
dr_mode as otg; Some platforms don't have suspend & resume support yet.

Fixes: 13b1f8e25bfd1 ("usb: dwc2: Force mode optimizations")
Cc: stable <stable@kernel.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Link: https://patch.msgid.link/20260129021534.10411-1-jszhang@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index c3d24312db0fe..f375c5185bfe2 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -578,6 +578,7 @@ void dwc2_force_dr_mode(struct dwc2_hsotg *hsotg)
 {
 	switch (hsotg->dr_mode) {
 	case USB_DR_MODE_HOST:
+		dwc2_force_mode(hsotg, true);
 		/*
 		 * NOTE: This is required for some rockchip soc based
 		 * platforms on their host-only dwc2.
-- 
2.51.0





