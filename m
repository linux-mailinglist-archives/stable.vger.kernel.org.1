Return-Path: <stable+bounces-269353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HSG/H29nP2p5SwkAu9opvQ
	(envelope-from <stable+bounces-269353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 08:02:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A226D13E6
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 08:02:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=bbPal+EP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269353-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269353-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6E463031AD8
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 06:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AE831619C;
	Sat, 27 Jun 2026 06:02:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m25480.xmail.ntesmail.com (mail-m25480.xmail.ntesmail.com [103.129.254.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6A38D;
	Sat, 27 Jun 2026 06:02:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782540135; cv=none; b=d1tOH3zJ4DphoRXwUOE1AHbxjStEZ0fQMWrXrBqvlTcZvz+UMB8lVRnmNPBf93PAWPhhZlIXCY4ZxVEmMuQ8tvO4yjmFZE/obuACVcm/QsuId8Dq2kwzjAkS8TGcJXwAGp1700KoYo2p8OqWm1C/BX3TmG3NcA3ZAVh+SlNXIks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782540135; c=relaxed/simple;
	bh=RDp+J++cMiM5EXpN1DVkoOqPgcThQ/SSI7QkoKnwB8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F3n/k69AO3eOnJTYLvRKdiWX+CuOB26wIf9PbOCe0M6UhlgaGVM0KI0zb5ib6okHLTils5WJA5kvH0fcV7aHt6PLOSY/61MzwiElo2PcooE4doBMUTlFjoRa07r6Zf1HrPjT5PzISF4/EM/wPwSWPRVILcMAGz/fR92R9MejX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=bbPal+EP; arc=none smtp.client-ip=103.129.254.80
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43fb5734c;
	Sat, 27 Jun 2026 14:02:06 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org,
	linusw@kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	zilin@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: free iso schedules on failed submit
Date: Sat, 27 Jun 2026 14:02:07 +0800
Message-Id: <20260627060207.2543749-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f07abc88c03a2kunmb178c0f5ebeef
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSh8eVk1OQ0xNSExPTR9CGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=bbPal+EP/on1mILwQBWEofyBSBf7jEbF/Zvy5P6+rF+XuUKhMNsrHfvbWBj43AkC94E9dyJFo0GwCRP7mUO7VKRowvm8pXzEXRblxEQEuzkHBHt13k7wa57NrN0CUuibDjBVf5+wkRrg3CgdHwyC0e2o36ATkbsZc3j6wz+0BNw=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=P/28q1bQb5ROyksuFPBg9FZKSgb/MWwXMwuiu/ZP2vU=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stern@rowland.harvard.edu,m:gregkh@linuxfoundation.org,m:linusw@kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:dawei.feng@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269353-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2A226D13E6

EHCI and FOTG210 isochronous submits build an ehci_iso_sched before
linking the URB to the endpoint queue, and keep the staged schedule in
urb->hcpriv until iso_stream_schedule() and the link helpers consume it.
If the controller is no longer accessible, or usb_hcd_link_urb_to_ep()
fails, submit jumps to done_not_linked before that handoff happens and
leaks the staged schedule still attached to urb->hcpriv.

Free the staged schedule from done_not_linked when submit fails before
the URB is linked and clear urb->hcpriv after the free.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1.1.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
EHCI host controller with a USB isochronous device to test with, no
runtime testing was able to be performed.

Fixes: 8de98402652c ("[PATCH] USB: Fix USB suspend/resume crasher (#2)")
Fixes: e9df41c5c589 ("USB: make HCDs responsible for managing endpoint queues")
Fixes: 7d50195f6c50 ("usb: host: Faraday fotg210-hcd driver")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/usb/fotg210/fotg210-hcd.c | 4 ++++
 drivers/usb/host/ehci-sched.c     | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 1a48329a4e08..d92b11d488a5 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -4562,6 +4562,10 @@ static int itd_submit(struct fotg210_hcd *fotg210, struct urb *urb,
 	else
 		usb_hcd_unlink_urb_from_ep(fotg210_to_hcd(fotg210), urb);
 done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&fotg210->lock, flags);
 done:
 	return status;
diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index a241337c9af8..33a0111cfb37 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1966,6 +1966,10 @@ static int itd_submit(struct ehci_hcd *ehci, struct urb *urb,
 		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
 	}
  done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&ehci->lock, flags);
  done:
 	return status;
@@ -2343,6 +2347,10 @@ static int sitd_submit(struct ehci_hcd *ehci, struct urb *urb,
 		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
 	}
  done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&ehci->lock, flags);
  done:
 	return status;
-- 
2.34.1


