Return-Path: <stable+bounces-256994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EgOKTYQG2q/+ggAu9opvQ
	(envelope-from <stable+bounces-256994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:28:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C4960E2C6
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C12D630117ED
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AD934575D;
	Sat, 30 May 2026 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZKwF1Lvp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34433F8A4;
	Sat, 30 May 2026 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158515; cv=none; b=k2iUct9kDwhRTsxFxQyPoIAnXzDFzJZ+ZGiR9ll1caNaRdx0BeeRyKqxEakOJrPHRIsOSWTfXHSmFVdR7xP6H/PikEL04lcxzjbT/XNZnYF5ka1zfjEZTdzRJpecexaRq+LtT3nFfnzg2w/+SoIjTGEk1tEzRbVu+F905NTYjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158515; c=relaxed/simple;
	bh=SDm8x/xvQ/2gbJJSv7rrg4iED6ZK5NELaG5o90LnNfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjEIfYqt5KgA7FXgiT23duHTEYhteH8uoGk1Xx2Nu6CWBgeLRMTECt+vsrbqjEdCiM/nnB7Wps7yei8RGdLtpbKo5mUswaCb/A0pDWqN2dwJhxu6cPWuCERpf1TuQEg1MZRICfZ+MTqt0TmdJRT2eLuz5L1gyVw/CIZaVcrsCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZKwF1Lvp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C621F00893;
	Sat, 30 May 2026 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780158514;
	bh=rdonv+Rj8BGqg3BYepgdiBTSsNUDzFiuC1LwZrUtk6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZKwF1Lvp2ZLc+jGU+ujwBDyXMWLmNZMWyEFOwpOwTrWvQ+bK121JbTzOHpTC8JyyN
	 JjxrOZmWBYgJ38ke32ynuFMDGe5Mg7yYcb9lTGsAyGx6KN6CsgzXW1bRoXZq1RDW8O
	 Qc/5uMNXol3fH4BhLxpHOvW3+1RX+n1JZZLWhJ3E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lin YuChen <starpt.official@gmail.com>
Subject: [PATCH 6.1 059/969] staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_verify()
Date: Sat, 30 May 2026 17:53:03 +0200
Message-ID: <20260530160302.017089167@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-256994-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 52C4960E2C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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



