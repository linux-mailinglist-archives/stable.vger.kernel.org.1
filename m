Return-Path: <stable+bounces-47647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C448D3A8B
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 17:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4641F24B2C
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7083E17F38E;
	Wed, 29 May 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OT1wS6cj"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CD17BB17
	for <stable@vger.kernel.org>; Wed, 29 May 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995869; cv=none; b=Qdc+J+z29D29YFKDv+onnqBKSKKhDcFX5g6LU6q+LBoYmG+N2E9Si+wB9E6eyyX7biOgMaH6SDxiYmDcQNfqfwPZarlbk8qT0vEtveP6M7jmpUYnmRLrtL/jiC7d+6DP2tDl6VRcSrs1BaLO3h0gIZZaQb5OO5X08Btcf+aO7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995869; c=relaxed/simple;
	bh=vzsK31JkWOOVNx0mkraRdWn1Wf9rEykDGvhmFzNoBxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/X7n60wDsosb09l+pHC5pm/gnkf959UpO+m4yh00jg6RXkUXEy2o7huiltXYEr9WjzWCxlQPQm8S+ipqDVy4Ybfjr8aOWTv0vmSDPNFleT6gVwV38huKTBd6NX78p1NHEgvFy7WcmqO7skhPW+2hOviVhU7D8lkXWkthY1/Xcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OT1wS6cj; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ABD5C3FEF5;
	Wed, 29 May 2024 15:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716995864;
	bh=VwVedG5ofM+gl6SVN7aCuMmzFqNcvKVg6fz2vy21s4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=OT1wS6cjWQQ/9mazFqqT4mSp+Tk6Z2ie+0elY2kk08iyN/hoCW9Fw85afYKqeuKdI
	 R3dAo6+g4g/T/bVaqH8Yf4G3HdblA0girJoe44QyOJ2f/BUe/xA38cPe3ZIRavyGgu
	 5g7Me1lMSyH1//yLkZPkENyMgGIkC3dLHdIx0mIx6IC6WJ0xV4oO44E7W87j/xu5kn
	 Tr+cg/cID8z5jeZgI+9jrEcbBGRiTx1KVshV9GaYe3myPrEaMh/qBJhPXQ1JMXSuYN
	 iSaLpFRP2PuqcENZiUbPNOb4z1MIgRqFhkPkK3rgIEt9OCy6droXfmxBQDPMzpZn9a
	 qqseYO18+EpiQ==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	po-hsu.lin@canonical.com
Subject: [PATCH 6.6.y 3/4] selftests: net: included needed helper in the install targets
Date: Wed, 29 May 2024 23:16:02 +0800
Message-Id: <20240529151603.204106-4-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529151603.204106-1-po-hsu.lin@canonical.com>
References: <20240529151603.204106-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit f5173fe3e13b2cbd25d0d73f40acd923d75add55 upstream.

The blamed commit below introduce a dependency in some net self-tests
towards a newly introduce helper script.

Such script is currently not included into the TEST_PROGS_EXTENDED list
and thus is not installed, causing failure for the relevant tests when
executed from the install dir.

Fix the issue updating the install targets.

Fixes: 3bdd9fd29cb0 ("selftests/net: synchronize udpgro tests' tx and rx connection")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/076e8758e21ff2061cc9f81640e7858df775f0a9.1706131762.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[PHLin: ignore the non-existing lib.sh]
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index de4506e..6fbebf8 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -55,6 +55,7 @@ TEST_PROGS += rps_default_mask.sh
 TEST_PROGS += big_tcp.sh
 TEST_PROGS_EXTENDED := in_netns.sh setup_loopback.sh setup_veth.sh
 TEST_PROGS_EXTENDED += toeplitz_client.sh toeplitz.sh
+TEST_PROGS_EXTENDED += net_helper.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
 TEST_GEN_FILES += tcp_mmap tcp_inq psock_snd txring_overwrite
-- 
2.7.4


