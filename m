Return-Path: <stable+bounces-221952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AISiC32qo2nfJQUAu9opvQ
	(envelope-from <stable+bounces-221952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:54:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 849401CE0C6
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A86320919A
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D052F6596;
	Sun,  1 Mar 2026 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4J+qkk9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892220010A;
	Sun,  1 Mar 2026 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329540; cv=none; b=J/GPcv8goHq+TVZdcaVp7T9OUlzuGuiF646eYtAi9xG3Nl91cC3BIpeRALe00HA+/9epHnJFgjM1WSQiJLgOOXK6NkK8JK0usXW/eo1m4GeP6LuNqSb6g2IsHXzGFtzdEhCuPAlXKU3i/E9kYU81oYoBWiVsJNWbFUxL6MMOuyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329540; c=relaxed/simple;
	bh=szZdcZApczKE6lWtvRKkuHP4Kt21vGD4f2feq5CiPxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgK3hqwq8H3HA8XQTMIjL+EW+ovjbac+NT4lv9K27RrheequOfuQDBx13yZpZqTOskrbFpLgpVM+V05u6JJmijnA//a/VO7LZZ/fMkfi6H4b8zoyLz/N2+Z8kHAYA8zscoZvhVXUulltbaCvY/cNnERqskkJXCQDzwsUatnqeLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4J+qkk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C641C19421;
	Sun,  1 Mar 2026 01:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329540;
	bh=szZdcZApczKE6lWtvRKkuHP4Kt21vGD4f2feq5CiPxc=;
	h=From:To:Cc:Subject:Date:From;
	b=f4J+qkk9VDi4bV2CW6qeCLvaT5fbNhD6b7waxL1WU8DHRoaCZ9uCYenshHlto044Y
	 z/PsOWuA5tlm5rzRiNAyVLXqLr82sP/bTQe9IAukoOyZaU1K3eIwgYYZduePxZe3Be
	 cKvdz67UekPVMjYaiJhIFOSc5UYYll+Se/b1E9p17rlm2EkC6w5Keb+3DUjkJ+tt1v
	 7G31UBI34OxzyEmGhFjTLIGQdKDKv5nQUrIeMVk03qpprBBdtBpEB3J+Cn/41Qql56
	 WHn3brnw3p+iZilBQ+nINgUBV+VL7PAGsoPvqZC4RKveGAGRnf7wfKceWMozKEAjZ6
	 hTxFdGd7FoR+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ethantidmore06@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Subject: FAILED: Patch "staging: rtl8723bs: fix null dereference in find_network" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:45:38 -0500
Message-ID: <20260301014538.1708294-1-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[linuxfoundation.org:server fail,msgid.link:server fail,sea.lore.kernel.org:server fail];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-221952-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 849401CE0C6
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
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





