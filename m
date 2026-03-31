Return-Path: <stable+bounces-231801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDlZNjL7y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:49:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968036D35D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55A2430A1E3B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B19426EA6;
	Tue, 31 Mar 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="04WYhfOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BED423A7C;
	Tue, 31 Mar 2026 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975104; cv=none; b=asl3/0/gbWPCOo49U3oPWO6X0DF+66hclpsD7IE7SYTZ456JFmApFqBiy6zNQCwb5kin2ChQgPU/vn5NkZmVmYB8nALLivA9ggIfXhhfClubcgsx7GBx9th7d5EYbO3W4odaz1+Vq0qIT/99Ry2sOtYykCq/U+QzbTLet0Oka4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975104; c=relaxed/simple;
	bh=YeHZ289FLAbtf4fBeVWC2cLTIhYagnF7ynvOg/RFtC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOLDt6k+DBFElpRFBaq+1WL2+EV0RDgyqDvdv/lLon8uCTnTXe3QW3FFZA+upKgOYtid/OHZ2xt4bMUKaRSsoPc28tYwUvOSq/LQVKsnK4QVyivtynBvugmYJ8BhC7aXSGDonX2kwP9j/27jPHGtXMxJMJLGe6sajJljOe9AcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=04WYhfOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008C1C19423;
	Tue, 31 Mar 2026 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975104;
	bh=YeHZ289FLAbtf4fBeVWC2cLTIhYagnF7ynvOg/RFtC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=04WYhfOxU4G/M3g8olIoCpkHERksLL59YgTTcWbW+o8ltom+h3733rk2WA/eCAA5r
	 TQb3u9TClWeA3MWTwpW9g+x6Sfnch/LlqWhLjXvmCQNPJDu7nSa8xuOQUWIltQblDX
	 vgigEv1BSe42JMXoxlECqwe4DlYe0SyZDDl2ojY4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Chen <zhangchen01@kylinos.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 133/342] Bluetooth: L2CAP: Fix send LE flow credits in ACL link
Date: Tue, 31 Mar 2026 18:19:26 +0200
Message-ID: <20260331161803.901025626@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231801-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 8968036D35D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Chen <zhangchen01@kylinos.cn>

[ Upstream commit f39f905e55f529b036321220af1ba4f4085564a5 ]

When the L2CAP channel mode is L2CAP_MODE_ERTM/L2CAP_MODE_STREAMING,
l2cap_publish_rx_avail will be called and le flow credits will be sent in
l2cap_chan_rx_avail, even though the link type is ACL.

The logs in question as follows:
> ACL Data RX: Handle 129 flags 0x02 dlen 12
      L2CAP: Unknown (0x16) ident 4 len 4
        40 00 ed 05
< ACL Data TX: Handle 129 flags 0x00 dlen 10
      L2CAP: Command Reject (0x01) ident 4 len 2
        Reason: Command not understood (0x0000)

Bluetooth: Unknown BR/EDR signaling command 0x16
Bluetooth: Wrong link type (-22)

Fixes: ce60b9231b66 ("Bluetooth: compute LE flow credits based on recvbuf space")
Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 848a9b945de89..b5e393e4f3eb1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6589,6 +6589,10 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	struct l2cap_le_credits pkt;
 	u16 return_credits = l2cap_le_rx_credits(chan);
 
+	if (chan->mode != L2CAP_MODE_LE_FLOWCTL &&
+	    chan->mode != L2CAP_MODE_EXT_FLOWCTL)
+		return;
+
 	if (chan->rx_credits >= return_credits)
 		return;
 
-- 
2.51.0




