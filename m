Return-Path: <stable+bounces-244269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE7TG5ld+mnmNgMAu9opvQ
	(envelope-from <stable+bounces-244269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 23:14:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA244D3D4F
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 23:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD26303D70C
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 21:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F22492538;
	Tue,  5 May 2026 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAZzVyZ1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76348B388
	for <stable@vger.kernel.org>; Tue,  5 May 2026 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778015608; cv=none; b=mZsDDOZiSvqzDhrzIWFkHf2A0/hVQlm9aWbbcgx6q6gd/z0A5n4JZB0/79nSqBAVBaWndxNhRBZMir5Sn5GMjyWDvaiULwnFPORu2/iBfd5QuLuU+iACUm1UDlW6ta6zWr629FWirX6ywX4/DZhLzFDgSeSt/9fCJVSJwDu3jUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778015608; c=relaxed/simple;
	bh=23flgCKPmr/64LZQVG5CYe9gxCAybtMU8IEcjYVeovQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Quy6XGQVJ/Zm8cmqnlZKdakiZxBz5UqoD1ckLKioLLydTVUP/sPlQ0P8V2pQzgKlJmaSfUeVeou04+cknkChA82YoOtQnuDOJw0IJerRS7UOHU+iZlsSxV/cJU11hDn4m4VIl7YsZtSlJZXWnCb9P400TxXN2X0gV8tg64RkmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAZzVyZ1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48d102471a4so24472115e9.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 14:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778015605; x=1778620405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV8sC4ksQylO6CsH5rg4mb+3+8qM/80Gf6RZW/LIH2k=;
        b=IAZzVyZ1lkF1Nr1iel3VY+5X1gFUt7gFjDNwuxMMWeFZ6xgAZnu8q9LiFm+k+u3n0K
         sv2LzMwDyl5rDrrT5DYANlYotzeX+/DrDF7V5bkWGaO7Hip6T0usC/ODrYLykejgUo/G
         hitvfRW4XXKwBuTcB7Plkg118H9DyyjUvTib6T9T6xV+VtXbFowZM43rK8Zn2JFIVDQf
         3H04mdC9aTq9Exu9daLrl0BNtbJ9SoTpdk1wucADkp+xflYVM6aSuX8dQgym5gM45AqZ
         BKGVu7GkIT7QZ//Nqjx6FmvbO8fHGKuqlWYuNlAlot7p2DyYQYcihHWqAP1oQX/EMTjc
         IOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778015605; x=1778620405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MV8sC4ksQylO6CsH5rg4mb+3+8qM/80Gf6RZW/LIH2k=;
        b=hXbhijmWJ1wTXczE+nBjHedL9tZfK2DukNiwwrdHPpjQjUTdDr3droVENS+5Kt2It1
         xF3RlZycoQBTqbrN/J/CLiCz+bZAlHMPTsbocUgcxhM93bU874eV4jINrFLuZHFKy6CI
         SZKqRHs7aCYbYEUYSmcOEd8zk585rKtNeced5eOUc5VtRSm0rwaYz+8WSWl3vQvZmPhA
         FLDP6puJbxsZuukV6hu7+eDr8cYLdZPfJRVMIvQYOT9Y1Hs+zdhG46eBWS3m2A43RR4V
         okLcoSCnq/rj9XjJoZF5T8ioj6lMip2OWKvOnPiVho/YO7V2hF0E9wcx1ZxNL6ebxVij
         pdQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kYF8P/++M92H5E20RlJ9VdacE2W2JAl35NqtgK45iVhYDUTEnrgKwe67xFQ0fAfokyz7Jxk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBbep/U9NOc/0T/7/gqwt4XQB4aa+iPvJxrT8KklsrLJQpVMG
	EYhm5os6474vnRRBSj5jCfoEcMPH8CUpAO/lHUAu2P5t/2CO2CmrHviq
X-Gm-Gg: AeBDieumveMP3nr37WbhF/slvS4T65uig8nhTbo2gDyiKbgF1RaO0lsx9JrzE9HAmwn
	ZtyV6vwnHIqjOZHdtXhMEqXNTfXxwk8UVF8zeCE6/p+utFpzy6vYsTHTSRMTrgSJdola42gdfY5
	um74uCtaIHG1wNTkaohTt1mZUiIvGEJO0HYJnB/JddV7A/M6HTas0msByr6dMONnPaODRWlHHG5
	OmqwoKzAGSEV3yh6r+IiOs1t/Ipjvynzfv/hIK/mhcay7uNt8ZXHQ5wi2D54CMUmB8yw7nPVAa1
	uis8OWzYkCVTMz5LJrFtd1O2QUCTYZIYD4DyaEs0ll25MVqgo/2C6siAwMdNjRoYr5XaCyV/i8O
	icbNKOVCt8RI0k7qdQ38SRiPQ4RyGAX+hblRv94+FGFrVDUqf2yfcoZJXktjb1CvmKG27PB+5OR
	oKKBbHIcjjT2BEIKzAX3jXM0GeZjy0/pnaAzRRdxoPO6t1XXXiGNj73i+h+a5SI6iHjd/moeP0e
	6XuGls6KOIG5SmjvFnjP6AB4JCcfUXGoz+pR4ry+pYdCUQAzEhyNEeRlePDRZ2Rffkbh/0=
X-Received: by 2002:a05:600c:4f53:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48e51f44577mr13674245e9.22.1778015605001;
        Tue, 05 May 2026 14:13:25 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6fffcsm403400045e9.4.2026.05.05.14.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:13:24 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: error27@gmail.com,
	stable@vger.kernel.org,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH v7 1/2] staging: rtl8723bs: fix Challenge Text IE length checks in OnAuthClient() and OnAuth()
Date: Tue,  5 May 2026 23:13:15 +0200
Message-ID: <20260505211316.3837020-2-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505211316.3837020-1-hossu.alexandru@gmail.com>
References: <2026050453-scorer-rebate-3898@gregkh>
 <20260505211316.3837020-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0AA244D3D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244269-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linux.dev,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Two functions process Challenge Text IEs without verifying that the IE
length matches the 128-byte buffer:

1. OnAuthClient() shared key path (STA mode).

   rtw_get_ie() returns the raw IE length from the received frame,
   which can be up to 255.  This length is used directly in memcpy()
   into chg_txt[128] with no bounds check, allowing a heap overflow of
   up to 127 bytes when a rogue AP sends an Auth seq=2 frame with a
   Challenge Text IE longer than 128 bytes.

2. OnAuth() sequence 3 path (AP mode).

   When a STA completes shared-key authentication, OnAuth() calls
   rtw_get_ie() to find the Challenge Text IE, checks only that the
   IE is present and has nonzero length, then calls
   memcmp((p + 2), pstat->chg_txt, 128).  If a rogue STA sends a
   Challenge Text IE shorter than 128 bytes, memcmp reads past the
   end of the IE payload into adjacent packet data, causing an
   out-of-bounds read.

IEEE 802.11 mandates the Challenge Text element carries exactly 128
bytes of challenge data.  Add len != sizeof(pmlmeinfo->chg_txt) and
ie_len != sizeof(pstat->chg_txt) guards to reject any element whose
length field does not match.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v7:
  - No code changes from v6; dropping Reviewed-by: Dan Carpenter because
    patch 2/2 changes code from the reviewed version.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5f00fe282d1b..dd3c94d314d8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -802,7 +802,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
-			if (!p || ie_len <= 0) {
+			if (!p || ie_len != sizeof(pstat->chg_txt)) {
 				status = WLAN_STATUS_CHALLENGE_FAIL;
 				goto auth_fail;
 			}
@@ -891,7 +891,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (!p)
+			if (!p || len != sizeof(pmlmeinfo->chg_txt))
 				goto authclnt_fail;
 
 			memcpy(pmlmeinfo->chg_txt, p + 2, len);
-- 
2.53.0


