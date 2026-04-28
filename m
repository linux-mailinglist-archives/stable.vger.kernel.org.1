Return-Path: <stable+bounces-241738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCHeCxnq8Gn2awEAu9opvQ
	(envelope-from <stable+bounces-241738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:10:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D973489A94
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EAC430C3C92
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F2F329E79;
	Tue, 28 Apr 2026 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=cipherat.com header.i=@cipherat.com header.b="kMXdw3V+"
X-Original-To: stable@vger.kernel.org
Received: from mail.cipherat.com (mail.cipherat.com [91.98.42.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA627329E7E;
	Tue, 28 Apr 2026 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.98.42.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394732; cv=none; b=h6i48foxdaBdjMbgTTGRPP7xz9lupVh8OzL7cIhxNu+BJBZv8PTwOzD593RUmpCziZcJchbqB02QfzBUfKNo79mS67dQ4N5lzs4VaL6KwY4KplznSWpabEvdOZ5aDGaSZpt0vi3CjksOobZ1GjI9VgwduU8vUaPAXiKcqZVpYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394732; c=relaxed/simple;
	bh=rZHYkXggah79PkVFN+6E/RKD6b6tAyfkViysUFDb8oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6199SHSbc8cpveqUEsTlIuF/I45NuZHgnlLylh6iK1z9W1Rk/frdCBh/knkzDz5xwTfwNr+cMfPrRKjRiqKOii4Uf8Mocmv7jPFCQA2sstqG5nPnzkihXTaGmH0LAOQb7qlLOa7YubwW0CYpZRXnlCP1lPH5yXoACllnyZggxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cipherat.com; spf=pass smtp.mailfrom=cipherat.com; dkim=pass (4096-bit key) header.d=cipherat.com header.i=@cipherat.com header.b=kMXdw3V+; arc=none smtp.client-ip=91.98.42.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cipherat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cipherat.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 637EC84F95;
	Tue, 28 Apr 2026 19:45:22 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cipherat.com;
	s=dkim; t=1777394722; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9UgJASqxAWAeh3eiXQ4y7gcX7HLK+OapSPbuxmiLW5Y=;
	b=kMXdw3V+X6KaN5jNvIsUSwjtoV9CmY+pp7Y/en//lQ8nmd423LdSDsJRhRtA/WssAY6WGJ
	5henIhw9hhiG/aZLkzsLaD3npjFsbU7eCHlcK4lrVH2HOC68iiCaCmwwFDruk+NBpIUNcY
	Ef1y0Zx9+0PKS37moQ/pVU0a2cOUArCfo88go5kGYgkBYRJNQck+DFTZ8iiYAhRyfk3zfm
	OgR5sFXkNg/GTxpchOnUpWziIrB3UAqS3rR9k6sKjZsUk3LA4K/zO9RLWvWBD3cCAqeCrP
	jyFPwp7tdfblH76Ji53OJaJqQqEU9qywjdoNPDlPtOgGkoS6KTEuPGFgGPFKfZVR1JL8DD
	c7JQisNAH2nIsgdAOwZ0BRKCigXMYvNVJIuS0m4sV/rAtJ1oCLXGUHLYyr/81eZHq4g+64
	U0MLQe8dcbSxeJkA+BriweQX9MyE5OP5zvrIx3EQI3WjB8QM1aSLTZqcAYNEeXorX8DtoN
	K7n2fWai2jucAqiC6ii1uzGOHXT3YsuPfwMRE/sFFB1Li5gPOrtwefdyM/X/06qQElu05o
	WGGMu0djklXS4J/yGC18rF9LPNE/NFCAU6VsuxhrdncXZCWYUEElf7gEOao7sVnWAhOnc0
	Ib/TT60wReMad+Fw/JqpZg7hcRtsK3SWO/I0YDvj0TTnBFIF+AXk8=
From: Salman Alghamdi <me@cipherat.com>
To: gregkh@linuxfoundation.org
Cc: luka.gejak@linux.dev,
	straube.linux@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6 1/8] staging: rtl8723bs: fix buffer over-read in rtw_update_protection
Date: Tue, 28 Apr 2026 19:44:31 +0300
Message-ID: <20260428164513.763471-2-me@cipherat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428164513.763471-1-me@cipherat.com>
References: <20260428164513.763471-1-me@cipherat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 9D973489A94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cipherat.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241738-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[cipherat.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,lists.linux.dev,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@cipherat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cipherat.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cipherat.com:email,cipherat.com:dkim,cipherat.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]

rtw_update_protection() is called with a pointer offset into the
ies buffer but the full ie_length is passed, causing a potential
buffer over-read.

Fixes: e945c43df60b ("Staging: rtl8723bs: Delete dead code from update_current_network()")
Fixes: d3fcee1b78a5 ("staging: rtl8723bs: fix camel case in struct wlan_bssid_ex")
Reported-by: Luka Gejak <luka.gejak@linux.dev>
Closes: https://lore.kernel.org/linux-staging/DI2H39EAAFBZ.3KI5NWN02AQ2S@linux.dev
Cc: stable@vger.kernel.org
Signed-off-by: Salman Alghamdi <me@cipherat.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ddfc56f0253d..268f294528e6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -464,8 +464,11 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED) && (is_same_network(&pmlmepriv->cur_network.network, pnetwork, 0))) {
 		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
+		if (pmlmepriv->cur_network.network.ie_length < sizeof(struct ndis_802_11_fix_ie))
+			return;
+
 		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
-								pmlmepriv->cur_network.network.ie_length);
+								pmlmepriv->cur_network.network.ie_length - sizeof(struct ndis_802_11_fix_ie));
 	}
 }
 
@@ -1072,8 +1075,11 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 			break;
 	}
 
+	if (cur_network->network.ie_length < sizeof(struct ndis_802_11_fix_ie))
+		return;
+
 	rtw_update_protection(padapter, (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
-									(cur_network->network.ie_length));
+									(cur_network->network.ie_length - sizeof(struct ndis_802_11_fix_ie)));
 
 	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.ds_config);
 }
-- 
2.54.0


