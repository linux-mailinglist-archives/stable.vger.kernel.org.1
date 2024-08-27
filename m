Return-Path: <stable+bounces-70286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D5995FEEB
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 04:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5BA1F2250A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 02:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A5710A3E;
	Tue, 27 Aug 2024 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="iI8bP8wr"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F7846F;
	Tue, 27 Aug 2024 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724975; cv=none; b=hUaC0zp1yqjHoRwKAa+KcI7BYt88LSvRoD5utxergwE1RUJHSv+vZEbCkppUn4MQOMxStpchQUTRFWqSa2JpKi+cmPaKVMLSeV/exfyQsMJ67mxxCFu+JGDvSLl1dYMg1+dVvXSgL3cSc7q1akwWdC3uRXuLlpGKT1j1TRUeMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724975; c=relaxed/simple;
	bh=M3RAVr3uj665OZDliStYtNbwq0gJjrhEh2Chl4fuyDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGg1pJNGMBKfIMWdtdqHb5PSn5dLD6qu6PUvU+gXd5Id0JJOgbabUqNHkxfKRbDwnR7ZLck3nqs3pNL4vM44WJk1bTF7Qun8HDBdTcDyqKPUYWK58NSAnfsFUeHpRVltsebI0JeV5rDzFn0VpYWd0PpmkhcPO93to84cz/ky/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=iI8bP8wr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724724493;
	bh=p800AyUXkvfL2lcxngX4N/WQHpYo7TXzu2o3akbuxCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iI8bP8wrghOtYlkhRtE3kNtkxrSOM8GGTFjAUXDSBRRjhTP/Utiw/hkWpr8el4n88
	 LzHdNXbTZfYu1l5eV7QJgwdue+gaoDUc8DLRvxM2tgkudTkZAXBQssm89g48qapUO0
	 LljlsWoI7gI/nKLBzNa7MAo60SiME81qxsUtJjPC1FBUhHjQTzz93QkOWB+BZ/7OBJ
	 20ii01lTAQk1783y5Gv3yw0fpNb46KMLlvZQ99ljWDARwq9a5FUF1/RZGmTrEVSXYm
	 F4U1xaz5Pp3370OK9B7RvDUfIFLUY40wDrYDJWHFB1zL58bep5/MZiwaYQLRRoFK2o
	 WDa8/5L9EsUOA==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 30B8965139; Tue, 27 Aug 2024 10:08:13 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
To: jk@codeconstruct.com.au
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: mctp-serial: Fix missing escapes on transmit
Date: Tue, 27 Aug 2024 10:07:59 +0800
Message-ID: <20240827020803.957250-3-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827020803.957250-1-matt@codeconstruct.com.au>
References: <20240827020803.957250-1-matt@codeconstruct.com.au>
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
index d7db11355909..82890e983847 100644
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
 

