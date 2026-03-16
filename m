Return-Path: <stable+bounces-225601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOuABWkmuGnhZgEAu9opvQ
	(envelope-from <stable+bounces-225601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:48:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9A229CBD4
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E92C3007885
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1033831AA94;
	Mon, 16 Mar 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HKHxawqt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75CC246BC6
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676038; cv=none; b=NUYAkvRo5YvczTJ7tTMmpGK7QkCBkQEmvFxHPD55rKTtIETpFRMzrehQnzFaS/XhXUSC3034VJcRe7i6HaYMvgVt3+BYvYnk/UTubu9iXSrXhhZZB+Z3YcyjLftD5eRK6Xn30rYJdcuS8mfR/VFxqtxHB92/gtysJnoWTslCZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676038; c=relaxed/simple;
	bh=Il8h6ZbZDwR91hhkfYH3c+g4CveJkYAcCzeJHfInFU4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sim/TaDWmU+FHn2faxxGFr+0T8x5uoponU6MEZ+zrTm0zidC5pbeqYVyYnLIZzN5SJhaUW5HSte00Va89cH0PaQ0Z4ymZ2e1n22dudlAne0NBvSLYMEXh0NRB8/33esvZF6BCfGp91TIoJwoECNUiwJAal3Z7fVS1Gqtn/Xgxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HKHxawqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AA9C19421;
	Mon, 16 Mar 2026 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773676038;
	bh=Il8h6ZbZDwR91hhkfYH3c+g4CveJkYAcCzeJHfInFU4=;
	h=Subject:To:Cc:From:Date:From;
	b=HKHxawqtpw50qUwyPb5fyY6SSORE96y2qHE+K+6mzDH6+4ugftg9DXo/F7ep2t/Px
	 stdabwPXpAMLxlqOCbCmkGFmCtGu4bHyt2N0wna7r7/0SFcnvYexzrFkDtWOZ1NQ9M
	 2a1NO5zY3zCtcVeQsL8UzX3acFKlSlTsuphYT0e0=
Subject: FAILED: patch "[PATCH] usb: roles: get usb role switch from parent only for" failed to apply to 5.15-stable tree
To: xu.yang_2@nxp.com,arnaud.ferraris@collabora.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Mar 2026 16:47:15 +0100
Message-ID: <2026031615-celibate-diabolic-3dae@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225601-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nxp.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,gregkh:email,collabora.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C9A229CBD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8345b1539faa49fcf9c9439c3cbd97dac6eca171
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031615-celibate-diabolic-3dae@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8345b1539faa49fcf9c9439c3cbd97dac6eca171 Mon Sep 17 00:00:00 2001
From: Xu Yang <xu.yang_2@nxp.com>
Date: Mon, 9 Mar 2026 15:43:13 +0800
Subject: [PATCH] usb: roles: get usb role switch from parent only for
 usb-b-connector

usb_role_switch_is_parent() was walking up to the parent node and checking
for the "usb-role-switch" property regardless of the type of the passed
fwnode. This could cause unrelated device nodes to be probed as potential
role switch parent, leading to spurious matches and "-EPROBE_DEFER" being
returned infinitely.

Till now only Type-B connector node will have a parent node which may
present "usb-role-switch" property and register the role switch device.
For Type-C connector node, its parent node will always be a Type-C chip
device which will never register the role switch device. However, it may
still present a non-boolean "usb-role-switch = <&usb_controller>" property
for historical compatibility.

So restrict the helper to only operate on Type-B connector when attempting
to get the role switch from parent node.

Fixes: 6fadd72943b8 ("usb: roles: get usb-role-switch from parent")
Cc: stable <stable@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Tested-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260309074313.2809867-3-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index b8e28ceca51e..edec139b68b5 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -139,9 +139,14 @@ static void *usb_role_switch_match(const struct fwnode_handle *fwnode, const cha
 static struct usb_role_switch *
 usb_role_switch_is_parent(struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *parent = fwnode_get_parent(fwnode);
+	struct fwnode_handle *parent;
 	struct device *dev;
 
+	if (!fwnode_device_is_compatible(fwnode, "usb-b-connector"))
+		return NULL;
+
+	parent = fwnode_get_parent(fwnode);
+
 	if (!fwnode_property_present(parent, "usb-role-switch")) {
 		fwnode_handle_put(parent);
 		return NULL;


