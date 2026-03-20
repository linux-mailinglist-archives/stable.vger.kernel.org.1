Return-Path: <stable+bounces-227467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO6lAvUKvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:53:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA612D7873
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B75430F8311
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D53624A7;
	Fri, 20 Mar 2026 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XtX5pFrO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72B2E7621
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996481; cv=none; b=egaT+wzjjeHdmETEq6nJgHKl701NtYPrxdB+jy58sF8aXuGM35r4+Jlwf2W7XMkfnUp//OpBGbytr6cl3O94q1KOPzuUUVEm1L38v2zuljmkKryGSMMFKEE/IdtrDZgQv81PFjyptZGbaQLhyqil47C0zujpnj77qDWceVKvwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996481; c=relaxed/simple;
	bh=FrbzmRQA684c/XuC9UeSv3HY5asnFY4jocyEeDHZrT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IMe15RWnrWpS/H9YC4HDzaPDSppR7MYNshPuehE4FITm1mhI19U/qtAEywLtRbXYBCxqll+n9lK5XxbLI2bmnQSyrfnXr3lzPv+GI1p56pxmLIXitNskPeBcld6hxo3P6FPW4Qx3MrbmBTaw3HU2momFBM5tsgZlaxF+hhtmFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XtX5pFrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27D6C4CEF7;
	Fri, 20 Mar 2026 08:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773996481;
	bh=FrbzmRQA684c/XuC9UeSv3HY5asnFY4jocyEeDHZrT4=;
	h=Subject:To:Cc:From:Date:From;
	b=XtX5pFrO7G8M2yzhifpRNyiouiB5EaywmFP4EjbmRqyGgqNDYXZyc2ULXXdj9u0Xl
	 E/OMSzY2krzvtsHOJVEBMTfKW568F3DqK324yKKb7xU5FSFpTluFGhjhSJ/CtFylBj
	 L0cQCmDz4WHYeiJXaoIfpydaT9B417JqyujI61jI=
Subject: FAILED: patch "[PATCH] HID: appletb-kbd: add .resume method in PM" failed to apply to 6.12-stable tree
To: gargaditya08@live.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Mar 2026 09:47:53 +0100
Message-ID: <2026032053-reviver-stock-9da2@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227467-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[live.com,suse.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.902];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 9AA612D7873
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1965445e13c09b79932ca8154977b4408cb9610c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032053-reviver-stock-9da2@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1965445e13c09b79932ca8154977b4408cb9610c Mon Sep 17 00:00:00 2001
From: Aditya Garg <gargaditya08@live.com>
Date: Tue, 17 Feb 2026 02:54:46 +0530
Subject: [PATCH] HID: appletb-kbd: add .resume method in PM

Upon resuming from suspend, the Touch Bar driver was missing a resume
method in order to restore the original mode the Touch Bar was on before
suspending. It is the same as the reset_resume method.

[jkosina@suse.com: rebased on top of the pm_ptr() conversion]
Cc: stable@vger.kernel.org
Signed-off-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index a1db3b3d0667..0fdc0968b9ef 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -476,7 +476,7 @@ static int appletb_kbd_suspend(struct hid_device *hdev, pm_message_t msg)
 	return 0;
 }
 
-static int appletb_kbd_reset_resume(struct hid_device *hdev)
+static int appletb_kbd_resume(struct hid_device *hdev)
 {
 	struct appletb_kbd *kbd = hid_get_drvdata(hdev);
 
@@ -500,7 +500,8 @@ static struct hid_driver appletb_kbd_hid_driver = {
 	.event = appletb_kbd_hid_event,
 	.input_configured = appletb_kbd_input_configured,
 	.suspend = pm_ptr(appletb_kbd_suspend),
-	.reset_resume = pm_ptr(appletb_kbd_reset_resume),
+	.resume = pm_ptr(appletb_kbd_resume),
+	.reset_resume = pm_ptr(appletb_kbd_resume),
 	.driver.dev_groups = appletb_kbd_groups,
 };
 module_hid_driver(appletb_kbd_hid_driver);


