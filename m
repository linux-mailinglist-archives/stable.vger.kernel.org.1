Return-Path: <stable+bounces-10206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E93D8273B7
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACF21C22CCD
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619F751C31;
	Mon,  8 Jan 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rSUu+TeK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5C5100F;
	Mon,  8 Jan 2024 15:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4CFC433CB;
	Mon,  8 Jan 2024 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728320;
	bh=z8wU0WgyLXrrgOXqXdbFfqrAXs7ioGPTnZdCpkTCpkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSUu+TeKmGQszzcU+Ev5NZ2cKKyrWeaeFBlstmE77qqB8ybbe0Rqbn66jtKae+2W6
	 FwLrTgIKsw8eapVxTh/DxFA6RSlU/VSpB1KajRXKoK+cw5VXlpob1FEYtUoXtpxb4a
	 WnplDfy6Vo+oMtYY2bCde9cch273qw7/3Nucejk8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Dionne <marc.dionne@auristor.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 040/150] net: Save and restore msg_namelen in sock_sendmsg
Date: Mon,  8 Jan 2024 16:34:51 +0100
Message-ID: <20240108153513.122794680@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Dionne <marc.dionne@auristor.com>

[ Upstream commit 01b2885d9415152bcb12ff1f7788f500a74ea0ed ]

Commit 86a7e0b69bd5 ("net: prevent rewrite of msg_name in
sock_sendmsg()") made sock_sendmsg save the incoming msg_name pointer
and restore it before returning, to insulate the caller against
msg_name being changed by the called code.  If the address length
was also changed however, we may return with an inconsistent structure
where the length doesn't match the address, and attempts to reuse it may
lead to lost packets.

For example, a kernel that doesn't have commit 1c5950fc6fe9 ("udp6: fix
potential access to stale information") will replace a v4 mapped address
with its ipv4 equivalent, and shorten namelen accordingly from 28 to 16.
If the caller attempts to reuse the resulting msg structure, it will have
the original ipv6 (v4 mapped) address but an incorrect v4 length.

Fixes: 86a7e0b69bd5 ("net: prevent rewrite of msg_name in sock_sendmsg()")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index 07470724e7358..0104617b440dc 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -740,6 +740,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
 	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;
 	struct sockaddr_storage address;
+	int save_len = msg->msg_namelen;
 	int ret;
 
 	if (msg->msg_name) {
@@ -749,6 +750,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 
 	ret = __sock_sendmsg(sock, msg);
 	msg->msg_name = save_addr;
+	msg->msg_namelen = save_len;
 
 	return ret;
 }
-- 
2.43.0




