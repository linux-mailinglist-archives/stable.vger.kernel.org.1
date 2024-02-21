Return-Path: <stable+bounces-23145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4180485DF96
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 440BDB228D9
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D967BB16;
	Wed, 21 Feb 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gni/RsAL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02279DBF;
	Wed, 21 Feb 2024 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525713; cv=none; b=oPuTV9P+PHAKZ1pdbb9LMyTACQTYSco2WXwr02Lc88E3pdTH/5kaTQghM8XkAWAE3klxQrnOEEv0NRBvVY18+qWzEbPkuXWgPb+J8M1W5NcMVlNprICAajGucAbYaW9Fqbc+u8gtPPQLCDrRX4nMnGuGmzhKNbwCCg87Hi2UjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525713; c=relaxed/simple;
	bh=l9ZIZ2gV0ks5mwgPIaFScrYsCH5uC0HJp5Cs/XDSUM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl8xcN7W460qZMp8Qfq7kHVrWtpe3RnHh8h/nWiuyaJ26TPVEZmX/aWqELAJqRtyzLKiKD5sRmpPK2cklhbFIZB2OG4NxZaVgiSgHsyOqmL74kaCSoeguJ5R725wZ2pg3SZwlfABke0nPQjaFHriJJXSzJAV5zH8mjFC/ysJP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gni/RsAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5448FC43390;
	Wed, 21 Feb 2024 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525712;
	bh=l9ZIZ2gV0ks5mwgPIaFScrYsCH5uC0HJp5Cs/XDSUM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gni/RsALRdfbPACu/WzkA3ffpEtBq+Uhm1wKPaN9es8ocHFVKOpQcGIqFzoeklWzV
	 wscL8bQ8joUO3ZKPzia0DGvhMZR6LXaBHaDu9c6oukg4kP6pUhRnxivse9hjckLXsj
	 a3aoiLkzCS5XaVNDkm39scln/Fs0inBZpsie4cYI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	syzbot+ee2ae68da3b22d04cd8d@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 241/267] nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
Date: Wed, 21 Feb 2024 14:09:42 +0100
Message-ID: <20240221125947.817409525@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit 38296afe3c6ee07319e01bb249aa4bb47c07b534 upstream.

Syzbot reported a hang issue in migrate_pages_batch() called by mbind()
and nilfs_lookup_dirty_data_buffers() called in the log writer of nilfs2.

While migrate_pages_batch() locks a folio and waits for the writeback to
complete, the log writer thread that should bring the writeback to
completion picks up the folio being written back in
nilfs_lookup_dirty_data_buffers() that it calls for subsequent log
creation and was trying to lock the folio.  Thus causing a deadlock.

In the first place, it is unexpected that folios/pages in the middle of
writeback will be updated and become dirty.  Nilfs2 adds a checksum to
verify the validity of the log being written and uses it for recovery at
mount, so data changes during writeback are suppressed.  Since this is
broken, an unclean shutdown could potentially cause recovery to fail.

Investigation revealed that the root cause is that the wait for writeback
completion in nilfs_page_mkwrite() is conditional, and if the backing
device does not require stable writes, data may be modified without
waiting.

Fix these issues by making nilfs_page_mkwrite() wait for writeback to
finish regardless of the stable write requirement of the backing device.

Link: https://lkml.kernel.org/r/20240131145657.4209-1-konishi.ryusuke@gmail.com
Fixes: 1d1d1a767206 ("mm: only enforce stable page writes if the backing device requires it")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+ee2ae68da3b22d04cd8d@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/00000000000047d819061004ad6c@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/file.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -105,7 +105,13 @@ static vm_fault_t nilfs_page_mkwrite(str
 	nilfs_transaction_commit(inode->i_sb);
 
  mapped:
-	wait_for_stable_page(page);
+	/*
+	 * Since checksumming including data blocks is performed to determine
+	 * the validity of the log to be written and used for recovery, it is
+	 * necessary to wait for writeback to finish here, regardless of the
+	 * stable write requirement of the backing device.
+	 */
+	wait_on_page_writeback(page);
  out:
 	sb_end_pagefault(inode->i_sb);
 	return block_page_mkwrite_return(ret);



