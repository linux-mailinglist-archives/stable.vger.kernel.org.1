Return-Path: <stable+bounces-237577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCt/Mrgj3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-237577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:11:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DFE3F0EE9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE6A73077353
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A26302146;
	Mon, 13 Apr 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mbkypDZ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235113016EE;
	Mon, 13 Apr 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099814; cv=none; b=Q0SgRiUBvcrnshA2IuUCCLL9b2fkrW+EVs0oX4Bei4HeEuQtXDRindTB5cT4nlj5dyk7Hx+LqmhyEAx6X45IU9NsC6DGXebXOsDZV4MjqOojhvtrGD3G6ci7R/GrCQf2zyT1vyeTMJtToY52yu2i8ps/NxG9bvKGuZWeCBBxhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099814; c=relaxed/simple;
	bh=5R3jnYUQ8/X1YOVc50VyaBWg5R6KrwiUGiHwex34Ht0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dee60Nt6kzYwnTEHcmLUUtB2c0u12c8DZPlvtCY3N+A9twln1C+fLMLQq2R9usaLxuC6i0YIrfR83Dlst8yHCuL7GFecne0+9KdbdMSzggdK00xKFGyIGvJBCowTzXVub2fk0NURRd95XShjqJVDxpMiCSi8mctHmIDGC1HGqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mbkypDZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A995BC2BCAF;
	Mon, 13 Apr 2026 17:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099814;
	bh=5R3jnYUQ8/X1YOVc50VyaBWg5R6KrwiUGiHwex34Ht0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbkypDZ0ktn282m7Ig71NmTc93RUgzorWTPCCMSgUUz3AZGM0+Ixka4ECKQYXznFF
	 +9c5LqNpuJdQA3rUXbjAuEqpUZptiBp/tyBsNyYRrOMcZ8sI+O+jh+cjPk14h5AnTX
	 5J5qtB8XDWzDxTjC727fqxAkNo9Lvuj6W0Ztjpo8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 483/491] device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()
Date: Mon, 13 Apr 2026 18:02:08 +0200
Message-ID: <20260413155837.136539581@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.intel.com,gmail.com,intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-237577-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 65DFE3F0EE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Scally <djrscally@gmail.com>

[ Upstream commit b5b41ab6b0c1bb70fe37a0d193006c969e3b5909 ]

Sensor drivers often check for an endpoint to make sure that they're
connected to a consuming device like a CIO2 during .probe(). Some of
those endpoints might be in the form of software_nodes assigned as
a secondary to the device's fwnode_handle. Account for this possibility
in fwnode_graph_get_next_endpoint() to avoid having to do it in the
sensor drivers themselves.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 2692c614f8f0 ("device property: Allow secondary lookup in fwnode_get_next_child_node()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/property.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1033,7 +1033,26 @@ struct fwnode_handle *
 fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 			       struct fwnode_handle *prev)
 {
-	return fwnode_call_ptr_op(fwnode, graph_get_next_endpoint, prev);
+	const struct fwnode_handle *parent;
+	struct fwnode_handle *ep;
+
+	/*
+	 * If this function is in a loop and the previous iteration returned
+	 * an endpoint from fwnode->secondary, then we need to use the secondary
+	 * as parent rather than @fwnode.
+	 */
+	if (prev)
+		parent = fwnode_graph_get_port_parent(prev);
+	else
+		parent = fwnode;
+
+	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
+
+	if (IS_ERR_OR_NULL(ep) &&
+	    !IS_ERR_OR_NULL(parent) && !IS_ERR_OR_NULL(parent->secondary))
+		ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
+
+	return ep;
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 



