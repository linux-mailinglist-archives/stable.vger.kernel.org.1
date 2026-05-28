Return-Path: <stable+bounces-255612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I8cL8ukGGrClggAu9opvQ
	(envelope-from <stable+bounces-255612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:25:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B605F8A90
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17CDD3252480
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E312DF6E6;
	Thu, 28 May 2026 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qf8Yg78J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7165257854;
	Thu, 28 May 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999400; cv=none; b=ubqpySHjTv4tiNPHh9Y/XW/9H36L1jS1P6FOZSs8Pe3KLTN3a1gQyoXx5jUso5WoblEis0jb9uyo/DIgtK4187klqUp2ZYcHViksVhLYYEwX6FT5P6K/fkOJ3ZG5H5wgz3y8ydReZ2XPQadwS+aGBJRmXvmicibr0r7fpd/njSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999400; c=relaxed/simple;
	bh=O7Zvf5pMThuZU8TrkpNQv8WtlFzq/e47PBl8g6do0Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HG8+mez1b/akQhbYnsNiLVuwvk2zaKLcGMVJlSuw4Ra1se5GvF5Q9OFuAb7s6pqdbANk6926je51LPLHEc2y1/3RLgHY3tzRgVeUzDeayMMSB9A1oKtSivayrESJw5tUKnrJ+3hQbwIFx6jvMVJhQctfqVlEbHLYeSct+bDMe2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qf8Yg78J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DF01F000E9;
	Thu, 28 May 2026 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999399;
	bh=ZwgNxXT0zS26gpbPpaGmhquEmm2f7A4ljY8eKLwhjUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qf8Yg78JgMjGK9OrzWnTe/W40O5fKOZqLKd4lrQaZ0z4n0a2x3sNhor8pTVwI3BCP
	 BdmpWpQ9yDPEWx0OduUIPnq3DA07l2EIddYydZhjBHAlZ/uTuCNzNq6vBx7h+WyLuU
	 JsfK/L7ec+LHnCHFZaDcqbDa0L9tuNwlNtkn7s0s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.18 053/377] Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
Date: Thu, 28 May 2026 21:44:51 +0200
Message-ID: <20260528194639.906554789@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-255612-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 41B605F8A90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

commit 84c24fb151fc1179355296d7ff29129ac7c42129 upstream.

ISO data PDUs carry a packet-boundary flag indicating START, CONT, END
or SINGLE. The ISO_CONT branch of iso_recv() guards against a missing
ISO_START by checking conn->rx_len before touching conn->rx_skb, but
ISO_END does not.

If a peer sends an ISO_END as the first packet on a fresh ISO
connection, conn->rx_skb is still NULL and conn->rx_len is zero, so
skb_put(conn->rx_skb, ...) dereferences NULL and oopses. For BIS,
where receivers sync to a broadcaster without pairing, any broadcaster
on the air can trigger this.

Mirror the ISO_CONT check at the top of ISO_END so a stray end fragment
is logged and dropped instead of crashing the host.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/iso.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2461,6 +2461,11 @@ int iso_recv(struct hci_dev *hdev, u16 h
 		break;
 
 	case ISO_END:
+		if (!conn->rx_len) {
+			BT_ERR("Unexpected end frame (len %d)", skb->len);
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;



