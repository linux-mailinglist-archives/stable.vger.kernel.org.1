Return-Path: <stable+bounces-172611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47CDB32968
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3D6684CC6
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC312848B4;
	Sat, 23 Aug 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uk/+k5aC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6B2BE7B3;
	Sat, 23 Aug 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960691; cv=none; b=AIB7QWKix7wc3zqcZMpIdP9cTiU61YAizWbNLVcAJw9oyt456CDiyDpZR5p0ila+xs46ehzQuLMtgxERvOKIyKh1llKxh9vW7QFFx+r3YniUUO1dRuyfFB2xaP/ara5xPAw7s+3Wuqdu7GZG4HBEhtqNf+TfPtLqprUkGp2fCtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960691; c=relaxed/simple;
	bh=NBQpinPL7QvZ9DjO7SJJnsfvwtbexyh4pGpsdHhWNGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdy56lM1zbUQGy7MxnMxZRE01yPKteKdxo2KVD66y2GXcNi2TyHR2Vk9ZfOqyWkPihRjkI4BCdVhin8Rqt8udxhpWZYO4DV1i0Wk2HHpDDA1IwbKGNsN+gcB7CD4xHE6hQ0uSlrs7a848lvBuMaf9u2ZI/I/0TWD+bDPZou3nLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uk/+k5aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E17DC4CEE7;
	Sat, 23 Aug 2025 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755960691;
	bh=NBQpinPL7QvZ9DjO7SJJnsfvwtbexyh4pGpsdHhWNGM=;
	h=From:To:Cc:Subject:Date:From;
	b=Uk/+k5aC8qSo6fQHme4rpUPKmNZClFe6/9466Y7h0cFxsTlAv24debl0LYbJS9rNC
	 ERZHtpBzfsO/kJMrhmSMtMRzfGwR593S3+c9kcJeT87oYajAJ+k6xW5SyzBS/M+Cj8
	 lwY/dpMNt9XyNvgUveNYMFttuhNzPNfzfxzq3GJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.16.3
Date: Sat, 23 Aug 2025 16:51:26 +0200
Message-ID: <2025082354-halogen-retaliate-a8ba@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.16.3 kernel.

All users of the 6.16 kernel series that use the ext4 filesystem should
upgrade.

The updated 6.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                    |    2 
 fs/ext4/ext4.h              |    2 
 fs/ext4/extents.c           |    6 
 fs/ext4/inline.c            |    6 
 fs/ext4/inode.c             |  323 +++++++++++++++++++++++++++-----------------
 fs/ext4/move_extent.c       |    3 
 fs/ext4/xattr.c             |    2 
 include/trace/events/ext4.h |   47 +++++-
 8 files changed, 250 insertions(+), 141 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.16.3

Zhang Yi (9):
      ext4: process folios writeback in bytes
      ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
      ext4: fix stale data if it bail out of the extents mapping loop
      ext4: refactor the block allocation process of ext4_page_mkwrite()
      ext4: restart handle if credits are insufficient during allocating blocks
      ext4: enhance tracepoints during the folios writeback
      ext4: correct the reserved credits for extent conversion
      ext4: reserved credits for one extent during the folio writeback
      ext4: replace ext4_writepage_trans_blocks()


