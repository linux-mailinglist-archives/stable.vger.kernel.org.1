Return-Path: <stable+bounces-173261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76097B35CBD
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E41189C6F7
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE4333A01B;
	Tue, 26 Aug 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oJeKvZXu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E032144F;
	Tue, 26 Aug 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207788; cv=none; b=EmlLxgUXimwtstdZOKpIsU7cPf3yNmISdaJlsLsbYQFp8H4rbZqw8iTt8y0w+UulaqFoEgoQlxCC5qw9iJ3o6fxRf4l2XGSO/5RfbeQSodRsRl4+9tffMIwtQ1dGTrjQkYC6utq0cptKHn+3r1A6i/lF5jmzoj+/H5izM4vDKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207788; c=relaxed/simple;
	bh=NN/VGsWHWzTntBi+JJIAofKbczPXARncCuGSJaN6Slo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pI+YZ2csE34SW45KZgrX0iU2PINTmIlt3kQGlFQeYdNV8Pu5lk9qb9rtMaM9ToyrwWKzPuPzI+5NNVh4/IXN9wuv9cIvHDpSgan2ZteNtOEVOXGyuOOR11s1NbhC38eoD+hzLJDf/J8oNBpfdrM0nzhoC5iQveV2gW1uL7OarCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oJeKvZXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AD4C4CEF1;
	Tue, 26 Aug 2025 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207788;
	bh=NN/VGsWHWzTntBi+JJIAofKbczPXARncCuGSJaN6Slo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJeKvZXudxXB9VaV+rGDP+oMcQgur/RbuNM3FenuUNAZW94QjeJLD0GTsXzBRPEqS
	 4/z4YtjNIp6R7pFqGgjY8goqWYHRkx1IYgZEndAExtfjs6OLAt8B8hl6pP4WSe4Fzl
	 SskhHv108yaAqTe4fmwzXAN1NT9URdVONooM0w5s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ye Bin <yebin10@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 287/457] fs/buffer: fix use-after-free when call bh_read() helper
Date: Tue, 26 Aug 2025 13:09:31 +0200
Message-ID: <20250826110944.475494690@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 7375f22495e7cd1c5b3b5af9dcc4f6dffe34ce49 ]

There's issue as follows:
BUG: KASAN: stack-out-of-bounds in end_buffer_read_sync+0xe3/0x110
Read of size 8 at addr ffffc9000168f7f8 by task swapper/3/0
CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.16.0-862.14.0.6.x86_64
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Call Trace:
 <IRQ>
 dump_stack_lvl+0x55/0x70
 print_address_description.constprop.0+0x2c/0x390
 print_report+0xb4/0x270
 kasan_report+0xb8/0xf0
 end_buffer_read_sync+0xe3/0x110
 end_bio_bh_io_sync+0x56/0x80
 blk_update_request+0x30a/0x720
 scsi_end_request+0x51/0x2b0
 scsi_io_completion+0xe3/0x480
 ? scsi_device_unbusy+0x11e/0x160
 blk_complete_reqs+0x7b/0x90
 handle_softirqs+0xef/0x370
 irq_exit_rcu+0xa5/0xd0
 sysvec_apic_timer_interrupt+0x6e/0x90
 </IRQ>

 Above issue happens when do ntfs3 filesystem mount, issue may happens
 as follows:
           mount                            IRQ
ntfs_fill_super
  read_cache_page
    do_read_cache_folio
      filemap_read_folio
        mpage_read_folio
	 do_mpage_readpage
	  ntfs_get_block_vbo
	   bh_read
	     submit_bh
	     wait_on_buffer(bh);
	                            blk_complete_reqs
				     scsi_io_completion
				      scsi_end_request
				       blk_update_request
				        end_bio_bh_io_sync
					 end_buffer_read_sync
					  __end_buffer_read_notouch
					   unlock_buffer

            wait_on_buffer(bh);--> return will return to caller

					  put_bh
					    --> trigger stack-out-of-bounds
In the mpage_read_folio() function, the stack variable 'map_bh' is
passed to ntfs_get_block_vbo(). Once unlock_buffer() unlocks and
wait_on_buffer() returns to continue processing, the stack variable
is likely to be reclaimed. Consequently, during the end_buffer_read_sync()
process, calling put_bh() may result in stack overrun.

If the bh is not allocated on the stack, it belongs to a folio.  Freeing
a buffer head which belongs to a folio is done by drop_buffers() which
will fail to free buffers which are still locked.  So it is safe to call
put_bh() before __end_buffer_read_notouch().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Link: https://lore.kernel.org/20250811141830.343774-1-yebin@huaweicloud.com
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8cf4a1dc481e..eb6d85edc37a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -157,8 +157,8 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
  */
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 {
-	__end_buffer_read_notouch(bh, uptodate);
 	put_bh(bh);
+	__end_buffer_read_notouch(bh, uptodate);
 }
 EXPORT_SYMBOL(end_buffer_read_sync);
 
-- 
2.50.1




