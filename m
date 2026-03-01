Return-Path: <stable+bounces-221433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKteA4GVo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 702041CA825
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A56133024196
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091622750E6;
	Sun,  1 Mar 2026 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3aYX4DO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0638C8F0;
	Sun,  1 Mar 2026 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328253; cv=none; b=YveF36d64YrITh8FhRf+NARFCICapWWYCU5N/DZB09YWiMW9y8KepHzpFOq31WK56ivf/T3XkxM5hCrTZcujvBPuv0k7nXameLoWoxUDOVCVxIbSxLzfE1DT85Nt74SAsfEAbk5O8BluX8Xp0qljT1pSDRJ9EWyz7+XaWqRh688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328253; c=relaxed/simple;
	bh=Nbp/rGnzUuLFmZ6dBof+7IF9zvr4JZdQP+uO9PRHoXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E+yheL/jlV5hwD4uxjnEaJnqi7WuU16ekVFuIJjTk6nG1mKaKYvOwsWs4Ew/Z5uyuV2OIDPrrDsV5hGS0h1ad+VUiovos339B0XVD0HTm+hsc+elCOt0K5CrApIUX06NiLgc3snAd0uc1HugkaRaDnI3gJbsj3YVY7DuXAVi+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3aYX4DO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12111C19421;
	Sun,  1 Mar 2026 01:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328253;
	bh=Nbp/rGnzUuLFmZ6dBof+7IF9zvr4JZdQP+uO9PRHoXE=;
	h=From:To:Cc:Subject:Date:From;
	b=C3aYX4DOmIBhaCzoSeyk1XSsuJ2GGkw/ZgExX9uFiiAfLc2SzK4gea30XRdvkFL/i
	 YJVXRv4kxVUlJRkRTx6Lqt8HDz+Jt3qoiKaEwQ5WnYv3CaKlONy9Paxp3L4pXBJfV8
	 JAb4jltVeZLN5UTOv9ToG8wCTktipfQGCkOTsfnrr1WQDJv9u9xqpAIRDVEo47wvjJ
	 grKxCbwswWxV2F2WZ18hAtehTRTp28T7+k27k68QTsqGSQd6TZo4gdj1o9FxDaCrTz
	 nWAEXq2ZgZ8jv7zhqp8RBxnncflQDLS0zgApezUeP8QS3eY08sqNU3O2QgqSYvsqQv
	 sqnWAXKpw7S1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: =?UTF-8?q?Malte=20Schr=C3=B6der?= <malte+lkml@tnxip.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI: Fix bridge window alignment with optional resources" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:24:11 -0500
Message-ID: <20260301012411.1680981-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221433-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,intel.com:email,tnxip.de:email]
X-Rspamd-Queue-Id: 702041CA825
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7e90360e6d4599795b6f4e094e20d0bdf3b2615f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 19 Dec 2025 19:40:14 +0200
Subject: [PATCH] PCI: Fix bridge window alignment with optional resources
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/pci/setup-bus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6e90f46f52afd..4b918ff4d2d8b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -14,6 +14,7 @@
  *	     tighter packing. Prefetchable range support.
  */
 
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/init.h>
@@ -456,7 +457,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 					"%s %pR: ignoring failure in optional allocation\n",
 					res_name, res);
 			}
-		} else if (add_size > 0) {
+		} else if (add_size > 0 || !IS_ALIGNED(res->start, align)) {
 			res->flags |= add_res->flags &
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(dev, idx, add_size, align))
@@ -1442,12 +1443,13 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
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





