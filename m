Return-Path: <stable+bounces-3514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8F37FF605
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2806B21172
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A6E4878B;
	Thu, 30 Nov 2023 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="msz4ctnw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0624777A;
	Thu, 30 Nov 2023 16:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB68C433C7;
	Thu, 30 Nov 2023 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701362024;
	bh=wsMri4gabEw0xUUF37g1NIUY7B7uBpsQqYZ5YOLjuKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msz4ctnwS4yN8RvHN0EN7jb/qPqNDnpcJfsxfZmGj6pq1yn6WX7Wp3y1NTWML684j
	 hi2IhIQY4Tma/HhzRUbkJeQXZjR5YjVNi1qoUQF4vCyH4H13Q2mA0Dcx0L8R/ewoPe
	 dYI6U/EmBDd0qxf1em9tOVU5NsnP8c3VmbDeAwzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Mirabile <cmirabil@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 49/69] io_uring/fs: consider link->flags when getting path for LINKAT
Date: Thu, 30 Nov 2023 16:22:46 +0000
Message-ID: <20231130162134.688163026@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
References: <20231130162133.035359406@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Mirabile <cmirabil@redhat.com>

commit 8479063f1fbee201a8739130e816cc331b675838 upstream.

In order for `AT_EMPTY_PATH` to work as expected, the fact
that the user wants that behavior needs to make it to `getname_flags`
or it will return ENOENT.

Fixes: cf30da90bc3a ("io_uring: add support for IORING_OP_LINKAT")
Cc:  <stable@vger.kernel.org>
Link: https://github.com/axboe/liburing/issues/995
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Link: https://lore.kernel.org/r/20231120105545.1209530-1-cmirabil@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -4049,7 +4049,7 @@ static int io_linkat_prep(struct io_kioc
 	newf = u64_to_user_ptr(READ_ONCE(sqe->addr2));
 	lnk->flags = READ_ONCE(sqe->hardlink_flags);
 
-	lnk->oldpath = getname(oldf);
+	lnk->oldpath = getname_uflags(oldf, lnk->flags);
 	if (IS_ERR(lnk->oldpath))
 		return PTR_ERR(lnk->oldpath);
 



