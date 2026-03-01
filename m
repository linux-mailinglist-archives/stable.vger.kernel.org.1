Return-Path: <stable+bounces-221742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP9CDw2co2k3IQUAu9opvQ
	(envelope-from <stable+bounces-221742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:53:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFFC1CC206
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A62863276CA0
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B82C15B0;
	Sun,  1 Mar 2026 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9U69csQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9928FFFB;
	Sun,  1 Mar 2026 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329029; cv=none; b=LhrJMkTw8yXQyrias+fOIXHlRAniRJwBZjb0NcbLWQk1uUrQ7/pTIblRGT/mFa3lXATpVfV8NbVJ8nEbY5WeXlzL9I8P5ntR+SFI1pdXhOsX1pczj46qnmMu+YIqwKCgYsC9/4FC16fQwl4fryz+My84QaohbXhKhzGJJWpWWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329029; c=relaxed/simple;
	bh=gXafvwIQfg362EDrwydIDZ4rEEhgur3U/156J2dwyR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mvyg9e3aYafS0N8PuT3xEbeQIPa0lwAS189WPRM8wGIiPD2kWHmBDd/DvyL9qAvgEgtUWkmM5gG3uVs5YegjcjGpwz4g6kdo7jq2y94Tj1UGtWcDWfdMBcP73mFZn3K1emUP2Kg9RJ3MNT55Oi9jZFPTrz96ee0Li75Y6ST/2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9U69csQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D80C19425;
	Sun,  1 Mar 2026 01:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329028;
	bh=gXafvwIQfg362EDrwydIDZ4rEEhgur3U/156J2dwyR0=;
	h=From:To:Cc:Subject:Date:From;
	b=O9U69csQD0/hTCDxwRC5RS1v9flTesSabJFuuQUJwxlb0JBySLYKsucwA9ftZMUTP
	 Is7QE1+eYiBWu5QgXaute3oP2HxhSRO9Cf02IAXQbxTGu5MBiLLPlMqHztb88va67f
	 Km3PkjlC+a37JwhBSOz7N+HM500U4NgCYjBzcV51uMZ3m1zbAfSZKyejnpFd4ejN0w
	 b7Kb+sEUBJUBMNBt083c/t2EfIGmOY6DTNIGXMysfE2QTnw4VPfAGVWwHxPMK4DM02
	 T00/QYcQvcb9Ze6cYwKCMCBA1VjK3LWjCd1preMmB9Bc9YI2oj2NAknb9Ly6W1MfKI
	 qV9Tj5X25czyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ethantidmore06@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Subject: FAILED: Patch "staging: rtl8723bs: fix null dereference in find_network" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:37:06 -0500
Message-ID: <20260301013707.1697306-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221742-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email]
X-Rspamd-Queue-Id: AEFFC1CC206
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
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





