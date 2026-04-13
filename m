Return-Path: <stable+bounces-236831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJQXA1gd3WlWaAkAu9opvQ
	(envelope-from <stable+bounces-236831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 454493EFA49
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D3C53023D50
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA95238166;
	Mon, 13 Apr 2026 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xspKuK6B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74928B4FD;
	Mon, 13 Apr 2026 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097904; cv=none; b=TuL9P7ly6s9qff2/APxWyZb26Oz1ERI+1BlD6w1cvY3S5x3/8BCV+/VodB5HpnEeN0CFvSknBoPV5AqVlbHJifEtJwry7AOM0tzr1b4o8Xh+tRkRynA0tvYZBlCuOFg9dY311cfNB1UIQ5FJTtlHObbBTdD6+zPCThd3bW2Z7eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097904; c=relaxed/simple;
	bh=gRtouCgv0KftyvxvCu4TA8mMbXflmtyh4oKsgm8EhiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWOxBIfzUSPOncNRH5u57iI6jLyGMJ8q7nKLjY//pajl5TOPo8t/7rF5nuxuJeuHP52gxt8HfWmYlvWuavBkoIJpCftNsq7aa2WQ7UqfMpAQIdyxnnNQMa/Kl4USypXbmLT/wJn5c1cpapwGpOpuzOgB3r/3eod/sJtPe4ZZZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xspKuK6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ADEC2BCAF;
	Mon, 13 Apr 2026 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097904;
	bh=gRtouCgv0KftyvxvCu4TA8mMbXflmtyh4oKsgm8EhiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xspKuK6BADIWH1pGqY/x/cPG6ck6fOt9hquStiBTKhVWPm9dOJabCcMeoyMxMs5gv
	 rgH2oZTVI+M3p7ni/f6f0z0ZkSeY801U2C42JOxza+6E0x9HM0wMir6TZ74chybjrE
	 szZFdX7fqdgGpb1QDEXOPWweYzAx16Jt4oJZwTMY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 317/570] Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
Date: Mon, 13 Apr 2026 17:57:28 +0200
Message-ID: <20260413155842.370745547@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236831-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 454493EFA49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit c65bd945d1c08c3db756821b6bf9f1c4a77b29c6 ]

l2cap_ecred_data_rcv() reads the SDU length field from skb->data using
get_unaligned_le16() without first verifying that skb contains at least
L2CAP_SDULEN_SIZE (2) bytes. When skb->len is less than 2, this reads
past the valid data in the skb.

The ERTM reassembly path correctly calls pskb_may_pull() before reading
the SDU length (l2cap_reassemble_sdu, L2CAP_SAR_START case). Apply the
same validation to the Enhanced Credit Based Flow Control data path.

Fixes: aac23bf63659 ("Bluetooth: Implement LE L2CAP reassembly")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5010c200b2c41..e69c6041437b0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7650,6 +7650,11 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 	if (!chan->sdu) {
 		u16 sdu_len;
 
+		if (!pskb_may_pull(skb, L2CAP_SDULEN_SIZE)) {
+			err = -EINVAL;
+			goto failed;
+		}
+
 		sdu_len = get_unaligned_le16(skb->data);
 		skb_pull(skb, L2CAP_SDULEN_SIZE);
 
-- 
2.51.0




