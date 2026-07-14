Return-Path: <stable+bounces-274418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8XdfKrpdVmqN4AAAu9opvQ
	(envelope-from <stable+bounces-274418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:03:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A732756C40
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:03:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qEDrBK+C;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274418-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274418-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C2743028C28
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD114A340F;
	Tue, 14 Jul 2026 16:02:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564FD3890E0
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:02:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044961; cv=none; b=jetrTnVGjRqZpAmZnK2SR99pOD2P7Daf7i2hihJykdz0Qqzb65T+4vIeARX+EZsWhCbrQlOdNBlrehCjhDyiun6i7ooZGsNm5DrIwfvWLcj/3tKcwSRydHKNumAfqH1wP8MtLFuzVgk0kdVPiouhhsdL01c52eOB0IrMT3JrUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044961; c=relaxed/simple;
	bh=hByhfpvijs+grwgnqAAh+os/ZOGEHFK5+as4pBzgwKU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H3NiqJdMAKBhfqH0/Cv4lfgZ7BtFF5myzXCZMzCEKE2jEEauDUoNHENT8nuuh164qYpTRSDqvznV4cl5uEUTfJquzvKMtmWeIPi9GvC0mJpS47N1QGEsUz9UoFpoQXL16GrlGgDUBImtCYFP0e5ZK9QRLsQLfyrJZw0vhh7A6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qEDrBK+C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECE41F000E9;
	Tue, 14 Jul 2026 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044959;
	bh=bh1IiZ+zC/3hznHUKOxZL45ypq+JDeOPDinUueQYeoY=;
	h=Subject:To:Cc:From:Date;
	b=qEDrBK+CgK/nGf0fSDw1Za4Pngt8cIIRMm1G8bmQ5Js9/c6a9Be670OZ8AjrryakR
	 BSap4Yzo6AEdGg2IeMgEajEkOxgqZQRX22DoC0hJKjXbyeNwalxbQf07LxKpMeL0KN
	 TLFFb2F7+NLapxO4eTXTpdqkG0ICW49E4O842LME=
Subject: FAILED: patch "[PATCH] usb: free iso schedules on failed submit" failed to apply to 6.1-stable tree
To: dawei.feng@seu.edu.cn,gregkh@linuxfoundation.org,stable@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:02:33 +0200
Message-ID: <2026071433-debating-yonder-99d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274418-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:gregkh@linuxfoundation.org,m:stable@kernel.org,m:stern@rowland.harvard.edu,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:from_mime,linuxfoundation.org:email,linuxfoundation.org:dkim,msgid.link:url,gregkh:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A732756C40


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b9399d25fbb34a05bbe76eeedd730f62ff2670e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071433-debating-yonder-99d6@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b9399d25fbb34a05bbe76eeedd730f62ff2670e9 Mon Sep 17 00:00:00 2001
From: Dawei Feng <dawei.feng@seu.edu.cn>
Date: Tue, 30 Jun 2026 15:14:19 +0800
Subject: [PATCH] usb: free iso schedules on failed submit

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
Cc: stable <stable@kernel.org>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260630071419.349161-1-dawei.feng@seu.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 1a48329a4e08..956be5b56510 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -4267,8 +4267,6 @@ static int iso_stream_schedule(struct fotg210_hcd *fotg210, struct urb *urb,
 	return 0;
 
 fail:
-	iso_sched_free(stream, sched);
-	urb->hcpriv = NULL;
 	return status;
 }
 
@@ -4562,6 +4560,10 @@ static int itd_submit(struct fotg210_hcd *fotg210, struct urb *urb,
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
index a241337c9af8..57d07d1c2dfa 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1623,6 +1623,7 @@ iso_stream_schedule(
 			status = 1;	/* and give it back immediately */
 			iso_sched_free(stream, sched);
 			sched = NULL;
+			urb->hcpriv = NULL;
 		}
 	}
 	urb->error_count = skip / period;
@@ -1653,8 +1654,6 @@ iso_stream_schedule(
 	return status;
 
  fail:
-	iso_sched_free(stream, sched);
-	urb->hcpriv = NULL;
 	return status;
 }
 
@@ -1966,6 +1965,10 @@ static int itd_submit(struct ehci_hcd *ehci, struct urb *urb,
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
@@ -2343,6 +2346,10 @@ static int sitd_submit(struct ehci_hcd *ehci, struct urb *urb,
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


