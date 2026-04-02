Return-Path: <stable+bounces-232915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMBRNN8Bzmk/kQYAu9opvQ
	(envelope-from <stable+bounces-232915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 07:42:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4FA38418F
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 07:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BCA3069D72
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 05:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E1370D74;
	Thu,  2 Apr 2026 05:40:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B8C242D70;
	Thu,  2 Apr 2026 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775108426; cv=none; b=fytCnmVHsaX6mM8V2SaNWOzJbQMEExzncIwRWPVnmT+97UOgeYuUKtk7hA49WWI17Vjnuja8Ih8904+MsBYbTlqxIcrPzYkngdjVIQBm1tTPAzqVz4YRXesun11eQVqy26xhz6OP5PP3uVAkrPJdgJ7Sbyj2tUBTmmwjmzcTH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775108426; c=relaxed/simple;
	bh=RlWXLzbu9xrIUqlOY90vMNqryRL8/cs5dVpsRxXxeyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWwB0Yx7rYm73t47ADprMWpSpBL1ckXl1WQ5rZgEi+0cWF3DDZMWohlZE9vfT9vQEKVcNGlM6UGjc1k7eWSQ4gorq28awMvFt9Cohw0/gGuua8JYrP+p1/r0LBStZXyOD/t6lf35GRXMFb6T+we4DFAhA8mZ3Gds7B/NRPYDS4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAB3IW0_Ac5pOvbxCw--.16287S2;
	Thu, 02 Apr 2026 13:40:16 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Gyeyoung Baek <gye976@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn,
	stable@vger.kernel.org
Subject: [PATCH] iio: chemical: mhz19b: reject oversized serial replies
Date: Thu,  2 Apr 2026 13:40:15 +0800
Message-ID: <20260402054015.38565-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3IW0_Ac5pOvbxCw--.16287S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4xKr47ury3ZF1kZr4fKrg_yoW8tw4fpF
	45JF15CFy8Xr4xKr1vkrnrCFy5uFWFyayDAF4xAa43ZF15J34qkFykKFyrXr4IyrWrCa42
	vryDKrWY9ay5ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqeHgUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232915-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 3F4FA38418F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mhz19b_receive_buf() appends each serdev chunk into the fixed
MHZ19B_CMD_SIZE receive buffer and advances buf_idx by len without
checking that the chunk fits in the remaining space. A large callback
can therefore overflow st->buf before the command path validates the
reply.

Reset the reply state before each command and reject oversized serial
replies before copying them into the fixed buffer. When an oversized
reply is detected, wake the waiter and report -EMSGSIZE instead of
overwriting st->buf.

Fixes: 4572a70b3681 ("iio: chemical: Add support for Winsen MHZ19B CO2 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/iio/chemical/mhz19b.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
index 3c64154918b1..90c997191c83 100644
--- a/drivers/iio/chemical/mhz19b.c
+++ b/drivers/iio/chemical/mhz19b.c
@@ -52,6 +52,7 @@ struct mhz19b_state {
 	struct completion buf_ready;
 
 	u8 buf_idx;
+	bool buf_overflow;
 	/*
 	 * Serdev receive buffer.
 	 * When data is received from the MH-Z19B,
@@ -106,6 +107,10 @@ static int mhz19b_serdev_cmd(struct iio_dev *indio_dev, int cmd, u16 arg)
 	cmd_buf[8] = mhz19b_get_checksum(cmd_buf);
 
 	/* Write buf to uart ctrl synchronously */
+	st->buf_idx = 0;
+	st->buf_overflow = false;
+	reinit_completion(&st->buf_ready);
+
 	ret = serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
 	if (ret < 0)
 		return ret;
@@ -121,6 +126,9 @@ static int mhz19b_serdev_cmd(struct iio_dev *indio_dev, int cmd, u16 arg)
 		if (!ret)
 			return -ETIMEDOUT;
 
+		if (st->buf_overflow)
+			return -EMSGSIZE;
+
 		if (st->buf[8] != mhz19b_get_checksum(st->buf)) {
 			dev_err(dev, "checksum err");
 			return -EINVAL;
@@ -240,6 +248,14 @@ static size_t mhz19b_receive_buf(struct serdev_device *serdev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
 	struct mhz19b_state *st = iio_priv(indio_dev);
+	size_t remaining = MHZ19B_CMD_SIZE - st->buf_idx;
+
+	if (len > remaining) {
+		st->buf_idx = 0;
+		st->buf_overflow = true;
+		complete(&st->buf_ready);
+		return len;
+	}
 
 	memcpy(st->buf + st->buf_idx, data, len);
 	st->buf_idx += len;
-- 
2.50.1 (Apple Git-155)


