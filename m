Return-Path: <stable+bounces-221119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBZbLCxZo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:07:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0801C8CA9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D407316E327
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8895A37147A;
	Sat, 28 Feb 2026 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXKohXoq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C136DA0F;
	Sat, 28 Feb 2026 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301469; cv=none; b=l2fkYteE8dBfjqgQf7UFDPJcVVeHrlnA15ssLh9NnB6a5M5OycbKyDwihj9xKrAWuD002aKz7f9XBHAUjaNgqI9fro5GfRlykzd5HIHmnx0t7IkfFn8t2SCYZZD1JkDg/56bGFOxHdgsjMti2GMBe9YMk1hUqhXNCpyRD9akdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301469; c=relaxed/simple;
	bh=yMS0BgmJmKe5TSW4NOligMEP01OzhOnh2Eem50LILFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GU3zhg+S1ndhIX4GPmPz0xkivofcBD8Vde6O3EblqAO1qMdWOSDtxbWuh984ylMHSGqEKqiGxcXalnyvnqeMnKfG/O+M+KJ5+vUkiLgAZlhYF8Wc0KK20S3FLhi1+10R9YUbvFW3GQH3a934G4NTt2vchzpbTjr8kAj1/dAztRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXKohXoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEEAC19424;
	Sat, 28 Feb 2026 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301469;
	bh=yMS0BgmJmKe5TSW4NOligMEP01OzhOnh2Eem50LILFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXKohXoq3PrQXO87O4fAE5tuIo8cQhWXXA3BdTvfnJ1mf/OtmBG/WOzv8UJtHmRSu
	 naGnL8BZu5v5DySdsGT8tUo6JFlDCS8ySXGE4+mtqZP1gptloWOtQvBhuJe0H2YGfv
	 Uubp8XQPXTQ/oUA58HLoGbo5YHgYlTVDKvwMC/kMpmb3u7hSHHxp6cKnYFpF7suDHm
	 4nIkfEA1EnSGabVEDbLE355kwoZ9nztnjUdu4w28eaPGpf3DbEbTZx6mlv+sCpxO4b
	 XkCGwGMYAgvEl6Ma8lbTUh+7KERAFhDqyKH6DMByLKxwzrDCTaET5dzb9V2gjF5rki
	 loIyTfzpywnAg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	stable@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 654/752] btrfs: zoned: fixup last alloc pointer after extent removal for DUP
Date: Sat, 28 Feb 2026 12:46:05 -0500
Message-ID: <20260228174750.1542406-654-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-221119-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,wdc.com:email]
X-Rspamd-Queue-Id: DF0801C8CA9
X-Rspamd-Action: no action

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit e2d848649e64de39fc1b9c64002629b4daa1105d ]

When a block group is composed of a sequential write zone and a
conventional zone, we recover the (pseudo) write pointer of the
conventional zone using the end of the last allocated position.

However, if the last extent in a block group is removed, the last extent
position will be smaller than the other real write pointer position.
Then, that will cause an error due to mismatch of the write pointers.

We can fixup this case by moving the alloc_offset to the corresponding
write pointer position.

Fixes: c0d90a79e8e6 ("btrfs: zoned: fix alloc_offset calculation for partly conventional block groups")
CC: stable@vger.kernel.org # 6.16+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/zoned.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 8e6e96660fa66..4cbe1ba7af66d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1442,6 +1442,20 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 		return -EIO;
 	}
 
+	/*
+	 * When the last extent is removed, last_alloc can be smaller than the other write
+	 * pointer. In that case, last_alloc should be moved to the corresponding write
+	 * pointer position.
+	 */
+	for (int i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			continue;
+		if (last_alloc <= zone_info[i].alloc_offset) {
+			last_alloc = zone_info[i].alloc_offset;
+			break;
+		}
+	}
+
 	if (zone_info[0].alloc_offset == WP_CONVENTIONAL)
 		zone_info[0].alloc_offset = last_alloc;
 
-- 
2.51.0


