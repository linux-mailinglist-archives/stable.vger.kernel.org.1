Return-Path: <stable+bounces-147816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C8DAC5951
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539314C0739
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBB027FB3D;
	Tue, 27 May 2025 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qinU3nnk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE1428031F;
	Tue, 27 May 2025 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368522; cv=none; b=oeHKFhQ33Rd/dLAMu14xg/Cgew3k6RVwZ9oGVr/6gw6LzO8LLG6pmr0UbgWWPjU4miF8xWeiTVzLwNZtzGW2Iq6CIQooO1wOkUG23TVivrOvyhStSopyndfkf4JEiGSTIVnEroN6xza2gurK7gZps9lQ6tuW9CAEC8C4kalxw0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368522; c=relaxed/simple;
	bh=9kkNv4H4CnI/dZ5qALtZsiq1OObO247yfldwcPphWuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZ7nhdGkeWBila9d7es7P7Pnr5kbAEyoOGQXm8Kth/ltTv6OAuJCR9dH9dvrcwpz8Sh6RhXB/erOySgn2AqecCv2YyWkiODxFf5DguFAXvzar9ETj98VioMvX1O+s5On7VWGztdn106RwCj0GMU7sY03O8VRKa5TSX9T6/j4c/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qinU3nnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D20C4CEE9;
	Tue, 27 May 2025 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368522;
	bh=9kkNv4H4CnI/dZ5qALtZsiq1OObO247yfldwcPphWuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qinU3nnkwSB80E+7DkoATCYGhyTvApno7GfyQy9MsSoBX6CqOpTnVyUGOcc2P6F/5
	 9E/CbvziTd/LwZhvDIYOF/jwyaV6KfM4YWeiaIS0dLinCXoLrmRkh/p1nReeUiUDjF
	 MDl8qS9J7Yxe92p3WfosjyRyjS8IXq/54ewNVidU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.14 733/783] llc: fix data loss when reading from a socket in llc_ui_recvmsg()
Date: Tue, 27 May 2025 18:28:50 +0200
Message-ID: <20250527162542.972013357@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>

commit 239af1970bcb039a1551d2c438d113df0010c149 upstream.

For SOCK_STREAM sockets, if user buffer size (len) is less
than skb size (skb->len), the remaining data from skb
will be lost after calling kfree_skb().

To fix this, move the statement for partial reading
above skb deletion.

Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org)

Fixes: 30a584d944fb ("[LLX]: SOCK_DGRAM interface fixes")
Cc: stable@vger.kernel.org
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/af_llc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -887,15 +887,15 @@ static int llc_ui_recvmsg(struct socket
 		if (sk->sk_type != SOCK_STREAM)
 			goto copy_uaddr;
 
+		/* Partial read */
+		if (used + offset < skb_len)
+			continue;
+
 		if (!(flags & MSG_PEEK)) {
 			skb_unlink(skb, &sk->sk_receive_queue);
 			kfree_skb(skb);
 			*seq = 0;
 		}
-
-		/* Partial read */
-		if (used + offset < skb_len)
-			continue;
 	} while (len > 0);
 
 out:



