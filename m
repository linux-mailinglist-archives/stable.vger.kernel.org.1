Return-Path: <stable+bounces-182445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852BFBAD8F3
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0129E1942B9E
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2643306B05;
	Tue, 30 Sep 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S7GvuybE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C930595C;
	Tue, 30 Sep 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244971; cv=none; b=W19Q5eoRr12I3GiPCVT9TQxhoW/EOuB977A560ldiLjyd8CrJQ/1EgY/EXq0Ok4/IwsYbiG+MED5VAymtNc6u6CrE+LhDTmgGZrB14/dYVFY8/rrhMnfNNR6otHjyNtqfEvcv3TvQkMyuc93EXxv5bAvgsYu3IE/kAsHpCheLBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244971; c=relaxed/simple;
	bh=qc+DJb2Zw6FFlO7KUNq5tMNSvumr7+rnX05nwYEjvWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nERNwIPblga81dKzHRj3e+nxD4TEECaYwEHCitY1NAdmNC6J8Lsyb2SMApbIU01+hNHQjHf/adUyGxgr3yXnPkALTX4dzPDlBgatTLu1SGVs1neCPVJjv8kgG53Gz91s8O0VToLdHAQqieO+FAD//F/FpuUWwQnIVKMwbytUYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S7GvuybE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51C1C4CEF0;
	Tue, 30 Sep 2025 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244971;
	bh=qc+DJb2Zw6FFlO7KUNq5tMNSvumr7+rnX05nwYEjvWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7GvuybEuxfHrnJnBItROGavx0yE+AE555FIxGNj/9inXDdp3ul5WqUTxKABPNsSY
	 QnjE2IOuX8nTjPidVb3xE4waIPWNnAH7KSumEnti8ErrA23IYWLqH4bqTWwBz3BTRg
	 1N8O5k0Oz+px8oo4/Te2FfdaUhu0XROr2ZZCfJHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Weimer <fweimer@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.15 026/151] fuse: prevent overflow in copy_file_range return value
Date: Tue, 30 Sep 2025 16:45:56 +0200
Message-ID: <20250930143828.655439757@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
References: <20250930143827.587035735@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 1e08938c3694f707bb165535df352ac97a8c75c9 upstream.

The FUSE protocol uses struct fuse_write_out to convey the return value of
copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RANGE
interface supports a 64-bit size copies.

Currently the number of bytes copied is silently truncated to 32-bit, which
may result in poor performance or even failure to copy in case of
truncation to zero.

Reported-by: Florian Weimer <fweimer@redhat.com>
Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.com/
Fixes: 88bc7d5097a1 ("fuse: add support for copy_file_range()")
Cc: <stable@vger.kernel.org> # v4.20
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3047,7 +3047,7 @@ static ssize_t __fuse_copy_file_range(st
 		.nodeid_out = ff_out->nodeid,
 		.fh_out = ff_out->fh,
 		.off_out = pos_out,
-		.len = len,
+		.len = min_t(size_t, len, UINT_MAX & PAGE_MASK),
 		.flags = flags
 	};
 	struct fuse_write_out outarg;



