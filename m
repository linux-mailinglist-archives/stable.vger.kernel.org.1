Return-Path: <stable+bounces-260425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S+/4NTxYIWrIEQEAu9opvQ
	(envelope-from <stable+bounces-260425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:49:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7624563F319
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:49:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=d6qJnA+b;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260425-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-260425-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93CCE3039B6C
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DDE38398F;
	Thu,  4 Jun 2026 10:47:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1051F78E6
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:47:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570070; cv=none; b=JfI+tHPQs1mlaqCXPRY0lDl+HPBC6RGmSDOUofZoeKSQvVoQepqC9DwGXGNt7+C5+6L0JrtRLIy3VdEoQUmMqNEtSko37mloquGs1/JzFijn7VM1NlhLJMJ73iBXYWGDqMjUTtxa0FIDD6RxL3MEMdOfMITU0nNF+F+miolu6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570070; c=relaxed/simple;
	bh=O3YDbJW1n5Y1XyHYkFodLCd8KBL1Qns7XG2rsXX5vQk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XZNDcXSF/uE+LpgqKtgv9m/WyyMo4bftfNqN1y3cmqcTbbRe0l+MYEhD/41Umk8mUKUHAgccMDm5ujDQyIKH1nPjGvveal/yCgUYhV6AIilQDu/zErcQCMYhoH8vNQiCnym1SLjOVaXD5xXRargUDuALpu/Sf7mfNHtLCAhaHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d6qJnA+b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CD51F00893;
	Thu,  4 Jun 2026 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570069;
	bh=2WiH86qBrML/4f06Wc5dmlVOPwSfEaa5BToyrs/aJp4=;
	h=Subject:To:Cc:From:Date;
	b=d6qJnA+brFEW7etRVoeivCTe8EuKDlpQ0xQSv3yWSfkcM0eUmDW3ld8vEC1mJROOZ
	 c4X5GBfMCW1QxFBtAgdVFufHnwOpu6dVxMm92b3Jqp63xMJg3/k83FA6oAgClVcqE1
	 J7qQLhOF9EJXc9q+67vYWXWvSuByV1ErwJmjXZrw=
Subject: FAILED: patch "[PATCH] usb: gadget: f_hid: fix device reference leak in hidg_alloc()" failed to apply to 6.1-stable tree
To: lgs201920130244@gmail.com,gregkh@linuxfoundation.org,johan@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:46:52 +0200
Message-ID: <2026060452-vastness-hulk-8040@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260425-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:gregkh@linuxfoundation.org,m:johan@kernel.org,m:stable@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
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
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7624563F319


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4f88d65def6f3c90121601b4f62a4c967f3063a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060452-vastness-hulk-8040@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f88d65def6f3c90121601b4f62a4c967f3063a6 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 13 Apr 2026 22:21:19 +0800
Subject: [PATCH] usb: gadget: f_hid: fix device reference leak in hidg_alloc()

hidg_alloc() initializes hidg->dev with device_initialize() before
calling dev_set_name(). If dev_set_name() fails, the function currently
jumps to err_unlock and returns without calling put_device().

This leaves the device reference unbalanced and prevents hidg_release()
from being called. Calling put_device() here is also safe, since
hidg_release() only frees resources owned by hidg.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Route the dev_set_name() failure path through err_put_device so the
device reference is dropped properly.

Fixes: 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")
Cc: stable <stable@kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Johan Hovold johan@kernel.org
Link: https://patch.msgid.link/20260413142119.2977716-1-lgs201920130244@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index c5a12a6760ea..3c6b43d06a6d 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1622,7 +1622,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
 	if (ret)
-		goto err_unlock;
+		goto err_put_device;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1659,7 +1659,6 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 
 err_put_device:
 	put_device(&hidg->dev);
-err_unlock:
 	mutex_unlock(&opts->lock);
 	return ERR_PTR(ret);
 }


