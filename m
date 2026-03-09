Return-Path: <stable+bounces-223525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEp+J7Germm2GwIAu9opvQ
	(envelope-from <stable+bounces-223525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:19:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 550C2236E86
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F08E430333AA
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2238BF9B;
	Mon,  9 Mar 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q0hArrL+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAAB38E5FC
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051494; cv=none; b=aPsLsJc0AwQe/+X6U2qDeoXBXxHWsLjjkgNcQXi0w5Ji/jY+ArFCIhoQd9R1tpQHgmIwA4t3q6v2uszLKh/ng4XZxZ9mAV3zs8mCyj3EV7wvnvQHnp780/Z0CIZRCuSEnJFJQyu167X9CoIVZ3bwaztnD4N6/7olHIuqBN2PTXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051494; c=relaxed/simple;
	bh=4Bat59N9oNtMhlEBjg7cA4r23jN7dRjIkBjI/gq/obw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V8SnppSPyZrfkXbC5qqbz9r1FL7rmBlAyatqWl3+fltRb97oTUmzgAmeVcoQTO6wpWkcxgnohZZEQsTEFSp8jsJ4A0sCDVt1z4qRaRwslOM87kemnDicKRQKQQIx5Adx7q6MuZI38iDItpu/xbzz+QSuyickstt09sz5EJPP8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q0hArrL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9588AC4CEF7;
	Mon,  9 Mar 2026 10:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051493;
	bh=4Bat59N9oNtMhlEBjg7cA4r23jN7dRjIkBjI/gq/obw=;
	h=Subject:To:Cc:From:Date:From;
	b=Q0hArrL+M12lE6af9wpIVYKVqb+whORw8yGXNvlKAYzIx61jHq0cr7V99cLuq+OdW
	 MCqfumZQe1S37K0A7SbK4M9j3qH02S9HDfrl/Icz+5Fso4NfnRg/I3YpH/eb3LZTxb
	 W1tSRCSXBdH3p43/nxl+5b/TXkqwt0uU1pu4XXjg=
Subject: FAILED: patch "[PATCH] platform/x86: hp-bioscfg: Support allocations of larger data" failed to apply to 6.19-stable tree
To: mario.limonciello@amd.com,ilpo.jarvinen@linux.intel.com,p.kerry@sheffield.ac.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:17:29 +0100
Message-ID: <2026030929-repeated-ungraded-202a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 550C2236E86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223525-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.360];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,gregkh:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email,sheffield.ac.uk:email,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x 916727cfdb72cd01fef3fa6746e648f8cb70e713
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030929-repeated-ungraded-202a@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 916727cfdb72cd01fef3fa6746e648f8cb70e713 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 25 Feb 2026 15:06:46 -0600
Subject: [PATCH] platform/x86: hp-bioscfg: Support allocations of larger data
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some systems have much larger amounts of enumeration attributes
than have been previously encountered. This can lead to page allocation
failures when using kcalloc().  Switch over to using kvcalloc() to
allow larger allocations.

Fixes: 6b2770bfd6f92 ("platform/x86: hp-bioscfg: enum-attributes")
Cc: stable@vger.kernel.org
Reported-by: Paul Kerry <p.kerry@sheffield.ac.uk>
Tested-by: Paul Kerry <p.kerry@sheffield.ac.uk>
Closes: https://bugs.debian.org/1127612
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260225210646.59381-1-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index 470b9f44ed7a..af4d1920d488 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -94,8 +94,11 @@ int hp_alloc_enumeration_data(void)
 	bioscfg_drv.enumeration_instances_count =
 		hp_get_instance_count(HP_WMI_BIOS_ENUMERATION_GUID);
 
-	bioscfg_drv.enumeration_data = kzalloc_objs(*bioscfg_drv.enumeration_data,
-						    bioscfg_drv.enumeration_instances_count);
+	if (!bioscfg_drv.enumeration_instances_count)
+		return -EINVAL;
+	bioscfg_drv.enumeration_data = kvcalloc(bioscfg_drv.enumeration_instances_count,
+						sizeof(*bioscfg_drv.enumeration_data), GFP_KERNEL);
+
 	if (!bioscfg_drv.enumeration_data) {
 		bioscfg_drv.enumeration_instances_count = 0;
 		return -ENOMEM;
@@ -444,6 +447,6 @@ void hp_exit_enumeration_attributes(void)
 	}
 	bioscfg_drv.enumeration_instances_count = 0;
 
-	kfree(bioscfg_drv.enumeration_data);
+	kvfree(bioscfg_drv.enumeration_data);
 	bioscfg_drv.enumeration_data = NULL;
 }


