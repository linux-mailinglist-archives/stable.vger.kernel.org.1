Return-Path: <stable+bounces-273618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 05/AJ+WwVGpHpgMAu9opvQ
	(envelope-from <stable+bounces-273618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:33:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4087C74959D
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:33:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=mKmVrnWX;
	dmarc=pass (policy=none) header.from=uniontech.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273618-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273618-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5787C301D05C
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD7B3E1732;
	Mon, 13 Jul 2026 09:33:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D33E024F;
	Mon, 13 Jul 2026 09:33:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935193; cv=none; b=IUOSO1sANM5E9Fe0lgdzxDxEXWuYN/amfx9cTmSWlVhapgposuAyTB0IMEYKnNjVOqvNnywH/G06pc9eV7GP4f+Mv+KWBBaMMD5XRGg2QCfC5snQK+Vn+kG0Un0HWHE1RWZfupJd74Brb2djCrqhrDVzRbTeOqt1s0I+6HuNqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935193; c=relaxed/simple;
	bh=iF8R7oBHHe4h8c/wcMeQ/WmPi8XOA4vfShtynnbZflE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcR71SrK6xSAUL+q09DbyunSUV4De8znVTHkRzkM+npWlCaxJP3R/Qs0hvD21HkqG9MDsQd83XPJJVFGrceDtmNfcTTcAt4DoVXxSE36MuUGWR0oOoGu1/eN4JWlBw7JkwqosjMNmIR0WCoWKeY2oP0L5L0bBsNaCwpMh3HgesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mKmVrnWX; arc=none smtp.client-ip=54.207.22.56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783935166;
	bh=UiIh4OOhAvzzVkPtdgMJxtSPcXyqzkLManFtvdn0m6g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mKmVrnWXaBRJtLPz9XtSzZN7AM6Qv+y7HNMP9RECL36+7wr76rtmMelyczrSNGLKp
	 MjEwPh02vq45tu3U+Z4x6BnstkK1B/eKS0iHVPkIArWiCXz5BZ9GeQKDE+6ertniqS
	 982FAF7X9IobmrLyH024xLzFhimuSEQ8JxRKp9Eo=
X-QQ-mid: esmtpsz21t1783935161t12b464a2
X-QQ-Originating-IP: Zo6aPw+xIR/Z8JGu2D3imdDpMwvCIDKIlqGdsRUZxM8=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 17:32:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 36213218852409400
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: andreas.noever@gmail.com
Cc: westeri@kernel.org,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] thunderbolt: icm: preserve USB4 proxy data-valid bit
Date: Mon, 13 Jul 2026 17:32:37 +0800
Message-ID: <BA3238878103AC07+20260713093237.3516283-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MLbAtvpy5B1PBUEzIsVyP2A5eq6UHQzJMT4Yi0JyLy3yDX/LQ8mTHqoI
	DKOc0Xa89FqmCD37PTEqnPm4ANj9gywHT1lD8BFALb98LHhIl5xeq4JBHv94P7Q9SBtfa/W
	7uccvBpLNsg5V0i3sZPIHS5s3fDRtmGiuGGtld3+b0YT4NsFEjxHgVeZ//f4Dekw0wRXhBC
	IrSRmXE1U7aWpWVUeI/LER360stXgYXnO3XOzsQ6ukdF0SwFofdxz1rrxfQN1VciGxq0I5K
	r9YLsKfsQ6kClcC8fg2mTwFz6Q/Mk1urf5NZ7k6YwkAU7UrGMOcN+i7KtJWEzNNpWB1OUje
	QGRUAMdk2STsQUZrm6683Nsaf39sfH/hW7DjxNiAWamgQNhOoKJ4L9kjbZJT3IqahDQfDdF
	VKlTPXnexIoeux87IOla/uzyK6sQAMEpxDMqt4d20QSlgNQPOebuzSHztAMHc4Qqujfknna
	2uqNYEBwsERWHx/J47vN1oLxdezABsoCq+zLeMWcBXdhSp6NuBK9HH5iAZTagy03tN7A/aU
	+DUl1o+RhZZtTrlpyBV50h68UadndKVBKxZ+Kycp0gecmLUISJi5YdBbbK5fAlEDaVR67JQ
	s4nvJm26yV2taRM5SXp21YMOcNHgwwZhNHbJqejEbHn21ELCoxv6uArZD9n+nWepdTdC0wW
	bxVp8n4yYT3WEDNgx8ErgUFxywLnL1F9YP4nMrSCDnKWGbNRtkGTKcnDrnP2Id3G9G0u1g6
	BWOcAD6q75PAqhcLkVX0VueGD25Km5SPkxUI5WKr0tGkRVAs/eAeuvRftU+1Ww0x/ymEzBH
	Uu3pqwlYkYxVlV1KzLm1pSfDLQGHIH/QJD186fb2FI+sFJ2a6mAzlA2HtAyBFP70ameanj9
	6rwy9jwZVBra14MVTOoTpDB/5X1gFrSV2KRJoHxAFcjkZTO1NnTeuEzIbyeHW58150T4EaT
	koGqRfVyeMCwULHpsqm+8AZwj9vl+LAoCKEXqO9P+YVXiC9rgws2HQ4hnvoZvnEpgdj/+aR
	Wl7RHKiFvpZw/Gs1KdIjIrbZ0tTNOpivMb7upBXUkesCaVFi9eFvXl45qAfWI4hQq6mgO/R
	K9dZl9qv46m
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,uniontech.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-273618-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andreas.noever@gmail.com,m:westeri@kernel.org,m:YehezkelShB@gmail.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:raoxu@uniontech.com,m:stable@vger.kernel.org,m:andreasnoever@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:from_mime,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4087C74959D

From: Xu Rao <raoxu@uniontech.com>

The ICM USB4 switch operation request encodes two values in
request.data_len_valid: bit 4 marks the data payload valid, while bits
3:0 hold the payload length in dwords.  A zero length with the valid bit
set represents the full 16-dword data array.

icm_usb4_switch_op() sets the valid bit when a transmit payload is
present.  For payloads shorter than the full 16 dwords, it then assigns
the length to the whole field and clears the valid bit that was just set.
The payload is still copied into the request, but the descriptor sent to
firmware marks that data as invalid.

This affects USB4 router operations that send short payloads through the
firmware connection manager.  In particular, USB4 NVM writes can send a
short final block when the image size is not aligned to the 64-byte proxy
payload size.  Firmware may then ignore or reject that final block, while
full 16-dword blocks are unaffected because they are encoded as length 0
with the valid bit set.

OR the short payload length into data_len_valid so the valid bit is
preserved.

Fixes: 9039387e166e ("thunderbolt: Add USB4 router operation proxy for firmware connection manager")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/thunderbolt/icm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 10fefac3b1d9..669807f0eaf8 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -2341,7 +2341,7 @@ static int icm_usb4_switch_op(struct tb_switch *sw, u16 opcode, u32 *metadata,
 	if (tx_data_len) {
 		request.data_len_valid |= ICM_USB4_SWITCH_DATA_VALID;
 		if (tx_data_len < ARRAY_SIZE(request.data))
-			request.data_len_valid =
+			request.data_len_valid |=
 				tx_data_len & ICM_USB4_SWITCH_DATA_LEN_MASK;
 		memcpy(request.data, tx_data, tx_data_len * sizeof(u32));
 	}
--
2.50.1


