Return-Path: <stable+bounces-271692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bKV7Dw98R2rWZAAAu9opvQ
	(envelope-from <stable+bounces-271692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 11:08:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2BC700740
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 11:08:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wdc.com header.s=dkim.wdc.com header.b=A8FNESOM;
	dmarc=pass (policy=quarantine) header.from=wdc.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271692-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271692-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 359B630C72DE
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD21386557;
	Fri,  3 Jul 2026 08:47:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CD385D6B;
	Fri,  3 Jul 2026 08:47:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068469; cv=none; b=NH2n10zq+XZSiR24HEE7mir205ZqZjsm34Kbks7O577IhG9RylfN2vtByvxpGT8iombHMWMaQ85+2NWPaglFjoS0o/HDXLxWJZMqSdnvLQeds4dzW8dN8sw09N+W6iz+iPnP9/OBEB+Vr/yqpONXO8WCb1BEw4Usjc3M48u+leY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068469; c=relaxed/simple;
	bh=w0fsexi7MXFeOO/xpoXkxYO8P4fqzMLwCCWXGi46M7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljhewm8b+0OUUV1rGU9AbsogcDtpYrHqiE+of70gjN56wDCCMrNlJFLrt3jp4c+4VJOv0T40w0wSywVjw5s9cGEI2lB5Kit+1FyiDMR2JwQhlshlrUJOM7LUOaRQQPn64n1UamrqfeFmBv50qiIuoOL5hmc/j/qM9eRJ3BquwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=A8FNESOM; arc=none smtp.client-ip=216.71.154.42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783068468; x=1814604468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w0fsexi7MXFeOO/xpoXkxYO8P4fqzMLwCCWXGi46M7Y=;
  b=A8FNESOMHLIXM12GNLSRqC1EujAR8+gve0isWguvV6khXWhVHknMUFyL
   CMo/w1dhRdTnw1kLBBKxXfXBI03GoqQeJFW/wF6nSmrHNE4l1iZ9ZAxjT
   fMuk8rnIGElwQlvbmlmLg3ILEqeB3xFeiWbUef6mTNygXmOQT5HvGTsle
   3088LmSuncHsVDMfXtLO6jhrK5kNpxkcQvxcrJZCZrxdgZJJCIqZZZ6LG
   USp3G5QfMllxsD2L9HwI+pbcHhdVIevwxRHEWepxzvyzQA4ea5yz6Iamm
   W7sfdrDx2KjCAxUjIunWEMjw0UbMNx+XJTz8vzlSgZYZnVBZnR5UWCWXj
   A==;
X-CSE-ConnectionGUID: nLx0nX/aT+ad1jWYn8yufQ==
X-CSE-MsgGUID: NTYvehg9QBmEJ0bIWLh/dw==
X-IronPort-AV: E=Sophos;i="6.25,145,1779120000"; 
   d="scan'208";a="146156545"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2026 16:46:39 +0800
X-CSE-ConnectionGUID: 2o3jtba8QFqyvKqxWNpalg==
X-CSE-MsgGUID: wX43H3AhT1yyKFrVBqOyCg==
IronPort-SDR: 6a4776ca_389QZrYmFe4dZYXsDIK0pkMFQu7PAIunTztzKA8HaEuGvvg
 WJ9y0n/AnLRpQ9ftY6HQnpIZh+Be+ZivmtCNt1w==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2026 01:46:02 -0700
X-CSE-ConnectionGUID: Y3VWgAeaRiuXi/yd5oSxAA==
X-CSE-MsgGUID: /2b9ukckQzqgzNxkr+o39w==
WDCIronportException: Internal
Received: from wdap-kpvfcmq4pw.ad.shared (HELO neo.wdc.com) ([10.224.28.134])
  by uls-op-esai1-o.wdc.com with ESMTP; 03 Jul 2026 01:46:01 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: zoned: reset active_meta_bg on zone finish
Date: Fri,  3 Jul 2026 10:45:59 +0200
Message-ID: <20260703084559.136605-1-johannes.thumshirn@wdc.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271692-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-btrfs@vger.kernel.org,m:johannes.thumshirn@wdc.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes.thumshirn@wdc.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wdc.com:from_mime,wdc.com:email,wdc.com:mid,wdc.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E2BC700740

do_zone_finish() clears BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE and removes the
block group from zone_active_bgs, but only the path in
check_bg_is_active() resets fs_info->active_meta_bg / active_system_bg.
Any other finish path leaves active_meta_bg / active_system_bg pointing
at an inactive, fully written block group.

Reset the corresponding active_{meta,system}_bg pointer in do_zone_finish()
so it can never go stale.

Fixes: 13bb483d32ab ("btrfs: zoned: activate metadata block group on write time")
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 44a13ed6b8b2..c8c850de1702 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2539,6 +2539,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	const bool is_metadata = (block_group->flags &
 			(BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM));
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+	struct btrfs_block_group **active_bg = NULL;
 	int ret = 0;
 	int i;
 
@@ -2636,6 +2637,20 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	/* For active_bg_list */
 	btrfs_put_block_group(block_group);
 
+	if (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM)
+		active_bg = &fs_info->active_system_bg;
+	else if (block_group->flags & BTRFS_BLOCK_GROUP_METADATA)
+		active_bg = &fs_info->active_meta_bg;
+
+	if (active_bg) {
+		btrfs_zoned_meta_io_lock(fs_info);
+		if (*active_bg == block_group) {
+			btrfs_put_block_group(block_group);
+			*active_bg = NULL;
+		}
+		btrfs_zoned_meta_io_unlock(fs_info);
+	}
+
 	clear_and_wake_up_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags);
 
 	return 0;
-- 
2.54.0


