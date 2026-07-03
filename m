Return-Path: <stable+bounces-271637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yAm+LRxPR2qqVwAAu9opvQ
	(envelope-from <stable+bounces-271637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 07:56:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0E66FEE04
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 07:56:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wdc.com header.s=dkim.wdc.com header.b=gp9siDt6;
	dmarc=pass (policy=quarantine) header.from=wdc.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271637-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271637-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83DC930228B5
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 05:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3498035E1C1;
	Fri,  3 Jul 2026 05:55:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4235F5ED;
	Fri,  3 Jul 2026 05:55:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058111; cv=none; b=bLAppVsJH1/6coz7gm2kRnEspRBAH31UMgsQ7lTaLkO6P1mzXbvycMQRI5zYk7W3jUDeJSOi48c3FXfG2EkwX9uzanlJETr39IvEqrRsNcHUOKa8q2FhQgSxkN1CBssOA+w7UIqan6HLv5LBV71Rcp2mOSAL3+/CwyspAFUQDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058111; c=relaxed/simple;
	bh=cpYDhPRBOsCHWtbvTGNcTpiU1B1Su3/m7lFW71xVwyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azZiGUxafqQCSyt11aDRYatOjXmJUT5CQWdEjikU3YirU5uj3p7EWx03rbxHcthLm8HHlOaPdYWlzK70FARWaVwX7fTL81q5STAZZA2qKJ4goFFM/XMrtF85Ogq3ounWhxDxz/tfASmn30/4gei8AleT3mSK7Ls3PRDrsyAi2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gp9siDt6; arc=none smtp.client-ip=68.232.143.124
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783058109; x=1814594109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cpYDhPRBOsCHWtbvTGNcTpiU1B1Su3/m7lFW71xVwyY=;
  b=gp9siDt6vM8Y+Yug2hRk2t5XKqUWTi6AxT8tEe9bWxpvABPEYwUi88Aa
   Xm31pHon+DjI47pA4WwzoI6lQWDKW7t++insQ1UTpLx16vxPjSDH1KDj0
   ZL0N2N6THitNz3prB8ZvHbQrBFEOxdkqEfQu31N1WFjdspeRN/OkKkN9r
   k+P9U53Hu3yHaqQuw8ThS+BJnkjnBisj+Ap6f3havscIBf8Q8OHELbLpP
   TXUbF3w/2fm2UOdgQn8kQCH5LFlsVhIpPPipgot57cejRcUtiKInQxWKy
   JX+2FKEpqaHf68+sQpnSFhoU47NF5AtmULdbzaPvZawf3eXiH5VlKQcVN
   A==;
X-CSE-ConnectionGUID: 6Sg3KzSnRASH9e9oDGzY/Q==
X-CSE-MsgGUID: ml53/CyrTsibPQrNvxy4tA==
X-IronPort-AV: E=Sophos;i="6.25,145,1779120000"; 
   d="scan'208";a="151204828"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2026 13:55:00 +0800
X-CSE-ConnectionGUID: f/kO9TsSQyCXh5gQu3BavQ==
X-CSE-MsgGUID: TVykZTGER9qp/71qdC0UfQ==
IronPort-SDR: 6a474ea9_X/JTLXgyKfR2vuMdJVeZp9/dslx7Ye4zETVnoHhacDn3Dtj
 6Dsignny3kAohFYAOf0cXGCNuCCInRyNQffaxQg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jul 2026 22:54:48 -0700
X-CSE-ConnectionGUID: Rzov4/oRRMGQDk6493+6fg==
X-CSE-MsgGUID: nDiOL+egSIWZfhVkGpzETw==
WDCIronportException: Internal
Received: from c02g32sfmd6m.ad.shared (HELO neo.wdc.com) ([10.224.28.132])
  by uls-op-esai1-o.wdc.com with ESMTP; 02 Jul 2026 22:54:48 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: zoned: reset meta_write_pointer on zone reset
Date: Fri,  3 Jul 2026 07:54:45 +0200
Message-ID: <20260703055445.117214-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271637-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-btrfs@vger.kernel.org,m:naohiro.aota@wdc.com,m:johannes.thumshirn@wdc.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes.thumshirn@wdc.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,wdc.com:from_mime,wdc.com:email,wdc.com:mid,wdc.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF0E66FEE04

btrfs_reset_unused_block_groups() resets a block group's zone and sets
alloc_offset back to 0 so the space can be reused, but it leaves
meta_write_pointer pointing at the previous end of the zone.

Once the block group is reactivated and reused for metadata, newly
allocated tree blocks live before that stale write pointer.
btrfs_check_meta_write_pointer() then sees them behind the write pointer,
so they can never be written out in sequential order: the dirty extent
buffers are stranded and pin their btree_inode folios until unmount.

Reset meta_write_pointer back to the start of the block group for
metadata and system block groups.

Fixes: 453a73c3069a ("btrfs: zoned: reclaim unused zone by zone resetting")
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ab7c3cc52599..765655473263 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -3218,6 +3218,17 @@ int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num
 		reclaimed = bg->alloc_offset;
 		bg->zone_unusable = bg->length - bg->zone_capacity;
 		bg->alloc_offset = 0;
+		/*
+		 * The zone was just reset to empty, so alloc_offset went back to
+		 * the start of the zone. For metadata/system block groups the
+		 * write pointer must follow it back to the start of the zone;
+		 * otherwise it stays stale at the previous (finished) zone end,
+		 * and metadata written into the reused zone would sit behind the
+		 * write pointer, could never be written out in sequential order,
+		 * and would be stranded (pinning its folio) until unmount.
+		 */
+		if (bg->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM))
+			bg->meta_write_pointer = bg->start;
 		/*
 		 * This holds because we currently reset fully used then freed
 		 * block group.
-- 
2.54.0


