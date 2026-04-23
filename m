Return-Path: <stable+bounces-240541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NYZ/L3+g6mlF1gIAu9opvQ
	(envelope-from <stable+bounces-240541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 00:43:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5754582CA
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 00:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A98C301E6F5
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11170376BDE;
	Thu, 23 Apr 2026 22:43:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF28263F4A;
	Thu, 23 Apr 2026 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984184; cv=none; b=fPqwtT95gMNzeqo3l0zf3SU2gkUVwTZDSR/Ni3Etqu603y+iJd4q55vK3aEDpP+7M0JgQOqzMKdHWcwDlWkrUMUreIuGBmWMhxfh4SyUPWiiE+cF3BIfMZMuF6yF6LqGVBPdJplAfp0TsdQwqCZMSIRMfDyEs4ETKy75JxiFoEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984184; c=relaxed/simple;
	bh=uQkxhPq+o/MWVp11jq+/hM9wcFEiw7SvZ8/4dH77Mdw=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References; b=U2/PiVbzroXkGoitaGsk4l/pAzfbP5p/P6SrDf7IUnZb0v3WifMcEAdB/Hvuxbf7INsqiTscDHE/zt2DyhW4a19cw+WDb3ghfOdvkRZWjccdrKfAoS4yo3Y7T+HSVxipUn0ikvbuVJfEK+CAQ/Y+FtMFMNK+JUPokr8EWblaA4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 02-rfcomm-v2.eml (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowACHFwtpoOppMW5sDg--.33109S2;
	Fri, 24 Apr 2026 06:42:50 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Thu, 23 Apr 2026 23:31:00 +0800
Message-ID: <20260424070102.1-rfcomm-v2-pengpeng@iscas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Ingo Molnar <mingo@kernel.org>, Bastien Nocera <hadess@hadess.net>, Thomas Gleixner <tglx@linutronix.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH v2] Bluetooth: RFCOMM: pull credit byte with skb_pull_data()
In-Reply-To: <20260417073446.95494-1-pengpeng@iscas.ac.cn>
References: <20260417073446.95494-1-pengpeng@iscas.ac.cn>
X-CM-TRANSID:zQCowACHFwtpoOppMW5sDg--.33109S2
X-Coremail-Antispam: 1UD129KBjvJXoWruF17Xr4fAF1rtF47Zw47Arb_yoW8JrW3pr
	Z8CF4SkFsrZr1Yyr17tFW8GFy5trn8Cr1akrs5Cr1fCw15Gw4rAr4rKr18Wa4DArWvyFW3
	AF40qr1fur9FvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_JFv_Gryl8cAvFVAK0II2c7
	xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjc
	xK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240541-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	DMARC_NA(0.00)[iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D5754582CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rfcomm_recv_data() treats the first payload byte as a credit field when
the UIH frame carries PF and credit-based flow control is enabled.

After the header has been stripped, the PF/CFC path consumes that byte
with a direct skb->data dereference followed by skb_pull(). A malformed
short frame can reach this path without a byte available.

Use skb_pull_data() so the length check and pull happen together before
the returned credit byte is consumed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1:
- use skb_pull_data() as suggested by Luiz Augusto von Dentz

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 611a9a94151e..d11bd5337d57 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1715,9 +1715,12 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 	}
 
 	if (pf && d->cfc) {
-		u8 credits = *(u8 *) skb->data; skb_pull(skb, 1);
+		u8 *credits = skb_pull_data(skb, 1);
 
-		d->tx_credits += credits;
+		if (!credits)
+			goto drop;
+
+		d->tx_credits += *credits;
 		if (d->tx_credits)
 			clear_bit(RFCOMM_TX_THROTTLED, &d->flags);
 	}
-- 
2.50.1 (Apple Git-155)


