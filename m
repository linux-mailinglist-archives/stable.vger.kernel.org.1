Return-Path: <stable+bounces-238441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIoMD2nj4WkKzgAAu9opvQ
	(envelope-from <stable+bounces-238441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:38:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D54A941806E
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4B8830E1B1D
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6CA378D98;
	Fri, 17 Apr 2026 07:35:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB2378821;
	Fri, 17 Apr 2026 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411308; cv=none; b=qL782bOVIoLzNqCLI3tatvt4AlR+NRBPDJl6w51EgWV/mJGfHV5qycNTXHLwU/u+OTE4wz4kNpOQOMRZH+yW5y0zAN6Y/zr4L0CWHNzcxnMCQpw7wxz0LQ5nvs9D6o4NIq2+Hp9aJekoZmcDhJlVptZ4KVEUrNuf+qe+aRk9doE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411308; c=relaxed/simple;
	bh=AlB7MW1WfIdd2n7uXYfqYA/36FU+N0myptPoH1cvHJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLg81t+dLLoZ/pI2stMoYssbZdSiOScrLBLB9FDIlo9QO+vtEMvT1GhynuwPBwvy2fimFo5cX9gXWAV+KQECsd0sBY2XdpGGkyy9Yfw8FWDBT4Xv7N6h//oGR+uJyUgLc4fBfOsTjzYF4XhWirKaqao8HZ0rxdHmLmQxOSmEewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowADXaw+Y4uFpouLXDQ--.31687S2;
	Fri, 17 Apr 2026 15:34:49 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: require a credit byte before consuming it
Date: Fri, 17 Apr 2026 15:34:46 +0800
Message-ID: <20260417073446.95494-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXaw+Y4uFpouLXDQ--.31687S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF17Xr4fAr4ruryrJr4rGrg_yoWkJrgEg3
	48AFW8Aw43XrZ7JF4Dur45Zry3J34fJFn5G3yIgFWIgrW8Krs7XFs5Cr9YvF1xWrWUuFyx
	AFs8JF4xZ3WxXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU5iihUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238441-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.265];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D54A941806E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rfcomm_recv_data() treats the first payload byte as a credit field when
the UIH frame carries PF and credit-based flow control is enabled.

After the header has been stripped, the code does not re-check that the
frame still has at least one payload byte before dereferencing skb->data.
A malformed short frame can therefore trigger an out-of-bounds read.

Drop the frame if the optional credit byte is not present.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 net/bluetooth/rfcomm/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 611a9a94151e..964a78d473cc 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1715,6 +1715,9 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 	}
 
 	if (pf && d->cfc) {
+		if (!skb->len)
+			goto drop;
+
 		u8 credits = *(u8 *) skb->data; skb_pull(skb, 1);
 
 		d->tx_credits += credits;
-- 
2.50.1 (Apple Git-155)


