Return-Path: <stable+bounces-219877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CYBB9rcoGmMngQAu9opvQ
	(envelope-from <stable+bounces-219877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:52:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C44CC1B10C9
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A977030233EC
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F80329C56;
	Thu, 26 Feb 2026 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ExAUFnqk"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E033439D
	for <Stable@vger.kernel.org>; Thu, 26 Feb 2026 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149969; cv=none; b=Thw2IpjX2zQBnaVkz6OFBQI1A+bud4yZIliRVuaqTGTYubx1WnHgskBwE1m5Z1o7ZFcASO5yMz+rjkmbUj8q1ih+/nfxOjvf3ABYVTwzttGorfP5CRQrKqICkxU1eV1gdH5jBqYxlsP+J3YGtEsBQkC0adCJSnqB5fIAoR3EkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149969; c=relaxed/simple;
	bh=VTJo0t5q88oKhef3cln3YfSNHwPb9+mxWkjluavwOr4=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=NpSPlCIHRIM7+Kna4xuUg8YjE20o0VNGg+N5iID2bL2YmdNisLCR7ZlDCgcTYTtXLJRvx7mn95mlmvu11xp4hoqp8zatVusEoMSID7zEaycrSOE9QgCXR6RAHtDOF0ImQxstvLEmJAXMeyVaUPmK+dIhaNtL2xYHOxRbrPqqMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ExAUFnqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A2FC116C6;
	Thu, 26 Feb 2026 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772149969;
	bh=VTJo0t5q88oKhef3cln3YfSNHwPb9+mxWkjluavwOr4=;
	h=Subject:To:From:Date:From;
	b=ExAUFnqkzRa65Zk+WB9cGXvt656Z5375pA8Ow5ASeChSTDXCBxNE6YbReEHmHWxGo
	 QJduOd993393KyVxqfOykwCfv6wiX/w5Z3F6yNH67SOJUX0V2zmHrb8shC12tfV/iL
	 5V7w+QbV7FeeMqC2qkUDlEA3vv9J9d1wGMzMFxL4=
Subject: patch "iio: magnetometer: tlv493d: remove erroneous shift in X-axis data" added to char-misc-linus
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 26 Feb 2026 15:52:35 -0800
Message-ID: <2026022635-anemia-gilled-316a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219877-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C44CC1B10C9
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: magnetometer: tlv493d: remove erroneous shift in X-axis data

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 82ee91d6b15f06b6094eea2c26afe0032fe8e177 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Tue, 10 Feb 2026 18:49:50 +0200
Subject: iio: magnetometer: tlv493d: remove erroneous shift in X-axis data

TLV493D_BX2_MAG_X_AXIS_LSB is defined as GENMASK(7, 4). FIELD_GET()
already right-shifts bits [7:4] to [3:0], so the additional >> 4
discards most of the X-axis low nibble. The Y and Z axes correctly
omit this extra shift. Remove it.

Fixes: 106511d280c7 ("iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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



