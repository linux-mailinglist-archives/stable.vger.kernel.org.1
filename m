Return-Path: <stable+bounces-263314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lY3GBFMZMGomNgUAu9opvQ
	(envelope-from <stable+bounces-263314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:25:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0AF687A4A
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:25:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=MoV7YU95;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263314-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263314-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4F833046ED4
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351463FBB56;
	Mon, 15 Jun 2026 15:22:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E5B4028FD
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:22:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536951; cv=none; b=UpVjOwPHGUx+J7NAi/8bAUHywbzu9sxR1a1aXz93j8pR4yqe78skPQEPGS7K8f9DUgoI+nuMRDLGMRt9oL/n7vaZ8q3+FKV1MsfRppHTtW4H3Lu152Ai7zjT7Lhaup/Y4inpmC4leOMVqLvfcmMCekYFyN1BXn8HkuyMiVjhYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536951; c=relaxed/simple;
	bh=KkQ8gTd0OicITxSU46gZflPVevSgHhy7vQ83FaxhAgg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I3L+etYyV/W/s5ElJEandHhQoCljxOU82DE78DTRo7C9WNx8uC4OIqjRywBg3SORAeXAXAIj9/gsg3zcf75lPZHRwGZ3sNGp7QclPJN3ALBhmuuMYtB29YPRAt2u1opuR73ZdiXBUQhZbW8HIicuijaMrG3QPhSTpVO8YJpQCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MoV7YU95; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852371F000E9;
	Mon, 15 Jun 2026 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781536949;
	bh=Ts/zfNB3UqRFBvY8AZ56+QRhp0dxvzDwL1k4w1yafz8=;
	h=Subject:To:Cc:From:Date;
	b=MoV7YU95/ugL6s+IrXeDO2CSBu+65QQh+pj8QpyxRdR4UF7wZ6ID49Zur1lYI/fv0
	 5+AtVOzP8ARcr/eWxtLXou4qdqtKXj3RqLHEf3IxDQT9XF3pg6x2kF2SBCXpINku55
	 6+bQ8aGeufQc0js492fv8qqaYfdJrRh7OUr9WHxQ=
Subject: FAILED: patch "[PATCH] net: phonet: free phonet_device after RCU grace period" failed to apply to 5.15-stable tree
To: santosh.kalluri129@gmail.com,horms@kernel.org,kuba@kernel.org,remi@remlab.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:50:47 +0200
Message-ID: <2026061547-discourse-faceless-4af5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263314-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,remlab.net];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:santosh.kalluri129@gmail.com,m:horms@kernel.org,m:kuba@kernel.org,m:remi@remlab.net,m:stable@vger.kernel.org,m:santoshkalluri129@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gregkh:mid,remlab.net:email,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F0AF687A4A


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 71de0177b28da751f407581a4515cf4d762f6296
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061547-discourse-faceless-4af5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 71de0177b28da751f407581a4515cf4d762f6296 Mon Sep 17 00:00:00 2001
From: Santosh Kalluri <santosh.kalluri129@gmail.com>
Date: Wed, 3 Jun 2026 17:08:43 -0700
Subject: [PATCH] net: phonet: free phonet_device after RCU grace period
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

phonet_device_destroy() removes a phonet_device from the per-net device
list with list_del_rcu(), but frees it immediately. RCU readers walking
the same list can still hold a pointer to the object after it has been
removed, leading to a slab-use-after-free.

Use kfree_rcu(), matching the lifetime rule already used by
phonet_address_del() for the same object type.

Fixes: eeb74a9d45f7 ("Phonet: convert devices list to RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
Acked-by: Rémi Denis-Courmont <remi@remlab.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 86325b7fc1b6..ad44831d6745 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -108,7 +108,7 @@ static void phonet_device_destroy(struct net_device *dev)
 		for_each_set_bit(addr, pnd->addrs, 64)
 			phonet_address_notify(net, RTM_DELADDR, ifindex, addr);
 
-		kfree(pnd);
+		kfree_rcu(pnd, rcu);
 	}
 }
 


