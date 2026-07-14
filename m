Return-Path: <stable+bounces-274452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NSxPE8NoVmoZ5AAAu9opvQ
	(envelope-from <stable+bounces-274452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:50:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88820757141
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:50:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CsFxtUgm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274452-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274452-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98DAC30135D9
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC84A37CD27;
	Tue, 14 Jul 2026 16:50:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539B285CA2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:50:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047805; cv=none; b=RmPadRL9Ji5dlqKKOpcENkAyLEfNYmLf5TDlxL01W/w92joPe73nyf5UZZwHj9OgnqLehBKrMqIRGMmD9Uvx7z92wFoZCmPROFlJPLsaWoCUwvbn865maMKCfOw6vLxbV/0XhslzkfxL2U7cplDD+PPTLJFF9Hj9OlO7E2SWTu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047805; c=relaxed/simple;
	bh=VcpUxW+ltp2u5qre11CBv5BI7BpHR1bl8WlW2//dVNQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VmlWp5CXIdp+m8YnDIqvqKvOigz8pq4PdW+hMb8I0cNANmkrT/+d3CLHbDIDDN3VRTKmYF9EieBWrcgQzsVxXAdW56z8/xpRa2Jy32qQqajGJZOSMuGNazttA3QtnouF2xOjbg9qossaixU0RAd/B/hB4WyCjwiCA3poK9db+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CsFxtUgm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761151F000E9;
	Tue, 14 Jul 2026 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784047804;
	bh=wC9IW29aT5eYmDJyRIqJAXNW3soe71PE2txF2JeyPqs=;
	h=Subject:To:Cc:From:Date;
	b=CsFxtUgmNqLeXwAr4x3ADW16NM/25/Mm8J9EHtYNqgIbvlfgOq7WpThv3fediBfqU
	 OmQ84SFvZk8575zEtXeDmp+F3+dd6WooiMnZ2FNXXcUGprZTQqeiyPp6ej8awUSoey
	 VOi1ZJ/5N36Rl5k9TZSPiXdjQTQeZU3pLNtsBtxQ=
Subject: FAILED: patch "[PATCH] usb: gadget: f_fs: initialize reset_work at allocation time" failed to apply to 6.12-stable tree
To: tyler.baker@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,loic.poulain@oss.qualcomm.com,mina86@mina86.com,peter.chen@kernel.org,srinivas.kandagatla@oss.qualcomm.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:49:55 +0200
Message-ID: <2026071455-slacker-valium-0309@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274452-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tyler.baker@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:gregkh@linuxfoundation.org,m:loic.poulain@oss.qualcomm.com,m:mina86@mina86.com,m:peter.chen@kernel.org,m:srinivas.kandagatla@oss.qualcomm.com,m:stable@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:from_mime,linuxfoundation.org:email,linuxfoundation.org:dkim,gregkh:mid,qualcomm.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88820757141


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3137b243c93982fe3460335e12f9247739766e10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071455-slacker-valium-0309@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3137b243c93982fe3460335e12f9247739766e10 Mon Sep 17 00:00:00 2001
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 15:36:34 -0400
Subject: [PATCH] usb: gadget: f_fs: initialize reset_work at allocation time
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ffs_fs_kill_sb() unconditionally calls cancel_work_sync() on
ffs->reset_work when a functionfs instance is unmounted:

	ffs_data_reset(ffs);
	cancel_work_sync(&ffs->reset_work);

However ffs->reset_work is only ever initialized via INIT_WORK() in
ffs_func_set_alt() and ffs_func_disable(), and only on the
FFS_DEACTIVATED path. That state is reached solely by ffs_data_closed()
when the instance is mounted with the "no_disconnect" option, so for the
common case (no "no_disconnect", or mounted and unmounted without ever
being deactivated) reset_work is never initialized.

ffs_data_new() allocates the ffs_data with kzalloc_obj() and does not
initialize reset_work, and ffs_data_reset()/ffs_data_clear() do not touch
it either, so reset_work.func is left NULL. cancel_work_sync() on such a
work then trips the WARN_ON(!work->func) guard in __flush_work():

  WARNING: kernel/workqueue.c:4301 at __flush_work+0x330/0x360, CPU#3: umount
  Call trace:
   __flush_work
   cancel_work_sync
   ffs_fs_kill_sb [usb_f_fs]
   deactivate_locked_super
   deactivate_super
   cleanup_mnt
   __cleanup_mnt
   task_work_run
   exit_to_user_mode_loop
   el0_svc

On older kernels cancel_work_sync() on a zero-initialized work struct was
a silent no-op, which hid the missing initialization.

Initialize reset_work once in ffs_data_new() so it is always valid for
the lifetime of the ffs_data, and drop the now-redundant INIT_WORK()
calls from the two deactivation paths.

Fixes: 18d6b32fca38 ("usb: gadget: f_fs: add "no_disconnect" mode")
Cc: stable <stable@kernel.org>
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Peter Chen <peter.chen@kernel.org>
Acked-by: Michał Nazarewicz <mina86@mina86.com>
Link: https://patch.msgid.link/20260609193635.2284430-1-tyler.baker@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 7cc446502980..745c44d251f7 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -288,6 +288,7 @@ static int ffs_acquire_dev(const char *dev_name, struct ffs_data *ffs_data);
 static void ffs_release_dev(struct ffs_dev *ffs_dev);
 static int ffs_ready(struct ffs_data *ffs);
 static void ffs_closed(struct ffs_data *ffs);
+static void ffs_reset_work(struct work_struct *work);
 
 /* Misc helper functions ****************************************************/
 
@@ -2222,6 +2223,7 @@ static struct ffs_data *ffs_data_new(const char *dev_name)
 	init_waitqueue_head(&ffs->ev.waitq);
 	init_waitqueue_head(&ffs->wait);
 	init_completion(&ffs->ep0req_completion);
+	INIT_WORK(&ffs->reset_work, ffs_reset_work);
 
 	/* XXX REVISIT need to update it in some places, or do we? */
 	ffs->ev.can_stall = 1;
@@ -3776,7 +3778,6 @@ static int ffs_func_set_alt(struct usb_function *f,
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
 		spin_unlock_irqrestore(&ffs->eps_lock, flags);
-		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return -ENODEV;
 	}
@@ -3807,7 +3808,6 @@ static void ffs_func_disable(struct usb_function *f)
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
 		spin_unlock_irqrestore(&ffs->eps_lock, flags);
-		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return;
 	}


