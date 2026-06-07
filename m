Return-Path: <stable+bounces-261445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mycmJ9VJJWrVGAIAu9opvQ
	(envelope-from <stable+bounces-261445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:37:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3F964FDA6
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:37:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=kNaeah6n;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261445-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261445-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0F7B3017501
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E773254A9;
	Sun,  7 Jun 2026 10:36:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2537A32A3C9;
	Sun,  7 Jun 2026 10:36:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828587; cv=none; b=p10wShRWi05qzkex1P/BOWrRRZa6PzmoBKMlSOZyXfO/+VxwCZ5rqcisHPZ9FB8W1DVV5E3Z6OxZToGNnITSEKqGuJpjt1/kfbmdacbK26+C0ZMlWBE5mIhxe0rrensXM8OwMLreavyzBVfM/nub+E3IRdD6o6H5Dkgp8ZoJXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828587; c=relaxed/simple;
	bh=85/puwfzhwyxZ0jMgGEDpcoLRCmAFPtDLx2jIuzI4qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gd4C1o2plZQ83JbN9EmS73+t4payFzvfzFPTmuToNOvTmlagUEwbTbock+h+dYnv0Dfae8Z8AnMkGpvzUkqVWw7LPtK2pGcsDnoZDGgZT+yON1244UDOyiEiEuefxVzJ63ZNcYCf6MoB1mJCI1TeP6Ibx8H4yY0N3sqYYg99u8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kNaeah6n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0681D1F00893;
	Sun,  7 Jun 2026 10:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828586;
	bh=xIxnEEqer6lCmfc/RdlEvRGCjCthy8DWt29MGgQyazI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kNaeah6n303yaDw/TLo4tfolKp2KExhpOAsnv1Ky0ow0A7c3oS9C/1xobsh2sqXam
	 ewepfSsw70Y52hl3Ex+6jIZ1qHylMYuZRC7HVxfjdWvYiwsV3I5d9NTSe6shZKkTGF
	 9R6uiF8YWr/WHz/RcQjnntHQHMgcLj6SAFsNZwco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Gyeyoung Baek <gye976@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7.0 195/332] iio: chemical: mhz19b: reject oversized serial replies
Date: Sun,  7 Jun 2026 11:59:24 +0200
Message-ID: <20260607095735.221369933@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261445-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pengpeng@iscas.ac.cn,m:gye976@gmail.com,m:Jonathan.Cameron@huawei.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,iscas.ac.cn,gmail.com,huawei.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,iscas.ac.cn:email,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C3F964FDA6

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

commit 673478bc29cf72010faaf293c1c8c667393335a0 upstream.

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
Acked-by: Gyeyoung Baek <gye976@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/chemical/mhz19b.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/iio/chemical/mhz19b.c
+++ b/drivers/iio/chemical/mhz19b.c
@@ -52,6 +52,8 @@ struct mhz19b_state {
 	struct completion buf_ready;
 
 	u8 buf_idx;
+	bool buf_overflow;
+
 	/*
 	 * Serdev receive buffer.
 	 * When data is received from the MH-Z19B,
@@ -106,6 +108,10 @@ static int mhz19b_serdev_cmd(struct iio_
 	cmd_buf[8] = mhz19b_get_checksum(cmd_buf);
 
 	/* Write buf to uart ctrl synchronously */
+	st->buf_idx = 0;
+	st->buf_overflow = false;
+	reinit_completion(&st->buf_ready);
+
 	ret = serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
 	if (ret < 0)
 		return ret;
@@ -121,6 +127,9 @@ static int mhz19b_serdev_cmd(struct iio_
 		if (!ret)
 			return -ETIMEDOUT;
 
+		if (st->buf_overflow)
+			return -EMSGSIZE;
+
 		if (st->buf[8] != mhz19b_get_checksum(st->buf)) {
 			dev_err(dev, "checksum err");
 			return -EINVAL;
@@ -240,6 +249,14 @@ static size_t mhz19b_receive_buf(struct
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



