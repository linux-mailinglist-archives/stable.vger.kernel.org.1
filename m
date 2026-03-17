Return-Path: <stable+bounces-225834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF5QJUI9uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:38:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F822A904A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B84CD30670BC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D6F36EAA9;
	Tue, 17 Mar 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NbrUloqB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBE335BDB
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747307; cv=none; b=H+WOPHBOSr/BMkKFSJyTcan547f3XPq1blcNGvL5mxPfl/GN3aSvu3SOUqd5K9XhxXtPdbsCx1/+HpkreIZfc9KcC7FWlEZK/0zo4OV68I1nxrCgVFYfo6nnxJreDy9/anvSjuFEuc+8AelXbTSBReBNEtxpudtnkUQmxTtfaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747307; c=relaxed/simple;
	bh=Ubtec/RGSLayrNCzJIZSGm6UPAqxRE2CQf+HuLPrF5w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qdqvtMx6QlPOwhEn0MCitoI5EKkwl5sslH6cKx8KeCtL3NMOi43uXwc3KFIvarrKcKUO50gfB2cSvLQ/5JJjLeM9kbPIdDpXSUa57B9Afw/9vBgxJUBaBKdkHTUqdq8bpwfzsF49qQ3rFQ7kTA48aPA6FjIZxat83dd4PdcuRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NbrUloqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E510C4CEF7;
	Tue, 17 Mar 2026 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773747306;
	bh=Ubtec/RGSLayrNCzJIZSGm6UPAqxRE2CQf+HuLPrF5w=;
	h=Subject:To:Cc:From:Date:From;
	b=NbrUloqBhJipmTvZqJv00Xx9tClM8/Hf/wo3NoeJrdC9/tTsOroQ9Nn7+yw630P3U
	 3fhVCeJOqRLZApfO1osy+QSM+0ndL2BfZt1sHOiAp8i+CmRk3Skg1jg6Jw96psQOmo
	 uhoMD381K6Dimel/ZmzNXDMt/ACo2SWy78KOeDKQ=
Subject: FAILED: patch "[PATCH] device property: Allow secondary lookup in" failed to apply to 5.10-stable tree
To: andriy.shevchenko@linux.intel.com,dakr@kernel.org,rafael@kernel.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:35:03 +0100
Message-ID: <2026031703-caravan-bladder-c63a@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225834-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,linuxfoundation.org:dkim,gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39F822A904A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2692c614f8f05929d692b3dbfd3faef1f00fbaf0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031703-caravan-bladder-c63a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2692c614f8f05929d692b3dbfd3faef1f00fbaf0 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 10 Feb 2026 14:58:22 +0100
Subject: [PATCH] device property: Allow secondary lookup in
 fwnode_get_next_child_node()

When device_get_child_node_count() got split to the fwnode and device
respective APIs, the fwnode didn't inherit the ability to traverse over
the secondary fwnode. Hence any user, that switches from device to fwnode
API misses this feature. In particular, this was revealed by the commit
1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
that effectively broke the GPIO enumeration on Intel Galileo boards.
Fix this by moving the secondary lookup from device to fwnode API.

Note, in general no device_*() API should go into the depth of the fwnode
implementation.

Fixes: 114dbb4fa7c4 ("drivers property: When no children in primary, try secondary")
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Link: https://patch.msgid.link/20260210135822.47335-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 6a63860579dd..8d9a34be57fb 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -797,7 +797,18 @@ struct fwnode_handle *
 fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 			   struct fwnode_handle *child)
 {
-	return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
+	struct fwnode_handle *next;
+
+	if (IS_ERR_OR_NULL(fwnode))
+		return NULL;
+
+	/* Try to find a child in primary fwnode */
+	next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);
+	if (next)
+		return next;
+
+	/* When no more children in primary, continue with secondary */
+	return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
@@ -841,19 +852,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
 struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child)
 {
-	const struct fwnode_handle *fwnode = dev_fwnode(dev);
-	struct fwnode_handle *next;
-
-	if (IS_ERR_OR_NULL(fwnode))
-		return NULL;
-
-	/* Try to find a child in primary fwnode */
-	next = fwnode_get_next_child_node(fwnode, child);
-	if (next)
-		return next;
-
-	/* When no more children in primary, continue with secondary */
-	return fwnode_get_next_child_node(fwnode->secondary, child);
+	return fwnode_get_next_child_node(dev_fwnode(dev), child);
 }
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 


