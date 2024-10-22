Return-Path: <stable+bounces-87708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F289A9FE6
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 12:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B4D1F233BE
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 10:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACDB199FDE;
	Tue, 22 Oct 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="UwtAw8jc"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BDD18BBA9;
	Tue, 22 Oct 2024 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592730; cv=none; b=sqElM1qmRy+gFBeZGc+17TuqR2KVlW60uu4THx+9v9MCrz5qN2VrqKkFzVWJ5/IQ2/qzVSa6GbyP79Fk5/pGZGw0Qngc3QMDm7ARPqfgwmg66IckpaUuL7/mu/V3nMON4R4Un/EkO6hnYkKhIOgY49ztuGs8pIjhIEMflLhpnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592730; c=relaxed/simple;
	bh=KJD4Ry/2X30y0yWc1Gi4NZVNNYThAgbJWHFDVv9gsok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DdEdCmuB7CYi+HXbzhI5mbybEPpXM+ByK0xapCZoJ3CFRsir8HK+4MYokIV6FLjRsRZmLsOGAGsA5FAxUHs+FcHCI+yu/dMxjrHLyMcACAneTLozgAxonT5CG2Nk67OLDrvFhHOozLJExSBgET1f4GZvQ4/wXYywNco/bJxI23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=UwtAw8jc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729592719;
	bh=6o56xZfBaRNwzkXaIrbO659XgXhrMaP0nd4BRPOidOc=;
	h=From:Date:Subject:To:Cc;
	b=UwtAw8jcuJKMf/rk6Tx+9oa0CXWK5H5zG/XYV92FXlYfuNmBJBNxI1vIA4oKijKn3
	 to0GeMttvZlhFojESUZd6xbcFr/QVoM7DobGuGxdnfHCGc1+Tuz7mqkqdvEUNRA45s
	 y5PzrsTKNq2bz1jG+v3f0JxJgTwyd5rCq90B58o1hDwPwARtf5zyiy5oB2B5Cx7brg
	 OSzeg7fGnZKjKZcRcemFLvR3bYP+uAbD9EkfbiLEM4nqLXAFejZHzrgdI9s/1NwBUF
	 pN04BJD88UKhCL0EUY7VyscI1j3oCQ7cBaUaWOyxadbw9FS2UVERPeLizNI/SepOyZ
	 MCNKsLJ/bVuMw==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 58A7E691B2; Tue, 22 Oct 2024 18:25:19 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Tue, 22 Oct 2024 18:25:14 +0800
Subject: [PATCH net v3] mctp i2c: handle NULL header address
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-mctp-i2c-null-dest-v3-1-e929709956c5@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAIl9F2cC/33NTQ7CIBAF4Ks0rKVh6L8r72Fc0OloSVpogBJN0
 7tLunKhLt+8zPc25slp8uycbcxR1F5bk0JxyhiOyjyI6yFlJoUsQUDLZwwL1xK5WaeJD+QDV6J
 XsgESWLYsPS6O7vp5oFdmKLBbOo7aB+tex1CEo/pnRuDAewWqr2RX19Rd0A6E1vjgVgw52jlX6
 yFH+aFJ+KrJpJWVKKhs2goa/KHt+/4GIq3UhxIBAAA=
X-Change-ID: 20241018-mctp-i2c-null-dest-a0ba271e0c48
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Wolfram Sang <wsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Dung Cao <dung@os.amperecomputing.com>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729592718; l=1644;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=KJD4Ry/2X30y0yWc1Gi4NZVNNYThAgbJWHFDVv9gsok=;
 b=dofR1HzPL5sL8/hYzPbWlf8fLcFn3fP2KRK4ajY3bANNXS6A/ntHLPCZdNwGpRoXjkQXJokc/
 UarEtsQVBn9BFM/BsSuuoGfLXhygVFoKlCO6XK+BSaIW2DJTULmvtCw
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

daddr can be NULL if there is no neighbour table entry present,
in that case the tx packet should be dropped.

saddr will usually be set by MCTP core, but check for NULL in case a
packet is transmitted by a different protocol.

Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Cc: stable@vger.kernel.org
Reported-by: Dung Cao <dung@os.amperecomputing.com>
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
Changes in v3:
- Revert to simpler saddr check of v1, mention in commit message
- Revert whitespace change from v2
- Link to v2: https://lore.kernel.org/r/20241021-mctp-i2c-null-dest-v2-1-4503e478517c@codeconstruct.com.au

Changes in v2:
- Set saddr to device address if NULL, mention in commit message
- Fix patch prefix formatting
- Link to v1: https://lore.kernel.org/r/20241018-mctp-i2c-null-dest-v1-1-ba1ab52966e9@codeconstruct.com.au
---
 drivers/net/mctp/mctp-i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 4dc057c121f5d0fb9c9c48bf16b6933ae2f7b2ac..e70fb66879941f3937b7ffc5bc1e20a8a435a441 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -588,6 +588,9 @@ static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
 	if (len > MCTP_I2C_MAXMTU)
 		return -EMSGSIZE;
 
+	if (!daddr || !saddr)
+		return -EINVAL;
+
 	lldst = *((u8 *)daddr);
 	llsrc = *((u8 *)saddr);
 

---
base-commit: cb560795c8c2ceca1d36a95f0d1b2eafc4074e37
change-id: 20241018-mctp-i2c-null-dest-a0ba271e0c48

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


