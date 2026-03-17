Return-Path: <stable+bounces-226737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLQYF/GSuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:44:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A52172B0102
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3279B302F208
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E0F2DF132;
	Tue, 17 Mar 2026 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH01OBiw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557992459DC
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768001; cv=none; b=h/Wul2f1KadsQOcvlH3SotWWPWhK0ro67UqNEVafS9ny7mSLozn884cAuzOZgmBAWxk2qSR3fTxh9HDcghJO9ABN1OAEdwLx6Uy1LGV5VFg4MXZPLsXbfrcug3ER8LmbDuF/dEBubhAIyKDXOqJha4JZm1TCStC9TwyNxYKZ0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768001; c=relaxed/simple;
	bh=97NKTOTMkE5tCa10SnfmV8i0p+jWWo50FPkccVmVQYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBEOGD+Ems3uqr3P+Mp8zq6JQI1eJjaWCvRDMeKJ+bDHR2revdvwwmFrC8vaKfM1zSfzDBDoWCtgt2v3OISdhBOgO94XHq/kDkM4JALfBN/jjg+ZWvbyWFHD+4YPCLsKMnFT2jVWQ4z3mlixgs00UA7w4jZq1FD2iqrapBNQsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH01OBiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BE1C4CEF7;
	Tue, 17 Mar 2026 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768001;
	bh=97NKTOTMkE5tCa10SnfmV8i0p+jWWo50FPkccVmVQYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dH01OBiwZGpPYormdqdBGvoLsMeIIMOkD7roSVOZ8AbvKjKTuW/ooqLuzK7NlXuOB
	 VJbRRCe3UMD3NzHmrH239uV/4waX2KztLMDfRi1BET3y0fywlm3pkFK1ME/k9fyIt5
	 QBi/SLU5iHhD5O48Jx/QsIiVeORAmKMXAGprlhic5v3BhLaNVVVzkNJZo41I2QDd5L
	 QnBF3AMti5yJhqenjtjBHcAld4+dOTwr6EjFhalcjpe8AzvSy5lerT4Vd1EOmqbtWp
	 WwplChCEyDcp6MKsrb03CHHe3jS5+pguVpMqKnuvZc+oPulr69FVPjeZwpxtVIa3+m
	 AuxSAtX+4faJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/8] device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()
Date: Tue, 17 Mar 2026 13:19:51 -0400
Message-ID: <20260317171954.238398-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317171954.238398-1-sashal@kernel.org>
References: <2026031703-caravan-bladder-c63a@gregkh>
 <20260317171954.238398-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226737-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A52172B0102
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/base/property.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 40968fd9c8d14..bf9673fe59b3b 100644
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
 
-- 
2.51.0


