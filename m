Return-Path: <stable+bounces-258512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHaWFBYoG2qS/ggAu9opvQ
	(envelope-from <stable+bounces-258512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:10:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1D761129D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDEC33018C1A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661C32F90E0;
	Sat, 30 May 2026 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lnXAnExh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF029B799;
	Sat, 30 May 2026 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164599; cv=none; b=h7GjajARTZ/Un6IwN71Jklws+/AZ2eAz5wCm77Be40CWLGbbspNlm/Q0rh6B/tZkNCi2bVLWS1yCQTF7pEU0yZyCCzjCABkfu0hgOEuRILq5ATXt6R72fgms3j2UcH+LhgkYKyn4tI8NN3suIRLoEjBpyYBUUe0/uQLQMfWcj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164599; c=relaxed/simple;
	bh=BiuQwAcslFsD9PeuL4XofGvVOVPs+8J3VmnarnSYJog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Taui98i16jaNzVTZvQbsttL4QcG1yrgHIRreG/DL8lFapV5sG+GjbSPeLAsz6KVElr/NfIdhi843IFtk54Fr1+x/rnVfyGKXIVzkmzmWUiABsPjN0mCPHwbCIdWZLNfRuALdcP1XSg1n6VwIpMaubP5ZQ04moIq1HjKXW3m5KpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lnXAnExh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4781F00893;
	Sat, 30 May 2026 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164597;
	bh=T5kc+O1jhz/EiABEIphtlZ738BRBexU3d2wJW3aBEbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lnXAnExhRREjGedk4wXY/tB8jnOMOXKzfzKZw0mSxS+o6Uqn5KePBGhsEgdSCM8Si
	 wKQhInR1FDmKrYul59XALNKWt5xAGvn4itGDnSmp4XAezM5aybnKFyv+P07GQQddCj
	 KBx2wTU1RyH6AYoaOFwwmpWvwPLF4mR7lYrGkla4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Mark Harmstone <mark@harmstone.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 603/776] btrfs: fix double-decrement of bytes_may_use in submit_one_async_extent()
Date: Sat, 30 May 2026 18:05:17 +0200
Message-ID: <20260530160255.609700716@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258512-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CB1D761129D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 27aaa5064ff7e..181c2d9041d1a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1001,7 +1001,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				     async_extent->ram_size - 1,
 				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW |
-				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
+				     EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK | PAGE_SET_ERROR);
 	free_async_extent_pages(async_extent);
-- 
2.53.0




