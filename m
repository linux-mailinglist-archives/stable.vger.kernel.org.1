Return-Path: <stable+bounces-220776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDkdFlpCo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E37DA1C7127
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A8AC303099B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91C4096B2;
	Sat, 28 Feb 2026 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N44M+dUZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2424096A8;
	Sat, 28 Feb 2026 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300655; cv=none; b=rXnREUaiWOdKqX5PcYLDXZvZWdDYHfVUL0zJN2WNsBL4XhGW3tfsJ8K9+1JrzHL9nu5QA6yKm3PdvZGm0gndj4SJOdasWXR5hVKw/dldKPkJQh/Tf5THSdLPi3c2douNkrMQlgWcV2aHCMSeY0Mel5TvlugCX2KGySYSVjJ7ivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300655; c=relaxed/simple;
	bh=pZG3GCvDBKtzXTJvwnW1s7I9cHrCKIe4y4nCdtVb+X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pP4VSMR1HwDv30oL6nCP2bolvYM6HVAcqwe+P23Kg7JpIAmislNtryhrB9sXYnoJJw2hngZnSseA5rKYPKIkgrMyfIDBGJ7s15DiOPLi7vIEI3HF4LCwhkyLLZclURmsXfqb0wy60YX+oUZrMGgg3ijgxuFELD0hKeb7nUyl750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N44M+dUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D40C19425;
	Sat, 28 Feb 2026 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300655;
	bh=pZG3GCvDBKtzXTJvwnW1s7I9cHrCKIe4y4nCdtVb+X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N44M+dUZvXLxfymTkWJN1xaLN/1Kdevadto2u5epUqe8YVecciSMCmCm15biK9fIM
	 giqnSN50B2kT+GA2Sh/DEjLJquVwtCvVJHcqpTFTCkv7GMUyb3zdH00OhbivXV1Azb
	 nuzZiYEB+bo5WBy7zd0kz29DRaMg/srliw2jN9KA7+5HOC6Z3MWudKe5yCU9N8z4P6
	 6S0j9xTU/TUhlyDf2Dgmp6I/lTJL7enYKht14ymxcKBRbbEf2XvwY701Ynh/HRHLLE
	 xH8rG3MU/kSVmHvhgY8okrQ+Xz5kduayT/OeKSnuWMHASDeBEb/LmUdhQFXc7R5zJU
	 EvhdXzFga40vQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Malte=20Schr=C3=B6der?= <malte+lkml@tnxip.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 697/844] PCI: Fix bridge window alignment with optional resources
Date: Sat, 28 Feb 2026 12:30:10 -0500
Message-ID: <20260228173244.1509663-698-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220776-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,intel.com:email,tnxip.de:email]
X-Rspamd-Queue-Id: E37DA1C7127
X-Rspamd-Action: no action

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 7e90360e6d4599795b6f4e094e20d0bdf3b2615f ]

pbus_size_mem() has two alignments, one for required resources in min_align
and another in add_align that takes account optional resources.

The add_align is applied to the bridge window through the realloc_head
list. It can happen, however, that add_align is larger than min_align but
calculated size1 and size0 are equal due to extra tailroom (e.g., hotplug
reservation, tail alignment), and therefore no entry is created to the
realloc_head list. Without the bridge appearing in the realloc head,
add_align is lost when pbus_size_mem() returns.

The problem is visible in this log for 0000:05:00.0 which lacks
add_size ... add_align ... line that would indicate it was added into
the realloc_head list:

  pci 0000:05:00.0: PCI bridge to [bus 06-16]
  ...
  pci 0000:06:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 07] requires relaxed alignment rules
  pci 0000:06:06.0: bridge window [mem 0x00100000-0x001fffff] to [bus 0a] requires relaxed alignment rules
  pci 0000:06:07.0: bridge window [mem 0x00100000-0x003fffff] to [bus 0b] requires relaxed alignment rules
  pci 0000:06:08.0: bridge window [mem 0x00800000-0x00ffffff 64bit pref] to [bus 0c-14] requires relaxed alignment rules
  pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] requires relaxed alignment rules
  pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] requires relaxed alignment rules
  pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] add_size 100000 add_align 1000000
  pci 0000:06:0c.0: bridge window [mem 0x00100000-0x001fffff] to [bus 15] requires relaxed alignment rules
  pci 0000:06:0d.0: bridge window [mem 0x00100000-0x001fffff] to [bus 16] requires relaxed alignment rules
  pci 0000:06:0d.0: bridge window [mem 0x00100000-0x001fffff] to [bus 16] requires relaxed alignment rules
  pci 0000:05:00.0: bridge window [mem 0xd4800000-0xd97fffff]: assigned
  pci 0000:05:00.0: bridge window [mem 0x1060000000-0x10607fffff 64bit pref]: assigned
  pci 0000:06:08.0: bridge window [mem size 0x04900000]: can't assign; no space
  pci 0000:06:08.0: bridge window [mem size 0x04900000]: failed to assign

While this bug itself seems old, it has likely become more visible after
the relaxed tail alignment that does not grossly overestimate the size
needed for the bridge window.

Make sure add_align > min_align too results in adding an entry into the
realloc head list. In addition, add handling to the cases where add_size is
zero while only alignment differs.

Fixes: d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing and assigning")
Reported-by: Malte Schröder <malte+lkml@tnxip.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Malte Schröder <malte+lkml@tnxip.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251219174036.16738-2-ilpo.jarvinen@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 09a28cfcd5b88..ee8fe6e0de5fd 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -14,6 +14,7 @@
  *	     tighter packing. Prefetchable range support.
  */
 
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/init.h>
@@ -463,7 +464,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 					"%s %pR: ignoring failure in optional allocation\n",
 					res_name, res);
 			}
-		} else if (add_size > 0) {
+		} else if (add_size > 0 || !IS_ALIGNED(res->start, align)) {
 			res->flags |= add_res->flags &
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(dev, idx, add_size, align))
@@ -1392,12 +1393,13 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
 	resource_set_range(b_res, min_align, size0);
 	b_res->flags |= IORESOURCE_STARTALIGN;
-	if (bus->self && size1 > size0 && realloc_head) {
+	if (bus->self && realloc_head && (size1 > size0 || add_align > min_align)) {
 		b_res->flags &= ~IORESOURCE_DISABLED;
-		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
+		add_size = size1 > size0 ? size1 - size0 : 0;
+		add_to_list(realloc_head, bus->self, b_res, add_size, add_align);
 		pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
 			   b_res, &bus->busn_res,
-			   (unsigned long long) (size1 - size0),
+			   (unsigned long long) add_size,
 			   (unsigned long long) add_align);
 	}
 }
-- 
2.51.0


