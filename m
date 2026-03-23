Return-Path: <stable+bounces-228823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCdWDZpUwWlVSQQAu9opvQ
	(envelope-from <stable+bounces-228823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:56:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC462F578D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C8E930F4BF4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B823EA85;
	Mon, 23 Mar 2026 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fI2PYLAF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191B23AB9D;
	Mon, 23 Mar 2026 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277231; cv=none; b=CBz+ocT/462UsOqrOA3l36bynZrpNlyUZ9Sch9y2ECODCD5b1Virf/+ETQlPrq13k9BWrt4+yeVlGfyhQzTRorjheWc1KLscnfMrl7X+9Q0rgX0aLZWZD+piePy20cmnleGCtc8gMLPPUIzUiN3ef5/1FqBiDRXAqUcd8p6IxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277231; c=relaxed/simple;
	bh=OuXI7MPu68EeiEBodZ2cIDeu/vl4vStLDQ39ueVLEJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAsD70AL55tdzT7TxGl+oAXDbo/7wyCCc66QwX2RMFHMb6Bvyl+NGaMyet0cELfNfeLsUPAEAqwmASY4kdRB/kCYkLMuT1zBYvlyRLhKr8/aooZU8PGEXCVtvyTwh2nHScZih9enspkHXVkpaofB1yhhX9lgbRWCSiTTxKiNlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fI2PYLAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68011C4CEF7;
	Mon, 23 Mar 2026 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277231;
	bh=OuXI7MPu68EeiEBodZ2cIDeu/vl4vStLDQ39ueVLEJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fI2PYLAF7bXUKG02uu8cjNKu4Tt/GpNYS9kBXyzfF59Y+ZXEVEV6Ad9cOlqnACyOj
	 T7aIZEzHLBpA9mgQ0f6umX0IsGc3HIDynFTefEz+Gn7jJntybQfOQEqe5g9wUBqhW+
	 vZJftasL5+h1RS5DBqjb/P77aspo4QUKv22oSerk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiming Qian <yimingqian591@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.12 363/460] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
Date: Mon, 23 Mar 2026 14:45:59 +0100
Message-ID: <20260323134535.475984454@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228823-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.968];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_WP_URI(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BBC462F578D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 5b3e2052334f2ff6d5200e952f4aa66994d09899 upstream.

Currently the code attempts to accept requests regardless of the
command identifier which may cause multiple requests to be marked
as pending (FLAG_DEFER_SETUP) which can cause more than
L2CAP_ECRED_MAX_CID(5) to be allocated in l2cap_ecred_rsp_defer
causing an overflow.

The spec is quite clear that the same identifier shall not be used on
subsequent requests:

'Within each signaling channel a different Identifier shall be used
for each successive request or indication.'
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/host/logical-link-control-and-adaptation-protocol-specification.html#UUID-32a25a06-4aa4-c6c7-77c5-dcfe3682355d

So this attempts to check if there are any channels pending with the
same identifier and rejects if any are found.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/l2cap_core.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5010,7 +5010,7 @@ static inline int l2cap_ecred_conn_req(s
 	u16 mtu, mps;
 	__le16 psm;
 	u8 result, rsp_len = 0;
-	int i, num_scid;
+	int i, num_scid = 0;
 	bool defer = false;
 
 	if (!enable_ecred)
@@ -5022,6 +5022,14 @@ static inline int l2cap_ecred_conn_req(s
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
 	}
+
+	/* Check if there are no pending channels with the same ident */
+	__l2cap_chan_list_id(conn, cmd->ident, l2cap_ecred_list_defer,
+			     &num_scid);
+	if (num_scid) {
+		result = L2CAP_CR_LE_INVALID_PARAMS;
+		goto response;
+	}
 
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);



