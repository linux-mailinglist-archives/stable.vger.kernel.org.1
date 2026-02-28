Return-Path: <stable+bounces-220810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ+IOWFFo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:43:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CA81C74AF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C6BE30E6C89
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1290A411E08;
	Sat, 28 Feb 2026 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXHErwXH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0B494A13;
	Sat, 28 Feb 2026 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300695; cv=none; b=eh3OKwB32bPO6gJgd096xY7qadABYdZ1sXv7QaqbxvCXzsKKcklpzc1oBPTUniE+gSSAg/vVSEut2UnE0DlSMPrhkCyBuSD1uza/j3E7YGitlsj1SFQ6ysVr2BVfbH9N8LLSuow4K+9TFfHX6D6y+9VuCi+xn5B9XggSGfCnZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300695; c=relaxed/simple;
	bh=xXjaISQWB5K+hLOvfvyVDRNcW/9pv1KrNdhC60jFPYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAVKhBA5Mhvvst/ami+ZIldJXWpqTlXmwuXLHjLniEeGHdOWbCupeqLxc2IMwtmxmqg8JP1gD3xOdhTaA50MSZhQJTcSERl2ysq+86QEkf2z1pfkdBI/NoAlVj3zc6p1sm6bcgPf2BASQgacMGfbXixSdeR9Vc9OZB2eGXQc/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXHErwXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB952C19425;
	Sat, 28 Feb 2026 17:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300695;
	bh=xXjaISQWB5K+hLOvfvyVDRNcW/9pv1KrNdhC60jFPYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXHErwXHgDFLtOvEfWKXcBcR24b3daU6A5Gg9ks1vxJMMZz1Kg3kwCf2Jviyw1M1H
	 lK96WQHedzKGn9tqXpj96zBHXHkJ/uKuk9fFG6kAdcbz09hFOsgR5BnoVSCxz5opDE
	 KjUCVmn4LbuX+md54mRYZyIIhAGrDzHeIP8MtqItUOs5QiaMVXHVXYqc12dogwhgiI
	 JUJaMDtFfUZETiS5cno/ZjchfP5UVoyVbY0dYH4KE4X5drJjqGi1xs6RjxmYWePxGj
	 Hveu5CRl739O2dWdk2jwt149TeUga/IMmRpj34QdzR9O8t5Nu20HoecbQ5wmAuBUYP
	 kMn4YBDK5pk0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 731/844] btrfs: zoned: fixup last alloc pointer after extent removal for DUP
Date: Sat, 28 Feb 2026 12:30:44 -0500
Message-ID: <20260228173244.1509663-732-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220810-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78CA81C74AF
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
index f27ba6e9b47d5..6c06581954181 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1449,6 +1449,20 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
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


