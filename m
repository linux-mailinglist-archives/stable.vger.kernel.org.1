Return-Path: <stable+bounces-243554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIK8Kf+q+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:19:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 639B44BF158
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EF0B3037938
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC363DEAC1;
	Mon,  4 May 2026 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+j1xrmU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C6315785;
	Mon,  4 May 2026 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904183; cv=none; b=MTku63dx8ealrgPEO3IvUWgG8eeEkhTILHGkK7ZpcVxa8eUY6LednB/K1JOSZgpn0IcwKPFBgSmMf5CEI0GYx32kUFzR9fhVUIrmlQgrZyxtYjo0t9s9iC9wsaDAdb5cWhPnINnduKkHqs2KKxAXkNTrRSKGa/t3nlMF4Zp4mao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904183; c=relaxed/simple;
	bh=pRUkEI2QNy1tGUUA6Ak2OjHiNih+8RMJB/TUgL1T0dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIBxEcS6efhjezxLVhUaJ4bVUhv/xuj2ILjcOU8T/PPz+6mN/klQfdxH0rcvp2RGGbJHYZDaH5QHKFcDUePcpFEySgaVhYuif0s+EF5YTNYZ2Kk+hMDOXs5nbTdw9BBDycXQTi4J5HmBd/u9OUFS3BkpGN+HP26gCezFkvEWGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+j1xrmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD68C2BCB8;
	Mon,  4 May 2026 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904182;
	bh=pRUkEI2QNy1tGUUA6Ak2OjHiNih+8RMJB/TUgL1T0dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+j1xrmU4jF8HlOqfPCrczgAGOqwJ+ENfiR/gLzmTo/AZq7iSS4ZWE3HvW69C5Fzd
	 d+LlYTIWUeOuXDrhANNh4uH12qQ0HZCn9A2IjmOPWLqai0hWSLmhPjJzjJeelYPdnF
	 IeLTV2QMQefOlK4JtF5E0pJ59baSJg6DUgbartzM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Mak <makb@juniper.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.18 215/275] mfd: core: Preserve OF node when ACPI handle is present
Date: Mon,  4 May 2026 15:52:35 +0200
Message-ID: <20260504135151.059499752@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 639B44BF158
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243554-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,juniper.net:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Mak <makb@juniper.net>

commit caa5a5d44d8ae4fd13b744857d66c9313b712d1f upstream.

Switch device_set_node to set_primary_fwnode, so that the ACPI fwnode
does not overwrite the of_node with NULL.

This allows MFD children with both OF nodes and ACPI handles to have OF
nodes again.

Cc: stable@vger.kernel.org
Fixes: 51e3b257099d ("mfd: core: Make use of device_set_node()")
Signed-off-by: Brian Mak <makb@juniper.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260325223024.35992-1-makb@juniper.net
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/mfd-core.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -88,7 +88,17 @@ static void mfd_acpi_add_device(const st
 		}
 	}
 
-	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
+	/*
+	 * NOTE: The fwnode design doesn't allow proper stacking/sharing. This
+	 * should eventually turn into a device fwnode API call that will allow
+	 * prepending to a list of fwnodes (with ACPI taking precedence).
+	 *
+	 * set_primary_fwnode() is used here, instead of device_set_node(), as
+	 * device_set_node() will overwrite the existing fwnode, which may be an
+	 * OF node that was populated earlier. To support a use case where ACPI
+	 * and OF is used in conjunction, we call set_primary_fwnode() instead.
+	 */
+	set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
 }
 #else
 static inline void mfd_acpi_add_device(const struct mfd_cell *cell,



