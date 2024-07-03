Return-Path: <stable+bounces-57373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CA3925D8A
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF1AB38531
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F017C22B;
	Wed,  3 Jul 2024 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AK4V0+Wf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CB861FDF;
	Wed,  3 Jul 2024 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004682; cv=none; b=I2kk1sxHFP1BfgVDTYsY+XCfUMzNU3qdQEMdbBekmXeEcqL/WbNIiUizibXofP3WOKLqDZQ13l1a0Ajmc+Piu8eF2eFUFJGUvme0ppmo1OTf45s7ImNLm4OqsiiDELQtlO+Olt3XSM9hZ11VTzMfWQdhLiDNbI10pkWM2EW/xZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004682; c=relaxed/simple;
	bh=FWQlCJATcCRHLXyjERkuwiPy20XWvOL875rU4Wmt1eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlTvHR6plE9VOBJqLr9zKGMKQpmWHJQb5Tm4efym9tzc5Y61Tq9WmZLAy5vkuGjbgwCdNoFKArDDflWWF2RXUhuXWnb/wl7GG2wzlilQq+WfjKcYw75/JvwjQeBecrwx1CJlJthZN0L6vpJ+WQMtSZnfj2khg493nr/0Ad7KaAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AK4V0+Wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83153C2BD10;
	Wed,  3 Jul 2024 11:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004681;
	bh=FWQlCJATcCRHLXyjERkuwiPy20XWvOL875rU4Wmt1eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AK4V0+WfsiCjs3HA21YBC4lzAzi/Bgv5WQxYScp6N5Z1bdzVHgErh/7nGeqVJ8+9P
	 tmp+Tx5Vm83ZTGxfXmK8y6Ste+3bkn+iO17nuHWr/PEYUo+p9znfQMLjVo2X2XaJXI
	 vcloPslX3sJaXoGGDLgF7y/abO2B2D8WNIl9kU5E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 092/290] nilfs2: fix potential kernel bug due to lack of writeback flag waiting
Date: Wed,  3 Jul 2024 12:37:53 +0200
Message-ID: <20240703102907.664922693@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit a4ca369ca221bb7e06c725792ac107f0e48e82e7 upstream.

Destructive writes to a block device on which nilfs2 is mounted can cause
a kernel bug in the folio/page writeback start routine or writeback end
routine (__folio_start_writeback in the log below):

 kernel BUG at mm/page-writeback.c:3070!
 Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
 ...
 RIP: 0010:__folio_start_writeback+0xbaa/0x10e0
 Code: 25 ff 0f 00 00 0f 84 18 01 00 00 e8 40 ca c6 ff e9 17 f6 ff ff
  e8 36 ca c6 ff 4c 89 f7 48 c7 c6 80 c0 12 84 e8 e7 b3 0f 00 90 <0f>
  0b e8 1f ca c6 ff 4c 89 f7 48 c7 c6 a0 c6 12 84 e8 d0 b3 0f 00
 ...
 Call Trace:
  <TASK>
  nilfs_segctor_do_construct+0x4654/0x69d0 [nilfs2]
  nilfs_segctor_construct+0x181/0x6b0 [nilfs2]
  nilfs_segctor_thread+0x548/0x11c0 [nilfs2]
  kthread+0x2f0/0x390
  ret_from_fork+0x4b/0x80
  ret_from_fork_asm+0x1a/0x30
  </TASK>

This is because when the log writer starts a writeback for segment summary
blocks or a super root block that use the backing device's page cache, it
does not wait for the ongoing folio/page writeback, resulting in an
inconsistent writeback state.

Fix this issue by waiting for ongoing writebacks when putting
folios/pages on the backing device into writeback state.

Link: https://lkml.kernel.org/r/20240530141556.4411-1-konishi.ryusuke@gmail.com
Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/segment.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1697,6 +1697,7 @@ static void nilfs_segctor_prepare_write(
 			if (bh->b_page != bd_page) {
 				if (bd_page) {
 					lock_page(bd_page);
+					wait_on_page_writeback(bd_page);
 					clear_page_dirty_for_io(bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
@@ -1710,6 +1711,7 @@ static void nilfs_segctor_prepare_write(
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_page != bd_page) {
 					lock_page(bd_page);
+					wait_on_page_writeback(bd_page);
 					clear_page_dirty_for_io(bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
@@ -1726,6 +1728,7 @@ static void nilfs_segctor_prepare_write(
 	}
 	if (bd_page) {
 		lock_page(bd_page);
+		wait_on_page_writeback(bd_page);
 		clear_page_dirty_for_io(bd_page);
 		set_page_writeback(bd_page);
 		unlock_page(bd_page);



