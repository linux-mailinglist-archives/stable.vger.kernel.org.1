Return-Path: <stable+bounces-221694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLTQNGmYo2lIHwUAu9opvQ
	(envelope-from <stable+bounces-221694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:37:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4F71CB2C2
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86D65303872F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C1C2DC349;
	Sun,  1 Mar 2026 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5elU/al"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07E2773CC;
	Sun,  1 Mar 2026 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328912; cv=none; b=c5Inn6a+zoZC6HPojpPBHPbUYD0JSr+IinmKUKkIHVnZjLP9W55g6RzZtrhxBRZxnjoic4EtXT6VRmORhvAstwhJcARaC+Nmr++1DMEgh9xNC82gmYHcczwhyDsH2BNdheiAYTloeQx07tc2GFCQl44gGX6rhN/FY5B3MlHL9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328912; c=relaxed/simple;
	bh=GpVIQHtnx+7xhyOiT3tpNJy45Xx0iKxk7U0dzID4nkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rmsgbEkdJR2RWdfzLlJ/E4C6sLvjslGWTjyh5MwOFOGJnoJQ2+47KOpuphi1cp80YODbr9h/N3z81tceLHRggeHGmBTGkxZbrFDBnE5BgMtvhGC7hxrZuPtrUNexShnEE7EnE/yQW0+vFHDJbi5SVhCJ7ptYwA4jqU/lN5nn0d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5elU/al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3865AC19421;
	Sun,  1 Mar 2026 01:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328912;
	bh=GpVIQHtnx+7xhyOiT3tpNJy45Xx0iKxk7U0dzID4nkc=;
	h=From:To:Cc:Subject:Date:From;
	b=T5elU/al07smRNU4gYt620BF2mtseuT6nhoereyCaOSP4xqCpQB1ByWc9+ugJ0k0N
	 7GHORxaDkk1HDg1vp9f4xmaD5aSHLPfNBLwn+/IwH0kmE35/ZtR6x79G6IaF0rtheH
	 99AhnbwlD01+7YGv8P+ubSvKTAife+D33eWWP0GkDT4nCxU288RSbnFg+nqGcW92QA
	 O6tJlM4E08DhTFXcPXklr/DTCO/P5h3rY1y2CIxZ9MIVYSK8aL81BZIXTMFHo3aHSB
	 NGGGqtXvzorjggvXMKDrcUjHPYqQlxMWmtxxyhxN4utiq2miV58KgmpOwRkN0zRZqg
	 WHQLmUQlVXQVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: =?UTF-8?q?Malte=20Schr=C3=B6der?= <malte+lkml@tnxip.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI: Rewrite bridge window head alignment function" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:35:10 -0500
Message-ID: <20260301013511.1694780-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-221694-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 8E4F71CB2C2
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bc75c8e5071120e919beb39e69f0979cccfdf219 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 19 Dec 2025 19:40:15 +0200
Subject: [PATCH] PCI: Rewrite bridge window head alignment function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The calculation of bridge window head alignment is done by
calculate_mem_align() [*]. With the default bridge window alignment, it
is used for both head and tail alignment.

The selected head alignment does not always result in tight-fitting
resources (gap at d4f00000-d4ffffff):

  d4800000-dbffffff : PCI Bus 0000:06
    d4800000-d48fffff : PCI Bus 0000:07
      d4800000-d4803fff : 0000:07:00.0
        d4800000-d4803fff : nvme
    d4900000-d49fffff : PCI Bus 0000:0a
      d4900000-d490ffff : 0000:0a:00.0
        d4900000-d490ffff : r8169
      d4910000-d4913fff : 0000:0a:00.0
    d4a00000-d4cfffff : PCI Bus 0000:0b
      d4a00000-d4bfffff : 0000:0b:00.0
        d4a00000-d4bfffff : 0000:0b:00.0
      d4c00000-d4c07fff : 0000:0b:00.0
    d4d00000-d4dfffff : PCI Bus 0000:15
      d4d00000-d4d07fff : 0000:15:00.0
        d4d00000-d4d07fff : xhci-hcd
    d4e00000-d4efffff : PCI Bus 0000:16
      d4e00000-d4e7ffff : 0000:16:00.0
      d4e80000-d4e803ff : 0000:16:00.0
        d4e80000-d4e803ff : ahci
    d5000000-dbffffff : PCI Bus 0000:0c

This has not caused problems (for years) with the default bridge window
tail alignment that grossly over-estimates the required tail alignment
leaving more tail room than necessary. With the introduction of relaxed
tail alignment that leaves no extra tail room whatsoever, any gaps will
immediately turn into assignment failures.

Introduce head alignment calculation that ensures no gaps are left and
apply the new approach when using relaxed alignment. We may want to
consider using it for the normal alignment eventually, but as the first
step, solve only the problem with the relaxed tail alignment.

([*] I don't understand the algorithm in calculate_mem_align().)

Link: https://git.kernel.org/history/history/c/5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220775
Reported-by: Malte Schröder <malte+lkml@tnxip.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Malte Schröder <malte+lkml@tnxip.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251219174036.16738-3-ilpo.jarvinen@linux.intel.com
---
 drivers/pci/setup-bus.c | 53 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4b918ff4d2d8b..80e5a8fc62e70 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1228,6 +1228,45 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
 	return min_align;
 }
 
+/*
+ * Calculate bridge window head alignment that leaves no gaps in between
+ * resources.
+ */
+static resource_size_t calculate_head_align(resource_size_t *aligns,
+					    int max_order)
+{
+	resource_size_t head_align = 1;
+	resource_size_t remainder = 0;
+	int order;
+
+	/* Take the largest alignment as the starting point. */
+	head_align <<= max_order + __ffs(SZ_1M);
+
+	for (order = max_order - 1; order >= 0; order--) {
+		resource_size_t align1 = 1;
+
+		align1 <<= order + __ffs(SZ_1M);
+
+		/*
+		 * Account smaller resources with alignment < max_order that
+		 * could be used to fill head room if alignment less than
+		 * max_order is used.
+		 */
+		remainder += aligns[order];
+
+		/*
+		 * Test if head fill is enough to satisfy the alignment of
+		 * the larger resources after reducing the alignment.
+		 */
+		while ((head_align > align1) && (remainder >= head_align / 2)) {
+			head_align /= 2;
+			remainder -= head_align;
+		}
+	}
+
+	return head_align;
+}
+
 /**
  * pbus_upstream_space_available - Check no upstream resource limits allocation
  * @bus:	The bus
@@ -1315,13 +1354,13 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 {
 	struct pci_dev *dev;
 	resource_size_t min_align, win_align, align, size, size0, size1 = 0;
-	resource_size_t aligns[28]; /* Alignments from 1MB to 128TB */
+	resource_size_t aligns[28] = {}; /* Alignments from 1MB to 128TB */
+	resource_size_t aligns2[28] = {};/* Alignments from 1MB to 128TB */
 	int order, max_order;
 	struct resource *b_res = pbus_select_window_for_type(bus, type);
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
-	resource_size_t relaxed_align;
 	resource_size_t old_size;
 
 	if (!b_res)
@@ -1331,7 +1370,6 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 	if (b_res->parent)
 		return;
 
-	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
 	size = 0;
 
@@ -1382,6 +1420,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 			 */
 			if (r_size <= align)
 				aligns[order] += align;
+			aligns2[order] += align;
 			if (order > max_order)
 				max_order = order;
 
@@ -1406,9 +1445,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
 	if (bus->self && size0 &&
 	    !pbus_upstream_space_available(bus, b_res, size0, min_align)) {
-		relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
-		relaxed_align = max(relaxed_align, win_align);
-		min_align = min(min_align, relaxed_align);
+		min_align = calculate_head_align(aligns2, max_order);
 		size0 = calculate_memsize(size, min_size, 0, 0, old_size, win_align);
 		resource_set_range(b_res, min_align, size0);
 		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
@@ -1422,9 +1459,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
 		if (bus->self && size1 &&
 		    !pbus_upstream_space_available(bus, b_res, size1, add_align)) {
-			relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
-			relaxed_align = max(relaxed_align, win_align);
-			min_align = min(min_align, relaxed_align);
+			min_align = calculate_head_align(aligns2, max_order);
 			size1 = calculate_memsize(size, min_size, add_size, children_add_size,
 						  old_size, win_align);
 			pci_info(bus->self,
-- 
2.51.0





