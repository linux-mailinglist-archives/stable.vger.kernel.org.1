Return-Path: <stable+bounces-242280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGaJFH+H9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:59:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E034ABCD0
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEBAC300A60F
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 10:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5683932CC;
	Fri,  1 May 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z0fbez9c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43040384238
	for <stable@vger.kernel.org>; Fri,  1 May 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633143; cv=none; b=a2Kt88oifA3v8jDb8DLyel/X3qp+Rh5diqMNQBOqQe2L2jzxnoQpaK4IoiHFCcOiiVwRcc3AKX8sRK7B7m5C5YbH+wTSSzYRHPyho/TBTNb/OCBuiyDvAR/7OUuYWNLwUmEjaV7uSyoESH7vRw/uCFeeQOkykxHCrXubf26EBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633143; c=relaxed/simple;
	bh=sBDEpFrIih55zGdA1p9lIKl6Q4efu94Qhzzo377V2Z0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZQK+VIY/DfYZFu00rg1kZCEgKZMolszUXfwVPlPoHH9lXty7Y3dgDxqtK7RfSzURkXjK20jdTNyFVx/wFRVLJDC0dMEU9gntlg2g/INUCleY/UQdCRY2LRck/FhwEqg5oYdx/0oExTS971+B2syDL7GCrVemtXdVdjujH2qIeCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z0fbez9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C98C2BCB4;
	Fri,  1 May 2026 10:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777633142;
	bh=sBDEpFrIih55zGdA1p9lIKl6Q4efu94Qhzzo377V2Z0=;
	h=Subject:To:Cc:From:Date:From;
	b=Z0fbez9cvLvvsiYY1lAc+d25irSI2IfP68HOh06Rfo3lGju4vdVSDzwpQF8hjMyEn
	 IWxshvQc6tcAJUjtQwY1zy/U5d51bTSibxGaN6uMSJkersosSQbTmsG5AYKNau6huV
	 mo4j1MHWTvHSDmNG4MV6RKjKOkks8xLh6OpDmOfs=
Subject: FAILED: patch "[PATCH] ipmi:ssif: Clean up kthread on errors" failed to apply to 5.10-stable tree
To: corey@minyard.net,252270051@hdu.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 12:58:48 +0200
Message-ID: <2026050148-irregular-kite-7f24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C3E034ABCD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242280-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,hdu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 75c486cb1bcaa1a3ec3a6438498176a3a4998ae4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050148-irregular-kite-7f24@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75c486cb1bcaa1a3ec3a6438498176a3a4998ae4 Mon Sep 17 00:00:00 2001
From: Corey Minyard <corey@minyard.net>
Date: Mon, 13 Apr 2026 08:00:23 -0500
Subject: [PATCH] ipmi:ssif: Clean up kthread on errors

If an error occurs after the ssif kthread is created, but before the
main IPMI code starts the ssif interface, the ssif kthread will not
be stopped.

So make sure the kthread is stopped on an error condition if it is
running.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")
Reported-by: Li Xiao <<252270051@hdu.edu.cn>
Cc: stable@vger.kernel.org
Reviewed-by: Li Xiao <252270051@hdu.edu.cn>
Signed-off-by: Corey Minyard <corey@minyard.net>

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index ce918fe987c6..b49500a1bd36 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1268,8 +1268,10 @@ static void shutdown_ssif(void *send_info)
 	ssif_info->stopping = true;
 	timer_delete_sync(&ssif_info->watch_timer);
 	timer_delete_sync(&ssif_info->retry_timer);
-	if (ssif_info->thread)
+	if (ssif_info->thread) {
 		kthread_stop(ssif_info->thread);
+		ssif_info->thread = NULL;
+	}
 }
 
 static void ssif_remove(struct i2c_client *client)
@@ -1912,6 +1914,15 @@ static int ssif_probe(struct i2c_client *client)
 
  out:
 	if (rv) {
+		/*
+		 * If ipmi_register_smi() starts the interface, it will
+		 * call shutdown and that will free the thread and set
+		 * it to NULL.  Otherwise it must be freed here.
+		 */
+		if (ssif_info->thread) {
+			kthread_stop(ssif_info->thread);
+			ssif_info->thread = NULL;
+		}
 		if (addr_info)
 			addr_info->client = NULL;
 


