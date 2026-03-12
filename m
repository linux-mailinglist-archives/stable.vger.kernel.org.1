Return-Path: <stable+bounces-225195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG1ZCz4ks2nlSgAAu9opvQ
	(envelope-from <stable+bounces-225195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:38:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1BC2795EF
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B112332A5F35
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA251387346;
	Thu, 12 Mar 2026 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zg+7bx5x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B62D0606;
	Thu, 12 Mar 2026 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347313; cv=none; b=EXl3VKk2zgVvaCIT4Y+IMxGfZV0Nv9G+J8ng8bUorbmFRAKFZsk+AdZL62pcB37ih4BajAVF/AE0G0XdOwNM1r36Fyr8em5wG5M9XyW7/vXzKrezTHM/RqgCuNJaM24KyqeYm8UFhLsM+C826tyK1e+Ix+kCW3pQ7bZNOBSGRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347313; c=relaxed/simple;
	bh=+OAiL3s4xjYnXQkJZr66f4rA3QDNTuDw3CzQow5+940=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c474lQbDYDRdCo+8ZOuAFHOiUpxWXntwX5ctV3DeXVZSoHnN5PDnM5OoyaKzQkvAlpQWU5qaF8LGpGyUWEz3adCbq2O79OCy8nnxZ4SyBalO1LXsMS9JiaqHc2ed9+HVE7cZZUN8eYhIEGXaOhrmCNDRT+4yMkZzlQK87vTz2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zg+7bx5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877E9C4CEF7;
	Thu, 12 Mar 2026 20:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347313;
	bh=+OAiL3s4xjYnXQkJZr66f4rA3QDNTuDw3CzQow5+940=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zg+7bx5xEh1rbq9F/9iE8iqjQHOk+giJvKcSYiTv/ZTXmfivzQgU/wEIJhSAJUcU6
	 JzmQp5cygKiigrKsYg33U0t7HIQSXYPCIGgTxucIimmsxQwHR9Zr3r4SQxrR9cQ/op
	 CquYfyvX6S1ZnNjbzumuLF/bail3QVCdzYBuN98Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Ray <ian.ray@gehealthcare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 228/265] net: nfc: nci: Fix zero-length proprietary notifications
Date: Thu, 12 Mar 2026 21:10:15 +0100
Message-ID: <20260312201026.563788019@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-225195-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,gehealthcare.com:email]
X-Rspamd-Queue-Id: 9C1BC2795EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Ray <ian.ray@gehealthcare.com>

[ Upstream commit f7d92f11bd33a6eb49c7c812255ef4ab13681f0f ]

NCI NFC controllers may have proprietary OIDs with zero-length payload.
One example is: drivers/nfc/nxp-nci/core.c, NXP_NCI_RF_TXLDO_ERROR_NTF.

Allow a zero length payload in proprietary notifications *only*.

Before:

-- >8 --
kernel: nci: nci_recv_frame: len 3
-- >8 --

After:

-- >8 --
kernel: nci: nci_recv_frame: len 3
kernel: nci: nci_ntf_packet: NCI RX: MT=ntf, PBF=0, GID=0x1, OID=0x23, plen=0
kernel: nci: nci_ntf_packet: unknown ntf opcode 0x123
kernel: nfc nfc0: NFC: RF transmitter couldn't start. Bad power and/or configuration?
-- >8 --

After fixing the hardware:

-- >8 --
kernel: nci: nci_recv_frame: len 27
kernel: nci: nci_ntf_packet: NCI RX: MT=ntf, PBF=0, GID=0x1, OID=0x5, plen=24
kernel: nci: nci_rf_intf_activated_ntf_packet: rf_discovery_id 1
-- >8 --

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Link: https://patch.msgid.link/20260302163238.140576-1-ian.ray@gehealthcare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 1bdaf680b488c..3c42b149c729c 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1471,10 +1471,20 @@ static bool nci_valid_size(struct sk_buff *skb)
 	unsigned int hdr_size = NCI_CTRL_HDR_SIZE;
 
 	if (skb->len < hdr_size ||
-	    !nci_plen(skb->data) ||
 	    skb->len < hdr_size + nci_plen(skb->data)) {
 		return false;
 	}
+
+	if (!nci_plen(skb->data)) {
+		/* Allow zero length in proprietary notifications (0x20 - 0x3F). */
+		if (nci_opcode_oid(nci_opcode(skb->data)) >= 0x20 &&
+		    nci_mt(skb->data) == NCI_MT_NTF_PKT)
+			return true;
+
+		/* Disallow zero length otherwise. */
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.51.0




