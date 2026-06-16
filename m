Return-Path: <stable+bounces-265821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9nslA5WQMWp0mwUAu9opvQ
	(envelope-from <stable+bounces-265821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:06:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A222B693CD9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:06:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tDXlc9sc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265821-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-265821-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 121D2302983A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E86F3D171F;
	Tue, 16 Jun 2026 18:06:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B133A5E91;
	Tue, 16 Jun 2026 18:06:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633168; cv=none; b=AajWxpgTTNjEizhePU6Vkzu2l5RSAUdeG6RheYAZaLJDQdikIKkUlqJ6DDfpxWCbusSaI67ZqzDvnFFNfyv7Zxv+C0onEprjaKL4X+cq25S6t5WYvQI4QDw006Kb1lt8k93qEm1NfbKXRAdGd78E/Me5nFsClgrGOOUFA/cB2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633168; c=relaxed/simple;
	bh=f1ohPvA8FqMmGHTt4EjsU8yhTnHFaIbP0tN2gNCU1kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyxu6pXBWRHhCcKBd11CYmavvh/DRug2lHzMx5jSP8TBhXUAe9eqmLMk6NwaRmcPfn6yGmir2/A9PyVL7tesf55flPyp1S/gDwxkei/Vj80Pxbh75TJwDXc1sSkGmMm2NOzvNz8MURkb5oDp7RU9Zdtzu16dq8antuv4NSwYbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tDXlc9sc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAAA1F000E9;
	Tue, 16 Jun 2026 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633167;
	bh=DJ2wC9GMzaecr5pWuRy4n8OtWMyYkg2Bo4AQrFBqG6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tDXlc9scUHBk4Sp9jJupD1AwCFp9dbxdhL5FcUbT1QbnCsfgx4lzxuEu/STMVCbQz
	 N9svUvAKIf8B+mSGVK4X10YJIHlrTn3TB0AH5QlCg6peTx2vbsms45d0zh+XUpu5+S
	 Tb09Dfv01rlR7gFYPANU3pduFGZUrJpvOSHSpgAk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhenghang Xiao <kipreyyy@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 031/411] Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success
Date: Tue, 16 Jun 2026 20:24:29 +0530
Message-ID: <20260616145101.994100843@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265821-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kipreyyy@gmail.com,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A222B693CD9

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhenghang Xiao <kipreyyy@gmail.com>

[ Upstream commit 00e1950716c6ed67d74777b2db286b0fa23b4be9 ]

l2cap_ecred_reconf_rsp() returns early on success without clearing
chan->ident. Every other L2CAP response handler (l2cap_ecred_conn_rsp,
l2cap_le_connect_rsp, l2cap_config_rsp) clears chan->ident after a
successful transaction to prevent the channel from matching subsequent
responses with the recycled ident value.

A remote attacker that completed a reconfiguration as the peer can
replay a failure response with the stale ident, causing the kernel to
match and destroy the already-established channel via
l2cap_chan_del(chan, ECONNRESET).

Clear chan->ident for all matching channels on success, and harden the
failure path by using l2cap_chan_hold_unless_zero() consistent with
other L2CAP handlers (l2cap_le_command_rej, __l2cap_get_chan_by_ident).

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a5db427c13de20..7e3825c1b10b95 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6422,14 +6422,20 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("result 0x%4.4x", result);
 
-	if (!result)
+	if (!result) {
+		list_for_each_entry(chan, &conn->chan_l, list) {
+			if (chan->ident == cmd->ident)
+				chan->ident = 0;
+		}
 		return 0;
+	}
 
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		if (chan->ident != cmd->ident)
 			continue;
 
-		l2cap_chan_hold(chan);
+		if (!l2cap_chan_hold_unless_zero(chan))
+			continue;
 		l2cap_chan_lock(chan);
 
 		l2cap_chan_del(chan, ECONNRESET);
-- 
2.53.0




