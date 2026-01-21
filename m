Return-Path: <stable+bounces-210988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O3vJbwrcWl1fAAAu9opvQ
	(envelope-from <stable+bounces-210988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:40:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 627DA5C5E2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A11986324B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA15358D0F;
	Wed, 21 Jan 2026 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E6WVQ3LY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EB334A3D6;
	Wed, 21 Jan 2026 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020059; cv=none; b=FQ4qATCmu2MI0LzNrIGr4hhsB620s5QWYcWEKZyzSmzi5OcVZaimr/N/GTBjBGFEzhcInomQOcTCesLmCr8QNr2rCWoiGV2GJn5iyUoQi5fjyvtYqGcMFSKt4jVkkhmj0Y8tFKZqDqr1XUsW5FP5pfdbnQZp0J8PFE0htATEA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020059; c=relaxed/simple;
	bh=KmhDBQMfrP2FWOtNSLo4VM/GO4s9IzB9EqYeDg6wQhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oo/eL6g2Km7Caj1utM2aOINQV5sumL6wblc9T4Av3pn9ondaYvrv0aDtE+sBL5K/YysrloBOltcKj9i3h0GrkjsuecdaGLI7iokueVsRY+rAVoJTtjJWxh2pX/MpoBuyBS3/Y8KGu6tT2gvyxRnyT9a1kyma0/s7ys3CCiHlH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E6WVQ3LY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92951C4CEF1;
	Wed, 21 Jan 2026 18:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020059;
	bh=KmhDBQMfrP2FWOtNSLo4VM/GO4s9IzB9EqYeDg6wQhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6WVQ3LYi23/P/rrdyehw/ROKIKfr9tDxinlQ5SLPt/WI2MLjxtXRe3vip0xa0WlH
	 C3uegqp4Z9DDuDs51ODtgWcP3mkdd1shUb9cGoE/5WNFhsJXnUAzSWFD867aKw92t+
	 QO4u4M66lujZortp9gHWLXGr10l6fo/X8NI6HhYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 030/198] btrfs: send: check for inline extents in range_is_hole_in_parent()
Date: Wed, 21 Jan 2026 19:14:18 +0100
Message-ID: <20260121181419.637451498@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210988-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 627DA5C5E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 08b096c1372cd69627f4f559fb47c9fb67a52b39 ]

Before accessing the disk_bytenr field of a file extent item we need
to check if we are dealing with an inline extent.
This is because for inline extents their data starts at the offset of
the disk_bytenr field. So accessing the disk_bytenr
means we are accessing inline data or in case the inline data is less
than 8 bytes we can actually cause an invalid
memory access if this inline extent item is the first item in the leaf
or access metadata from other items.

Fixes: 82bfb2e7b645 ("Btrfs: incremental send, fix unnecessary hole writes for sparse files")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 96a030d28e091..9012ce7a742f4 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6399,6 +6399,8 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 		extent_end = btrfs_file_extent_end(path);
 		if (extent_end <= start)
 			goto next;
+		if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE)
+			return 0;
 		if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
 			search_start = extent_end;
 			goto next;
-- 
2.51.0




