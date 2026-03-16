Return-Path: <stable+bounces-225596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCFVMncluGmNZgEAu9opvQ
	(envelope-from <stable+bounces-225596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:44:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE8629CACB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78D5E301B92F
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A13318BB8;
	Mon, 16 Mar 2026 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oAmZ/rBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61E2C031E
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675385; cv=none; b=NQkJPa3ltnDeHvMu1trFEWr+CnDCwQIigZ6vtNl5XxkSES4v5KCkCzGHDZwVCYppnnRpiBG48TtGIeYN6GEidcBYK+1mT8P4NpLkHEi99GdnZ0Cty3r7+iNZf/sqQ+wtFVU6eIwiCANp7tD3BzHFVfX3lHbntgm9S/ZY4/HsSQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675385; c=relaxed/simple;
	bh=4mmkmn1gSc657CQIwtcvsPlU5bUeEiPUlVZHhnyg3Ng=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QJlD/GF+cY9VmHDzCAJrOSbEcelc8VOq94Eg8VwJHoLOE7zrejJVtem7H22BE4NTidngkz6LnfeHVyxGaiNp2xLetjT2jbWlxjvT11nOc+cwXT3FZhfDEQZzczbngV1qfIFxwWhCrVDAAIwsgjR+Yt++aaZiCOMKli6tR2HykkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oAmZ/rBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5B9C19421;
	Mon, 16 Mar 2026 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773675385;
	bh=4mmkmn1gSc657CQIwtcvsPlU5bUeEiPUlVZHhnyg3Ng=;
	h=Subject:To:Cc:From:Date:From;
	b=oAmZ/rBHlxPTjs7qcMZXrmNc93jXU261nAxftY/b5cgYOpgAdBuk2LGW26urqd59C
	 EVlvezyARRpeAs7elIjQ1GbMEo3m2qOTZO5Y/rPK+8dhBU1VBfnODf3ixAWJCDuvPJ
	 J+5hp3EO5vJswghJEz44TKxkNnvYgTvNuesMG6Yw=
Subject: FAILED: patch "[PATCH] usb: gadget: f_tcm: Fix NULL pointer dereferences in nexus" failed to apply to 5.15-stable tree
To: jiashengjiangcool@gmail.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Mar 2026 16:36:09 +0100
Message-ID: <2026031609-supper-smitten-f64e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225596-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,synopsys.com,linuxfoundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,linuxfoundation.org:email,synopsys.com:email]
X-Rspamd-Queue-Id: 2EE8629CACB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b9fde507355342a2d64225d582dc8b98ff5ecb19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031609-supper-smitten-f64e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b9fde507355342a2d64225d582dc8b98ff5ecb19 Mon Sep 17 00:00:00 2001
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Date: Thu, 19 Feb 2026 02:38:34 +0000
Subject: [PATCH] usb: gadget: f_tcm: Fix NULL pointer dereferences in nexus
 handling

The `tpg->tpg_nexus` pointer in the USB Target driver is dynamically
managed and tied to userspace configuration via ConfigFS. It can be
NULL if the USB host sends requests before the nexus is fully
established or immediately after it is dropped.

Currently, functions like `bot_submit_command()` and the data
transfer paths retrieve `tv_nexus = tpg->tpg_nexus` and immediately
dereference `tv_nexus->tvn_se_sess` without any validation. If a
malicious or misconfigured USB host sends a BOT (Bulk-Only Transport)
command during this race window, it triggers a NULL pointer
dereference, leading to a kernel panic (local DoS).

This exposes an inconsistent API usage within the module, as peer
functions like `usbg_submit_command()` and `bot_send_bad_response()`
correctly implement a NULL check for `tv_nexus` before proceeding.

Fix this by bringing consistency to the nexus handling. Add the
missing `if (!tv_nexus)` checks to the vulnerable BOT command and
request processing paths, aborting the command gracefully with an
error instead of crashing the system.

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP + BOT")
Cc: stable <stable@kernel.org>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260219023834.17976-1-jiashengjiangcool@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index ec050d8f99f1..a7853dcbb14c 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1222,6 +1222,13 @@ static void usbg_submit_cmd(struct usbg_cmd *cmd)
 	se_cmd = &cmd->se_cmd;
 	tpg = cmd->fu->tpg;
 	tv_nexus = tpg->tpg_nexus;
+	if (!tv_nexus) {
+		struct usb_gadget *gadget = fuas_to_gadget(cmd->fu);
+
+		dev_err(&gadget->dev, "Missing nexus, ignoring command\n");
+		return;
+	}
+
 	dir = get_cmd_dir(cmd->cmd_buf);
 	if (dir < 0)
 		goto out;
@@ -1483,6 +1490,13 @@ static void bot_cmd_work(struct work_struct *work)
 	se_cmd = &cmd->se_cmd;
 	tpg = cmd->fu->tpg;
 	tv_nexus = tpg->tpg_nexus;
+	if (!tv_nexus) {
+		struct usb_gadget *gadget = fuas_to_gadget(cmd->fu);
+
+		dev_err(&gadget->dev, "Missing nexus, ignoring command\n");
+		return;
+	}
+
 	dir = get_cmd_dir(cmd->cmd_buf);
 	if (dir < 0)
 		goto out;


