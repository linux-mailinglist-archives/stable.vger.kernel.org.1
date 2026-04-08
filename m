Return-Path: <stable+bounces-235056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMqtOoak1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:55:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F27713C1F04
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37CD53007AE9
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0003D9043;
	Wed,  8 Apr 2026 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zmnxHXTQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915DE3D8912;
	Wed,  8 Apr 2026 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674456; cv=none; b=Bvtytc5wAuhpiJDReSlGV1nPWsUKVJamAl+Ljuj88fJ8uLVnWvgDuv8KpEpWdpQD/o4x4WJPcTltaLdQYptcHFpGIM4UW6vEK+fcZR9LC0wU83iG7dXoy7BkZO9p1HVG5dV6oSFDRTv8QGJ484lRGBucDH5g5tD5zm7YAFwHPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674456; c=relaxed/simple;
	bh=0aErxOv7tlpc0rpoB0aHAz+LiFHlLwXixx1igcXP/WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyWQ/GCkPdtbVmBMvLQGHggGj2Rl7IRUYR1THqOoygfvQ+VXMOPqWNbDqUPIU9aXrdVE26j9eN606SqQM4ku3/isDBolcl+cPKiI3+/iaVEN7HA5+QOPupwZePZxf/E8Xhz9Tn5NuRxUNS0SRnBRMpnpslteik8teuyQW3NPEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zmnxHXTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24899C19421;
	Wed,  8 Apr 2026 18:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674456;
	bh=0aErxOv7tlpc0rpoB0aHAz+LiFHlLwXixx1igcXP/WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zmnxHXTQnri+lXTkHSheb4Ol6zt/Yqna91D0arVgmq1FVFHFbTUe+OomJ/N/be+km
	 DhoaTZACfdulT027vvIgfafB2W8Ayc45AMJQPdro3CKlKwI0TNLk7UrrMBe6wkKJDZ
	 qLDLFt531r+3OErUkaVkfg3TFQpooiGxSiMc8KHo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 072/311] NFC: pn533: bound the UART receive buffer
Date: Wed,  8 Apr 2026 20:01:12 +0200
Message-ID: <20260408175942.103077147@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235056-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,iscas.ac.cn:email]
X-Rspamd-Queue-Id: F27713C1F04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit 30fe3f5f6494f827d812ff179f295a8e532709d6 ]

pn532_receive_buf() appends every incoming byte to dev->recv_skb and
only resets the buffer after pn532_uart_rx_is_frame() recognizes a
complete frame. A continuous stream of bytes without a valid PN532 frame
header therefore keeps growing the skb until skb_put_u8() hits the tail
limit.

Drop the accumulated partial frame once the fixed receive buffer is full
so malformed UART traffic cannot grow the skb past
PN532_UART_SKB_BUFF_LEN.

Fixes: c656aa4c27b1 ("nfc: pn533: add UART phy driver")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Link: https://patch.msgid.link/20260326142033.82297-1-pengpeng@iscas.ac.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/pn533/uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nfc/pn533/uart.c b/drivers/nfc/pn533/uart.c
index a081bce61c29f..49c399a571750 100644
--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -211,6 +211,9 @@ static size_t pn532_receive_buf(struct serdev_device *serdev,
 
 	timer_delete(&dev->cmd_timeout);
 	for (i = 0; i < count; i++) {
+		if (unlikely(!skb_tailroom(dev->recv_skb)))
+			skb_trim(dev->recv_skb, 0);
+
 		skb_put_u8(dev->recv_skb, *data++);
 		if (!pn532_uart_rx_is_frame(dev->recv_skb))
 			continue;
-- 
2.53.0




