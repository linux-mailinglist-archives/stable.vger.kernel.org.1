Return-Path: <stable+bounces-226934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HFTC1/xuWkYPwIAu9opvQ
	(envelope-from <stable+bounces-226934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:27:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE652B4A2D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 337253055C8C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744291AE877;
	Wed, 18 Mar 2026 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTtTFjNN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFF3A1D2
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773793628; cv=none; b=ji9elCRNyaW/nnbHfmeIto+UtOQkixg3fj75423g40wcEM2HYGJiUZzK3wa0Ptza+e5J8cF8thgFnJAsx406yMXDm0ve9CXVE2HXZq1BVmwJCGIPQsJJFe/IHvkVGCw12NzuybWNZmUbjnQeu81Hp+4E62QtK7nJSxCNYASWP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773793628; c=relaxed/simple;
	bh=CdjofAXhgHBxExrrj7eI98tH4RFUEsA2GWFVmpXyLus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4tg4X1EIiIl0uuFgQqOq4jofBtb/DEWpwvfym7d/ZMBxRgYIn2QMThfXfvJN+f1LUu/0orDsMxH8irznuxKsiQZ1OazYG8UDk913cKnfTJqEGNJAJuTUjPDzPdsaC859iLwBIu3SOXc2l5myPYa2xSGrtAztOME9354lbfnRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTtTFjNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158C8C4CEF7;
	Wed, 18 Mar 2026 00:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773793627;
	bh=CdjofAXhgHBxExrrj7eI98tH4RFUEsA2GWFVmpXyLus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTtTFjNND2WWb35LviLVb06LKipq9gkA8CSvW5Z7c+YDFQgX2hd+SU05DHurCjver
	 aLWcwjkibtkLh8PVENN63hJaamR7xWQ3lmGhOvB5vleibaMlXI2X/XNiCmDofnHMc8
	 ddr6BKatD6eqWU/cSWTTlQcLqYzyf2YkT2un7bQ1dZc+dYi4NT1cWZ3L93Eri2FaZX
	 aZ+nnv1Bm3j/yuHtouCtkc9su/V9gXN1gtCvkCSRZeaQWkxgqEW0TMaZTCGcMTR8nH
	 hAB/mJZSnBr78+UNWGqMDI7L8lwm9NYU9HEV2Ukv27tYoeE2D7e7yhzNRgN5G0zAiv
	 4kmsKYDDDk0sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iomap: reject delalloc mappings during writeback
Date: Tue, 17 Mar 2026 20:27:04 -0400
Message-ID: <20260318002704.392804-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031712-recant-discount-9829@gregkh>
References: <2026031712-recant-discount-9829@gregkh>
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
	TAGGED_FROM(0.00)[bounces-226934-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CE652B4A2D
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
[ iomap_add_to_ioend() => iomap_writepage_map_blocks() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 397c96c25c31f..0178292c18648 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1879,18 +1879,19 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
 
 		switch (wpc->iomap.type) {
-		case IOMAP_INLINE:
-			WARN_ON_ONCE(1);
-			error = -EIO;
-			break;
-		case IOMAP_HOLE:
-			break;
-		default:
+		case IOMAP_UNWRITTEN:
+		case IOMAP_MAPPED:
 			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
 					end_pos, map_len);
 			if (!error)
 				(*count)++;
 			break;
+		case IOMAP_HOLE:
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			error = -EIO;
+			break;
 		}
 		dirty_len -= map_len;
 		pos += map_len;
-- 
2.51.0


