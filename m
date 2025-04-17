Return-Path: <stable+bounces-133010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89579A9199E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1631891BC6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F341E521A;
	Thu, 17 Apr 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TUkKNZ5m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE672DFA42
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886783; cv=none; b=XEEp8MNx/olkn374JqBGmBI25SPMZXez9k45e+jiQwfQKsljcfnv8ti1iBLY/5ZTAfOBDTMYQhKVzZJ8d39iLJAV3sffC6B1GR97joBiEHmM6NZGjH4qR84IKE/PTjj4mMMfm6HVZG0mF6cEdHX/ZQBoXR0huJbUmIliq7h+FkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886783; c=relaxed/simple;
	bh=jm+YsCRO7iJs17cG2paq9VELG1VG5BGNWSU3p72jME8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TkRRXzjwCdLz+IRsaMT12W1swakW1sBd74soLJG6LbI9YRkaSOmA1BDmx9LKW/weVCPVJAvCGWx9S2bcwoIHV49Uy5grBtyvaB6ZtlV3S5sHh1w33dwWJAzx3uVL1cgJLJaCikCzidnaLw/bp5thv9i4L+XQp+S7u9jyxfPxi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TUkKNZ5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8D8C4CEE4;
	Thu, 17 Apr 2025 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744886783;
	bh=jm+YsCRO7iJs17cG2paq9VELG1VG5BGNWSU3p72jME8=;
	h=Subject:To:Cc:From:Date:From;
	b=TUkKNZ5m+xuGk3xxGA9UaZzXY5q1lQmPFhW+sDtOhbtNolhbojmpV2RB7yJGpMyAj
	 a286mLCShwZxO0FdmGRqqAJZnSngBJLMyZzbe+R+ZhXqkLEEaXC6o7nBj2F5oA2nS7
	 iEXFiAHJ7r+kRhltW3i4PwD6N6ERbjCd7V98s7Uo=
Subject: FAILED: patch "[PATCH] io_uring/net: fix accept multishot handling" failed to apply to 6.1-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:46:12 +0200
Message-ID: <2025041712-science-poster-b5b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f6a89bf5278d6e15016a736db67043560d1b50d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041712-science-poster-b5b0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f6a89bf5278d6e15016a736db67043560d1b50d5 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Sun, 23 Feb 2025 17:22:29 +0000
Subject: [PATCH] io_uring/net: fix accept multishot handling

REQ_F_APOLL_MULTISHOT doesn't guarantee it's executed from the multishot
context, so a multishot accept may get executed inline, fail
io_req_post_cqe(), and ask the core code to kill the request with
-ECANCELED by returning IOU_STOP_MULTISHOT even when a socket has been
accepted and installed.

Cc: stable@vger.kernel.org
Fixes: 390ed29b5e425 ("io_uring: add IORING_ACCEPT_MULTISHOT for accept")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/51c6deb01feaa78b08565ca8f24843c017f5bc80.1740331076.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index 1d1107fd5beb..926cdb8d3350 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1641,6 +1641,8 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 	}
 
 	io_req_set_res(req, ret, cflags);
+	if (!(issue_flags & IO_URING_F_MULTISHOT))
+		return IOU_OK;
 	return IOU_STOP_MULTISHOT;
 }
 


