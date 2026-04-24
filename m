Return-Path: <stable+bounces-240768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPe+FuRx62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:36:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 583CD45F357
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64EE430000AE
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAB53D75B6;
	Fri, 24 Apr 2026 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZr4mvuI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0A3D5251;
	Fri, 24 Apr 2026 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037790; cv=none; b=mJ3DeOVPI3SRnq7B7oItv68oTrJTX23y2RK+6ttQ9/O0M5DPiPN/odrZeMx36mkk1YtZsc4I4AE/T1Yc+XLUtKg69lh3FYZeTsBcrssicACWoCHFdJ1S0df53Q0KHsPt6KirQZFBvIhLCmf26J61g1nnNZWMNmHYh/LtpkHBxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037790; c=relaxed/simple;
	bh=oDc9JQ19FNH2futpxAcTcOfl7REzv+Q+z0zzJJXS8zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RF84IQIOXsUvq0ZuuUWaXUHt9aBrlipfrkeBKG72ErOkXmgn7GQGiDblkGaAoGh0mhhwT4CWAo2utvwHLTFfEjBFMMJlEStuaimEn/W9LArmzwGszDeUz0Uu4udjsHVmQb0XhmaEjeWoRttUjHQpZ8N7aXRJoLX+VlAWYfgJ25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZr4mvuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BA1C19425;
	Fri, 24 Apr 2026 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037790;
	bh=oDc9JQ19FNH2futpxAcTcOfl7REzv+Q+z0zzJJXS8zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZr4mvuIePkBXngHOUd217Z05va5e5FuawHF1/5PD8nzIa5ruRjZNGu9Nz5sylZCj
	 YZmparRe9ojc9Y8cIOmXa22PC8dnJH6F9RCbzpOkAy43phO+1aWrXZzepZc6kOPkCN
	 zu+sQsTgLTw7YPp9HnuaBuln5Xya3EoVQcUkVRXA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lin YuChen <starpt.official@gmail.com>
Subject: [PATCH 6.6 070/166] staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_verify()
Date: Fri, 24 Apr 2026 15:29:44 +0200
Message-ID: <20260424132547.450512768@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 583CD45F357
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240768-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linaro.org:email]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin YuChen <starpt.official@gmail.com>

commit 8c964b82a4e97ec7f25e17b803ee196009b38a57 upstream.

Initialize le_tmp64 to zero in rtw_BIP_verify() to prevent using
uninitialized data.

Smatch warns that only 6 bytes are copied to this 8-byte (u64)
variable, leaving the last two bytes uninitialized:

drivers/staging/rtl8723bs/core/rtw_security.c:1308 rtw_BIP_verify()
warn: not copying enough bytes for '&le_tmp64' (8 vs 6 bytes)

Initializing the variable at the start of the function fixes this
warning and ensures predictable behavior.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-staging/abvwIQh0CHTp4wNJ@stanley.mountain/
Signed-off-by: Lin YuChen <starpt.official@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/20260320172502.167332-1-starpt.official@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8723bs/core/rtw_security.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1364,7 +1364,7 @@ u32 rtw_BIP_verify(struct adapter *padap
 	u8 mic[16];
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	__le16 le_tmp;
-	__le64 le_tmp64;
+	__le64 le_tmp64 = 0;
 
 	ori_len = pattrib->pkt_len-WLAN_HDR_A3_LEN+BIP_AAD_SIZE;
 	BIP_AAD = rtw_zmalloc(ori_len);



