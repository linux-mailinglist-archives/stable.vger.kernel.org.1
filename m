Return-Path: <stable+bounces-215942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBcdGYexjWmz5wAAu9opvQ
	(envelope-from <stable+bounces-215942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 11:55:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B8812CBD0
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 11:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D84C030F13B9
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F05314D2B;
	Thu, 12 Feb 2026 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="HNl6P126"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF99314D03
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893591; cv=none; b=RFDBox8sFVqlruWFonjVi4qnByMfq96KQbyUNTmcpn9TYDEdSMMQz1Yor0HZPbHcj+YXF8sApoN1Sxad4JIeO2kd0m+qm1jkbwNtXetZrGxVIjPlkqVU/sfR20rbrYFIOj+Yrji2+iuREsz6qVwGSspnm1jHxsyzNMMoh2wPzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893591; c=relaxed/simple;
	bh=QODKW3Mcvd5psbAB98MHCK7+ZWVDYdyCLvhF40H+wI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XE0AW/EXM4nY/rBm3rECLVW28XY8RCojNh9HEPnWIePJI+Rl5XRuaa/bOF3v06J10hl2ltohLUZBEcfZ6KDKmzue24lch2OPni5SA1wXQSGLjcCqof/EukjinQqhTVjHH9qdngOYfKU/g2ZCK6gdX1h65J1dYklSiyuz5peBU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=HNl6P126; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=HNl6P126EBTkodbXBvlQAX2+fGhMo2a46FkYJtf/2mvB60LsTX7YA2fU0TK3VOGX1wQHsAA2HcmuO
	 0xwM82sd02sA3pxZwe7Id3SMMg1XBdbMknH3OZgRCjyUTtFBPtyqh1rWufWQ1XQvB5hmEMlRnfKyhM
	 cdGZordgXCYQ/a5o=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from ubuntu24.corp.ad.wrs.com (unknown[120.244.194.126])
	by rmsmtp-lg-appmail-20-12023 (RichMail) with SMTP id 2ef7698db110fe2-976f4;
	Thu, 12 Feb 2026 18:53:06 +0800 (CST)
X-RM-TRANSID:2ef7698db110fe2-976f4
From: Bin Lan <lanbincn@139.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.1.y] net: dsa: free routing table on probe failure
Date: Thu, 12 Feb 2026 10:53:04 +0000
Message-ID: <20260212105304.4210-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[139.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[139.com];
	TAGGED_FROM(0.00)[bounces-215942-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[139.com:-];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,139.com];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,msgid.link:url]
X-Rspamd-Queue-Id: D2B8812CBD0
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 8bf108d7161ffc6880ad13a0cc109de3cf631727 ]

If complete = true in dsa_tree_setup(), it means that we are the last
switch of the tree which is successfully probing, and we should be
setting up all switches from our probe path.

After "complete" becomes true, dsa_tree_setup_cpu_ports() or any
subsequent function may fail. If that happens, the entire tree setup is
in limbo: the first N-1 switches have successfully finished probing
(doing nothing but having allocated persistent memory in the tree's
dst->ports, and maybe dst->rtable), and switch N failed to probe, ending
the tree setup process before anything is tangible from the user's PoV.

If switch N fails to probe, its memory (ports) will be freed and removed
from dst->ports. However, the dst->rtable elements pointing to its ports,
as created by dsa_link_touch(), will remain there, and will lead to
use-after-free if dereferenced.

If dsa_tree_setup_switches() returns -EPROBE_DEFER, which is entirely
possible because that is where ds->ops->setup() is, we get a kasan
report like this:

==================================================================
BUG: KASAN: slab-use-after-free in mv88e6xxx_setup_upstream_port+0x240/0x568
Read of size 8 at addr ffff000004f56020 by task kworker/u8:3/42

Call trace:
 __asan_report_load8_noabort+0x20/0x30
 mv88e6xxx_setup_upstream_port+0x240/0x568
 mv88e6xxx_setup+0xebc/0x1eb0
 dsa_register_switch+0x1af4/0x2ae0
 mv88e6xxx_register_switch+0x1b8/0x2a8
 mv88e6xxx_probe+0xc4c/0xf60
 mdio_probe+0x78/0xb8
 really_probe+0x2b8/0x5a8
 __driver_probe_device+0x164/0x298
 driver_probe_device+0x78/0x258
 __device_attach_driver+0x274/0x350

Allocated by task 42:
 __kasan_kmalloc+0x84/0xa0
 __kmalloc_cache_noprof+0x298/0x490
 dsa_switch_touch_ports+0x174/0x3d8
 dsa_register_switch+0x800/0x2ae0
 mv88e6xxx_register_switch+0x1b8/0x2a8
 mv88e6xxx_probe+0xc4c/0xf60
 mdio_probe+0x78/0xb8
 really_probe+0x2b8/0x5a8
 __driver_probe_device+0x164/0x298
 driver_probe_device+0x78/0x258
 __device_attach_driver+0x274/0x350

Freed by task 42:
 __kasan_slab_free+0x48/0x68
 kfree+0x138/0x418
 dsa_register_switch+0x2694/0x2ae0
 mv88e6xxx_register_switch+0x1b8/0x2a8
 mv88e6xxx_probe+0xc4c/0xf60
 mdio_probe+0x78/0xb8
 really_probe+0x2b8/0x5a8
 __driver_probe_device+0x164/0x298
 driver_probe_device+0x78/0x258
 __device_attach_driver+0x274/0x350

The simplest way to fix the bug is to delete the routing table in its
entirety. dsa_tree_setup_routing_table() has no problem in regenerating
it even if we deleted links between ports other than those of switch N,
because dsa_link_touch() first checks whether the port pair already
exists in dst->rtable, allocating if not.

The deletion of the routing table in its entirety already exists in
dsa_tree_teardown(), so refactor that into a function that can also be
called from the tree setup error path.

In my analysis of the commit to blame, it is the one which added
dsa_link elements to dst->rtable. Prior to that, each switch had its own
ds->rtable which is freed when the switch fails to probe. But the tree
is potentially persistent memory.

Fixes: c5f51765a1f6 ("net: dsa: list DSA links in the fabric")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250414213001.2957964-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Backport the fix to net/dsa/dsa2.c in v6.1.y for dsa2.c was
renamed back into dsa.c by commit
47d2ce03dcfb ("net: dsa: rename dsa2.c back into dsa.c and create its header")
since v6.2. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 net/dsa/dsa2.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 98f864879175..668699d7b0b7 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -1148,6 +1148,16 @@ static void dsa_tree_teardown_lags(struct dsa_switch_tree *dst)
 	kfree(dst->lags);
 }
 
+static void dsa_tree_teardown_routing_table(struct dsa_switch_tree *dst)
+{
+	struct dsa_link *dl, *next;
+
+	list_for_each_entry_safe(dl, next, &dst->rtable, list) {
+		list_del(&dl->list);
+		kfree(dl);
+	}
+}
+
 static int dsa_tree_setup(struct dsa_switch_tree *dst)
 {
 	bool complete;
@@ -1165,7 +1175,7 @@ static int dsa_tree_setup(struct dsa_switch_tree *dst)
 
 	err = dsa_tree_setup_cpu_ports(dst);
 	if (err)
-		return err;
+		goto teardown_rtable;
 
 	err = dsa_tree_setup_switches(dst);
 	if (err)
@@ -1197,14 +1207,14 @@ static int dsa_tree_setup(struct dsa_switch_tree *dst)
 	dsa_tree_teardown_switches(dst);
 teardown_cpu_ports:
 	dsa_tree_teardown_cpu_ports(dst);
+teardown_rtable:
+	dsa_tree_teardown_routing_table(dst);
 
 	return err;
 }
 
 static void dsa_tree_teardown(struct dsa_switch_tree *dst)
 {
-	struct dsa_link *dl, *next;
-
 	if (!dst->setup)
 		return;
 
@@ -1218,10 +1228,7 @@ static void dsa_tree_teardown(struct dsa_switch_tree *dst)
 
 	dsa_tree_teardown_cpu_ports(dst);
 
-	list_for_each_entry_safe(dl, next, &dst->rtable, list) {
-		list_del(&dl->list);
-		kfree(dl);
-	}
+	dsa_tree_teardown_routing_table(dst);
 
 	pr_info("DSA: tree %d torn down\n", dst->index);
 
-- 
2.43.0



