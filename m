Return-Path: <stable+bounces-37960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451C889F0D7
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7681C1C21B5B
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11FA15D5DB;
	Wed, 10 Apr 2024 11:28:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4315D5A1
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748497; cv=none; b=YVcigZIjbprClhPGInyaKtvoq/yQf8BnPeaE3LNkG5u8s8CAV5czoL7AxU1uhDFpgMBXzi2L/PRyHaI1ZX9SWv4xth5x8GoO9aynUJaeoM2GDnfAQ4oIqwUGiY+nMuyzOQ15pDNpsLuRXFdVaH80FiTFrT9opyxyw2gtrNbDwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748497; c=relaxed/simple;
	bh=BlySz+03d4cnr/omox3s5hwRJsNKdHdwLgVOjGLSCoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ykv1k9W4/xxJcUs6kHC25OfH9rpyJhKuo8hpTF5cyzEMinmojTY0md+L1x1qo7g57phhdpMS54maV6xRsPw3U3Hdp0guEE/ovFLByUI4N60wMMAqOWkBjUJuY4Pgkc2xpVyxckliBG2TBWzJClM5RH8BxkFnJnTS8xPsszJN4Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 1620A2F20251; Wed, 10 Apr 2024 11:28:08 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id D11C32F2024A;
	Wed, 10 Apr 2024 11:28:03 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Howells <dhowells@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Xin Long <lucien.xin@gmail.com>,
	Vadim Fedorenko <vfedorenko@novek.ru>,
	linux-afs@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 4/4 5.10] rxrpc: Enable IPv6 checksums on transport socket
Date: Wed, 10 Apr 2024 14:27:46 +0300
Message-ID: <20240410112747.2952012-5-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240410112747.2952012-1-oficerovas@altlinux.org>
References: <20240410112747.2952012-1-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 39cb9faa5d46d0d0694f4b594ef905f517600c8e ]

AF_RXRPC doesn't currently enable IPv6 UDP Tx checksums on the transport
socket it opens and the checksums in the packets it generates end up 0.

It probably should also enable IPv6 UDP Rx checksums and IPv4 UDP
checksums.  The latter only seem to be applied if the socket family is
AF_INET and don't seem to apply if it's AF_INET6.  IPv4 packets from an
IPv6 socket seem to have checksums anyway.

What seems to have happened is that the inet_inv_convert_csum() call didn't
get converted to the appropriate udp_port_cfg parameters - and
udp_sock_create() disables checksums unless explicitly told not too.

Fix this by enabling the three udp_port_cfg checksum options.

Fixes: 1a9b86c9fd95 ("rxrpc: use udp tunnel APIs instead of open code in rxrpc_open_socket")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: Vadim Fedorenko <vfedorenko@novek.ru>
cc: David S. Miller <davem@davemloft.net>
cc: linux-afs@lists.infradead.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org
---
 net/rxrpc/local_object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 6215800db33333..790c270c067850 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -117,6 +117,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	       local, srx->transport_type, srx->transport.family);
 
 	udp_conf.family = srx->transport.family;
+	udp_conf.use_udp_checksums = true;
 	if (udp_conf.family == AF_INET) {
 		udp_conf.local_ip = srx->transport.sin.sin_addr;
 		udp_conf.local_udp_port = srx->transport.sin.sin_port;
@@ -124,6 +125,8 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	} else {
 		udp_conf.local_ip6 = srx->transport.sin6.sin6_addr;
 		udp_conf.local_udp_port = srx->transport.sin6.sin6_port;
+		udp_conf.use_udp6_tx_checksums = true;
+		udp_conf.use_udp6_rx_checksums = true;
 #endif
 	}
 	ret = udp_sock_create(net, &udp_conf, &local->socket);
-- 
2.42.1


