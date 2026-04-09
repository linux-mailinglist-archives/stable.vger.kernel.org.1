Return-Path: <stable+bounces-235321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UONYKKxM12lrMQgAu9opvQ
	(envelope-from <stable+bounces-235321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:52:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC83C6B2E
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C92EE3008D37
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BC634C140;
	Thu,  9 Apr 2026 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BcF8Kb7O"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EDC2DF132;
	Thu,  9 Apr 2026 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775717540; cv=none; b=oLIUh90aUhjbCbQZLidGUAaFJqlqe0Yr2rFgKXN5y3TpEIQIIf7BXHqKAguIsSUIGx1rD1jKr5KuonLudeLQICADITabyGLq0ylp5KvQLPwSIbAtwuiQ96oWkJrCpwRRXQ3cqRpWJbLZY8+KGliZOdbIy6n3SDJ7VXdXYslARRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775717540; c=relaxed/simple;
	bh=Np5Lt5ETnUEaipPxhdY64Brx8L+nmKdeJoYDj9q6ynY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b+wXqc7sAKZ4Y5oRappJ1TMTswHUwleLYXUxXIrzDsDK4mco4GmnXASwaiEmeK/r3qdmqsGc9ZO6horjadAYL6QJJiCLtTkWcRyF6DCCSYJ3BlYfIu7AE9tjfR2e/naeHG3sb994lHBLtn9qqbhqA1fuWUMpxY0wDA/9ClGCJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BcF8Kb7O; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=td
	6JF46MJVa/vlsyoVQQDQ8QJpiXMdq2Ddm53feU6OU=; b=BcF8Kb7OtHYkJwRi9t
	SQka+hvI/c/Srni/fKJHLNqyA1ztu1b5v52YFRiP2NInvUUzAJo5ttrJbdQHGxqB
	B7Qi9eSHnXaw70TKBrb9N/V+fc8tMX2Iqu8hgeE3OYO+2TYIeHZD1tSlfaoOwE5v
	zQypDSyZNI+hVvqmq8dVRh8WE=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCHUbCDTNdp0ADzDw--.61243S2;
	Thu, 09 Apr 2026 14:51:49 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Robert Garcia <rob_garcia@163.com>,
	Zicheng Qu <quzicheng@huawei.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Daniel Junho <djunho@gmail.com>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] iio: adc: ad7923: Fix buffer overflow for tx_buf and ring_xfer
Date: Thu,  9 Apr 2026 14:51:47 +0800
Message-Id: <20260409065147.136824-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHUbCDTNdp0ADzDw--.61243S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4kXw43WrW7CFW8Kw1xKrg_yoW8XFyrpF
	4YkrWjkF47CF1UCF45Ww1UCFWfWa1DKry2ganrCa9Ivr15ZFy5CrWUK34FvF1rJFW7C39F
	vr1q9ry5Ww109rUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pESfODUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5QWE72nXTIV5+gAA3-
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235321-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[huawei.com,163.com,metafoo.de,analog.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,huawei.com:email]
X-Rspamd-Queue-Id: 9AFC83C6B2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nuno Sa <nuno.sa@analog.com>

[ Upstream commit 3a4187ec454e19903fd15f6e1825a4b84e59a4cd ]

The AD7923 was updated to support devices with 8 channels, but the size
of tx_buf and ring_xfer was not increased accordingly, leading to a
potential buffer overflow in ad7923_update_scan_mode().

Fixes: 851644a60d20 ("iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928")
Cc: stable@vger.kernel.org
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Link: https://patch.msgid.link/20241029134637.2261336-1-quzicheng@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ Context change fixed. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 drivers/iio/adc/ad7923.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index b8cc94b7dd80..a8e59fd2dcf3 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -47,7 +47,7 @@
 
 struct ad7923_state {
 	struct spi_device		*spi;
-	struct spi_transfer		ring_xfer[5];
+	struct spi_transfer		ring_xfer[9];
 	struct spi_transfer		scan_single_xfer[2];
 	struct spi_message		ring_msg;
 	struct spi_message		scan_single_msg;
@@ -63,7 +63,7 @@ struct ad7923_state {
 	 * Length = 8 channels + 4 extra for 8 byte timestamp
 	 */
 	__be16				rx_buf[12] ____cacheline_aligned;
-	__be16				tx_buf[4];
+	__be16				tx_buf[8];
 };
 
 struct ad7923_chip_info {
-- 
2.34.1


