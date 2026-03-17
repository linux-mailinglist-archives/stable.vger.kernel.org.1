Return-Path: <stable+bounces-226050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOvyAENsuWl6EgIAu9opvQ
	(envelope-from <stable+bounces-226050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:59:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 778722AC8D6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12A5430C7BCC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F93E5ECD;
	Tue, 17 Mar 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LTgoU6WQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209B3C1996
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758742; cv=none; b=FcmZMOdQ98cCGmBKKGjpTuhFRV/2dZ4AH6wPo78By4TXq5TpwPZDlpZxl/HaJvehnWUrIR/yDptAZGLsuRk7rfBC/F5I/lYR4BFqZtRH+rFwmSDxO5kVVI+hDlk7rvh6GCV9qGMktyEf2g9UdKpCa8LRvHLXb4rMkTehnc0K/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758742; c=relaxed/simple;
	bh=RlbHucOz655TIZMBRLFgw5BR/J64cNhEvUjCwf17NhY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jY8hf/oiXg75Y+XAcrbUM209E5h5tOaNDfYoSF/Fk9+DHTTd7Z8T+TQO5CLk7ekX9h9PjBhvemNwdv0+jJ2wGjk8hDGgyNZg0srTz1jaxHBKR5GQvvbFTfZ0kzbVaoKMUshqxB0i7jv/i0u0nWMTT13QdJ9k1GH6liVR8EydKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LTgoU6WQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC0AC4CEF7;
	Tue, 17 Mar 2026 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773758742;
	bh=RlbHucOz655TIZMBRLFgw5BR/J64cNhEvUjCwf17NhY=;
	h=Subject:To:Cc:From:Date:From;
	b=LTgoU6WQSvbRGji2bNYz0xoJEh1LfnHNiqsUkmH9Kz1xkQ4IXNvoHo9p+K601SMxa
	 FKKNMAnocMM50kW9qW72oqZ5bQY8j9K1+P2IHYIsrMRsEGDMhhIr8FvxPSFfagzwtI
	 6h+P/iixWOPeDdcBmti06WkhE4qV04Y8PAeep4W0=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Fix Hot-Join NACK" failed to apply to 6.18-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:45:28 +0100
Message-ID: <2026031728-stinky-support-943e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226050-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,nxp.com:email,gregkh:email,intel.com:email,bootlin.com:email]
X-Rspamd-Queue-Id: 778722AC8D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x fa9586bd77ada1e3861c7bef65f6bb9dcf8d9481
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031728-stinky-support-943e@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa9586bd77ada1e3861c7bef65f6bb9dcf8d9481 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 6 Mar 2026 09:24:39 +0200
Subject: [PATCH] i3c: mipi-i3c-hci: Fix Hot-Join NACK

The MIPI I3C HCI host controller driver does not implement Hot-Join
handling, yet Hot-Join response control defaults to allowing devices to
Hot-Join the bus.  Configure HC_CONTROL_HOT_JOIN_CTRL to NACK all Hot-Join
attempts.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-3-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index dbe93df0c70e..4877a321edf9 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -152,7 +152,8 @@ static int i3c_hci_bus_init(struct i3c_master_controller *m)
 	if (hci->quirks & HCI_QUIRK_RESP_BUF_THLD)
 		amd_set_resp_buf_thld(hci);
 
-	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE);
+	/* Enable bus with Hot-Join disabled */
+	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE | HC_CONTROL_HOT_JOIN_CTRL);
 	dev_dbg(&hci->master.dev, "HC_CONTROL = %#x", reg_read(HC_CONTROL));
 
 	return 0;
@@ -764,7 +765,8 @@ static int i3c_hci_runtime_resume(struct device *dev)
 
 	hci->io->resume(hci);
 
-	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE);
+	/* Enable bus with Hot-Join disabled */
+	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE | HC_CONTROL_HOT_JOIN_CTRL);
 
 	return 0;
 }


