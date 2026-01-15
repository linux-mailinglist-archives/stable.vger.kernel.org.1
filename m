Return-Path: <stable+bounces-209695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F9D27018
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2C6F304E43F
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865073E95BF;
	Thu, 15 Jan 2026 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NYyV9HHV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0CF3E95A6;
	Thu, 15 Jan 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499428; cv=none; b=o/dEhUunrYL+1EZdKPFTH394V24UV1IhtN5gif4DT57p/S1l39uRHluwGIdYYbvjXwyRBtGivLPTa5IMQiAT7T76qD/JQ7yZhppvAjfKlMfCM/Vwg33GZUHraMKNVu1AogdggmHFSGtA8vwzrgJ+D6yDOsmA9r15hlVm9QYi/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499428; c=relaxed/simple;
	bh=y4cL95q2u1jkNJCUNNpM2uq86TyJukbXt1LiK6AXfjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Trtl/oliunQaL/d3lzsEWxG9FBkWcW23DO8ZJq9Xdt2uB8Xzsf1TE/l6uvc3Xz4Zxczt/O/TbrBK4W9lUofz0umyBpI1PpXqA0w0SdFILtDwxFsAnaTOYkNcJf1maOjSOX3zOrd1v12jagoNU8LG3MSOLZUl6oC2QzX7YvXMVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NYyV9HHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C22FC19425;
	Thu, 15 Jan 2026 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768499427;
	bh=y4cL95q2u1jkNJCUNNpM2uq86TyJukbXt1LiK6AXfjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYyV9HHVTGIjX+5lXN7HfofR4cAtMrZh+CTLqLTwo2WrdHI/XphdB2rV+THmtJNcp
	 9TQWrRMyPVX2G8AcJqwmKJnkYvdo2t7j2GwrLoo8uDVfnpu36KaFQmCdwE2IUt2RGP
	 vRrvy7sxgt89i8BSBSK0gIRA9QjKtgKrcFQUV3PQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactco.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 223/451] floppy: fix for PAGE_SIZE != 4KB
Date: Thu, 15 Jan 2026 17:47:04 +0100
Message-ID: <20260115164238.965068210@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
References: <20260115164230.864985076@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rene Rebe <rene@exactco.de>

commit 82d20481024cbae2ea87fe8b86d12961bfda7169 upstream.

For years I wondered why the floppy driver does not just work on
sparc64, e.g:

root@SUNW_375_0066:# disktype /dev/fd0
disktype: Can't open /dev/fd0: No such device or address

[  525.341906] disktype: attempt to access beyond end of device
fd0: rw=0, sector=0, nr_sectors = 16 limit=8
[  525.341991] floppy: error 10 while reading block 0

Turns out floppy.c __floppy_read_block_0 tries to read one page for
the first test read to determine the disk size and thus fails if that
is greater than 4k. Adjust minimum MAX_DISK_SIZE to PAGE_SIZE to fix
floppy on sparc64 and likely all other PAGE_SIZE != 4KB configs.

Cc: stable@vger.kernel.org
Signed-off-by: René Rebe <rene@exactco.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/floppy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -332,7 +332,7 @@ static bool initialized;
  * This default is used whenever the current disk size is unknown.
  * [Now it is rather a minimum]
  */
-#define MAX_DISK_SIZE 4		/* 3984 */
+#define MAX_DISK_SIZE (PAGE_SIZE / 1024)
 
 /*
  * globals used by 'result()'



