Return-Path: <stable+bounces-231090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N8wF59Gymnn7AUAu9opvQ
	(envelope-from <stable+bounces-231090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:47:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D235878B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFF2A3023321
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABCD3B4EAC;
	Mon, 30 Mar 2026 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aEJrrlEI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB33B4E8E
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863538; cv=none; b=nFrkg6NrRXCoSz+Q6hOEmAElusFQhw21NhbXf7aXkYJp7cO77QyjWVvu1kK318mUmWf+cdJesPjjowEPQu0la/7tOA0fjd6UiFzd5ot97mBr7zdpY/NtJ8d/Bj+2bjZefxsGJBKENzO0psSh8Y2q3nJKoJvV62kQu34gVrqTwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863538; c=relaxed/simple;
	bh=a9mYWlHbXv8Q3ijo/fJCJP5Ojqgr0UR3by0Eq9ohp7M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kVnV08yfefWp+qWDDBaEiYaToN+SKMso6w4jZE5iCvIXhAqQzJk9xfgmHooZv5F2VdJmyb4B262TTiumMMoOXDRbz5G4ACHAoKo5Isrq12WSE/JGZQ8gwDBfy3UIeZkYNjgFdWg0Qf0BZUKY/jsJyovUoVBTe8QaGqaHoMvnjJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aEJrrlEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA7CC4CEF7;
	Mon, 30 Mar 2026 09:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774863537;
	bh=a9mYWlHbXv8Q3ijo/fJCJP5Ojqgr0UR3by0Eq9ohp7M=;
	h=Subject:To:Cc:From:Date:From;
	b=aEJrrlEIxVuZUAKuTsz26p7KZp7Mrd/Pgv3eDka0VCHUBogbRf3HnAghHYsbxIexH
	 /OV9khDSkZqKTixUi+yOs+XTObuzJ4Fy30m1xsmqqJuuttJPHvzH7sUhnVPShcm3im
	 ljEU5GR+3nvgU4bort9foOksCrzRpZDhWikVwzhg=
Subject: FAILED: patch "[PATCH] net: mana: fix use-after-free in add_adev() error path" failed to apply to 6.12-stable tree
To: lgs201920130244@gmail.com,kuba@kernel.org,longli@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:38:41 +0200
Message-ID: <2026033041-unkind-wifi-8aa8@gregkh>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231090-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C35D235878B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033041-unkind-wifi-8aa8@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 24 Mar 2026 00:57:30 +0800
Subject: [PATCH] net: mana: fix use-after-free in add_adev() error path

If auxiliary_device_add() fails, add_adev() jumps to add_fail and calls
auxiliary_device_uninit(adev).

The auxiliary device has its release callback set to adev_release(),
which frees the containing struct mana_adev. Since adev is embedded in
struct mana_adev, the subsequent fall-through to init_fail and access
to adev->id may result in a use-after-free.

Fix this by saving the allocated auxiliary device id in a local
variable before calling auxiliary_device_add(), and use that saved id
in the cleanup path after auxiliary_device_uninit().

Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
Cc: stable@vger.kernel.org
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260323165730.945365-1-lgs201920130244@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9017e806ecda..dca62fb9a3a9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3425,6 +3425,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	struct auxiliary_device *adev;
 	struct mana_adev *madev;
 	int ret;
+	int id;
 
 	madev = kzalloc_obj(*madev);
 	if (!madev)
@@ -3434,7 +3435,8 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	ret = mana_adev_idx_alloc();
 	if (ret < 0)
 		goto idx_fail;
-	adev->id = ret;
+	id = ret;
+	adev->id = id;
 
 	adev->name = name;
 	adev->dev.parent = gd->gdma_context->dev;
@@ -3460,7 +3462,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	auxiliary_device_uninit(adev);
 
 init_fail:
-	mana_adev_idx_free(adev->id);
+	mana_adev_idx_free(id);
 
 idx_fail:
 	kfree(madev);


