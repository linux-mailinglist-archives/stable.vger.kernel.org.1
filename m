Return-Path: <stable+bounces-274446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rb7oE4toVmoH5AAAu9opvQ
	(envelope-from <stable+bounces-274446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:49:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9A757117
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:49:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CPBjDe1r;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274446-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274446-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 956EF303275D
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB64285CA2;
	Tue, 14 Jul 2026 16:48:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0E2E228D
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:48:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047734; cv=none; b=VNAJikpB+jIz+Xa8svPWCZGmHReu3QfUXYTJ/BuRTAhgjxOqMr2WtYnKXKGryi9umK32aaCNbreUd5lcnCABobOuGp18yZAVtMZ62HAd9+RKrfwBETY/YR6D7EH3v5suDYeq10StaRy3xtGQ1ZDNFnSlYVZj2GTBlp0aYamKiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047734; c=relaxed/simple;
	bh=w+ulv4yare+/xelDtQ/A8CjD2p94o6yl44uMkOmWG3c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GKnGGxsmmrI5vN5hXJzjhZ9aY7g1P/aY+XMgyq8wM67eMi7+oxpncYBu/eNWnldjoag4jLA7WrtWatGt53SQIXB1yO1Ctna1px98wsIxQ2AasB+munhf0LqohlvmQt5NPppxkrwnYMjpieVrd5CuBFPzu8h9TUdGnwj0msPsFME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CPBjDe1r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DE41F000E9;
	Tue, 14 Jul 2026 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784047732;
	bh=yjSLAgla3zulw046r7YXGw5Zt1d6Jagtt0/9u3/iDJM=;
	h=Subject:To:Cc:From:Date;
	b=CPBjDe1rgJP/SAAs0L2XkXS/Sjd8JFwBg+gH1UI7H/CZvrDvc464jqWZ0PLDVsHGa
	 nquQyw5qWWPyxeS3G1rwLk2tLtpGcMYHuu3q7TKJBJSY0hsJ/dL+t2IXH936EshSdb
	 hUq2E3xD+HFZK+seXuMdJbrq/00oJ9X1o4QF8/bU=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: Fix VDM type for Enter Mode commands" failed to apply to 6.1-stable tree
To: andyshrk@163.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:48:38 +0200
Message-ID: <2026071438-t-shirt-chest-a453@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andyshrk@163.com,m:gregkh@linuxfoundation.org,m:heikki.krogerus@linux.intel.com,m:stable@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com,linuxfoundation.org,linux.intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-274446-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:email,linuxfoundation.org:dkim,intel.com:email,gregkh:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87F9A757117


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9cff680e47632b7723cb19f9c5e63669063c3417
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071438-t-shirt-chest-a453@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9cff680e47632b7723cb19f9c5e63669063c3417 Mon Sep 17 00:00:00 2001
From: Andy Yan <andyshrk@163.com>
Date: Thu, 4 Jun 2026 18:50:24 +0800
Subject: [PATCH] usb: typec: tcpm: Fix VDM type for Enter Mode commands

VDO() second parameter is VDM type (bit 15): 1 for SVDM, 0 for UVDM.
Using 'vdo ? 2 : 1' corrupts SVID low bit when vdo is non-NULL
(2 << 15 = BIT(16)). Enter Mode is always SVDM, hardcode to 1.

Fixes: 8face9aa57c8 ("usb: typec: Add parameter for the VDO to typec_altmode_enter()")
Cc: stable <stable@kernel.org>
Signed-off-by: Andy Yan <andyshrk@163.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260604105059.18750-1-andyshrk@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index bc531923b1ca..89eec20a2064 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3093,7 +3093,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	if (svdm_version < 0)
 		return svdm_version;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
@@ -3141,7 +3141,7 @@ static int tcpm_cable_altmode_enter(struct typec_altmode *altmode, enum typec_pl
 	if (svdm_version < 0)
 		return svdm_version;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);


