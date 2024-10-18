Return-Path: <stable+bounces-86727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63419A3333
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 05:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B46B23896
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 03:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BB7154C05;
	Fri, 18 Oct 2024 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFxK92/9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D110291E;
	Fri, 18 Oct 2024 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220893; cv=none; b=lxFnNVPwDCZ+vGwBx/FUSvya2WrqW4YOfVtX0Fq9jPc85GSKa7kqxCwB5JvKjopfIcse2KWp1+sGJxYowj+oLe1XN6TLBJ1tr27J7swcTht5UlNbawLCWKaEjW7m1zU/+Plb46aQlqDpLvk0Kp3+qSVyUt6fOOq+IFRxtcSovgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220893; c=relaxed/simple;
	bh=DLTm42oj/supRBQkXEbePYVnGCztt3PzrDSJ7iJZz1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z/WDwGneNY7AZx+w7eI8g8DYIjDped/aoRwBw5CI0g0KPnZiONRIVRcl4aw9tT4VJc5/559dqrHmIS+y1wBNotENmKPjRlQu/UyTzGTj4QhC+AKwypromrsvSIHq9P+3UUgOSfn8P5+WqjYOvKDjg4ru7m5G/GOj+uCqZudkm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFxK92/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E3CEC4CEC3;
	Fri, 18 Oct 2024 03:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729220893;
	bh=DLTm42oj/supRBQkXEbePYVnGCztt3PzrDSJ7iJZz1I=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hFxK92/9D6V7W9LFT1fgiA+Q3nZ76/Cn/bwDF7MtykdlxKb2Hag4m7mKFKQXYseeH
	 4ab0xNIRjRpfBT2ySM03l1EVhFJ6pf2NuxM8mOt4klS2DscyjJf0w4bdwNhoRpFbUP
	 aGJitKODFTeexRsxsPcYF5c6Ko5O4Dd/Sg8+wZvIVRiGdzzByDXn46rvv3K6GfeTsO
	 5wYqkhwBeOzVRUmHkXBMPngnaqQGJnt4/dqGKvzQfrU/FmDxn+Mh4cHw/FWPSKWJOY
	 RwWnX0j6UMrTfV59cFXMX54sYmBYiWkKhQrXPHD4Y3JIO/IMkomLdgL7gH5Lgchuqe
	 bov4hZ2vUGdIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC91FD3C545;
	Fri, 18 Oct 2024 03:08:12 +0000 (UTC)
From: Matt Johnston via B4 Relay <devnull+matt.codeconstruct.com.au@kernel.org>
Date: Fri, 18 Oct 2024 11:07:56 +0800
Subject: [PATCH net] mctp i2c: handle NULL header address
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-mctp-i2c-null-dest-v1-1-ba1ab52966e9@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAAvREWcC/x3MQQqAIBBA0avErBtQEYquEi1MpxowC7UIwrsnL
 d/i/xcSRaYEQ/NCpJsTH6FCtg3YzYSVkF01KKG0FLLH3eYTWVkMl/foKGU0YjaqkySs7qGGZ6S
 Fn386QqAMUykfIW658GkAAAA=
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
 Dung Cao <dung@os.amperecomputing.com>, 
 Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729220892; l=1006;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=7a9bBX5OhQLyOr0r2mEwMYUi2yLjFDmAXhWqLtXX1W8=;
 b=/kNBRjdGOn742jnFpm20G3DlxvqTct2cMcXuCtIZTiEISmQex18y9fVEgY0Ii8Ngu8YDHGt+7
 u6RB0cOeiE3AhBqtNltj+KYY4be3ke+hCZ26q0kNMwb8ifYDVhMCybB
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=
X-Endpoint-Received: by B4 Relay for matt@codeconstruct.com.au/20241018
 with auth_id=253
X-Original-From: Matt Johnston <matt@codeconstruct.com.au>
Reply-To: matt@codeconstruct.com.au

From: Matt Johnston <matt@codeconstruct.com.au>

daddr can be NULL if there is no neighbour table entry present,
in that case the tx packet should be dropped.

Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Cc: stable@vger.kernel.org
Reported-by: Dung Cao <dung@os.amperecomputing.com>
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git drivers/net/mctp/mctp-i2c.c drivers/net/mctp/mctp-i2c.c
index 4dc057c121f5..e70fb6687994 100644
--- drivers/net/mctp/mctp-i2c.c
+++ drivers/net/mctp/mctp-i2c.c
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



