Return-Path: <stable+bounces-226935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rYjqHNT1uWnnPwIAu9opvQ
	(envelope-from <stable+bounces-226935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C61A2B4ADD
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A1E330200D6
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01171175A91;
	Wed, 18 Mar 2026 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NamDh/vv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E1FEED8
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794765; cv=none; b=tENaGDyPSEqd8ggiAbT5MiTMEImXDlTCeMUEHq+gZ56FpjRhb1VTEYpDnkD/hZumkji5B+viIAVxiWK9nCY2la5/FBMWQtqzh5iBIjBQ/umFeS3ul0bcwH534Qz3rtjCYUmzuhLWLg0NMSuIN4wyxBVyqR2tWdDmIhpIfor/9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794765; c=relaxed/simple;
	bh=lWeiDp/P+HqzVyjeFLZYWHE/wlYd0FATDZf4G7+yQUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSBuUEwccIOgrXVS6DLSNp/X3FM9QCfGnmoivxY8Xsku+Ge01aFGdYccDu5eG+K3abfo98RkIg6e1cSHAfAS4gvTqN56xsp5X+g7sO5xFEgEsuTJF2zUySYiDPBP36kFBTxSZrWNSwxhk6arDT5sKgxKKlKH7lmhmbOzqEGhHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NamDh/vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5DDC4CEF7;
	Wed, 18 Mar 2026 00:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773794765;
	bh=lWeiDp/P+HqzVyjeFLZYWHE/wlYd0FATDZf4G7+yQUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NamDh/vvP2zrMZTLKtk/lf5/5oqKFOjA2fN705VWQFOyJjjb6YaWc2V9MtdkI2nLb
	 UnHC1w5SemWcIJ3b+c2Kel3VhaDVAcUVLjkI1DQ78i0rviAW3T6lYdxL7I/L+HmumF
	 kFQKYxDffRLkezbwdyebZrvoJ7EDoWmY7WlXPnYF0a2Mn/5heZixd5i1up//JJtIir
	 gJq/bfqxKyvll8/dMO/sYdvq9CxFDrrnDn2S5Q6EUM47aKXxaQLREbjRu45C3aIibm
	 elFa5cDHMSZFmx7LVaETD4TXIzJuiVhAPNkNM6xvi0CeW12h9jpWi7LIYQNYWJtpEk
	 lPKe841ANp/Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iomap: reject delalloc mappings during writeback
Date: Tue, 17 Mar 2026 20:46:03 -0400
Message-ID: <20260318004603.406498-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031712-muskiness-fraction-b148@gregkh>
References: <2026031712-muskiness-fraction-b148@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226935-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email]
X-Rspamd-Queue-Id: 5C61A2B4ADD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit d320f160aa5ff36cdf83c645cca52b615e866e32 ]

Filesystems should never provide a delayed allocation mapping to
writeback; they're supposed to allocate the space before replying.
This can lead to weird IO errors and crashes in the block layer if the
filesystem is being malicious, or if it hadn't set iomap->dev because
it's a delalloc mapping.

Fix this by failing writeback on delalloc mappings.  Currently no
filesystems actually misbehave in this manner, but we ought to be
stricter about things like that.

Cc: stable@vger.kernel.org # v5.5
Fixes: 598ecfbaa742ac ("iomap: lift the xfs writeback code to iomap")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Link: https://patch.msgid.link/20260302173002.GL13829@frogsfrogsfrogs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ no ioend.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7e9480150d61e..c5d439f8e2254 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1838,10 +1838,19 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		if (error)
 			break;
 		trace_iomap_writepage_map(inode, &wpc->iomap);
-		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
-			continue;
-		if (wpc->iomap.type == IOMAP_HOLE)
+		switch (wpc->iomap.type) {
+		case IOMAP_UNWRITTEN:
+		case IOMAP_MAPPED:
+			break;
+		case IOMAP_HOLE:
 			continue;
+		default:
+			WARN_ON_ONCE(1);
+			error = -EIO;
+			break;
+		}
+		if (error)
+			break;
 		iomap_add_to_ioend(inode, pos, folio, ifs, wpc, wbc,
 				 &submit_list);
 		count++;
-- 
2.51.0


