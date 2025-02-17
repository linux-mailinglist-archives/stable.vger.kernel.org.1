Return-Path: <stable+bounces-115840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7526AA345E0
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D5A170DAD
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71572A1D1;
	Thu, 13 Feb 2025 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QeYgdR7q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0D26B097;
	Thu, 13 Feb 2025 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459434; cv=none; b=tmmyqPC8ZwSwW65skK+27BhAwsJXbDdBCT4GYhgOXvd2+4pv0clUlPUTR/oa4ABR8zs4isRG3anwOSxftVr4Kuj8rpK80/y8HHvyDVTg9/OFezBDpA8JCqS4Tql2d23+W6LO1Kzv3YAZtkS3/uKcpUwcLILjCpPL33x/i1gK4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459434; c=relaxed/simple;
	bh=+1mMJItrqnH12Mlo3XkFKDl0fydtuh2uscrqx2zkkfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWug5MjihE8gBzvAtSywl4/IsjNMz65g2yzOM0xG1ROXhI7By7njfHbHI2oPl+z1HyTD/1xiWi5JFFXnDXiyW6RR14OPdH6Uic7vUelY5fvBnc12ZD2aWEu0aNfKvjApM112xQiWFa1O+TbOaGWNuKvv5fQx47S/j45hwCTLU/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QeYgdR7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D60C4CED1;
	Thu, 13 Feb 2025 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459434;
	bh=+1mMJItrqnH12Mlo3XkFKDl0fydtuh2uscrqx2zkkfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QeYgdR7qwmisXbPtjI3AUmhtoP/g7KGJiUZOQJBHIw6USb1vxfGGc0JuzIPqz0AgX
	 qiq7Y9LpVXnRIqacNi9J39kkB4cZJ9pij3Wibb49M6QNi+y05EiOHda1zIp3jZMzXj
	 5dNbpMQXWT6nQ8h+d7+V5QGl1hZjQQ8RTMFgywc0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.13 263/443] block: dont revert iter for -EIOCBQUEUED
Date: Thu, 13 Feb 2025 15:27:08 +0100
Message-ID: <20250213142450.765802315@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit b13ee668e8280ca5b07f8ce2846b9957a8a10853 upstream.

blkdev_read_iter() has a few odd checks, like gating the position and
count adjustment on whether or not the result is bigger-than-or-equal to
zero (where bigger than makes more sense), and not checking the return
value of blkdev_direct_IO() before doing an iov_iter_revert(). The
latter can lead to attempting to revert with a negative value, which
when passed to iov_iter_revert() as an unsigned value will lead to
throwing a WARN_ON() because unroll is bigger than MAX_RW_COUNT.

Be sane and don't revert for -EIOCBQUEUED, like what is done in other
spots.

Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/fops.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/block/fops.c
+++ b/block/fops.c
@@ -758,11 +758,12 @@ static ssize_t blkdev_read_iter(struct k
 		file_accessed(iocb->ki_filp);
 
 		ret = blkdev_direct_IO(iocb, to);
-		if (ret >= 0) {
+		if (ret > 0) {
 			iocb->ki_pos += ret;
 			count -= ret;
 		}
-		iov_iter_revert(to, count - iov_iter_count(to));
+		if (ret != -EIOCBQUEUED)
+			iov_iter_revert(to, count - iov_iter_count(to));
 		if (ret < 0 || !count)
 			goto reexpand;
 	}



