Return-Path: <stable+bounces-86987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CFA9A5994
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 06:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461A71F22119
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 04:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E61940B2;
	Mon, 21 Oct 2024 04:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Twem3gfa"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0322C95;
	Mon, 21 Oct 2024 04:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729485364; cv=none; b=WOA1i/1aM21yHkuH2gKv3nBnnUyYaZeUFgyXI5z3ifuXCLplcYqYu87zMxM1UeOLPoQWRMReKDuf/MRpqhRln9W6dpDy4l6ZqlSzPjnn+BmiU2nSHsNA0akaTXkloQn9svHGzYjt0Iyu7TjUFDKF6NYltSXppigbEJyw5BZKeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729485364; c=relaxed/simple;
	bh=kfyBl89qi07l58LqgOVh/E+t7hT9q6eZ/J9aUMqlDdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sJ/GT4iZ4kOQV/GJe2HVQLsQ9RmU78aNybGbzY2jLgPNXYigi51qGTdpGYLnarhsFtaRXVlsNUVfkmCj0sqCHNJ8zhb1rNU4gv2cU24Rd2c/ChS2o8C4fLmLGn19vaH9WPxhJRiHfJaK2yPzBMQDYVdOWginGdkRoEMmvxpaRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Twem3gfa; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729485353;
	bh=SWW3lLflcZSTt/7kAMirXY1p2/5OZLkG+On5G9EG8/A=;
	h=From:Date:Subject:To:Cc;
	b=Twem3gfa9XF7vZ9+LBBoBs/KVaTjd5iDwmUpGIHcQHNvjpk+k42dMqotBhFknCfC/
	 tn1EeUwJY4ONJGbsmFGyMCpXAV6hf4cnVktpwRPC/KL6ht8Y4KjXFHbWKKgwRgApbj
	 9JjEIBPUbnh+ikgxFIx8xvHYlfpthwrGsMKpq908znJ991vx8KhJhnDM9P//cerDbr
	 IloAw5RWtSw6n2iYsC1Wl0TAA3ChCf8jQ4DFJ+21o7HWP4LGL/CP2YkmN8vN9E0q/S
	 okSsvfRvgA9arsO3NPMcA1BnMHHwweMgMocF8imL0QKUgIhVdf0OqISw+kCZO4YpA9
	 pAKVP50bRZ5Ag==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id D2D4368607; Mon, 21 Oct 2024 12:35:53 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Mon, 21 Oct 2024 12:35:26 +0800
Subject: [PATCH net v2] mctp i2c: handle NULL header address
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-mctp-i2c-null-dest-v2-1-4503e478517c@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAA3aFWcC/32NQQqDMBBFryKz7kgSrNWueo/iIo7TOqCJJFFax
 Ls3eIAu3//893eIHIQj3IsdAm8SxbsM5lIAjda9GWXIDEaZSivd4ExpQTGEbp0mHDgmtKq35qZ
 ZUdVAHi6BX/I5pU9wnKDL4Sgx+fA9jzZ9Vv+cm0aNvdW2v5q2rrl9kB+YvIsprJRK8nNpV+iO4
 /gBy/ICRcQAAAA=
X-Change-ID: 20241018-mctp-i2c-null-dest-a0ba271e0c48
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Wolfram Sang <wsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Dung Cao <dung@os.amperecomputing.com>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729485352; l=2035;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=kfyBl89qi07l58LqgOVh/E+t7hT9q6eZ/J9aUMqlDdU=;
 b=g8pthMSNyYuR426kRcv+rNB5vPq1JTxfSaNyB/pLReNKQr30VxaDqtwxBo/x6cHU755b1KqIm
 NS1QpeuuzdbDZMqYl6SqN+gNnn/6WS1F7p8opuPbPhlo58ziKBBOG/3
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

daddr can be NULL if there is no neighbour table entry present,
in that case the tx packet should be dropped.

saddr will normally be set by MCTP core, but in case it is NULL it
should be set to the device address.

Incorrect indent of the function arguments is also fixed.

Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Cc: stable@vger.kernel.org
Reported-by: Dung Cao <dung@os.amperecomputing.com>
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
Changes in v2:
- Set saddr to device address if NULL, mention in commit message
- Fix patch prefix formatting
- Link to v1: https://lore.kernel.org/r/20241018-mctp-i2c-null-dest-v1-1-ba1ab52966e9@codeconstruct.com.au
---
 drivers/net/mctp/mctp-i2c.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 4dc057c121f5d0fb9c9c48bf16b6933ae2f7b2ac..c909254e03c21518c17daf8b813e610558e074c1 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -579,7 +579,7 @@ static void mctp_i2c_flow_release(struct mctp_i2c_dev *midev)
 
 static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
 				  unsigned short type, const void *daddr,
-	   const void *saddr, unsigned int len)
+				  const void *saddr, unsigned int len)
 {
 	struct mctp_i2c_hdr *hdr;
 	struct mctp_hdr *mhdr;
@@ -588,8 +588,15 @@ static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
 	if (len > MCTP_I2C_MAXMTU)
 		return -EMSGSIZE;
 
-	lldst = *((u8 *)daddr);
-	llsrc = *((u8 *)saddr);
+	if (daddr)
+		lldst = *((u8 *)daddr);
+	else
+		return -EINVAL;
+
+	if (saddr)
+		llsrc = *((u8 *)saddr);
+	else
+		llsrc = dev->dev_addr;
 
 	skb_push(skb, sizeof(struct mctp_i2c_hdr));
 	skb_reset_mac_header(skb);

---
base-commit: cb560795c8c2ceca1d36a95f0d1b2eafc4074e37
change-id: 20241018-mctp-i2c-null-dest-a0ba271e0c48

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


