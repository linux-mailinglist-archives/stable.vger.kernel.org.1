Return-Path: <stable+bounces-256005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDh1EkypGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:45:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A85705F9723
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52F2C3116230
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E633CE8A;
	Thu, 28 May 2026 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V/gD3Hx2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395D223328;
	Thu, 28 May 2026 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000488; cv=none; b=CcnTEcmwgysqlkuo8bvFFVkhyTdhImEv7ieA0AKIGHmYPGdwLTmKNBiC5GoZ9O8UKf583bZmPbNUsfxES42cx5EK+x5ZutR/jqL5tEpCrFBTHX4J7+m/8uvsRzMOILd0/QQk0BLPDf98LrXnEY2oJGt4mGYPYJfKU+RBl471HxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000488; c=relaxed/simple;
	bh=iPyEJFYZaXDmX8bYoDaE6itN1xSN1SX//t0jLi/Qz6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGdYjaCkWmNg48foq0lxNoD6pEMQvhoNWVlnd47fNTYB+tcAoIOuUzTNgBZvy02DvJx/vhlAKeR+ysfyI/y+N9bC08ao1vtfXX2mHaWToAK21Mn3Cc819movc2T2nXFn/VRTaKtHI1O2UkbQN3gnCh/hQh92SKTFvL4t9diA6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V/gD3Hx2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFD11F000E9;
	Thu, 28 May 2026 20:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000487;
	bh=9aSkkHmH2/JTBuKi+P96e/9KFTe+6ZDhIjoVoARJwLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V/gD3Hx2+qSksesJhMEB1YwEnHLZfow1ykZcfn1JE/8Mjon19sRqH4vVVIAn26k1Q
	 2UI3NjvLJZ+RqJvl27kDvu/puMwM1hgIbxR4+gthstvw2EHov6oPMi+qPCMY8Toi8m
	 RvrdC0gJTziULOSH07FrbCjqt9F/kK8aMmbKtlEk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.12 063/272] Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
Date: Thu, 28 May 2026 21:47:17 +0200
Message-ID: <20260528194631.142166750@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-256005-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A85705F9723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2319,6 +2319,11 @@ void iso_recv(struct hci_conn *hcon, str
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



