Return-Path: <stable+bounces-131080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F242EA807AC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF784A6E86
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78933267B6B;
	Tue,  8 Apr 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h8tW34um"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957C26AAB7;
	Tue,  8 Apr 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115435; cv=none; b=rfp7MIfX73yvVmIFyU5tEmt5rhsxOORHxiX05DDi7gRdXATkiNezVUxkCeyzE2/NOkMLuW6eTUUQovVaHHuOQCzBlC7e4gnE7jYv3COC9VkOg3V+thBSlVFdpj7vt8objv/rd/N9uq4wNeQZbDyrIYYc3tiBjBZ5Iir7WZuk6j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115435; c=relaxed/simple;
	bh=qih1ZxGfki5FTHGOMacTF6QVbQQWxiw7UwIpj1EfboY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lal7OEmz2FhB4yXNslcwzmvccq57IoyLfmLu+BpydnwY+MhmPmM+RrekJbW+Q0USVD+N+zmLY1ZbYNdYVnnfG5HH4H+CnG8542f8z3S2sc0Fap+SXlqm9q0iQe4uMqh34Fzhb0QySOlytHhFlsU2cI2aBl/xRbbXK+VZSRMEGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h8tW34um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E751C4CEE5;
	Tue,  8 Apr 2025 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115434;
	bh=qih1ZxGfki5FTHGOMacTF6QVbQQWxiw7UwIpj1EfboY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h8tW34umCVDddqXpMPUXbNDaTz7Ta803QHFPGmsPTzAz0s9AQGjXuDEth+heIw+BO
	 g+I6nRtiFXsVSSFSXLoOchLnr3qoM40g6ERajnVNAcTfFZgbl7TiHXYqmFuSIskEFL
	 NcR/z80ENZaJI/pnU8hlp8FgZ+rM7VyljSwCt0OA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.13 474/499] exfat: fix potential wrong error return from get_block
Date: Tue,  8 Apr 2025 12:51:26 +0200
Message-ID: <20250408104903.176417705@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

From: Sungjong Seo <sj1557.seo@samsung.com>

commit 59c30e31425833385e6644ad33151420e37eabe1 upstream.

If there is no error, get_block() should return 0. However, when bh_read()
returns 1, get_block() also returns 1 in the same manner.

Let's set err to 0, if there is no error from bh_read()

Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
Cc: stable@vger.kernel.org
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/exfat/inode.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -391,6 +391,8 @@ static int exfat_get_block(struct inode
 			/* Zero unwritten part of a block */
 			memset(bh_result->b_data + size, 0,
 			       bh_result->b_size - size);
+
+			err = 0;
 		} else {
 			/*
 			 * The range has not been written, clear the mapped flag



