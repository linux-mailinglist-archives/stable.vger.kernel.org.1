Return-Path: <stable+bounces-175060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D1BB36631
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A3018989DE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF9234AB1A;
	Tue, 26 Aug 2025 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KiJ8ByYC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD671E519;
	Tue, 26 Aug 2025 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216035; cv=none; b=lCHH0WfjTzEhD5wHHaw95B1lQ6rjgmTjwljSgey0iaU4iIEZVmu6qv2esQqZSStBySpSGcYOVd1mrpqSMo5PBoOv8RD1GeS+m8DKC1HmaMtSGcnMn6lcQ6yutOUHpnEGFuigZMAbxLxYfAHVW66glfwdhVn2nw1MjxPuIcpQ/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216035; c=relaxed/simple;
	bh=l+rabo6rIOo1Svq0ircHut7M3zCAhBd9pMOU/tt+lEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBl9j1QoUez97WHrfIc7w45b/YCpo3Tqh8EoM5/rdwf/3mjtUwse+wGbO+bgOU6ME8cHDfIHo9NgdTM3LkWtdrUuHR6ROnBbWLv3gU3THfh9bd+0OWuOA5gEYK06Y/BKlbusUC5Td22zP4pwma/UKyoE/Saw4MW6AyQIuXJl17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KiJ8ByYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7E2C4CEF1;
	Tue, 26 Aug 2025 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216034;
	bh=l+rabo6rIOo1Svq0ircHut7M3zCAhBd9pMOU/tt+lEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiJ8ByYCL2wPejI8S0N25GkGFr5CjnCGSdmCMaeuwmK02oMZhIg1kWzZ1NFhFlphB
	 1rCCHfsm1gbxy6k+JZNEntO+QSECwF8QLiyV95F7m4kcxwsIA7k3f2rC5ciUf7fqDt
	 EJMfliYNemM2z5SUy1z+q4eLw2W2yz/9CftEQASU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 258/644] io_uring: dont use int for ABI
Date: Tue, 26 Aug 2025 13:05:49 +0200
Message-ID: <20250826110952.774324625@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

commit cf73d9970ea4f8cace5d8f02d2565a2723003112 upstream.

__kernel_rwf_t is defined as int, the actual size of which is
implementation defined. It won't go well if some compiler / archs
ever defines it as i64, so replace it with __u32, hoping that
there is no one using i16 for it.

Cc: stable@vger.kernel.org
Fixes: 2b188cc1bb857 ("Add io_uring IO interface")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/47c666c4ee1df2018863af3a2028af18feef11ed.1751412511.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/io_uring.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -29,7 +29,7 @@ struct io_uring_sqe {
 	};
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
-		__kernel_rwf_t	rw_flags;
+		__u32		rw_flags;
 		__u32		fsync_flags;
 		__u16		poll_events;	/* compatibility */
 		__u32		poll32_events;	/* word-reversed for BE */



