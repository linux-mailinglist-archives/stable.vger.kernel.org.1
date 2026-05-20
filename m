Return-Path: <stable+bounces-250360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFB+BDcPDmrc5wUAu9opvQ
	(envelope-from <stable+bounces-250360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:44:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DF0598B2A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 799B0318BB25
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8C333509B;
	Wed, 20 May 2026 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s4Icg9Hz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8952D12EE;
	Wed, 20 May 2026 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295209; cv=none; b=Ck4mBIdGIbkURir0oLWhGS2K3OcC4FfMzuZuVzRI731XsJq8RfddS8X5WKPbapZiBMNZ9MT9SSTS3kpWkYwiiIjg2wCpJXxDIU9akMF+IGmMcr8FnJ0qdPjlZbb3u6yhB6nzz0g08Tu7ttnHj56vdp9i+OUik/+rWsJrRP2jVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295209; c=relaxed/simple;
	bh=ZQMoi2jaE4rrilDov9MjD3jIG8zI7RwyOlgtBNHtC94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X48OET/J7iIBu0X9WC6Jja8o3ejmhYlxA7MR1TUVCJ4jtBLJP6GTF42Brp6Zz5zl1hgGvu3/TpZf0asnQtMgXTKZmZoGs12rHvyDjFEv8vPaDUjkXnQ1owFIDmaRcYsvhoZ8xHnOuAc62lNrKI5tNno7z7xyJW6wTNFMqvy8cXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s4Icg9Hz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3053C1F000E9;
	Wed, 20 May 2026 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295208;
	bh=sH/a2BDMFLMgWURZPMxkMAugsi+aJWRRTO2iwUSMX98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s4Icg9Hztw9I0MANmWLmCiW4bmTViaIpX8D5kWFtTtuZqamffXvqxacDL72LGHe5S
	 Fk7WOoSUG60wIW2BANMuPv7uiCogs2pLm+61WjFadFeEJY+kD/6IZt770fYd+g2E9u
	 RpjwgwCA4EqsyUc/ZJQhmsvzywxDABYQq7gI/8pg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Nisbet <peter.nisbet@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0331/1146] PCI: Fix premature removal from realloc_head list during resource assignment
Date: Wed, 20 May 2026 18:09:41 +0200
Message-ID: <20260520162155.689517161@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250360-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 61DF0598B2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 1ee4716a5a28eaef81ae1f280d983258bee49623 ]

reassign_resources_sorted() checks for two things:

a) Resource assignment failures for mandatory resources by checking if the
   resource remains unassigned, which are known to always repeat, and does
   not attempt to assign them again.

b) That resource is not among the ones being processed/assigned at this
   stage, leading to skip processing such resources in
   reassign_resources_sorted() as well (resource assignment progresses
   one PCI hierarchy level at a time).

The problem here is that a) is checked before b), but b) also implies the
resource is not being assigned yet, making also a) true. As a) only skips
resource assignment but still removes the resource from realloc_head, the
later stages that would need to process the information in realloc_head
cannot obtain the optional size information anymore. This leads to
considering only non-optional part for bridge windows deeper in the PCI
hierarchy.

This problem has been observed during rescan (add_size is not considered
while attempting assignment for 0000:e2:00.0 indicating the corresponding
entry was removed from realloc_head while processing resource assignments
for 0000:e1):

  pci_bus 0000:e1: scanning bus
  ...
  pci 0000:e3:01.0: bridge window [mem 0x800000000-0x1000ffffff 64bit pref] to [bus e4] add_size 60c000000 add_align 800000000
  pci 0000:e3:01.0: bridge window [mem 0x00100000-0x000fffff] to [bus e4] add_size 200000 add_align 200000
  pci 0000:e3:02.0: disabling bridge window [mem 0x00000000-0x000fffff 64bit pref] to [bus e5] (unused)
  pci 0000:e2:00.0: bridge window [mem 0x800000000-0x1000ffffff 64bit pref] to [bus e3-e5] add_size 60c000000 add_align 800000000
  pci 0000:e2:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus e3-e5] add_size 200000 add_align 200000
  pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: can't assign; no space
  pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: failed to assign
  pcieport 0000:e1:02.0: bridge window [io  0x1000-0x2fff]: resource restored
  pcieport 0000:e1:02.0: bridge window [io  0x1000-0x2fff]: resource restored
  pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: can't assign; no space
  pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: failed to assign
  pci 0000:e2:00.0: bridge window [mem 0x28f000000000-0x28f800ffffff 64bit pref]: assigned

Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
Reported-by: Peter Nisbet <peter.nisbet@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Peter Nisbet <peter.nisbet@intel.com>
Link: https://patch.msgid.link/20260313084551.1934-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1f87b018799f9..9506845c112c4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -434,6 +434,10 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		dev = add_res->dev;
 		idx = pci_resource_num(dev, res);
 
+		/* Skip this resource if not found in head list */
+		if (!res_to_dev_res(head, res))
+			continue;
+
 		/*
 		 * Skip resource that failed the earlier assignment and is
 		 * not optional as it would just fail again.
@@ -442,10 +446,6 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		    !pci_resource_is_optional(dev, idx))
 			goto out;
 
-		/* Skip this resource if not found in head list */
-		if (!res_to_dev_res(head, res))
-			continue;
-
 		res_name = pci_resource_name(dev, idx);
 		add_size = add_res->add_size;
 		align = add_res->min_align;
-- 
2.53.0




