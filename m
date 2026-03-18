Return-Path: <stable+bounces-226945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHNWBs36uWlfQAIAu9opvQ
	(envelope-from <stable+bounces-226945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 02:07:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD582B4D80
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 02:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE90B3091F8A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A55225760;
	Wed, 18 Mar 2026 01:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5qqbjck"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E9F21423C
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796014; cv=none; b=cM/iqBd9KdHnnPRxmi0M6WZkjQrj7bX2yurizbyVhOluW1jRTFOZSgdyqZkF4U0sPLMaFsSX5rXN2/ApUF7sUvAFhEWJVyem2xvcngfpGI52TfOmjk8aqH8efDKa5HLyJNagPk5Z2VfjgUMtV02RtgTTRPCMSq0wfxKeT2PyCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796014; c=relaxed/simple;
	bh=cfeNsB2ENCgCxoX0gjxMTAFWmh3h3ttbvIznt0GjAWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGJkAA6UJHkmdjYBIKrlJxjeS17gKKv6tVHLp/XEw02/AA7lKq7YIHYIswSY2Ggt0zeUmk709kDi0kO1utMyJ3ZrGr6UdoJQACjTXHdAo6tB1DyW4J03XzDnn7182FamjBzPPbKs4Lqd3i79EM1jeOxQPw10+S//VMzRFkWAlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5qqbjck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF245C4CEF7;
	Wed, 18 Mar 2026 01:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773796013;
	bh=cfeNsB2ENCgCxoX0gjxMTAFWmh3h3ttbvIznt0GjAWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5qqbjcklWaSTb+goVb/NxvpzIWxw73lRFt6zBLNDB+ESX2Gjnm8IQJaDji2H7btd
	 RjLV8soVanmdfD3LMVkLDOx2q9LaimkUWh5q3znenhfObGvycLavRoNgqGBVEvh5LK
	 3+Nfgj34uNuXtllZQXzdCvYmHWT/8E8sZud8hHIwtn/lW10Gqp2LsYHr6ZECOG0A2t
	 c6LUzN9tTtmgdqDCaptGNFqLwA56GBZa3sdhUyxOpY9+HaHqdCjbHAPp3PdmwSW9La
	 kjc33wyPDSL4a/OQEucZqDcy0U7iv4fqzeBSlBOS1nZog8X+3jrvaADkAmz0ZwVjXz
	 hdypqpuhdvk5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iomap: reject delalloc mappings during writeback
Date: Tue, 17 Mar 2026 21:06:50 -0400
Message-ID: <20260318010650.420596-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031713-ride-olympics-fd2c@gregkh>
References: <2026031713-ride-olympics-fd2c@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226945-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 6CD582B4D80
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
[ switch -> if ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e4f58d1e12d48..c3408ba636632 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1620,10 +1620,13 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		if (error)
 			break;
 		trace_iomap_writepage_map(inode, &wpc->iomap);
-		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
-			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
+		if (WARN_ON_ONCE(wpc->iomap.type != IOMAP_MAPPED &&
+				 wpc->iomap.type != IOMAP_UNWRITTEN)) {
+			error = -EIO;
+			break;
+		}
 		iomap_add_to_ioend(inode, pos, folio, iop, wpc, wbc,
 				 &submit_list);
 		count++;
-- 
2.51.0


