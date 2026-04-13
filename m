Return-Path: <stable+bounces-237287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBsfC3wf3WmsaAkAu9opvQ
	(envelope-from <stable+bounces-237287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:53:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C82C43F01C6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9E4B3031A23
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643ED317153;
	Mon, 13 Apr 2026 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d/0C+slc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827C31619A;
	Mon, 13 Apr 2026 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099068; cv=none; b=N2XOBQa6ruP8FiqL4sDL3zrtty3Z0g3nwXFj8gyj2BLrnaTtwSi5CA+uqcU0KJC+tf0i9PQNnxIfIJtqiQ1RQI8CNc6oBBS5+opUdT/dySOn2qzvUnRdmvPyuBpwxfpz0XMmJpnrUHA6yL41rBsf866rNgNiFFC5hzW3Ee/QLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099068; c=relaxed/simple;
	bh=kE0Io5b6nyIcqEu1y2CDlvv4hpgE4QfwUvjJPCoFFCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+DlnGhfp98ecHKR35kM7WKDO8CAkKdo+lUaHXAhFqfYWXCdhPo3aR+46JJc11s1LPrl5fEkMfeCN53Y81Dx3Xv199D/4Uo2jo82ZcAgNJixC22eO4BNmtz9/wIENiUl5adljD4lwgo3y/8a1TP515z0pc521ovIQyAlyCKc8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d/0C+slc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0515C2BCAF;
	Mon, 13 Apr 2026 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099068;
	bh=kE0Io5b6nyIcqEu1y2CDlvv4hpgE4QfwUvjJPCoFFCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/0C+slcTi+iGnB97EQ+GhJvQ4VjD6l5PvUSSnY6NtAtOVjowthliDAnvsc89Np9X
	 5oCGaoa8uVGG3Xd3jT43Uqm6fvLYHmYHvXqpyBQOZUsy70i+uCOzU/P/s49b3gSQ0j
	 gKUUC3CidaQfXueD0OD//rrRelVd2lPUeoGwiUMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 5.10 197/491] staging: rtl8723bs: fix null dereference in find_network
Date: Mon, 13 Apr 2026 17:57:22 +0200
Message-ID: <20260413155826.449000649@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237287-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C82C43F01C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Tidmore <ethantidmore06@gmail.com>

[ Upstream commit 41460a19654c32d39fd0e3a3671cd8d4b7b8479f ]

The variable pwlan has the possibility of being NULL when passed into
rtw_free_network_nolock() which would later dereference the variable.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Link: https://patch.msgid.link/20260202205429.20181-1-ethantidmore06@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -967,10 +967,12 @@ static void find_network(struct adapter
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
-	if (pwlan)
-		pwlan->fixed = false;
-	else
+	if (!pwlan) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_assoc_resources : pwlan == NULL\n\n"));
+		return;
+	}
+
+	pwlan->fixed = false;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
 	    (adapter->stapriv.asoc_sta_count == 1))



