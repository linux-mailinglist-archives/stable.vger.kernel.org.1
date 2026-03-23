Return-Path: <stable+bounces-229421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPkLCotywWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:04:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FE92F95F4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24F54355F25F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CD83BC673;
	Mon, 23 Mar 2026 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jprKIvF0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F03BC665;
	Mon, 23 Mar 2026 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279193; cv=none; b=ixChgt5sHddHajxDBOfn1YIbKfCDCP74jDoahcbDBDy631t+OmjFhlLg4IHnl5ay8ZSAUA20KfDCfpa1FnGBcMGMTV/nX/+WeAKjstB+aWcpP4BmANN34wWxbYK4eX9XbG5dLUg9IUxgXBColAF+QEUg+EICIahOMDCF745xf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279193; c=relaxed/simple;
	bh=Vepq20FGl41ExSlxdlfRNrq4yWhOzEv6FgrUBcWMdyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLnomrj9XHv3lvNZxu+5DtyKIxMUoNNrZ6xb9zHrzQJZ+74GQrBhboKxqV9pk1j/zB3exqf9mqvO58ir3oaC9YRF/NfmGxI0VoSsAkn4RczjaxsN25qa/xbL1wP5aQ/ou5wWvZEToK+8eHwYdzmqv8Nmc7hJQm8gFD1lLrNATCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jprKIvF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1ABC4CEF7;
	Mon, 23 Mar 2026 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279193;
	bh=Vepq20FGl41ExSlxdlfRNrq4yWhOzEv6FgrUBcWMdyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jprKIvF06RbDIWnjxwpbth/30ESIE9buhw989KYFZB3ljr1I5sNxMywarDtZ93Sfj
	 iIPS0G2B9qjZE6bKA9j+xBmViQU8B7ST51zmHQbzkxn+Emlr7KUQ4H81U8IXf13R+O
	 W7EdRx+A+iFK/5jdR7dhDmm7GznKqEaXTlzOANoA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Eggers <ceggers@arri.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 504/567] Bluetooth: LE L2CAP: Disconnect if sum of payload sizes exceed SDU
Date: Mon, 23 Mar 2026 14:47:04 +0100
Message-ID: <20260323134546.489518769@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229421-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 80FE92F95F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Eggers <ceggers@arri.de>

[ Upstream commit b6a2bf43aa37670432843bc73ae2a6288ba4d6f8 ]

Core 6.0, Vol 3, Part A, 3.4.3:
"... If the sum of the payload sizes for the K-frames exceeds the
specified SDU length, the receiver shall disconnect the channel."

This fixes L2CAP/LE/CFC/BV-27-C (running together with 'l2test -r -P
0x0027 -V le_public').

Fixes: aac23bf63659 ("Bluetooth: Implement LE L2CAP reassembly")
Signed-off-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 94dee7c227f74..4ab738e651837 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6677,6 +6677,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	if (chan->sdu->len + skb->len > chan->sdu_len) {
 		BT_ERR("Too much LE L2CAP data received");
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		err = -EINVAL;
 		goto failed;
 	}
-- 
2.51.0




