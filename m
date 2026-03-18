Return-Path: <stable+bounces-227026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oALhCCSPumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:40:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8701E2BAF4C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44027302573D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD34337998A;
	Wed, 18 Mar 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7HpdAem"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D4261B8D
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833838; cv=none; b=Z4CM7or/uQxXTPvsgZRWSZZGyEly7Cr+56i+yUJ0DbiCT037owyxE+uKmhSn6F0M64GJ3/03FDInRyBzez08fgn5cxLy1B5/mo1Z/9h7ah9mKfofsMRg6QtBMb7bX6gafTlwgqI0CceyTMQ9ALzJQE0NyGJGZ20Rq14/LPEQQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833838; c=relaxed/simple;
	bh=yzRTdpVDp02L2g186uJ353lMFJgY2ynPbRvt89Ey/3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJKunLlLjNqJ6C0q+11S2T2WsFCQtjofTAZ+IIbdKmSSRxWEAaGHIY2yzUXJ+oK2CQnxsQmr+NUyIV4Ei13cc0FJiR7wZy8cS68Ukx+XbBtPGhMECQgNAQQ/UdnVP425/SSJ+exWhALGU/F/vsQzwv0WcI69CwvO6nTcShl6rAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7HpdAem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E23BC19421;
	Wed, 18 Mar 2026 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773833838;
	bh=yzRTdpVDp02L2g186uJ353lMFJgY2ynPbRvt89Ey/3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7HpdAemCyJylzKXUDQARPfsvlj6UQeOMkttJKqTmGtgwmUl6cLpS2PnGqd036akg
	 jLSN1iNEEjBrjzRsZ8+8ZHFbsF/UREUMh3RF/RmRAwErA9SzF83vHXxlUqUP1+XDQb
	 N6UdSQiZf34aLP8EQrAX+wpLLM1VMoMoQ778Q3R8Uoxjq7BJ7nwGULhoYI52GPpIVF
	 Sslo1KpfoEnINKCX7/g4dDm0TGKfMEH1t/T4HPPQqdjRIh+yJ2H02jJliWufxCD09+
	 oKm3D014XfdO8SEXbYiqjrTwVOV0GT58b+PLxGpJs58uZFcv1cb89luYsqfts6bFUE
	 jQc7zWtdJdMyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iomap: reject delalloc mappings during writeback
Date: Wed, 18 Mar 2026 07:37:16 -0400
Message-ID: <20260318113716.629956-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031714-steadfast-uneaten-7cfd@gregkh>
References: <2026031714-steadfast-uneaten-7cfd@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227026-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,lst.de:email]
X-Rspamd-Queue-Id: 8701E2BAF4C
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
[ Different error handling structure ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 86297f59b43e2..219f9e1a26436 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1364,10 +1364,13 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		error = wpc->ops->map_blocks(wpc, inode, file_offset);
 		if (error)
 			break;
-		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
-			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
+		if (WARN_ON_ONCE(wpc->iomap.type != IOMAP_UNWRITTEN &&
+				 wpc->iomap.type != IOMAP_MAPPED)) {
+			error = -EIO;
+			break;
+		}
 		iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
 				 &submit_list);
 		count++;
-- 
2.51.0


