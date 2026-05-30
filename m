Return-Path: <stable+bounces-257427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJy2FJoaG2pR/QgAu9opvQ
	(envelope-from <stable+bounces-257427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:12:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 505D160F264
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE2273037430
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B32F3AEB26;
	Sat, 30 May 2026 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1jHQzQ3R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17C34165B;
	Sat, 30 May 2026 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160960; cv=none; b=KdLwvtMlGfBm9v2mbyAwpjwTrcwNX3+ek/v2wtkvl4YUdVGPEeYTDoN58Oj3GcmltCEYQnyzVqVZJReqIZOEnKHyjIRdASlU/W0Ep77M8N/ebifV9sApKYW+v13EaE1JhrcwgKnImOUvOyiOyBqMPw9/SJ0F8yQPJckN0wfIgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160960; c=relaxed/simple;
	bh=BNIuCvcJT/RlDUtRIuL2STdJQxTTZlQduHbSKxnJnwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/qNI4tNktZHZd19q2qoviXQI1J2tiygczS22lUJ2pB8UwiTS5LhxmhgOuom6915pkfM3ZeI8RKIKVFjrOqIfkscpmg0hNIzhI6BK5PiItlQmAtQx+UFdlQOgqE/7X8mCVh8M6yHv0+2irAGpLDLiJ+CPVo+qWAXcOowUaLSH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jHQzQ3R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677961F00893;
	Sat, 30 May 2026 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160959;
	bh=OO00mFtI3gJsTqMU1a3O8IFbR2axK4vAMpnh540vFis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1jHQzQ3ROkz3wUkVjhtIIDpMimEfvKEa3yGzqnBjQRhVK6UAnnWjvDIR7zWnDus9v
	 xFS9XCW/dcWSljsQ54Q5FzQjlE6wBKfaeR40bYsa3A1dlfe6bgz6eLp8KZoj/lyW9u
	 XxR9AglbzpPKSef75CEHuIAybrYxg2emzIxNpgi8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 485/969] Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU
Date: Sat, 30 May 2026 18:00:09 +0200
Message-ID: <20260530160313.699658579@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257427-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 505D160F264
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 15bf35a660eb82a49f8397fc3d3acada8dae13db ]

The code was printing skb->len and sdu_len in the places where it should
be sdu_len and chan->imtu respectively to match the if conditions.

Link: https://lore.kernel.org/linux-bluetooth/20260315132013.75ab40c5@kernel.org/T/#m1418f9c82eeff8510c1beaa21cf53af20db96c06
Fixes: e1d9a6688986 ("Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8a2d36f5cf33b..56fbf8d2769c6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7730,7 +7730,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 
 		if (sdu_len > chan->imtu) {
 			BT_ERR("Too big LE L2CAP SDU length: len %u > %u",
-			       skb->len, sdu_len);
+			       sdu_len, chan->imtu);
 			l2cap_send_disconn_req(chan, ECONNRESET);
 			err = -EMSGSIZE;
 			goto failed;
-- 
2.53.0




