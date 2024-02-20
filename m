Return-Path: <stable+bounces-21278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD2785C800
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B471F26FA7
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FC9151CD9;
	Tue, 20 Feb 2024 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZcKptJa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6B612D7;
	Tue, 20 Feb 2024 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463915; cv=none; b=GtOp8wH0K53OI6kl2uyx1fT5taYSssbRlC2GvkODLmLhYFm4HbVnrVTsY6Uj6O8wwNO/TgppP6uACSCK5kXcgyr8QE1VrRz6v/NAgdc6p84k6E4bbmkuDFudZmqOBN9fz8w4VZbDvNJoecyowovqhJ983RoW+cuOVRNlaJe4gi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463915; c=relaxed/simple;
	bh=Y1db0jUDbH+p5SUMtOp+2nkE+F/EIuXo4wp7LVbSCPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef4F9INUskrW6Niu5HpnvS4Xj4AqywGxNo+Cak9ke9mPmEMvD2J0A3Ab0Tom/+wZNbQmam8RErYv7WTOaeba0qdh8TpUo4cxTuNHCF5J95kPVaMFC89C7p0aSvvTdoT6CaHatBaMEzCkfZucJH8K64YwjVUd5NdHKa9DaROUogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZcKptJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7FAC433F1;
	Tue, 20 Feb 2024 21:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708463915;
	bh=Y1db0jUDbH+p5SUMtOp+2nkE+F/EIuXo4wp7LVbSCPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZcKptJaqyTxkpVX4bvb93DJeWACNNx5lhro5kE1XwHF1EPkA3D4epbJV2owRaZaq
	 595RznjV/2SPkKgNwGdQWqMOozfKMUYaN0cNpw3yM7iljSLwjUS10jR0Rai76v5JMu
	 za+rxqlrgnWLLY9gNm5j0haHAmuugYRCVevmNSH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 194/331] io_uring/net: fix multishot accept overflow handling
Date: Tue, 20 Feb 2024 21:55:10 +0100
Message-ID: <20240220205643.691103342@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit a37ee9e117ef73bbc2f5c0b31911afd52d229861 upstream.

If we hit CQ ring overflow when attempting to post a multishot accept
completion, we don't properly save the result or return code. This
results in losing the accepted fd value.

Instead, we return the result from the poll operation that triggered
the accept retry. This is generally POLLIN|POLLPRI|POLLRDNORM|POLLRDBAND
which is 0xc3, or 195, which looks like a valid file descriptor, but it
really has no connection to that.

Handle this like we do for other multishot completions - assign the
result, and return IOU_STOP_MULTISHOT to cancel any further completions
from this request when overflow is hit. This preserves the result, as we
should, and tells the application that the request needs to be re-armed.

Cc: stable@vger.kernel.org
Fixes: 515e26961295 ("io_uring: revert "io_uring fix multishot accept ordering"")
Link: https://github.com/axboe/liburing/issues/1062
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/net.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1372,7 +1372,7 @@ retry:
 			 * has already been done
 			 */
 			if (issue_flags & IO_URING_F_MULTISHOT)
-				ret = IOU_ISSUE_SKIP_COMPLETE;
+				return IOU_ISSUE_SKIP_COMPLETE;
 			return ret;
 		}
 		if (ret == -ERESTARTSYS)
@@ -1397,7 +1397,8 @@ retry:
 				ret, IORING_CQE_F_MORE))
 		goto retry;
 
-	return -ECANCELED;
+	io_req_set_res(req, ret, 0);
+	return IOU_STOP_MULTISHOT;
 }
 
 int io_socket_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)



