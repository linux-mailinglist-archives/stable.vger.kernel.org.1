Return-Path: <stable+bounces-171101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD605B2A7B3
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DEE584E58
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D859826F286;
	Mon, 18 Aug 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZyNb1lVp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AEB19E82A;
	Mon, 18 Aug 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524819; cv=none; b=Wks0a+RQaGyQUZSuS96hpmZrh2KkfTajVh6V6JCARYh6kfeEmWtTIjyYMD1McKqt3uRgEKPX//PoMPJkN2XZti0I8aG7Y0Xs3M17GpbLvLvfsYy0OYMnpXpsXGZIl3Jni4Yi/ssYP0eeJ9cfJ2ZrBxJATSUANMXGyR0+5P1Na+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524819; c=relaxed/simple;
	bh=q3DWkHVJRNPAUpiSeBS3d5DFnKWkWNNLWOazwNjXHKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jC+Gu7fpaBC1up8WK71LOJChCBqKPjcQAhWQrCUhG0k7uvmjmDiwRuUUn1qneFGat9xWcYcAnf5xQXF75RXG0oDfgjc07tRpFCpDfdUfQTkYNexbvEIG92/OQLk0q6OSj4r+VIUmeiJfWusmfkvvWWkrCJugtPlYV5xzEP6X0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZyNb1lVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55424C4CEEB;
	Mon, 18 Aug 2025 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524819;
	bh=q3DWkHVJRNPAUpiSeBS3d5DFnKWkWNNLWOazwNjXHKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyNb1lVpHmygNzlQ3Ts0IE/kgJQgKduxxx/pFP9/WsP4rFMLlsYJB31640ChpVDn4
	 HMQWwKCy1KTw0w+zvH+B3cp052/JN3oWt9WkomWMFWZtDrdcOHBFR35FUxtAAj8tFh
	 tX7XtG+Z7C7E7HbuMs5O84cjVj/jfdAxGV0O6suY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+773e51afe420baaf0e2b@syzkaller.appspotmail.com,
	syzbot+70a42f45e76bede082be@syzkaller.appspotmail.com,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 073/570] sctp: linearize cloned gso packets in sctp_rcv
Date: Mon, 18 Aug 2025 14:41:00 +0200
Message-ID: <20250818124508.640910365@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit fd60d8a086191fe33c2d719732d2482052fa6805 ]

A cloned head skb still shares these frag skbs in fraglist with the
original head skb. It's not safe to access these frag skbs.

syzbot reported two use-of-uninitialized-memory bugs caused by this:

  BUG: KMSAN: uninit-value in sctp_inq_pop+0x15b7/0x1920 net/sctp/inqueue.c:211
   sctp_inq_pop+0x15b7/0x1920 net/sctp/inqueue.c:211
   sctp_assoc_bh_rcv+0x1a7/0xc50 net/sctp/associola.c:998
   sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
   sctp_backlog_rcv+0x397/0xdb0 net/sctp/input.c:331
   sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1122
   __release_sock+0x1da/0x330 net/core/sock.c:3106
   release_sock+0x6b/0x250 net/core/sock.c:3660
   sctp_wait_for_connect+0x487/0x820 net/sctp/socket.c:9360
   sctp_sendmsg_to_asoc+0x1ec1/0x1f00 net/sctp/socket.c:1885
   sctp_sendmsg+0x32b9/0x4a80 net/sctp/socket.c:2031
   inet_sendmsg+0x25a/0x280 net/ipv4/af_inet.c:851
   sock_sendmsg_nosec net/socket.c:718 [inline]

and

  BUG: KMSAN: uninit-value in sctp_assoc_bh_rcv+0x34e/0xbc0 net/sctp/associola.c:987
   sctp_assoc_bh_rcv+0x34e/0xbc0 net/sctp/associola.c:987
   sctp_inq_push+0x2a3/0x350 net/sctp/inqueue.c:88
   sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
   sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
   __release_sock+0x1d3/0x330 net/core/sock.c:3213
   release_sock+0x6b/0x270 net/core/sock.c:3767
   sctp_wait_for_connect+0x458/0x820 net/sctp/socket.c:9367
   sctp_sendmsg_to_asoc+0x223a/0x2260 net/sctp/socket.c:1886
   sctp_sendmsg+0x3910/0x49f0 net/sctp/socket.c:2032
   inet_sendmsg+0x269/0x2a0 net/ipv4/af_inet.c:851
   sock_sendmsg_nosec net/socket.c:712 [inline]

This patch fixes it by linearizing cloned gso packets in sctp_rcv().

Fixes: 90017accff61 ("sctp: Add GSO support")
Reported-by: syzbot+773e51afe420baaf0e2b@syzkaller.appspotmail.com
Reported-by: syzbot+70a42f45e76bede082be@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Link: https://patch.msgid.link/dd7dc337b99876d4132d0961f776913719f7d225.1754595611.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 0c0d2757f6f8..6fcdcaeed40e 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -117,7 +117,7 @@ int sctp_rcv(struct sk_buff *skb)
 	 * it's better to just linearize it otherwise crc computing
 	 * takes longer.
 	 */
-	if ((!is_gso && skb_linearize(skb)) ||
+	if (((!is_gso || skb_cloned(skb)) && skb_linearize(skb)) ||
 	    !pskb_may_pull(skb, sizeof(struct sctphdr)))
 		goto discard_it;
 
-- 
2.50.1




