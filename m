Return-Path: <stable+bounces-222158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBDgNsmdo2l2IQUAu9opvQ
	(envelope-from <stable+bounces-222158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B91CC93D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 907C6305171A
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F5730B514;
	Sun,  1 Mar 2026 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kepOs2TH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF422E6CC0;
	Sun,  1 Mar 2026 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330044; cv=none; b=OHLGpOk/vP8CzzweozG/+ZZD4sOpFFsUqqcgJcNBAIcCXWqEHs/6U7ambrqESKYsedADzB/TAWL/otxBZ/rkXZS0fXEKAvV6CidUPpXTmVFXJg/kPKVPFeT8HdqJ9vMdqIHFPeFRURuwMXfOYapQjV8D/+jmr15YJ+I5tOXMv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330044; c=relaxed/simple;
	bh=L0vLKaJa41WR7N3GFw6yaBtH7B0+tbvOlTNfq1rxAD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tU//aiJb0PDEA5L0viRy0kAYwFz5mWnbjBYrITsOSH9VYQUt10rv/xGb3ncL/50Jc8oNsGDlOzwNqwnR5HEj7g4KCikMbkahElqHoB2FZW96JkHYwOtN8VQSOwprCa+4ceNvCsFc1F1C7o0zo88D1l6qgL6dzqrkPbKgWsFahEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kepOs2TH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF08C19421;
	Sun,  1 Mar 2026 01:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330044;
	bh=L0vLKaJa41WR7N3GFw6yaBtH7B0+tbvOlTNfq1rxAD8=;
	h=From:To:Cc:Subject:Date:From;
	b=kepOs2THNTGayhoCjucN3w7/YA5i4hCK3tR8mV6QThx369E02mpOwPZhAwSzZSx+i
	 QOVJFEs0Wsvy6XhzZ9LBzB+Ib8cjszJohGuENBLLSYAZrYbejDKAIu+dmnHv5WrhhT
	 1E1Vilb6s60UnMlrDm+FEdsP0SVccVauWdqkzO5qfBXS+ekbnCyeJVYvHk9xMkmfBG
	 1SoRWxnpMNygHXOEzn5XqUES0Av4lxesS/feS/iVplJAPHonNmIxHLnjGCLniKRwpl
	 mRCUVfio/lsQqEtU/noAxaqbH9j50kZRLU38mGt3CPqC6VOXKzu01i8MAkSH+h8hUV
	 OisAPIGLqW4mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ethantidmore06@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Subject: FAILED: Patch "staging: rtl8723bs: fix null dereference in find_network" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:54:02 -0500
Message-ID: <20260301015402.1720952-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222158-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 841B91CC93D
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 41460a19654c32d39fd0e3a3671cd8d4b7b8479f Mon Sep 17 00:00:00 2001
From: Ethan Tidmore <ethantidmore06@gmail.com>
Date: Mon, 2 Feb 2026 14:54:29 -0600
Subject: [PATCH] staging: rtl8723bs: fix null dereference in find_network

The variable pwlan has the possibility of being NULL when passed into
rtw_free_network_nolock() which would later dereference the variable.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Link: https://patch.msgid.link/20260202205429.20181-1-ethantidmore06@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b3a9e40054a7f..8e98344951acf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -826,8 +826,10 @@ static void find_network(struct adapter *adapter)
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
-	if (pwlan)
-		pwlan->fixed = false;
+	if (!pwlan)
+		return;
+
+	pwlan->fixed = false;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
 	    (adapter->stapriv.asoc_sta_count == 1))
-- 
2.51.0





