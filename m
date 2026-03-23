Return-Path: <stable+bounces-229758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJZRL0NtwWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:41:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3502F89DC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40F45319C75A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860573BE147;
	Mon, 23 Mar 2026 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rf1zKveY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C9F2517AF;
	Mon, 23 Mar 2026 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282789; cv=none; b=EzZ0MFK2TIcZ7JXa7unTwEIuNwya5ZrQxJN9BNnNyJDIcDbvhqQgU6v3f5qAh7nYJQMHIM2gKxeSIyktMv7xdrMQoBN0kfmQOw2/02fQ6nMDkpESWJS6q+jcTF7ZX1PpgdZJWuRn2UuWWPCjTnRKLvr6ON9A1h0bm3Rfw7Qb4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282789; c=relaxed/simple;
	bh=DKvcZHqlORfsDccxH5bMBldIX2ejRPrUOw63z/mqLMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGbWV2AO2h913hf0BzRMl2yEShf+VgAxsWZpO5ROyAErlU2k9hUrDiWVHLC4mjdWwOBl5Lzy5CPWNb+p5Cd1zeR/xv7fKeYrTphHabTfMlu4FqaPnss+mQtymq9O4h8L2Ow9niEqgy/K74tTeE3Qg1qnjEXD6uiNPBXL857+YyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rf1zKveY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD587C4CEF7;
	Mon, 23 Mar 2026 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282789;
	bh=DKvcZHqlORfsDccxH5bMBldIX2ejRPrUOw63z/mqLMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rf1zKveYrb5Hlhhz/46qcr5rcVQiHdONALRQQXL13lP50SACeGv+buoJ0tD5RatiV
	 vOk4PTRglX6ytwovcVWLLZowE+bmfmuWlSeXCK4KFN1HGpygWJieH1lodb1vh9Fbni
	 bp4wQoMSuTyt7tx8c77+f7F4ZL+gEj54zEBgGVwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1 287/481] Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
Date: Mon, 23 Mar 2026 14:44:29 +0100
Message-ID: <20260323134532.105977734@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229758-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: AB3502F89DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Johannes Möller <research@johannes-moeller.dev>

commit 15145675690cab2de1056e7ed68e59cbd0452529 upstream.

l2cap_ecred_reconf_rsp() casts the incoming data to struct
l2cap_ecred_conn_rsp (the ECRED *connection* response, 8 bytes with
result at offset 6) instead of struct l2cap_ecred_reconf_rsp (2 bytes
with result at offset 0).

This causes two problems:

 - The sizeof(*rsp) length check requires 8 bytes instead of the
   correct 2, so valid L2CAP_ECRED_RECONF_RSP packets are rejected
   with -EPROTO.

 - rsp->result reads from offset 6 instead of offset 0, returning
   wrong data when the packet is large enough to pass the check.

Fix by using the correct type.  Also pass the already byte-swapped
result variable to BT_DBG instead of the raw __le16 field.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Johannes Möller <research@johannes-moeller.dev>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6429,7 +6429,7 @@ static inline int l2cap_ecred_reconf_rsp
 					 u8 *data)
 {
 	struct l2cap_chan *chan, *tmp;
-	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
+	struct l2cap_ecred_reconf_rsp *rsp = (void *)data;
 	u16 result;
 
 	if (cmd_len < sizeof(*rsp))
@@ -6437,7 +6437,7 @@ static inline int l2cap_ecred_reconf_rsp
 
 	result = __le16_to_cpu(rsp->result);
 
-	BT_DBG("result 0x%4.4x", rsp->result);
+	BT_DBG("result 0x%4.4x", result);
 
 	if (!result)
 		return 0;



