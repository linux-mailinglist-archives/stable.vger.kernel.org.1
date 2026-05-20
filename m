Return-Path: <stable+bounces-253213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHCfIMUFDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-253213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:04:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E266D597AF0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 185C732B0CB8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7017540DFDE;
	Wed, 20 May 2026 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufPDGZhP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213F3FD15C;
	Wed, 20 May 2026 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302697; cv=none; b=u78+Jf9rLSLwClah06Srv64plkjV8VnI9UlRemthmQq44SqdAbH5dMaccpVSPjl9TAmi1d7OVpyGnQLgTgBK2dAuHmg1D6Pw0Ud2HRa2NfelOFMkP7Hx1h74/Emm0l+5B1LJMmxUttlWq8wmeKXtUr1NfkXwzvhOv8fvkalSozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302697; c=relaxed/simple;
	bh=Mc/2p+TouOg4v/MwjjfspFjo8Ox+Np+RdJ2ViRp4QlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpytfnEGTexCHpVjilKFCFtuWSTMA+AO6d9RJ39u7i96V69romkfNj54+q6ORDnfDNPq6ihm8kY69PNQwVyF2zyqF1r4Xy89q7EFCd9e38kBrdxG42a4bMsLqkCMO2NVegx4R6Ripbd4g886RS3NkiIKBrnXVda6zOlciJ1aZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufPDGZhP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972D01F000E9;
	Wed, 20 May 2026 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302696;
	bh=V1qpNHXbW5pyn0iL+MHi12ODAC8iPt8OOna2DfpXfns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ufPDGZhPt4esC88godE8sc70/j+5e22GwAuR7SVAiz0h1UlGOxur48ccDCB5Lu7DP
	 5fsKuTRepaevt5rfWkw87dskfgSthq4iW8uRaw71vVs0JKBsJKRLFxZICTSUnaUhpe
	 LHG9aThiA1EmgmQpM+GbKDOI1Kaz0vhIcDs/F0Fg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Mark Harmstone <mark@harmstone.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 365/508] btrfs: fix double-decrement of bytes_may_use in submit_one_async_extent()
Date: Wed, 20 May 2026 18:23:08 +0200
Message-ID: <20260520162106.537471951@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253213-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E266D597AF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Harmstone <mark@harmstone.com>

[ Upstream commit 82323b1a7088b7a5c3e528a5d634bff447fa286f ]

submit_one_async_extent() calls btrfs_reserve_extent(), which decrements
bytes_may_use. If the call btrfs_create_io_em() fails, we jump to
out_free_reserve, which calls extent_clear_unlock_delalloc().

Because we're specifying EXTENT_DO_ACCOUNTING, i.e.
EXTENT_CLEAR_META_RESV | EXTENT_CLEAR_DATA_RESV, this decreases
bytes_may_use again. This can lead to problems later on, as an initial
write can fail only for the writeback to silently ENOSPC.

Fix this by replacing EXTENT_DO_ACCOUNTING with EXTENT_CLEAR_META_RESV.
This parallels a4fe134fc1d8eb ("btrfs: fix a double release on reserved
extents in cow_one_range()"), which is the same fix in cow_one_range().

Fixes: 151a41bc46df ("Btrfs: fix what bits we clear when erroring out from delalloc")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Mark Harmstone <mark@harmstone.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 46df425ab7bae..00cd932791c8d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1209,7 +1209,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	extent_clear_unlock_delalloc(inode, start, end,
 				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW |
-				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
+				     EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
 	free_async_extent_pages(async_extent);
-- 
2.53.0




