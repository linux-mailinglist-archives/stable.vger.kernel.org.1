Return-Path: <stable+bounces-234147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBeEJrKb1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:17:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA05E3C057E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63A58303A8F8
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF323A6B6B;
	Wed,  8 Apr 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oTFdkfrf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F1045BE3;
	Wed,  8 Apr 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672105; cv=none; b=R0nhCvLB5m/6FORZBcT547VIgJW1Ung7QKyEX7WMwKgbOO2AaDojsg98lIH3pGTpuOJ0PX1eqJqUBSlKeDhEMzjI3GfaquF8KIS2ox6MNtNm/ajN6czyQ56YT1iilvPAZAsaaLIkdg75taIg4av9RD/bNONUfOkM3Jdl4J2seFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672105; c=relaxed/simple;
	bh=yZ6pygGsWDq7pB/danmuMt+VB+YIAN5Q2+XHNM9LCm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka09NtIJNVeOdd9zLVF1CnYHCtArwJF4Rhi8FZlCDHt+GYvDleLhcjsSgSmkuMgv7ikYxFvX/phDO8legQ3fLAaay94Ei8fhQD9ONiQLsmkQgPJDZbRgnRASYkiXtumNNn4ph5nudN3lrPTwcrcZcizUQXwSBSc8suSFMO3IVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oTFdkfrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63289C19421;
	Wed,  8 Apr 2026 18:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672105;
	bh=yZ6pygGsWDq7pB/danmuMt+VB+YIAN5Q2+XHNM9LCm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTFdkfrfogFUIG04vTlggCTsVbSMWLpee4TisuWHMH/1ujkBI1nMJ7xJ9KTYXl11o
	 vYsH2os2nOGdOjaYtMe5QBKY9iql5UkjrkhkXFD8gPnVlD0S9oNnS94DQZJ/eBqjSi
	 GzdwyxZfr6DG6F0flwi2RnFgqnpQCRPDokif5x1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 159/312] NFC: pn533: bound the UART receive buffer
Date: Wed,  8 Apr 2026 20:01:16 +0200
Message-ID: <20260408175939.704218160@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234147-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: EA05E3C057E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 07596bf5f7d6d..026d5ef825b59 100644
--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -211,6 +211,9 @@ static int pn532_receive_buf(struct serdev_device *serdev,
 
 	del_timer(&dev->cmd_timeout);
 	for (i = 0; i < count; i++) {
+		if (unlikely(!skb_tailroom(dev->recv_skb)))
+			skb_trim(dev->recv_skb, 0);
+
 		skb_put_u8(dev->recv_skb, *data++);
 		if (!pn532_uart_rx_is_frame(dev->recv_skb))
 			continue;
-- 
2.53.0




