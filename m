Return-Path: <stable+bounces-150225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1069EACB6C2
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9D01BA6938
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BEB22D790;
	Mon,  2 Jun 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fL/2lNBG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F522D4D7;
	Mon,  2 Jun 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876442; cv=none; b=Gxuzh+8TSKvauCayHt+ThzqAKSlh5fEEKhVdhqmSK9gjyHdO0UWxt//EdRcjAG35tMaXFuEMnFGPXF+Y3wSOcF3BWXFqn1mLR8JmmeGOYGgWig5IOgcX7R+t0jd2ZE+UsQOqJ7Zmo+tqVrbXRI/rhpBi8ltHY+dHmzeKbwXVKBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876442; c=relaxed/simple;
	bh=PF611zMRZtuzCG2xqfXIXyyLmqytSfeWxoRaCld43TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIxKJnvBDPNoWfBmt+pyCM+Y2znLMFizLjCm+l6V4pV/ZnTtlmjSuX1k5/VYtHiklcZTOy8Ie4avsJLxaBBH8BaxJ8bw0KUPhuPaWYvtqF8RY8/cpn3LeDtEqlJ1NWG5qd9ztuNfPOhqUEEgJfz+VygQOBJWWZX6ctNS+ejehrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fL/2lNBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCF1C4CEEB;
	Mon,  2 Jun 2025 15:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876442;
	bh=PF611zMRZtuzCG2xqfXIXyyLmqytSfeWxoRaCld43TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fL/2lNBG+MJeS1EPf2g0EIw68nPmWohZuHicxgvuh7nkSqL1xwevpqgf5x87HluKs
	 TeE7nqVXOpghm4otTCoUC3wAZJAY+7XDQ9ehIYA4NBI4pTd2Ltnbd+gf2k0fR3Ewjl
	 YNR8UiFwZ+JzZWquqt4P0c6HsHIWv3i/etPj7mGA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 175/207] llc: fix data loss when reading from a socket in llc_ui_recvmsg()
Date: Mon,  2 Jun 2025 15:49:07 +0200
Message-ID: <20250602134305.601832836@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
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
@@ -886,15 +886,15 @@ static int llc_ui_recvmsg(struct socket
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



