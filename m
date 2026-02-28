Return-Path: <stable+bounces-220809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB0rEC9Do2li+wQAu9opvQ
	(envelope-from <stable+bounces-220809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:34:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C748F1C71F1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B32BD30156D2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2629A411637;
	Sat, 28 Feb 2026 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqdwxDyL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0F41162C;
	Sat, 28 Feb 2026 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300694; cv=none; b=F19rvv5EJ5m9f84YAAMNdICs7KKMaG6nLN7nkhn5AeMJAJGTN8ViZuQ0vov2+hLcCP/ioo+HOHCOjf2DPq49+917kXtjRAxl5wIWqYA0smVhi4/5y6mYdpmbZF3nsRZosmY2z3bbWTN0dCsMDwhdrYNn4TeVWP4Um/CK99wQJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300694; c=relaxed/simple;
	bh=uFmPrhAMgpqXea1OZKq/YcQkGw59/awQ2V/rHRDjTy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+t7SsT+go659slIjKqgctVvWemGtMU0+2TGU/ceU3q3Z7dLx5PCZ48q+pv6OKmGtTfu4WG9jZ21fVFrVD3J/Vi1sDp7hNUwUHE+XqPuA1+8iqwnPcl2l7MQl29n57jyBMOuvjQ2Ugacmhdpkl377dYSXesvrffiE7Lu0QMO22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqdwxDyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011A1C116D0;
	Sat, 28 Feb 2026 17:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300694;
	bh=uFmPrhAMgpqXea1OZKq/YcQkGw59/awQ2V/rHRDjTy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqdwxDyLujQUsOcq/6Bn3AMZTXnfHjuM2MdaVkzokTnIXwmfTOromdiXusj9NOOOv
	 zmKSxRF5qbuI/zr1ADAxnxRfw3Xj3+Y0l/zGy4kmmvWvUH+2yGS14SYV1cPabfiKKo
	 +g8e+UmAutswDSAr8UVsiKParAKSnke+q7dLfYDmDqVJ8c0eM+Equo6+WPihf2N3sK
	 /OIXSAwX22Ivg1JUkyMOTmtuckdg72Z1g1hpaVVTgqerIbetseSwYiaiRRG8tKSy6h
	 Aqk1oIQBek0y3cwrwwJ3lI5qx6amrpI4Q4Mn4CqOiJ6L9bnyAjX8i4peMAluXHZNtT
	 hgkBlDz+JV88A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 730/844] btrfs: zoned: fixup last alloc pointer after extent removal for RAID1
Date: Sat, 28 Feb 2026 12:30:43 -0500
Message-ID: <20260228173244.1509663-731-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220809-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C748F1C71F1
X-Rspamd-Action: no action

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit dda3ec9ee6b3e120603bff1b798f25b51e54ac5d ]

When a block group is composed of a sequential write zone and a
conventional zone, we recover the (pseudo) write pointer of the
conventional zone using the end of the last allocated position.

However, if the last extent in a block group is removed, the last extent
position will be smaller than the other real write pointer position.
Then, that will cause an error due to mismatch of the write pointers.

We can fixup this case by moving the alloc_offset to the corresponding
write pointer position.

Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid stripe tree")
CC: stable@vger.kernel.org # 6.12+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/zoned.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 359a98e6de851..f27ba6e9b47d5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1490,6 +1490,21 @@ static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
 	/* In case a device is missing we have a cap of 0, so don't use it. */
 	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
 
+	/*
+	 * When the last extent is removed, last_alloc can be smaller than the other write
+	 * pointer. In that case, last_alloc should be moved to the corresponding write
+	 * pointer position.
+	 */
+	for (i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			continue;
+		if (last_alloc <= zone_info[i].alloc_offset) {
+			last_alloc = zone_info[i].alloc_offset;
+			break;
+		}
+	}
+
 	for (i = 0; i < map->num_stripes; i++) {
 		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
 			continue;
-- 
2.51.0


