Return-Path: <stable+bounces-236371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMlvM5EZ3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:28:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 900133EEFE6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2706A309D21D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80AB279DC2;
	Mon, 13 Apr 2026 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IW1V69B3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AC2727E2;
	Mon, 13 Apr 2026 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096733; cv=none; b=pTTOKlYVhh6k7TMhPr3DB/V14UaEeAw/j1/XAyUKmionJgfTzKbWobf6CoRAUi/6zCJZvgH2uSe2NzXT5Dds0/jEoPT+cRhxgZ+cxRidSprkJEzyi75I+ZNojg8z+CWiTQmi9dxUQrkusENxj3FUI1r4CCvJG/CAkS/R5w1UCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096733; c=relaxed/simple;
	bh=m4HPKKHlkyv5qBCJQq9iLl6edooG6YUJOlu7DZ2mEPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzI51k42BQWpRTEbvHGFf2kqxJQU4/YS6lPso5gumAtlQrmAihndkegim9vSGACrbAR3uU6UtsFcN4fB7n6Bt3yYRVAl6i5DEz2FaOLADZVGuurOGVfjZ6iOnkzP42WliTmhow+P7u7FDIm40t4EO5CN8WxO6clI1wPaBaaJBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IW1V69B3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CC2C2BCAF;
	Mon, 13 Apr 2026 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096733;
	bh=m4HPKKHlkyv5qBCJQq9iLl6edooG6YUJOlu7DZ2mEPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IW1V69B33vJO4JtBB0aCs3gD78NFj0E0iczEmRqI1GpqYlCMp7Poegibt48rN9qgs
	 AaJTxk4u99ECbm7eP9gO9+9PP+vznl1s2LSEkr3pwwRsg+EuUnAo8DxEKzKzjgeEBW
	 frOamzazCgxXPjhKQ82lZdx5CaaGPLdrA93DO9CQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 41/70] nfc: pn533: allocate rx skb before consuming bytes
Date: Mon, 13 Apr 2026 18:00:36 +0200
Message-ID: <20260413155729.713055558@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236371-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 900133EEFE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

commit c71ba669b570c7b3f86ec875be222ea11dacb352 upstream.

pn532_receive_buf() reports the number of accepted bytes to the serdev
core. The current code consumes bytes into recv_skb and may already hand
a complete frame to pn533_recv_frame() before allocating a fresh receive
buffer.

If that alloc_skb() fails, the callback returns 0 even though it has
already consumed bytes, and it leaves recv_skb as NULL for the next
receive callback. That breaks the receive_buf() accounting contract and
can also lead to a NULL dereference on the next skb_put_u8().

Allocate the receive skb lazily before consuming the next byte instead.
If allocation fails, return the number of bytes already accepted.

Fixes: c656aa4c27b1 ("nfc: pn533: add UART phy driver")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Link: https://patch.msgid.link/20260405094003.3-pn533-v2-pengpeng@iscas.ac.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/pn533/uart.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -211,6 +211,13 @@ static size_t pn532_receive_buf(struct s
 
 	del_timer(&dev->cmd_timeout);
 	for (i = 0; i < count; i++) {
+		if (!dev->recv_skb) {
+			dev->recv_skb = alloc_skb(PN532_UART_SKB_BUFF_LEN,
+						  GFP_KERNEL);
+			if (!dev->recv_skb)
+				return i;
+		}
+
 		if (unlikely(!skb_tailroom(dev->recv_skb)))
 			skb_trim(dev->recv_skb, 0);
 
@@ -219,9 +226,7 @@ static size_t pn532_receive_buf(struct s
 			continue;
 
 		pn533_recv_frame(dev->priv, dev->recv_skb, 0);
-		dev->recv_skb = alloc_skb(PN532_UART_SKB_BUFF_LEN, GFP_KERNEL);
-		if (!dev->recv_skb)
-			return 0;
+		dev->recv_skb = NULL;
 	}
 
 	return i;



