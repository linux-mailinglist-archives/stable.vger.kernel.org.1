Return-Path: <stable+bounces-37957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F089F0D1
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E201F22976
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4387015CD64;
	Wed, 10 Apr 2024 11:28:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB615CD6A
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748495; cv=none; b=ZIgVZzE0faMV3BQTE3c+ZBFc8h2oVmABNivomQRywESh82ibw1dhBJpsP0zmK1lj9eLL7pYDIN5+A+jwrenof2/cHWnDo4sfUtyBIYA01Mu+iI9fUrOd41HklLUMBfLrFHTBuBb4mHH0UxVa2MUnZw5ndtf1llCKDznua1Mj+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748495; c=relaxed/simple;
	bh=xKQI1ig+mCQf1HP8VSAS5WonfHZhMWD1vaqmwt4Nfak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXhlIjWvyEQfnKfX1MAaOYx9kHDqvUxudeMqEC5W50LCI39CaxWTHQxaOnXDZHYVaZSs+qMtofE3ZqwoYWNseVj/QYRUdMC/8SlyBvKszufM9L6nzCFkQc6mJoLQM2ej0StBU6J6/OhBbGflf58mBkZonMXjw+uL0WEwlb5voIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 6B3792F2024B; Wed, 10 Apr 2024 11:28:06 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 9B47A2F20248;
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
	kernel test robot <lkp@intel.com>,
	Vadim Fedorenko <vfedorenko@novek.ru>,
	Xin Long <lucien.xin@gmail.com>,
	alaa@dev.mellanox.co.il,
	stable@vger.kernel.org
Subject: [PATCH 2/4 5.10] rxrpc: Fix missing dependency on NET_UDP_TUNNEL
Date: Wed, 10 Apr 2024 14:27:44 +0300
Message-ID: <20240410112747.2952012-3-oficerovas@altlinux.org>
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

[ Upstream commit dc0e6056decc2c454f4d503fd73f8c57e16579a6 ]

The changes to make rxrpc create the udp socket missed a bit to add the
Kconfig dependency on the udp tunnel code to do this.

Fix this by adding making AF_RXRPC select NET_UDP_TUNNEL.

Fixes: 1a9b86c9fd95 ("rxrpc: use udp tunnel APIs instead of open code in rxrpc_open_socket")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vadim Fedorenko <vfedorenko@novek.ru>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
cc: alaa@dev.mellanox.co.il
cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org
---
 net/rxrpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/Kconfig b/net/rxrpc/Kconfig
index d706bb40836574..0885b22e5c0e4c 100644
--- a/net/rxrpc/Kconfig
+++ b/net/rxrpc/Kconfig
@@ -8,6 +8,7 @@ config AF_RXRPC
 	depends on INET
 	select CRYPTO
 	select KEYS
+	select NET_UDP_TUNNEL
 	help
 	  Say Y or M here to include support for RxRPC session sockets (just
 	  the transport part, not the presentation part: (un)marshalling is
-- 
2.42.1


