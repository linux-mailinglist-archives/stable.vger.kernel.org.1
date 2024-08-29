Return-Path: <stable+bounces-71464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ED2963D68
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 09:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397661F238F7
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 07:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1871898FC;
	Thu, 29 Aug 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="EJefvFLm"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AA18785D;
	Thu, 29 Aug 2024 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917455; cv=none; b=iwYmUybdHwwLaAHH8J5GjXYu+DeMR+V3bp2hLv67HGUmeDPPRrpBAT4pHfWPUyWhU3/xqT/NBYmh0OXLfk/9QN3BywnOlxSRIRNtdYiLK4Q/cuzd/qoRAzWX1YuMscb3pC4zqJD8SoZ+82DvEvlvCPCXwLkF6IaFhX6T9P/4uJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917455; c=relaxed/simple;
	bh=3H72LhuMwWS0t4/YPNgUCGZ4hz8rWOy8uMlCfu9xSGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKYCBY5IkJZlubVLRpSLwkv4TJI+mKGzcTByQMKwZlrk1dquq1V2iV9XNV1ZHZiFm4r2l3e9GjJ7ZdTzh2qQX9OG4Ze1n04S2oCSn4cjmIwUzV24n7FNuifRACqgtxrar3NgTUDfwp/XSStuVRc2zldmCK++lKNnYZwMJak4hhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=EJefvFLm; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724917445;
	bh=5R+sgB3xKH3yRTXkv5FKxf6/TvALXzaZUV1xcy3orLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EJefvFLmrToaN45BDm1toX0lNG1nkCxFmISUiVnFTeUKEgFFuzb9QxSguJGGECvK4
	 bAFnmZ2vQO7v0ZB/X3FN9qGv+XRkYt/HgjD6To+U4yTZSUC8qpe+KYXTw93QG7KHYK
	 bSgwi8q5dA1QYUpHIg+pYHhDMEK1oa15JCRQD/sPZQ6ogoz3kSFyrltg8PzkWBwmva
	 VOPOX/9j/BotVXKda6KcswQjrKHJzsIImPB8Y4Xt3ZyC6OET58E3OgY0egktuPHw2R
	 HA3hFjMG7XVtDJPFc7UM5uqIQUJHRG4ljCQQ+jq7IRXgt3lxoZRS9AnFhWUGSBaBAl
	 dtiKfyMk+3UXQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id DDA566750A; Thu, 29 Aug 2024 15:44:05 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] net: mctp-serial: Fix missing escapes on transmit
Date: Thu, 29 Aug 2024 15:43:46 +0800
Message-ID: <20240829074355.1327255-3-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829074355.1327255-1-matt@codeconstruct.com.au>
References: <20240829074355.1327255-1-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

0x7d and 0x7e bytes are meant to be escaped in the data portion of
frames, but this didn't occur since next_chunk_len() had an off-by-one
error. That also resulted in the final byte of a payload being written
as a separate tty write op.

The chunk prior to an escaped byte would be one byte short, and the
next call would never test the txpos+1 case, which is where the escaped
byte was located. That meant it never hit the escaping case in
mctp_serial_tx_work().

Example Input: 01 00 08 c8 7e 80 02

Previous incorrect chunks from next_chunk_len():

01 00 08
c8 7e 80
02

With this fix:

01 00 08 c8
7e
80 02

Cc: stable@vger.kernel.org
Fixes: a0c2ccd9b5ad ("mctp: Add MCTP-over-serial transport binding")
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 7a40d07ff77b..f39bbe255497 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -91,8 +91,8 @@ static int next_chunk_len(struct mctp_serial *dev)
 	 * will be those non-escaped bytes, and does not include the escaped
 	 * byte.
 	 */
-	for (i = 1; i + dev->txpos + 1 < dev->txlen; i++) {
-		if (needs_escape(dev->txbuf[dev->txpos + i + 1]))
+	for (i = 1; i + dev->txpos < dev->txlen; i++) {
+		if (needs_escape(dev->txbuf[dev->txpos + i]))
 			break;
 	}
 

