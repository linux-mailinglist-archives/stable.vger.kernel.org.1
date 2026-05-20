Return-Path: <stable+bounces-251419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FtbLUr7DWru5AUAu9opvQ
	(envelope-from <stable+bounces-251419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:19:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A0595D4F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040043347FCB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2A37754D;
	Wed, 20 May 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JtkgsrVK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957543F4124;
	Wed, 20 May 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297931; cv=none; b=eEsnbtBH3Ii+rSkflxvQmD1mv87TTL6BGTzHCaclzaRBZuEAlNTu+71iSElExqGss49X1VvkOLiZYiLfF/PnFszt27y2sfl1wkeAnkWdknFtCPqFQiRGVby19k1xwGwzF59TOfbli7YGlc/43JEekT+3HsYPjpu19ATIcwT0//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297931; c=relaxed/simple;
	bh=MdIUxbu31B0RO3MOHyCBkX1N42bOGRHlWkKJKBk9bSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5PIF5/3fzIJbEncP+LlZZnILKlgXvxgxt/xrCJdb0qMdzpVPkjHYOsVIf98KfuVpt+I++GwlyjlkghCxGx0JAlGNxq18kzCSrM8y9eH67u/SfCIo1D1xR6Q7jcogHaL95vmYd4EeHwFDTonwI3JUOz2RccqecWj3pCTtNwejnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JtkgsrVK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065011F000E9;
	Wed, 20 May 2026 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297930;
	bh=yiCK2qKO5T/QXBgmmCFADnsJ4xp/v/is1Sll6hlNVj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JtkgsrVKU/YfdVJDGg9vfVjEOVYSwD7NCX2EIishVvBarV9Z0a8PJ+I5OsqcrjUO1
	 Kg6LgCKieVeW53kUWPbYRto64FxKgmW7/3D8GJ9w21ti5OalSaH3drObV5CLb2aNci
	 ILeKBfDOtVN0V2zguhICSzNsug/SOwe9SJXl6Tow=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dudu Lu <phx0fer@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 177/957] Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp
Date: Wed, 20 May 2026 18:11:00 +0200
Message-ID: <20260520162138.392707636@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251419-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 488A0595D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dudu Lu <phx0fer@gmail.com>

[ Upstream commit 42776497cdbc9a665b384a6dcb85f0d4bd927eab ]

l2cap_ecred_reconf_rsp() calls l2cap_chan_del() without holding
l2cap_chan_lock(). Every other l2cap_chan_del() caller in the file
acquires the lock first. A remote BLE device can send a crafted
L2CAP ECRED reconfiguration response to corrupt the channel list
while another thread is iterating it.

Add l2cap_chan_hold() and l2cap_chan_lock() before l2cap_chan_del(),
and l2cap_chan_unlock() and l2cap_chan_put() after, matching the
pattern used in l2cap_ecred_conn_rsp() and l2cap_conn_del().

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7664723a34d0a..bcb13ce531099 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5473,7 +5473,13 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 		if (chan->ident != cmd->ident)
 			continue;
 
+		l2cap_chan_hold(chan);
+		l2cap_chan_lock(chan);
+
 		l2cap_chan_del(chan, ECONNRESET);
+
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
 	}
 
 	return 0;
-- 
2.53.0




