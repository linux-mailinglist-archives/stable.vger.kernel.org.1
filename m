Return-Path: <stable+bounces-226401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ApcEsmHuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:56:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1130E2AEA9E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 966AE303A3FA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3B3F23DD;
	Tue, 17 Mar 2026 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ydMDYddQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001F3C6612;
	Tue, 17 Mar 2026 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766543; cv=none; b=Px4oscGj8xQsMMuTNbj7lNl6w97Hn2wFY15zLKPgWdv4DEfygozc9Cal+wK4elvoD4a+tIsTp3nihGR0fq2SwiJ5WztSfYrTeCN+QL6ZCBqFoXb9gktj97IGmwhbO9Ux0twVk+zw8IB8UPNO1AtkQYewdYUbz4nKL1x9tQdKxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766543; c=relaxed/simple;
	bh=iTt6g+lNFcFKMpjC+wpusJxpzaEE6eMz1panmuyTptU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B624fOkyBsNfH4HpseVpvLtzMKsJEhGPZJbpMTZ5M4KISNldz7KoHKCrz8k8rFLOS7cvCmb047mW9rwJWp2Io+kB+YeIH2jZZSdlw8jEYDDsBAgf/2yKQCPjyNy8MUN4D1hVVTGlxlTjlSJ+oEphepHsX6cgjQqB6w4MikIlBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ydMDYddQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9892EC4CEF7;
	Tue, 17 Mar 2026 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766543;
	bh=iTt6g+lNFcFKMpjC+wpusJxpzaEE6eMz1panmuyTptU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ydMDYddQyK80g2sRzXJfakp+0zXxCsDp1ZLfzZS6gm3XRtUGRZ2n3ACcEc9Tr3GLv
	 uXzNbqKg4Y7ekhihNdq6BIztIfqwNitGdu+w1pO5F67C21dyexr0cSZQ1XmJpzuwFb
	 y/PasVpr61Eb3xb3nEM/foytNlOra8SQzIK/XOuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.19 236/378] device property: Allow secondary lookup in fwnode_get_next_child_node()
Date: Tue, 17 Mar 2026 17:33:13 +0100
Message-ID: <20260317163015.695741681@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226401-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1130E2AEA9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 2692c614f8f05929d692b3dbfd3faef1f00fbaf0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/property.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

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
 
@@ -841,19 +852,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_availa
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
 



