Return-Path: <stable+bounces-226607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB9/G76OuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1DB2AF8A6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EE3C311908F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D0F3F65EE;
	Tue, 17 Mar 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WhE9PC7F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1931815D;
	Tue, 17 Mar 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767447; cv=none; b=UgYcd8n9k6JN1GSh+kBprHVWxDWV+EAAQlBB9aRnmGLfQltb3CeQtZ06ezQGZLXgx1P2Ic5vxZwf5XcVQaQUNFPJEZ9aaq6Q5y8W0KSem9nHxgFcZ/FnvE8A9UNKh1IP0j19Xt79nuwhKDf4rhw9t2UUntvPyg+84PtD3eFzt8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767447; c=relaxed/simple;
	bh=8yz1xnnzqmy0QxdCvo8yJHvkZee3MqSijopnVjpl7OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaMP1oOBx1E1IW/fj9OUMjAmDXOaf267P1uOYBmFKR2FA+Zke0sPZnZ6tywES9fW2kWYxk9Lfmx/JXKQbNfvYH7xPJFLpWImwqO8X/10bq/rZBFR4ipC7uY9xdDVjp5Mu5VePNOo/kkfp474GiYFVKma/yIgEdOAcUNGFk79zX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WhE9PC7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17BBC4CEF7;
	Tue, 17 Mar 2026 17:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767447;
	bh=8yz1xnnzqmy0QxdCvo8yJHvkZee3MqSijopnVjpl7OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhE9PC7FeQ1NRHXcwYxa5AKRZ6BOYG18XOg+rCmE2ZG8xCBApfXCDm+/Du02ucpMM
	 g9ml21Sac5wleh7inh+xhlTNPmuHW9eLmQH4uTwFSaq7drmtJYJuiVxeze2bvqh9FR
	 nzBJHpohelmouCahhvL6PkxT+BtHa76WJfClPLHo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 088/333] ACPI: OSL: fix __iomem type on return from acpi_os_map_generic_address()
Date: Tue, 17 Mar 2026 17:31:57 +0100
Message-ID: <20260317163002.635806785@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226607-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,codethink.co.uk:email]
X-Rspamd-Queue-Id: 6A1DB2AF8A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Dooks <ben.dooks@codethink.co.uk>

[ Upstream commit 393815f57651101f1590632092986d1d5a3a41bd ]

The pointer returned from acpi_os_map_generic_address() is
tagged with __iomem, so make the rv it is returned to also
of void __iomem * type.

Fixes the following sparse warning:

drivers/acpi/osl.c:1686:20: warning: incorrect type in assignment (different address spaces)
drivers/acpi/osl.c:1686:20:    expected void *rv
drivers/acpi/osl.c:1686:20:    got void [noderef] __iomem *

Fixes: 6915564dc5a8 ("ACPI: OSL: Change the type of acpi_os_map_generic_address() return value")
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[ rjw: Subject tweak, added Fixes tag ]
Link: https://patch.msgid.link/20260311105835.463030-1-ben.dooks@codethink.co.uk
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5ff343096ece0..fd3ac84b596fa 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1681,7 +1681,7 @@ acpi_status __init acpi_os_initialize(void)
 		 * Use acpi_os_map_generic_address to pre-map the reset
 		 * register if it's in system memory.
 		 */
-		void *rv;
+		void __iomem *rv;
 
 		rv = acpi_os_map_generic_address(&acpi_gbl_FADT.reset_register);
 		pr_debug("%s: Reset register mapping %s\n", __func__,
-- 
2.51.0




