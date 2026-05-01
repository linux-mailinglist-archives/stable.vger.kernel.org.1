Return-Path: <stable+bounces-242281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON62I4OH9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:59:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 319234ABCD7
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56764300F5E6
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 10:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D263939AE;
	Fri,  1 May 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rVkaPZki"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C9384238
	for <stable@vger.kernel.org>; Fri,  1 May 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633145; cv=none; b=p7YSFj84xskaD8gGJpe3mfpMiNouMEKvaM/rtomAlMO/zWxR3UjgzdK1MYB5RMhP59GfDQh5ptFasvIBtwbTDu7NWFCOtuCT/SlHI66q+QDcvleQQUfRiHhPtAVJvZPUzxKNbmR5Zh4W/cMTIysQG8GERxMt+MkrQK0KiIf0s6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633145; c=relaxed/simple;
	bh=GZ1h6Iz/i2K/mB9JhxCk2dTlyBpCfbWpXCCPt9GwO6k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xk5gg2A2K822O0x3zoNhN9MZKc3y8U4yExoztXiYyi83yIHHvYP5HPgGiNa74HZgyTiQ/ayUy8RXw4XR+wmTNZ5mCTfzoGjMcrFD1F/ZYdOBk4+bOhIwq0ks4Y6Ds+P1EvaI6vIYEHxHpVrAJ4T+I9pqbEZjR5fRFfWRCXeHy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rVkaPZki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D580C2BCB4;
	Fri,  1 May 2026 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777633145;
	bh=GZ1h6Iz/i2K/mB9JhxCk2dTlyBpCfbWpXCCPt9GwO6k=;
	h=Subject:To:Cc:From:Date:From;
	b=rVkaPZkii7MyxHNWGQjTUQzucDicbdPJMjFAFtj6V76n+W1kc4vIOy3/BTpqNVJMW
	 WjnXxpUSYGS6atCKIN8OnFI8fFS0hDuTvQCFhC2se5b7Numb1YNsE3JgO48msYswto
	 hJpJVWTXNlK4ah1+zxMlFSh3CcJd+3xzHZbyDZOU=
Subject: FAILED: patch "[PATCH] ipmi:ssif: Clean up kthread on errors" failed to apply to 5.15-stable tree
To: corey@minyard.net,252270051@hdu.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 12:58:48 +0200
Message-ID: <2026050148-politely-tabloid-3059@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 319234ABCD7
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
	TAGGED_FROM(0.00)[bounces-242281-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,hdu.edu.cn:email]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 75c486cb1bcaa1a3ec3a6438498176a3a4998ae4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050148-politely-tabloid-3059@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


