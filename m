Return-Path: <stable+bounces-226830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDcNLu6VuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:57:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 419742B063C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 870823265D55
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6542D73B8;
	Tue, 17 Mar 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vdHOJvep"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E615E5BB;
	Tue, 17 Mar 2026 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768378; cv=none; b=EyKN/54x8UUBSKzgKIdnBQBFDuaYOFJSV9PL5o6IV5DMSjpL7xmCUjZpCfVY5vkEOEmOvfZCuy476yYhyGHJ5s6/ScElUAoZZgrO8PpTI7Fh3SExi4vhRj55pzqStP89kr73aRG3HL0fyM7ChWAdMPOMvwC/xuav2PjGOga3ToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768378; c=relaxed/simple;
	bh=an8CiVclzV/aYEITwIHtiRqn2yizFsmAfCcC8qkbFC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQQ45Mc4b7xuNngEDpYqKvqns01ApPFpdvqkQVM9vbRddBSnkNa7hBge/OEAYrl/Duc0sJNN5xeLZAJzu4EmbWHH6flPwtATAVj8QoXalZxR+tBBunFmqoSfiJQkple8c8FiIjnX3hQBddDoaiaExmKlNiBsYKX2gvKmo2ey4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vdHOJvep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E17C4CEF7;
	Tue, 17 Mar 2026 17:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768377;
	bh=an8CiVclzV/aYEITwIHtiRqn2yizFsmAfCcC8qkbFC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vdHOJvep+LhHxsfnEott4DnwnTS4eS4HsHQa74mO+NwGph1pOryh2lPr2BtrWwNEg
	 QTQneAtE8Qku70/ZbUz+H8U3bdZ41EltSFUq+ve+Hq1j7BizuQkAbGt05GJkQf2jUC
	 EQ67tiLbjrOYHrUcD+uGB+yA/80vEVRks+oZibc0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 296/333] iio: magnetometer: tlv493d: remove erroneous shift in X-axis data
Date: Tue, 17 Mar 2026 17:35:25 +0100
Message-ID: <20260317163010.369923909@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226830-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,analog.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 419742B063C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit 82ee91d6b15f06b6094eea2c26afe0032fe8e177 upstream.

TLV493D_BX2_MAG_X_AXIS_LSB is defined as GENMASK(7, 4). FIELD_GET()
already right-shifts bits [7:4] to [3:0], so the additional >> 4
discards most of the X-axis low nibble. The Y and Z axes correctly
omit this extra shift. Remove it.

Fixes: 106511d280c7 ("iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/magnetometer/tlv493d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
index ec53fd40277b..e5e050af2b74 100644
--- a/drivers/iio/magnetometer/tlv493d.c
+++ b/drivers/iio/magnetometer/tlv493d.c
@@ -171,7 +171,7 @@ static s16 tlv493d_get_channel_data(u8 *b, enum tlv493d_channels ch)
 	switch (ch) {
 	case TLV493D_AXIS_X:
 		val = FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 |
-		      FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4;
+		      FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]);
 		break;
 	case TLV493D_AXIS_Y:
 		val = FIELD_GET(TLV493D_BY_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << 4 |
-- 
2.53.0




