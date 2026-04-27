Return-Path: <stable+bounces-241263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF/QCk0c72ml6wAAu9opvQ
	(envelope-from <stable+bounces-241263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:20:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEDE46EF5E
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D0F1302D5FA
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D8A39A074;
	Mon, 27 Apr 2026 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enl7lMNY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B539A05A
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277916; cv=none; b=MtDnTdIyVCU07i5TvB/UCML9jBXKshPsCm4K/4V6cWmzmJU9I7VPRbClggMbB/9xztKZ7DLL589q9frxtO7dEKUxX5YwPRzz+DLxPSDnAuJ6bWTTaR6ybQQlaNYkw6YXW5kdEvocvI/6kq7Iv1U8Fm7JhG7cCz5jWsKz9NM5QJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277916; c=relaxed/simple;
	bh=UGUi2ZtX1bemwYp8cSksp8hkcBsw8FfUwrFHOQVPgO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmLRkSGceibY7/G6HmkmngboVEbjfmBWyrwXKxQEiS1qa98Da3/1x0aFbByjFciJpGWeaSDB6denvsYttQ5tCxPH1VugTLA70V+bPD9Xpf48Hy2qBC/EHfbgldBFVjUa4p45Bn/7uGQ2uxXiTn3zqgVa+qe6KK6KyCH2NtmL8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enl7lMNY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso91258615e9.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777277913; x=1777882713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORRSLkmyVRQ6NCw35RQV07Yi/LmWTcjj6Iy7t//9MNM=;
        b=enl7lMNYY+PU3skof4mFDxIopNGaynUd6Dy7HT3QRR1FkUEYRA++cCHxlOJ/5Bddty
         J1lLkwzStKVyPUWqG0xMh33k727ZeW3kWFcUA4u6cevK2/Vfy8euBTdgN2lQQI1sABjh
         gTIPHkqNIqZ7lguQbs8j58DGkAslwXh5rapDtCkdekMkZaOivN3ikquYmIMgR3AqJNnZ
         w4PAjXUWlhVOBHhM4kM/CPIgQoAb82186mOH+AoCMR40eHhx1XG8wRuwYqowCpXVuluY
         Ti33l3RdxNBKCARjsiMHyCxz/ffjc3A7PtjJ2OSkR9WnuDotA3CEtkrTG2uLLJOvoiax
         Lxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777277913; x=1777882713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ORRSLkmyVRQ6NCw35RQV07Yi/LmWTcjj6Iy7t//9MNM=;
        b=q9Md7x4fOUNsFbiCmS+/XkRP892qSPIMlSR6UM4LiLqA4q8vgYPEWbD2CfaNFu0EeB
         F/U4/JkKDYCGSVW1RFxsVnTuzzmGoTywrKxrSpe2bLPNj8cnWmCBPE3qX3Ud7GesqMxP
         SKPypvw19MUS3ialEC/yzSqoTVQhThckiO9ghKS8oKxKWGZO7He+JmzpUAV0bUPrOamU
         uc3MbXMfzd4765BXVXWiYsexFzX/AzENymbVOwrTq5rebk2mjcgwARNtoj5dM2FjSnlQ
         8RuwaxtGNCRPcV4IT4oy8Cm50g6PshNCt2U0Qs36z7wZczC5fjkJHXb+AAz3Ed+BJFob
         hO7A==
X-Forwarded-Encrypted: i=1; AFNElJ+vEXrqi94lRbeUqVPM1+5DXOFttEmbGHooqEEcBPsQl3ID8tOGnIWd/Fvlsck+YUfbxwnz37o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHuTkFjVEkUtRNFoqdmB1hFDrcBDl7jkQ4wZ86rFspofZI9fvR
	Opi8eto2WPcTTtqThNsAxLlpzpdh2J0mkVohMWJTw7lw7xpjRJWy9JHK
X-Gm-Gg: AeBDietuk63a3X5mp9oLJF/O7SD+vLn6w9boz4cRV9XoIUy6c0I8FRxRxYRriN3tvqh
	dr1NgHGImaI5t/w7h4JYhQOVC03Oa/PGfTAzVdDgx0y3GAmlFiUS3Oy1tE6pOdFMJWpE6UitM05
	mk1lrxNk9p58TQ9NuFu3KQMLL0jSMVvW213pwCanaewElUpj4iwB6UDA+fFI8RZ7unLNBw5TiCJ
	dh1HlZTmGm1deeArFc7bC83IjY8rCcfAOPlC/IlQ9cuzK6jsOjd2PqYTlIxHQLBWgvDHCzYvUUv
	TGaEeZ75H45nlIedYYLX1ZpMDr+RDafmhjtcVVrO1nWM8zsHP0DSCYqYazf66+ysMPIXuZ7JS/C
	19Q4lh1qogXigiVvRKqN0jkuRLX2js46htxBsiUT9Z38+4I/bTB6U0gqV6MK1LFsu2SksYC2Jpv
	sgAkxQRuN+UL9hpO1jFBfVAnmtZf0qtdMH91G16wZZBiXWWI+E0GNwzeNZ24f4D7K8AaUyGuWb7
	TbcHM6ttoscTCTTHAt4If67muy2IrcIScXlFeu8E9RdSfU62E4g6iv8ZwCS1aLx80y4h0g=
X-Received: by 2002:a05:600c:4652:b0:489:a4:e578 with SMTP id 5b1f17b1804b1-48900a4e944mr303852385e9.14.1777277912730;
        Mon, 27 Apr 2026 01:18:32 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc14a61asm712652115e9.15.2026.04.27.01.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 01:18:32 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and join_cmd_hdl()
Date: Mon, 27 Apr 2026 10:16:25 +0200
Message-ID: <20260427081626.3393697-3-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427081626.3393697-1-hossu.alexandru@gmail.com>
References: <20260427081626.3393697-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6DEDE46EF5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241263-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]

Two IE parsing loops are missing the header bounds checks before they
dereference pIE->length:

 - issue_assocreq() walks pmlmeinfo->network.ies to build the
   association request. If the stored IE data ends with only an
   element_id byte and no length byte, pIE->length is read one byte
   past the end of the buffer.

 - join_cmd_hdl() walks pnetwork->ies during station join and has
   the same problem under the same conditions.

Both buffers are filled from AP beacon and probe-response frames, so a
malicious AP that sends a truncated final IE can trigger the issue.

Apply the two-guard pattern already used in OnAssocRsp():
  1. Break if fewer than sizeof(*pIE) bytes remain.
  2. Break if the IE's declared data extends past the buffer end.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 884cd39ec756..c646dc2a1741 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2931,7 +2931,11 @@ void issue_assocreq(struct adapter *padapter)
 
 	/* vendor specific IE, such as WPA, WMM, WPS */
 	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
+		if (i + sizeof(*pIE) > pmlmeinfo->network.ie_length)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
+		if (i + sizeof(*pIE) + pIE->length > pmlmeinfo->network.ie_length)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
@@ -5324,7 +5328,11 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 	/* sizeof(struct ndis_802_11_fix_ie) */
 	for (i = _FIXED_IE_LENGTH_; i < pnetwork->ie_length;) {
+		if (i + sizeof(*pIE) > pnetwork->ie_length)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pnetwork->ies + i);
+		if (i + sizeof(*pIE) + pIE->length > pnetwork->ie_length)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:/* Get WMM IE. */
-- 
2.53.0


