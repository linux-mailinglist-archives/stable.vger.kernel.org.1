Return-Path: <stable+bounces-222333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHxDKyWko2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:27:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5BA1CD906
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5269A3206491
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF1303A15;
	Sun,  1 Mar 2026 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulDrnbeD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72F2FE042;
	Sun,  1 Mar 2026 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330619; cv=none; b=Sa7GGtw7ZFG+LnnUbtlbNNYmHXy6NoC8fPUw7ykOT7EU7OnwqbMNnRS4xl0CC8+l2NFphXGav/EBHni0L0/1eCgoysASZo/k2LEa/2V3eXqkbS/qbw/O/YJGSDRepGO3vS4pDpXvgOWDVCxf1uDemZ6NQ4GV6RQIRoMx4rg01gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330619; c=relaxed/simple;
	bh=H862XwlavCdbOLZzhwteOuPwF3ZTcWCqxfd1CFdXl90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oK+wOSqyNoKYA6gBdouEj3uChSeYs32O1KC91JJcYur+GcJYfdERIgSqV1uczHTl9+JBul02/fgPeiQCuL1YGccIp6hAEqSfGwVgVG89E/aWvLDPlpUbcpjCld9iUE6f0etFb6CLN9opkPFeDfJxolmXdQcl/DW7hThwtfX1Iwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulDrnbeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD12C19421;
	Sun,  1 Mar 2026 02:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330619;
	bh=H862XwlavCdbOLZzhwteOuPwF3ZTcWCqxfd1CFdXl90=;
	h=From:To:Cc:Subject:Date:From;
	b=ulDrnbeD8S5+lWGTPx0+1zaDXmOJyKTfkeUNeN4XaAzDLnDmRMRVPgwTazcmHWRkH
	 z9fwFPGSPeQRiEUr7nkFCKrZ7ZAkgLkXrCGKvIyfKjolNDY/QYzUKoW1TGkLSAwX7j
	 e7NGl9KmsMbjS3dvlTeKkvnOV3cLZIht1TSX/L7WoqKZ7ASTATIJmRVqYvAAg0CZHa
	 ebFl1EYPQV+wDEUpXJJ0lBNUa8cfjtgMrH+pwWZrCEHjCv1gfvSYu6QntmJjh7CPh8
	 vw5HmkrOdc3ma5WYRbSM6sFrvNIuPpp8wFp9FcRCoTVhlgt4toOY3WJTIpEf9apYT7
	 5o/RW5DX6RjQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ethantidmore06@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Subject: FAILED: Patch "staging: rtl8723bs: fix null dereference in find_network" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:03:37 -0500
Message-ID: <20260301020338.1731741-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-222333-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0F5BA1CD906
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
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





