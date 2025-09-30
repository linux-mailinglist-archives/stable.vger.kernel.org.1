Return-Path: <stable+bounces-182553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054CEBADA55
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9F31944051
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3C629827E;
	Tue, 30 Sep 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ACauneM7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692001D6188;
	Tue, 30 Sep 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245322; cv=none; b=MEfadCwQYmM/kKnmHpV3qUCBWPmhTkw45KH9raLDccaBtHjX+1WNmA4c2G0j5RQc76Z53Z/f01aO9YmM2xf0Zf2kPixBq38aAPBqI15VrrEU+pzewIajRSMqQx8oqPrEBKDtrAmRpjyyZpDOYNQZ5omznUFwfgw0MC3XzatntH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245322; c=relaxed/simple;
	bh=JWh5iDocfDenRB4TAT2UqkOe8mOXI4v319YbOAq09Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmlpsXlWAPpOTV0AGe6NW0ulQ9yMQrUoVOguTlNZ4UFSDcHqJVhRmtoZ5qGMVLbYMtMHd4woUciEfkOJDZA4rBldgCM1P/4C5mWg6LuP//dhBtKAmRE3dlPeULQCjWJXdO42rlFotDQ4lJMyEAAqts+ItIqEBAFAZUhoNOavRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ACauneM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BB4C4CEF0;
	Tue, 30 Sep 2025 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245320;
	bh=JWh5iDocfDenRB4TAT2UqkOe8mOXI4v319YbOAq09Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACauneM7XVjBioi31DG6QYak6GgDkm4kuUNA6yKpDmmqyTpTb+u9CYtsJe2Bk8Ufn
	 c/lPzwv9YWVO+qJ0G2/xV85+U2pbqHCfa47+QYhB+fu02ZpRubNKLy2+DZ3UEtIeDG
	 s65yA2nTlNzy/xq3UhALHVoReNwL+sNfmS74oU0I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 134/151] net: dsa: lantiq_gswip: suppress -EINVAL errors for bridge FDB entries added to the CPU port
Date: Tue, 30 Sep 2025 16:47:44 +0200
Message-ID: <20250930143832.936608897@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
References: <20250930143827.587035735@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 987afe147965ef7a8e7d144ffef0d70af14bb1d4 ]

The blamed commit and others in that patch set started the trend
of reusing existing DSA driver API for a new purpose: calling
ds->ops->port_fdb_add() on the CPU port.

The lantiq_gswip driver was not prepared to handle that, as can be seen
from the many errors that Daniel presents in the logs:

[  174.050000] gswip 1e108000.switch: port 2 failed to add fa:aa:72:f4:8b:1e vid 1 to fdb: -22
[  174.060000] gswip 1e108000.switch lan2: entered promiscuous mode
[  174.070000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 0 to fdb: -22
[  174.090000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 1 to fdb: -22
[  174.090000] gswip 1e108000.switch: port 2 failed to delete fa:aa:72:f4:8b:1e vid 1 from fdb: -2

The errors are because gswip_port_fdb() wants to get a handle to the
bridge that originated these FDB events, to associate it with a FID.
Absolutely honourable purpose, however this only works for user ports.

To get the bridge that generated an FDB entry for the CPU port, one
would need to look at the db.bridge.dev argument. But this was
introduced in commit c26933639b54 ("net: dsa: request drivers to perform
FDB isolation"), first appeared in v5.18, and when the blamed commit was
introduced in v5.14, no such API existed.

So the core DSA feature was introduced way too soon for lantiq_gswip.
Not acting on these host FDB entries and suppressing any errors has no
other negative effect, and practically returns us to not supporting the
host filtering feature at all - peacefully, this time.

Fixes: 10fae4ac89ce ("net: dsa: include bridge addresses which are local in the host fdb list")
Reported-by: Daniel Golle <daniel@makrotopia.org>
Closes: https://lore.kernel.org/netdev/aJfNMLNoi1VOsPrN@pidgin.makrotopia.org/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250918072142.894692-3-vladimir.oltean@nxp.com
Tested-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/lantiq_gswip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 97d88c25fc992..c40fd7dd153e8 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1337,8 +1337,9 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
 	int i;
 	int err;
 
+	/* Operation not supported on the CPU port, don't throw errors */
 	if (!bridge)
-		return -EINVAL;
+		return 0;
 
 	for (i = cpu_port; i < ARRAY_SIZE(priv->vlans); i++) {
 		if (priv->vlans[i].bridge == bridge) {
-- 
2.51.0




